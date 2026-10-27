# 2.0-17 自定义分组原生选人

当前 checkout 在 2.0-16 基础上修改，2026-10-26 完成核心回归与 Rootful / Rootless 打包。真机验收待安装本包后执行。

## 根因与失败证据

原 `CSChatGroupSettingsViewController` 的 `presentContactSelectWithType:tab:tagName:` 不区分私聊/群聊，统一创建 `WEContactSelectViewController`，套普通导航控制器，指定 PageSheet 和 medium/large detent，因此显示自建半屏页。

原 `showContactSelectForTab:` 与标签菜单在 action handler 中直接 present 下一页。当 UIKit 尚未完成 action sheet 的关闭转场时，原菜单仍占用 presenter，后续展示发生竞争。

改生产代码前，先运行实际入口方法的宿主替身测试，分别得到：

- [red-routing.log](red-routing.log)：`FAIL: private/group must use CSNativeContactPicker, never WEContactSelect PageSheet`。
- [red-race.log](red-race.log)：`FAIL: type handler must not present while its action sheet is dismissing`。

保存了 [改动前源码](before/CSChatGroupSettingsViewController.m)。最终测试入口仍可对该版本复现，两次均按预期退出 1：

```sh
CS_TEST_GROUP_SETTINGS_SOURCE=docs/audits/chatgroup-native-picker-2.0-17/before/CSChatGroupSettingsViewController.m bash Tests/verify-group-picker.sh
CS_TEST_GROUP_SETTINGS_SOURCE=docs/audits/chatgroup-native-picker-2.0-17/before/CSChatGroupSettingsViewController.m CS_TEST_GROUP_PICKER_RACE=1 bash Tests/verify-group-picker.sh
```

## 最终行为和代码范围

- 私聊/群聊调用 `CSNativeContactPickerPresent` 多选接口；该适配器使用原生好友/群聊控制器及 `MMUINavigationController`，保持全屏、搜索、完成、取消。共享适配器本身没有修改。
- 传入当前类别中能够识别的已有成员作为预选；完成后将原生选择结果与其他类别、自身、服务号和无法解析的原成员合并、去重、排序，再整体写回 `sessionUserNames`，更新 `updateTime`，调用原 `saveCustomTabs` / `setupData` / `reloadData`。取消不回调保存，名单和时间戳均不变化。
- `contactSelectionValidatorForTab:` 在菜单进入、选择、完成以及关闭后写回处复查 `canEditAccount`、稳定 tab ID、账号 epoch、隐私 revision / blocked、preferences 和规范化 tab 对象身份。`CSGroupPreferences.reload` 在定义不变时复用对象；其他页面保存定义后会替换对象，因此旧选择不能覆盖新定义。账号 A → B → A 也会因 epoch 变化失效。
- 监听现有隐私/账号通知，调用共享选择器的 `Revalidate`：过期列表原地隐藏，完成不可用，取消可返回；不会 dismiss 插件容器。
- 提取 `CSSettingsPresentation.h`，分组与定时任务共用 2.0-16 收尾规则：菜单已关闭则继续；关闭中观察其 transition coordinator，转场取消则终止；尚未关闭只 dismiss 菜单，并等待 completion。展示前检查窗口、导航栈顶、父容器关闭状态及是否已有其他模态页，没有固定延时。
- 标签/全部仍使用原页面；标签选择后的下一次展示也经过相同收尾逻辑。其完成回调改为页面关闭后执行，以便原有保存失败提示能显示。
- 同步版本、发布说明、README 与分组文档。投影、角标、共享原生选择器、备份/密友存储均未改动。

## 标签、全部与隐私边界

`CSNativeContactPickerPresent` 的类型只有 `BOOL groups`，不能表达指定标签或全部联系人/服务号。现有标签流程使用 `ContactTagMgr.getAllLabelName` 与 `getContactsForTagName:`，仍保留。没有基于猜测使用未验证的原生标签参数。

原 `WEContactSelectViewController` 的自定义组配置页面没有专门的密友过滤；它依照联系人类别、标签和搜索决定候选。新增入口沿用同一配置管理边界和共享原生管理选择器，不将“已在分组中的密友”从配置中删除。真实会话列表仍在 `CSGroupProjection.m` 按 `hiddenUserNames` 过滤（当前第 203 行），加入自定义组不会解锁或显示被隐藏会话。隐私状态变化会使本次未提交选择失效。

