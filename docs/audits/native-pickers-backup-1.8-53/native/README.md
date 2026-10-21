# 微信 8.0.78 原生选择器证据

目标沿用此前已核验的 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。本次 REA session 查询没有打开的目标；复用项目已有 Mach-O 元数据解析器与 LLVM 按方法边界反汇编，无整镜像反编译、目标运行或真机操作。

- `GroupSelectContactsViewController.initData` 在 `0x101ecc9e0` 开始重新创建 `m_dicMultiSelect`；在显示之前回填已选项才能保留预选。
- `GroupSelectContactsViewController.actionDone` 调用 `onGroupMultiSelectContactReturn:`，传入已选字典的 `allValues`。原生取消使用 `PopViewControllerAnimated:`，插件以模态方式呈现，因此仅在插件子类上接入关闭操作。
- `MultiSelectContactsViewController.init` 默认设置 `m_scene=28`。`initView` 在 `0x104ea5e30` 向内部 `ContactSelectView` 传入预选字典；原生 `actionDone` 在 `0x104ea1b20` 起读取内部选择视图的实时 `m_dicMultiSelect`。适配层使用同一实时来源。
- `ContactsDataLogic.filtInContacts:` 使用 `0x118d84930` 的字节跳转表。`data-scenes.json` 保留表地址、文件偏移和目标地址：群聊场景 5 跳到 `0x1010a40a8`，使用 `filterHistoryGroupContacts:IgnoreOpenim:`；好友默认场景 28 跳到 `0x1010a4170`，使用 `filterMultiSelectContacts:IgnoreOpenim:`。群聊候选交给原生历史群聊场景获取。
- 原生群聊完成按钮在空选择时可能禁用。插件子类保留微信按钮与计数，只允许空名单提交；插件的完成操作只返回名单给设置页，不执行原生群聊创建或发送操作。

方法地址、精确 ABI 编码与完整方法界限见 `methods.json`；各 `.asm` 均未截断，文件摘要见 `manifest.json`。头文件来源为仓库 `HeadersFile`。运行 `extract.py` 后运行 `disassemble.py` 可更新证据；输入仅只读。

静态证据确认接口和控制流，不证明真机 UI 已运行。微信版本不兼容时，适配层的方法签名检查会阻止打开该选择器。
