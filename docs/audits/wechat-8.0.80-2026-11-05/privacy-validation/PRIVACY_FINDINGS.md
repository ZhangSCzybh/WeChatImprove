# 密友入口的微信 8.0.80 兼容记录

分析对象是用户提供 IPA 的 REA 提取目录 `rea-extracted-3052a2ef-a112-4e10-88b7-75cbdfda71bc/Payload/WeChat.app`。Info.plist 显示 `com.tencent.xin`、`CFBundleShortVersionString=8.0.80`、`CFBundleVersion=8.0.80.34`，主 Mach-O 为 545,074,336 字节。未执行 IPA、未读取或修改用户微信数据。

## 可直接从交付二进制确认的事实

- `FTSHomeViewController -onGetTextInput:isFromVoice:` 编码是 `v28@0:8@16I24`，IMP 为 `0x10189dee8`。旧代码只接受 `v@:@B`，会被现有完整签名检查拒绝。修复为根据实际签名选择 unsigned int 或旧 BOOL 分支，并完整传递来源枚举值。
- `FTSHomeViewController -onTextFieldChanged:` 在 `0x101899a34` 读取 `markedTextRange`、`text`，再传给 `mmInputBoxTextChanged:text:`。
- `-mmInputBoxTextChanged:text:` 在 `0x101899538` 对首参判空，非 nil 时于 `0x101899548` 调用 `isEmpty`；空范围和 nil 都继续普通搜索。首参为输入法 `UITextRange`，不能用“非 nil”判断是否仍在组成态。新实现按 `-isEmpty` 的精确 BOOL 签名读取，未知对象仍保守视为组成态。
- 首页类 `NewMainFrameViewController` 仍有 `m_titleView`（`MFTitleView`）及 `fakeNavBarView`（`MainFrameCustomBarView`）。`initNavigationTitileView` IMP `0x1053f1b68` 将原生标题放入 navigationItem 的 `titleView`，该对象可直接作为长按命中目标。`MainFrameCustomBarView` 亦提供 `setTitleView:`、`titleViewContainer`。
- `NewMainFrameViewController -viewDidLayoutSubviews`、`-initNavigationTitileView` 的编码均为 `v16@0:8`，可在这些现有生命周期后更新手势附着。保留了原先 `viewDidAppear:` 初始化与账号刷新。

原始及已解析 metadata 在 `objc-metadata.json`；定点反汇编和选择子注释在 `search-input-tail-annotated.txt`、`home-title-disassembly-annotated.txt`。完整编辑方法头部的反汇编由主任务保存在上一级 `search-input-disassembly.txt`。`objc_metadata.py` 仅读取本地 Mach-O 的段、指针修复记录与 Objective-C 元数据。

## 实现与边界

长按现在优先附着当前微信原生标题（再回退 navigationItem.titleView、导航栏）；标题重建后禁用旧 recognizer 并更新新目标。长按行为仍执行既有启用开关、时长、前台、当前导航页、模态页、账号 epoch、blocked、biometric 规则；当前标题被替换或离开 window 后不能触发。既有非生物识别快捷解锁政策保持原样，没有新增绕过验证路径。

搜索仍仅消费通过既有运行时完整密码验证的查询；普通文本、前缀、输入法组成态、语音来源、原生实时建议、历史、Return、异步取消/账号切换都走既有逻辑。未改密码、Keychain、策略默认值、存储位置或账号数据。

## 离线行为验证

执行 `python3 docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/run_validation.py`。runner 将生产 adapter、hooks 和恢复手势方法原样提取，仅在 UIKit/微信原生对象边界使用测试替身，在当前目录 build 中编译执行；不会恢复或写入已删除的项目 Tests 目录。

- 旧 BOOL 搜索边界：108 项断言通过。
- 8.0.80 unsigned int 搜索边界：109 项断言通过，包括空 marked 范围与完整来源枚举。
- 单独 unsigned int 入口对照：108 项断言通过（复用搜索回归，不应累加为独立覆盖数量）。
- 恢复手势：32 项断言通过，包括当前原生标题、替换标题、离屏标题、重复 layout、模态页、账号切换、时长变更与生物识别失败。
- 同一测试替身配合 HEAD 旧生产逻辑的负对照，分别实际失败在空 marked 范围、unsigned int 完整密码进入原生语音方法、标题未收到 recognizer，详见 `results.json` 和 `build/baseline/*.log`。

编译命令启用 ARC、blocks、Wall/Wextra/Werror。仅 baseline 比较的 fixture 声明可能包含旧源码尚无的方法，显式关闭该 fixture 的 incomplete-implementation warning；其他告警仍为错误。

## 推断与待真机确认

空范围判定及 unsigned int 签名是可证实的旧兼容缺陷。新版自定义导航与标题承载导致导航栏范围的 recognizer 未收到标题触摸，是与用户现象一致的静态推断；离线替身确认新实现在标题与自定义栏分离时有效，但不能声称已观察用户设备上的实际命中链。

此 IPA 预注入了其他插件；本子任务没有执行这些插件或复现其运行时 hook 链。最终必须在用户原重签安装环境确认：首页搜索输入完整密码、长按当前标题、组成态与普通搜索、解锁到期/后台失效及其他注入插件共存。这里不将离线验证表述为真机验收。
