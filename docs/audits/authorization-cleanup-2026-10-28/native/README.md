# 授权清理：微信 8.0.78 静态核验

本目录只读分析已在仓库审计中选定的微信可执行文件 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，没有启动微信或执行 URL。重新计算的 SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`；arm64，UUID 为 `9CD58B8E-B7AB-3487-ADBD-2AC0AA16A5DE`，LC_ENCRYPTION_INFO_64 的 cryptid 为 0。版本 8.0.78、build 8.0.78.34 的来源是摘要完全匹配的既有 `docs/evidence/message-actions-native-2026-10-17/manifest.json`。该来源说明样本来自先前提取的本地第三方 IPA，没有验证当前设备安装实例的运行身份。本次静态证据不能扩大为不同微信二进制、全部机型或系统版本的实机保证。

## 关注查询

| 项目 | 实际元数据 / 实现 | 清理结论 |
| --- | --- | --- |
| `CContact +isBrandFollowedWithUsername:` | 类方法实际 IMP 为 `0x100bb11cc`，结束地址 `0x100bb12e8`，编码 `B24@0:8@16`，即 BOOL 返回、一个对象参数。不是只存在于导出头文件。 | 此样本正常加载时有该类方法，不存在从本样本推出“部分机型没有方法”的依据。 |
| 原生关注判定 | 每次进入方法执行 `MMContext.currentContext` → `getService:CContactMgr.class` → `getContactByName:username`。联系人非空，且 `isBrandContact` 真、`isWeAppContact` 假时，返回 `isMMContact`；否则返回 NO。继承的 `CBaseContact -isMMContact` 位于 `0x100f84460`，读取对象偏移 `0x64` 的最低位。 | 调用点每次仍须调用该方法；本方法的静态实现也没有把上次授权结果直接返回。微信内部联系人服务可能使用缓存，不能将这里的“每次实时查关注”误写成“每次请求微信服务器”。 |
| `CContactMgr -getContactByName:` | 实际 IMP `0x100fcd954`、编码 `@24@0:8@16`；本地联系人获取实现存在。 | 兼容分支依赖的方法存在。 |
| `CContact -m_uiBrandSubscriptionSettings` | 实际 IMP `0x100f92cf4`，编码 `I16@0:8`；读取 ivar 偏移表后返回 unsigned int 属性值。原生 `isBrandFollowedWithUsername:` 没有调用它。 | 两套判定不能由本证据宣称等价；本次不改变属性值 `> 0` 的既有兼容语义。 |

插件的属性兼容分支仅在其前置 `CContactMgr` 类与服务均存在、并且 `CContact` 类不存在、原生查询 selector 不存在，或原生查询抛出 Objective-C 异常时进入。原生查询正常返回 NO 时立即返回 NO，不会回落到属性判定。在本样本未被动态修改的正常加载情形，类/方法缺失不是预期路径；静态方法存在并不证明其所有动态服务调用永不抛异常。删除属性分支会改变原生查询异常后的结果，而任务明确要求不改行为，因此列为“存疑未删”。这不是声称某类机型必定需要属性分支。

## 打开公众号与两种 URL

`TingRouter +openBrandProfileWithUsername:` 的实际 IMP 为 `0x105e3071c`，结束地址 `0x105e307e4`，类型 `v24@0:8@16`。实现调用 `brandContactByUserName:`，创建 `ContactInfoViewController`，设置联系人、来源场景 60 和空 delegate，再向 `CAppViewControllerManager.topNavigationControllerOnMainWindow` 调用 `PushViewController:animated:YES`。返回类型是 void，没有失败 BOOL 或失败 completion。正常返回只能说明消息调用完成，不能静态保证导航对象存在或页面已经展示。

插件当前三级链的触发边界如下，本次全部保留：

1. `openOfficialAccountFromViewController:` 正常调用 TingRouter 后不会尝试 scheme。仅 TingRouter 类缺失、selector 缺失，或调用抛异常才转入 `openBrandProfileDirectly`。
2. `openBrandProfileDirectly` 请求 `weixin://profile/<公众号ID>`，仅系统 `openURL:options:completionHandler:` 回调的 success 为 NO 时转入 `tryAlternativeURLScheme`。TingRouter 页面未显示、但未抛异常，以及系统回调 success 为 YES、但微信没有显示资料页，都不会自动触发下一级。
3. `tryAlternativeURLScheme` 请求 `weixin://findfriend/verifycontact?username=<公众号ID>`，失败后只有日志，没有第四级。