## 核心回归

| 入口 | 断言数 | 结果 |
| --- | ---: | --- |
| `bash Tests/verify-group-picker.sh` | 427 | 通过 |
| `CS_TEST_GROUP_PICKER_RACE=1 bash Tests/verify-group-picker.sh` | 2 | 通过 |
| `bash Tests/verify-native-contact-picker.sh` | 196 | 通过 |
| `CS_TEST_SCHEDULED_PICKER=1 bash Tests/verify-native-contact-picker.sh` | 278 | 通过 |
| `bash Tests/verify-group-preferences.sh` | 23 | 通过 |
| 合计 | **926** | **0 失败** |

以上是断言数量，不是 926 个独立真机场景。未运行全量脚本或分组投影/角标回归；定时任务仅回归与抽出菜单工具直接相关的设置容器/选择器展示。

新增 `GroupPickerPresentationTests.h` 从生产源码提取实际选人入口、校验与完成方法，链接实际 `CSNativeContactPicker.m`、`CSGroupPreferences.m`、`WESessionTabItem.m`。UIKit、微信联系人及 defaults 是宿主替身，不写真实账号配置，不发送消息。

覆盖弹窗与 push 两种宿主、私聊/群聊、菜单已关闭/关闭中/待关闭、完成与取消、预选重新打开、多选去重、清空当前类别、混合成员保留、新建空分组、切账号、同账号 epoch 变化、隐私变化、组被删除或其他实例编辑、取消的转场、宿主失效/占用以及标签/全部保留。具体日志与计数见 [validation.json](validation.json)。

## 构建与产物

从当前 checkout 构建，复制前一版任务缓存到独立临时构建目录，未运行 `make clean`。Rootful 与 Rootless 均编译成功；保留既有弃用 API / 链接器警告，没有编译错误。

两包均为 2.0-17，分别验证 `iphoneos-arm` / `iphoneos-arm64`、安装前缀、arm64/arm64e 切片、dSYM UUID、当前分组入口与定时任务收尾符号、无测试替身、首个存储初始化入口。构建前后核对未授权修改的文件树、既有 `.theos`、历史 deb / symbols 均保持原字节。结果见 [package-check.log](package-check.log)、[packages.json](packages.json)。

- [Rootful deb](../../../packages/com.wechat.improve_2.0-17_iphoneos-arm.deb)
- [Rootless deb](../../../packages/com.wechat.improve_2.0-17_iphoneos-arm64.deb)
- [调试符号](../../../packages/com.wechat.improve_2.0-17_symbols.zip)

## 真机验收

1. 安装对应包，确认插件显示 **2.0-17**。将插件显示方式设为“弹窗”，进入聊天分组，创建一个空自定义组。
2. 点击该组 → 私聊：应出现微信原生全屏多选页，搜索后勾选两个好友并点完成。应返回原分组设置，插件容器保持打开；再次进入私聊应能看到两人已勾选。
3. 进入群聊，勾选两个群并完成。再次分别进入私聊与群聊，原好友与群均保留。取消勾选一人并完成只改好友名单，已有群不受影响。
4. 分别在好友、群聊选择器中修改勾选后点取消；再次打开，仍为取消前的已保存名单。取消类型菜单也不应修改配置。把当前类别全部取消并完成，应只清空该类别的可选成员。
5. 将显示方式切为“全屏/push”，重复步骤 2–4；两种模式都不应出现插件整体退出、空白宿主或重复展示。新建组与已有混合组均检查一次。
6. 检查标签 → 指定标签、全部仍能选择并保存；标签筛选能力未丢失。检查密友锁定后，真正聊天分组列表仍按原规则隐藏相关会话。若选择中途锁定或切换账号，旧完成结果不得保存；取消后重新进入当前账号即可重新选择。

本机测试没有连接真机微信，原生私有控制器在目标微信版本上的实际展示仍需以上验收确认；不支持原生接口时显示错误并保留名单，不退回自建私聊/群聊半屏页。
