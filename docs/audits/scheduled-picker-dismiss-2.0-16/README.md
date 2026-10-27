# 2.0-16：定时任务选择会话误关闭插件弹窗

日期：2026-10-26。以当前主分支 2.0-15（`21bf426cdcf8f5e1af76c5c962eeee5b0e509303`）为基础，修复 2.0-13 真机反馈中仍存在的会话选择问题。生产行为改动限定于 `CSScheduledTaskSettingsViewController.m` 的目标选择衔接。

## 录屏检查与根因

已检查用户提供的完整时间轴，并从原始 `2026-10-26-scheduled-picker-dismiss.mp4` 重新解码末段 6.8–8.0667 秒、每秒 12 帧的连续画面。视频为 592×1280、30 fps、242 帧。画面显示：会话类型 action sheet 向下收起 → 原任务编辑页短暂露出 → 整个插件容器又向下退出 → 露出微信“设置”页面。原生好友/群聊选择器没有出现。

- [原始录屏](../../feedbacks/2026-10-26-scheduled-picker-dismiss.mp4)
- [用户提供的全程时间轴](../../feedbacks/scheduled-picker-sheet.png)
- [本次从原录屏提取的末段连续帧](recording-last-transition.png)
- [视频参数与 SHA-256](recording.json)

旧 `chooseTarget` 的 action handler 调用 `[weakSelf dismissViewControllerAnimated:completion:]`，其中 `weakSelf` 是导航栈中的 `CSScheduledTaskEditor`。UIKit 可能已自动关闭 action sheet；此时再向 editor 发送 dismiss，会向父容器寻找可关闭的模态页面。在弹窗显示下，该对象就是承载整个插件的导航容器。容器关闭后，completion 中的 editor 已离开窗口层级，或已被释放，不能可靠呈现原生选择器。

原有原生选择器测试只模拟了 `self.presentingViewController`，没有子控制器向模态父容器转发 dismiss 的行为，也没有执行定时任务的真实 action handler，因此此前未覆盖这个问题。

## 修复

- `chooseTarget` 弱引用它自己的 action sheet，避免 handler 形成循环引用；不再 dismiss editor。
- `finishTargetSheet:groups:` 分别处理三种 UIKit 时序：已关闭时继续；正在关闭时使用该 sheet 的 transition coordinator，取消的转场不继续；尚未关闭时只 dismiss 这个 sheet，并在其 completion 中继续。不使用固定 delay，也不强行二次 present。
- `canPresentTargetPicker` 检查主线程、view 已加载且仍在窗口内、editor 是导航栈顶，以及 editor 和父容器没有正在关闭/移出或被其他 modal 占用。失效时记录 `[WeChatImprove][ScheduledPicker] skipped`，不调用 UIKit present。
- 保留原有账号代次和隐私校验，以及 `CSNativeContactPickerPresentSingle` 的单选约束。共享选择器实现未修改，仍全屏 present 自己的导航容器；取消只关闭选择器，确认仅回写 target，原任务草稿对象和导航栈保持。

## 相邻入口检查

| 范围 | 观察与处理 |
| --- | --- |
| 定时任务 `chooseRule` / `chooseWeekdays` | handler 只修改任务字段并 reload，不继续 present picker，也不 dismiss 宿主。保留。 |
| 密友名单 / 密友群聊 | 列表行直接调用共享原生选择器，无 action sheet → editor dismiss。保留。 |
| 密友重置确认 | `CSCloseFriendManager finishResetAlert:presenter:completion:` 已针对 alert 自身和转场处理；`leaveAfterReset` 是已完成独立重置后有意离开设置页，并非联系人选择衔接。保留。 |
| 红包白名单 / 黑名单 | 直接调用共享群聊选择器，无此二次 dismiss。保留。 |
| 备份导入 | 直接 present 文档选择器；备份记录菜单也没有这处关闭宿主的代码。部分菜单项继续显示确认/重命名弹窗，属于其他流程，本次没有改动。 |
| 聊天分组自定义联系人选择 | 自己的选择器在完成/取消时关闭自身，不是此 action sheet handler。保留。 |

这是以上源文件及相关入口的定向检查，不声称覆盖所有微信或插件弹窗。

## 失败复现与核心回归