静态证据确认两种 URL 的相关原生处理代码都实际存在，不能以字符串未命中或方法已存在为由删除整级：

| URL | 原生证据 | 本次能确认与不能确认 |
| --- | --- | --- |
| `weixin://profile/<username>` | `MMWebViewController -shouldHandleJumpProfileUrl:` 位于 `0x1048c1828`，用 `rangeOfString:@"weixin://profile/"` 的位置等于 0 判断前缀；`-handleJumpProfileUrl:` 位于 `0x1048c1858`，截取前缀后的 username，查询 profile JS API 权限后调用 `headImageJumpToProfile:withViewController:Scence:`。另有 `weixin://profile/%@` 的原生生成引用。 | 能确认微信内部 WebView 处理该精确路径形态。不能把 WebView 跳转能力直接等同于 UIApplication 从外部重新进入微信时一定会使用相同处理器。权限、宿主和导航状态仍影响实际结果。 |
| `weixin://findfriend/verifycontact` | `UrlController -handleUrl:withExtraInfo:` 位于 `0x105f6e634`，`0x105f6e7d8` 引用该前缀；匹配后跳至 `0x105f6e9f8`，用正则 `weixin://findfriend/verifycontact/([^/]*)`、capture 1 提取路径中的 username，然后调用 `verifyContactByUsrName:`。 | 能确认带 `/username` 的内部路由实现。该分支没有从 queryItems 中读取 `username`；插件现有 `?username=` 形态与这份路径正则不一致，因此不能宣称该精确备用 URL 已被验证可用。本次没有证明不存在其他处理器，也没有实际执行外部 scheme；按“不能证明就保留”的约束保留并记录疑点。 |

本次不修正备用 URL 参数，也不把 void 路由改成可反馈结果的接口，因为两者都会改变现有行为或导航路径。`UIApplication` 的 success 回调只能用于描述本地 API 给出的打开结果，不能在审计结论中代替微信页面成功证明。

## 可复核证据与工具限制

`metadata.json` 来自当前样本 Objective-C 类、元类、方法表、类型编码、ivar 及 category 的离线解析；`methods.json` 标注实际 IMP 和 LC_FUNCTION_STARTS 的结束地址；同名 `.asm` 是 Xcode LLVM 对这些方法边界的有界反汇编，注释仅解码静态 selector/class/CFString 引用。`url-evidence.json` 记录四个精确字符串、CFString 常量及有界 ADRP+ADD 引用，`url-methods.json` 将引用所在函数映射到 Objective-C 方法名。这是静态解析证据，不是 REA 反编译成功的伪代码。

REA 的 `open_binary` 已返回并确认文件身份，记录在 `rea-open.json`。`get_objc_classes` 需要先完成整份微信的 Ghidra 自动分析，在本轮有用等待期内未返回，已取消；随后停止本轮创建的临时 Ghidra helper，`close_binary` 成功返回 `result:null`，最后 `binary_session` 验证 `open:false`。没有使用未完成的分析结果，也没有改动 REA 配置或原始微信二进制。关闭记录见 `rea-close.json`。`manifest.json` 记录目标身份、来源限制及本目录证据摘要。

可通过 `python3 disassemble.py` 重建元数据和已选方法的反汇编，`python3 url-evidence.py` 重建有界字符串引用证据；脚本假设上述既有静态样本仍在原路径。辅助 Python 运行缓存已清理，不作为交付证据。
