# 2.0-12：统一定时任务设置和图片表情入口

2026-10-26，在现有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 的 `main` 分支，接续 2.0-11 修改。已完成核心回归、iOS 双架构编译和 Rootful / Rootless 打包校验。没有连接微信真机；本机没有可用 iOS Simulator runtime，最终页面观感与真实原生选择器仍需设备验收。

## 反馈与定位

已查看 `/Users/zhangshichao/Downloads/IMG_7497.PNG`。图中横跨聊天图片的黑色“已添加到表情。”来自 `CSMessageImageStickerAdapter` 成功回调，经消息操作协调器反馈显示；微信自身也提供成功反馈，因此重复。

2.0-11 在首页直接放了图片表情开关，定时任务则手工创建普通 subtitle 单元格和开关，并调用 `WEContactSelectViewController`。这与其他功能页使用的 `CSSettingItem` / `CSSettingTableViewCell`、以及密友的微信原生选择器不一致。

## 修改

- `CSCustomViewController` 的“图片添加到表情”改为进入二级页；“定时任务”和图片表情两个入口显示进入箭头。
- 新增 `CSImageStickerSettingsViewController`，沿用公共设置单元格、分组背景、默认行高和 54pt 文字/分隔线起点。开关继续读写 `com.wechat.enhance.image_sticker.enabled`，保留升级前配置与刷新链路。
- `CSMessageImageStickerAdapter` 的单项、同步及批量确认成功路径调用无提示的收尾。仍清理操作、观察者和委托；失败、待上传、未确认等有意义的反馈保留。没有修改微信提示，也没有改公共消息反馈实现。
- `CSScheduledTaskSettingsViewController` 的任务列表、编辑页和历史记录使用公共设置模型与局部单元格子类；长标题/详情限制在各自区域，超长时省略。消息正文独立进入多行编辑页，时间行进入系统滚轮选择；子页“完成”写回编辑草稿，任务页“保存”才持久化。执行记录点开查看完整内容。
- 私聊/群聊复用 `CSNativeContactPicker` 和微信 `MultiSelectContactsViewController` / `GroupSelectContactsViewController`。增加 `CSNativeContactPickerPresentSingle` 入口：原生逐项勾选最多一个目标，完成时再次检查恰好一个有效联系人，防止搜索/标签批量结果绕过限制。更换目标须先取消原勾选；空选或多选时不能完成，既不取第一项也不清空原目标。
- 选择类型弹层先完成关闭，再展示原生选择器。完成后才回填草稿，并验证账号、代次和隐私状态；取消或无效状态不写入。文件传输助手保留快捷入口。
- 密友和红包名单继续使用原多选 API，保留空名单保存、找不到的历史名单项和原生搜索/底部完成按钮行为。
- 同步 `control`、插件显示版本、内置更新说明、README 和功能文档至 2.0-12。

此次没有改变定时任务库格式、路径、调度与发送引擎，也没有改动公共设置单元格实现或密友设置页。上述四个既有文件与构建前哈希一致，见 `preserved-files.json`。

## 核心验证

| 检查 | 数量/结果 |
| --- | --- |
| `bash Tests/verify-native-contact-picker.sh` | 196 项通过 |
| `CS_TEST_SCHEDULED_STICKER=1 bash Tests/verify-message-actions-execution.sh` | 195 项通过 |
| `bash Tests/verify-scheduled-tasks.sh` | 102 项通过 |
| 三个设置/选择器文件在 arm64、arm64e 下严格编译 | 6 次通过，`-Wall -Wextra -Werror -Wno-unused-parameter` |
| Rootful / Rootless 构建、安装路径、版本、架构、符号校验 | 通过 |

总计 **493 项核心检查**，未运行全量脚本。测试使用临时任务库、独立偏好 suite 和原生接口替身，没有发送真实消息或上传真实图片。定时规则/存储回归用于确认本轮编辑入口调整仍对应既有模型契约；它不等同于 UIKit 交互测试。

新增覆盖包括：原生好友选择器的顶部/底部完成按钮、运行时子类、单目标勾选/更换、空选、搜索或标签溢出多选、失效目标、账号和隐私变化、关闭动画结束后的再验证，以及图片单项/同步/批量成功无插件成功提示且正常清理，失败/未知结果仍可见。

三份日志：`native-contact-picker.log`、`message-actions-execution.log`、`scheduled-tasks.log`。设置与选择器严格编译见 `ui-compile.log`。完整包构建仍有既有的 `UILocalNotification`、`statusBarFrame` 和 `multiply_defined` 弃用警告；本轮三个文件严格编译无诊断。

## 交付

- [Rootful 2.0-12](../../../packages/com.wechat.improve_2.0-12_iphoneos-arm.deb)
- [Rootless 2.0-12](../../../packages/com.wechat.improve_2.0-12_iphoneos-arm64.deb)
- [两种方案调试符号](../../../packages/com.wechat.improve_2.0-12_symbols.zip)

两个包均包含 arm64 / arm64e，最低 iOS 15.0；已核对 dSYM UUID、实际安装前缀、新页面/单选入口符号、测试替身未进入产物，以及首个初始化函数仍为 `CSPluginStorageLoad`。完整 SHA-256 和 UUID 见 `packages.json`；重复校验入口为 `python3 docs/audits/scheduled-sticker-ui-2.0-12/verify-packages.py`。

构建沿用既有独立 Theos 缓存路径，未执行 `make clean`。原 `.theos`、`packages/.DS_Store` 和 2.0-11 安装包均通过哈希保留校验。本项目是注入微信进程的插件，没有前后端服务 URL 或端口；交付为本地安装包，未更新手机内的实际运行代码或账号数据。

## 真机验收

1. 插件设置 → 功能增强 → 图片添加到表情：应进入二级页面，开关初值保持升级前状态。与“复读功能”等设置页比较浅色/深色背景、图标、行高和文字位置。
2. 打开功能，长按已下载图片添加到表情。原生成功反馈照常，截图中的黑色“已添加到表情。”插件提示应消失；表情栏应能看到结果。再验证失败时仍有原因提示。
3. 打开定时任务并编辑已有任务。长名称、长会话名、消息预览不覆盖标题或开关；正文编辑能查看完整多行内容，日期时间可正常选择。点击子页“完成”、任务页“保存”，返回后内容应保持。
4. “发送到”分别选择私聊与群聊：应打开微信原生列表及搜索；选择一个后可完成，取消保留原目标。更换时先取消原勾选。空选、标签/搜索多选不得提交。选中后切账号或重新锁定密友，过期选择不能写回。
5. 回到密友设置，确认好友/群聊仍可多选、取消、清空后完成保存，底部完成按钮仍有效。
6. 用文件传输助手创建每 1 分钟任务，验证连续执行、开关停止、保存后重新打开，以及历史记录详情。保持前台完成这次核心验收；手机后台准点能力仍受既有 iOS 限制。