新增 `Tests/ScheduledTaskPickerPresentationTests.h`，复用原生选择器的宿主替身框架。脚本从实际生产文件提取目标选择方法，编译实际 `CSNativeContactPicker.m`；没有另写一套选择流程来替代被测逻辑。

层级为 `微信宿主 → 插件导航容器 → 插件首页 / 任务列表 / push 后的 editor`；分别构造 modal 和普通 push 显示。模拟 UIKit 已自动关闭菜单后再调用 action handler，旧代码会向父容器转发 dismiss。

先保持生产逻辑不变运行，失败见 [red.log](red.log)：

```text
FAIL: plugin modal survives choosing a target (no editor/host dismiss)
```

为确保最终增强后的导航栈替身仍能复现，使用 `CS_TEST_SCHEDULED_SETTINGS_SOURCE` 指向本轮修改前的源码快照再运行一次；旧代码仍在上述断言失败。没有临时回退工作区生产文件。

| 命令 | 通过检查数 | 范围 |
| --- | ---: | --- |
| `CS_TEST_SCHEDULED_PICKER=1 bash Tests/verify-native-contact-picker.sh` | 278 | 两种容器 × 私聊/群聊 × 三种关闭时序；真实原生适配器的取消/完成；草稿保留；窗口、栈顶、父容器、占用、账号及取消转场失效 |
| `bash Tests/verify-native-contact-picker.sh` | 196 | 原有好友/群聊、单选/多选、完成/取消、预选、搜索结果、底部完成按钮、账号和隐私边界 |
| `bash Tests/verify-scheduled-tasks.sh` | 102 | 定时任务时间规则、独立存储、去重与调度核心 |
| 合计 | **576** | 两个脚本、三个测试分支；不跑全量 |

日志为 [presentation.log](presentation.log)、[native-picker.log](native-picker.log)、[scheduled-tasks.log](scheduled-tasks.log)。测试只使用隔离数据和宿主替身，没有连接微信，没有发送消息或创建群聊。

## 构建与包校验

当前工作区仍是用户原主分支目录。构建使用本轮独占的临时 Theos 缓存（从已有缓存复制），顺序生成 rootful / rootless；没有 `make clean`，没有改写原工作区 `.theos` 或历史 deb。版本、更新说明与功能文档同步为 2.0-16。

- [Rootful deb](../../../packages/com.wechat.improve_2.0-16_iphoneos-arm.deb)
- [Rootless deb](../../../packages/com.wechat.improve_2.0-16_iphoneos-arm64.deb)
- [调试符号](../../../packages/com.wechat.improve_2.0-16_symbols.zip)
- [包校验与 SHA-256](packages.json)、[源码摘要](source-sha256.json)、[验证结果](validation.json)

两种包均含 arm64 / arm64e。验证版本、安装前缀、修复方法、既有功能符号、dSYM UUID 和首个存储初始化器；确认测试替身未入包。`preserved-tree.json` 校验本轮范围外 47,194 个既有文件，包含原工作区构建文件和既有安装包。编译中只见项目已有的弃用 API / 链接参数警告，详见对应构建日志。

## 真机验收

按原有签名 IPA 流程更新到 2.0-16；先保持定时任务总开关关闭，使用一条已填名称、消息、时间规则但尚未保存修改的任务。

1. **弹窗样式**：进入任务编辑 → 发送到 → 私聊。菜单收起后应出现微信原生好友选择器；取消应回到原编辑页，整个插件弹窗仍存在，名称、正文、规则和原目标均保留。再对群聊重复一次。
2. **弹窗样式确认选择**：选择一个好友并完成，确认只改变“发送到”；再换群聊验证。反复打开、取消、重选，仍回同一个编辑页，不返回微信外层页面。
3. **全屏 / push 显示**：完整重复上述私聊、群聊的取消和完成操作，确认导航栈和草稿保留一致。
4. 在两种显示方式下验证“文件传输助手”和菜单“取消”；检查时间规则、星期菜单仍只修改对应字段。快速重复操作也不应叠出两个选择器。

本轮没有连接真机。录屏观察与宿主替身证明了失败路径，iOS 编译和包校验已覆盖交付代码，但真实 UIKit / 微信选择器的显示和转场仍需按上述步骤验收。
