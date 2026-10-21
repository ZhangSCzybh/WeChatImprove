# 原生群聊勾选与保存修复 · 1.8-55

基于 1.8-54（`6ee7a078`），处理“群聊选择器可以打开，但无法选择和保存”。密友群聊、红包白名单群、红包黑名单群共用同一原生选择适配器。

## 原因与依据

1.8-54 为 `GroupSelectContactsViewController.m_uiDataScene` 设置了 5。该场景提供单选历史群聊列表，不会切换 `m_dicMultiSelect`。设置页适配器需要多选，因此点击后既没有勾选变化，也没有可提交的新名单。

对已核验的微信 8.0.78 Mach-O 进行方法级静态检查，确认：

| 方法与地址 | 相关控制流 |
| --- | --- |
| `selectContact:`，`0x101ecda98` | 在 `0x101ecdad8` 判断场景是否为 4；仅为 4 时读取／切换已选字典、调用选择许可回调、更新按钮并刷新列表。其他场景进入单选 `onGroupSelectContactReturn:` 回调。 |
| `makeCell:contact:`，`0x101ecde00` | 在 `0x101ecdf30` 判断场景 4，使用已选／已存在状态显示原生勾选。 |
| `createInitRightBarItem`，`0x101ecceec` | 场景 4 创建原生多选完成按钮。 |
| 列表 `didSelectRowAtIndexPath:`、搜索 `didSearchViewTableSelect:` | 分别在 `0x101ece818`、`0x101eceb48` 调用同一个 `selectContact:` 入口。 |

方法边界、ABI 和完整反汇编保存在 `native/`，目标及文件摘要见 `native/manifest.json`。数据源场景 4 对应原生 `filterGroupContacts:IgnoreOpenim:`，依据复用 1.8-53 的 `native/data-scenes.json` 与 `ContactsDataLogic--filtInContacts_.asm`。这些是静态证据，不代表已经运行手机上的微信。

## 修复与验证

生产逻辑仅将群聊场景由 5 修正为 4，使列表勾选、搜索结果选择、已选字典和完成按钮使用同一套原生多选流程。1.8-54 保存原生 IMP 的递归修复继续保留。

此前主机测试直接修改已选字典，未模拟原生 `selectContact:` 按场景分支，因此没有发现该问题。本次补上已由二进制确认的场景分支，并通过原生按钮的 target／action 触发保存：

- 修复前在“点击群聊应勾选并更新完成计数”检查失败，见 `selection-before-fix.json`。
- 修复后选择器专项共 70 项通过，见 `host-results.json`。
- 三个入口均覆盖已有勾选、新增勾选、取消预选、完成计数、拒绝非群聊候选、保存实际选择、清空保存，以及勾选后取消不写入。
- 继续覆盖运行时额外子类下的递归修复、好友实时选择来源、重复回调、账号切换与授权失效。

测试使用真实适配器源码及主机 UIKit／微信接口替身，验证原生选择入口与按钮动作的调用语义；没有模拟真实列表绘制或手机触摸。

## 构建与交付

构建：`make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-55`，arm64／arm64e，最低 iOS 15.0。构建与安装包校验分别记录在 `build-result.json` 和 `validation.json`。

开发沿用 `/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove` 的 `codex/close-friends-148` 分支。交付包为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/com.wechat.improve_1.8-55_iphoneos-arm64.deb`；原项目 main 源码及历史安装包保留。

真机待验：安装并重新打开微信，在密友群聊、红包白名单群和黑名单群分别勾选一个群并完成，重新进入确认回填；再确认取消勾选、清空保存和取消退出正常。
