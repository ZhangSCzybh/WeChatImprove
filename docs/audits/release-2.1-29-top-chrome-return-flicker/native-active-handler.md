# active-name 回调的定点原生静态核查

结论：现有微信 8.0.78 二进制中，`MainFrameLogicController.onActiveUsrNameChange:curUsrName:` 的完整有界函数体没有直接发送 `getBanner:`、banner/header 更新、`reloadSessions` 或 notification selector。其可见业务边界是重置红包启动模式、取消旧选中 cell、在 split-view 条件下按新身份选中 cell。这缩小了“收窄 active-name 归属会漏掉本体直接 banner 更新”的风险；**不证明派生调用没有全局效果，也不证明用户现场的闪烁就是这条路径。**

本次只读取既有 `/tmp/wechat-8.0.78-inset-analysis/WeChat`；REA `open_binary` 识别 arm64 Mach-O，SHA-256 为：

```text
0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e
```

REA `inspect_macho` 在 60 秒超时，返回 `provider_timeout`，无 stdout/stderr；未重试、未启动 Ghidra 全量导入、未对目标执行。REA session 已 `close_binary` 关闭。以下方法/指令结论来自复用仓库已有的只读 Objective-C metadata decoder 与 LLVM 有界反汇编，不能归为 REA 已成功提供的 method dossier。

复用源为 `docs/audits/tabbar-wechat-badge-2.1-6-2026-10-29/native/metadata.json`、同目录 `extract.py` 的只读 Mach-O helpers 和 `disassemble.py` 的 selector-reference 注释方式；旧文件均未写入。该 metadata 中的 SHA-256 与本次 REA 打开结果一致。

| 核查项 | 观察 |
| --- | --- |
| Objective-C method entry | `0x104aa8398` |
| Objective-C type encoding | `v32@0:8@16@24`，即 void 返回、两个 object 参数，与现有 hook 匹配。 |
| 边界 | 按该二进制 `LC_FUNCTION_STARTS` 取下一入口 `0x104aa8548`，共 432 字节；末尾 tail branch 到 runtime release stub。 |
| `0x104aa8424–0x104aa842c` | 向通过 service lookup 得到的对象发送 `resetCurrentRedEnvLaunchMode`。 |
| `0x104aa8448–0x104aa8498` | old 参数非 nil 时，经 delegate weak-load 和 `respondsToSelector:` 检查后发送 `cancelSelectedCell`。 |
| `0x104aa849c–0x104aa84d4` | 查询 `getAppViewControllerManager` / `isUsingSplitView`。 |
| `0x104aa84d8–0x104aa8528` | 仅 split-view 分支，经 delegate weak-load 和 `respondsToSelector:` 检查后发送 `selectCellForName:`，传入 new 参数。 |

指令保存在同目录 `native-active-handler.asm`。提取命令为：

```text
xcrun llvm-objdump -d --start-address=0x104aa8398 --stop-address=0x104aa8548 /tmp/wechat-8.0.78-inset-analysis/WeChat
```

其 `selector` 行注释由 selector-reference 数据解码而来。LLVM 输出的最近保留全局符号 `_Flutter_MMFoundation_BindContext` 不是此方法的身份；入口身份以上述 ObjC method metadata 为准。注释不证明动态接收者类型、目标执行或具体 return 触发频率。

边界与限制：没有追踪 `cancelSelectedCell` / `selectCellForName:` / service reset 的完整传递调用图，不能排除它们触发派生 reload、布局、其它插件回调或业务更新。此次仅核对同一份 8.0.78 文件；其它微信版本、手机实际加载实现链及自然返回事件顺序仍 pending。嵌套显式未知 content 事件仍须保留 `pendingContentUnattributed=YES`，不得因本体的有界负面结果而全局抑制未知 banner 刷新。

源码补丁的只读审查还确认：old/new 任一非 nil 且无法可靠解析时整次回退未知；两个合法身份取 union；原生 body 保留 native index scope，`@finally` 结束 transaction；通用 `NativeEvent` 未改，显式未知嵌套事件仍传 nil 归属。adapter 累积的 unattributed 标记不会被外层已知 names 清掉。普通 generic reload 的继承行为与既有逻辑一致。该审查没有修改生产代码、版本、Tests 或包。
