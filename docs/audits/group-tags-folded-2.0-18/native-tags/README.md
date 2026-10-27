# 标签原生化证据（2.0-18）

目标为用户项目已分析的微信 8.0.78 arm64：`/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。本次使用 REA 打开此二进制；其 native dispatch metadata 操作遇到 64 MiB snapshot budget，未重复同一失败请求。后续复用仓库只读 mmap 元数据解析器与有函数起止边界的 `llvm-objdump`，不执行微信、不修改旧证据。完整方法签名和范围见 `methods.json`、`manifest.json`；汇编注释是静态解析，不是运行日志。部分 classref 自动注释会显示乱码，类身份使用 `classes.json` 的地址反查确认。

## 观察到的真实接口

| 观察 | 位置 / 证据 |
| --- | --- |
| 好友多选页有标签开关与入口 | `MultiSelectContactsViewController` 的 `setM_bShowContactTag:`（`v@:B`）与 `onSelectContactTag`（`v@:`）；已有原生朋友圈隐私入口 `WCMomentsPrivacyViewController--openAddFromFriend.asm` 也设置该开关 |
| 标签列表由微信自己创建 | `onSelectContactTag` 起点 `0x104eaa7b4`，创建 `ContactTagListViewController`，`setDelegate:self`，`setCanEditTagLabel:NO`，由原生代码设置 scene，再通过 `MMPageSheetAdapter` 展示 |
| 标签选择写入好友页当前勾选 | `contactTagListViewController:didSelectContactTag:` 起点 `0x104e9ee18`，用 `getValidContactsInContactTag:` 遍历成员，在 `0x104e9efc8` 取得 `updateMultiSelect:fromRecommendSection:fromInputView:needReloadTableView:`，随后对 `m_selectView` 调用；完成后刷新原生表格，不调用微信发送/建群动作 |
| 另有原生标签成员详情选择页 | `doTagSearch:arrContacts:` 起点 `0x104eaf6ac`，创建 `SelectTagContactsViewController`（classref `0x1201778f0`），传入真正的 `setTagName:` 与过滤后的 `setM_arrTagContacts:` |
| 标签成员详情页不能直接当作完整搜索选择器 | 检索该类完整方法表及 `viewDidLoad/initView/initData`，未找到搜索方法/搜索控件配置。它的 `m_dicMultiSelect` 也是 ivar，不能把其它选择器的 setter 合同照搬过去。此结论仅限此类/此版本的静态边界 |
| 标签页的容器为原生模态 | `MMPageSheetAdapter showFromViewController:animated:complete:` → `MMPageSheetContainerViewController showPageSheetAnimated:parentView:parentViewController:complete:`，后者创建导航容器、设置原生 presentation delegate、调用 `PresentModalViewController:...completion:`。标签页样式由微信决定，并非插件原 WEContactSelect 的 PageSheet |

## 采用的方案

`CSNativeContactPickerPresentTags` 复用原生好友多选页，开启已核实的标签开关；在该页实际 presentation completion、账号/配置校验与可见宿主校验均通过后调用原生 `onSelectContactTag`。类型菜单仍使用 2.0-16 的 sheet 自身转场完成工具，不用固定延时。

流程是 **原生标签列表批量勾选 → 原生好友页搜索、逐人调整 → 原生完成保存**。这是微信已有的标签批选流程，不伪装成“在 MultiSelectContactsViewController 上塞入 tagName 的标签过滤页”。只读当前 `m_selectView.m_dicMultiSelect`；取消不提交；最终结果仍做类别/账号/配置校验。标签批量回调即使绕过单联系人 delegate，也不能绕过最终校验。

私聊与标签编辑只替换可解析的普通联系人类别，保留已有群聊、服务号、自己和无法解析成员。已有隐私成员不会因为打开选择器被删除；沿用已有原生联系人/标签展示的隐私 hooks。账号 epoch、隐私 revision 或配置身份失效后禁止提交，遮住父选择页与原生标签内容，并仅关闭该原生子模态，保留外层取消。未接入微信标签管理/修改接口。

能力或签名不匹配时显示现有“无法打开微信原生选择器，原有名单已保留”错误，不退回自带标签页，也不修改配置。

以上为静态接口证据与 host 替身回归。标签页实际样式、搜索行为、原生回调与第三方插件组合仍需微信 8.0.78 真机验收。
