# 微信 8.0.78 未读汇总到 tab badge 的静态证据

本轮仅分析本地 Mach-O，没有启动微信或连接设备。镜像为 `/tmp/wechat-8.0.78-inset-analysis/WeChat`，arm64，既有镜像记录版本为微信 8.0.78 / build 8.0.78.34，SHA256：

```text
0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e
```

它与历史角标审计使用的镜像一致；尚未核验用户设备实际加载镜像的 UUID、版本或 Hook 安装结果。地址为未加 ASLR slide 的镜像虚拟地址。

## 提取方式和边界

`extract.py` 解析 Mach-O 段、Objective-C 类/方法/ivar、selector references；`metadata.json` 保存结果，`methods.json` 保存本轮选中方法的起止地址、类型编码及输出文件。`disassemble.py` 用本机 Xcode `llvm-objdump` 按这些地址做有界反汇编，并对 selector/class/字符串引用作注释。以 metadata 中的方法范围辨认方法，不能把 objdump 展示的泛化符号标题当成方法名。

REA 打开镜像成功，但 `inspect_macho` 超时后被工具终止，错误原文保存在 `rea-macho.json`；随后关闭会话。本目录证据来自本地 parser + LLVM，不冒充 REA 反编译或运行观测。执行输出见上级 `logs/native-extraction.log`。

## 已闭合的同步边

| 方法 / 证据文件 | 关键地址与含义 |
| --- | --- |
| [MainFrameLogicController onSessionTotalUnreadCountChange:](MainFrameLogicController--onSessionTotalUnreadCountChange_.asm)，IMP `0x104aa8180` | `0x104aa81ac–81c0` 检查 delegate 是否响应 `updateUnReadCount`；`0x104aa81d4–81e4` 直接同步发送该消息。delegate ivar 由 metadata 核对。 |
| [NewMainFrameViewController updateUnReadCount](NewMainFrameViewController--updateUnReadCount.asm)，IMP `0x1051129d4` | `0x105112a04–a1c` 从主列表 logic 读取 `getTotalUnreadCount` 并保存；`0x105112bd4` 将保存的 count 置于参数 w2，`0x105112bdc` 取 `setTabBarBadgeValue:forIndex:` selector，`0x105112be0` 令 x3=0，`0x105112be4` 同步发送。该边没有 dispatch/延时。 |
| [MainFrameLogicController getTotalUnreadCount](MainFrameLogicController--getTotalUnreadCount.asm)，IMP `0x104aa64fc` | 原生 `m_bReadyToLoadData` 未就绪时可以直接返回 0；就绪时取 `MMNewSessionMgr` 服务并发送 `GetTotalUnreadCount`。因此现场要记录原生输入，不能先假定它是正数。 |
| [MMNewSessionMgr GetTotalUnreadCount](MMNewSessionMgr--GetTotalUnreadCount.asm)，IMP `0x104521bf8` | `checkLoadData` 后读取原生 `m_uiTotalUnReadCount`。 |
| [MMNewSessionMgr recountUnReadCountAndFireExtension](MMNewSessionMgr--recountUnReadCountAndFireExtension.asm)，IMP `0x10452e9a8` | 以 `onSessionTotalUnreadCountChange:` selector 通过 `callExtension:selector:block:` 广播。没有在本轮把扩展分发 block、完整消息接收路径及线程调度都还原。 |

结合 `Hooks/SessionGroupHooks.xm:46`、`:200`：如果本次回调有主列表 adapter/table，插件先 begin 事务，再进入上述原生同步边。该 adapter 的 `changeDepth>0`，旧 snapshot revision 同时失效；若密友过滤有效且没有另一个可用主 adapter，过滤 getter 会返回 `@0`。这是源码和静态镜像共同证明的**条件路径**。尚不能说用户那一条新消息一定满足全部条件。

## 内容值到原生可见状态

| 方法 / 证据文件 | 关键地址与含义 |
| --- | --- |
| [MMTabBarController setTabBarBadgeValue:forIndex:](MMTabBarController--setTabBarBadgeValue_forIndex_.asm)，IMP `0x1047263ac` | `0x10472649c–4d4` 取指定 tab item 并调用它的 `setTabBarBadgeValue:`。 |
| [MMTabBarItemView setTabBarBadgeValue:](MMTabBarItemView--setTabBarBadgeValue_.asm)，IMP `0x1047272b0` | `<1` 分支跳到 `0x104727474`，`0x10472747c–48c` 对原生 badge 发 `setHidden:YES`；正数分支 `0x104727400–424` 设可见再 setValue。末尾调用 `layoutBadgeView`。 |
| [MMTabBarController setTabBarBadgeString:forIndex:](MMTabBarController--setTabBarBadgeString_forIndex_.asm)，IMP `0x104726534` | `0x104726628–638` 检查 length；空串或 nil 到 `0x104726690–6a0`，发送 `setBadgeViewHidden:YES`。 |
| [MMTabBarItemView setBadgeViewHidden:](MMTabBarItemView--setBadgeViewHidden_.asm)，IMP `0x104727298` | 直接取原生 badge ivar 并转发 `setHidden:`。 |

数字 controller setter 的类型编码为 `v32@0:8Q16Q24`，字符串为 `v32@0:8@16Q24`，与项目安装 Hook 使用的参数 ABI 一致。ABI 与 selector 的存在只能证明静态安装前提成立，不能替代设备上的 capability/实际调用记录。

这些内容隐藏证据与样式 adapter 的 frame 位移证据互相独立。`hidden=YES` 时只修位置不能恢复原生显示；`hidden=NO`、数值正确时仍需检查真实 frame、祖先裁剪和覆盖。

## 尚未证明

- `AsyncOnAddMsg:MsgWrap:` 到本次原生未读重算、扩展分发的完整调用顺序、线程和次数。
- 用户设备当次原生 count、过滤策略、adapter/cache/epoch/账号相等性及 Hook 是否实际安装。
- 冷启动时与收到消息后是否命中相同 setter、相同过滤状态，以及刷新之后是否另有原生写入恢复。
- 真实 badge 的层级、裁剪链与视觉覆盖；本目录的静态边不代替四象限采样。
