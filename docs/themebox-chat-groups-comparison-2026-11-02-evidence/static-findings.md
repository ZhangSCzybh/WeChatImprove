# ThemeBox 聊天分组：可核验的静态证据

分析对象：`/Users/zhangshichao/Downloads/Telegram Desktop/ThemeBox.dylib`

- SHA-256：`29d69aa8f608fee5317370275b8b029d4eb0428373f754a817dd55740aa8f3d9`
- ARM64 Mach-O dylib；LC_BUILD_VERSION platform 2（iOS），minOS 15.0；链接 UIKit；不是 macOS dylib。LC_ENCRYPTION_INFO cryptid=0。
- 本文地址均为未 ASLR 的 Mach-O VM 地址；该文件各有用段的 VM 地址与文件偏移相同（__TEXT.vmaddr=0/fileoff=0）。
- 只读取二进制、ObjC metadata 与 ARM64 指令；没有加载、运行或注入插件。静态解密脚本只对常量做算术折叠。

## 模型与关键方法（来自真实 Objective-C method/ivar/property metadata）

`ThemeSessionGroup` 的 ivars：`name: NSString`、`type: NSString`、`value: NSMutableArray`、`sessionInfo: ThemeSessionInfo`。

`ThemeSessionInfo` 的 ivars：`normalSessions: NSMutableArray`、`topSessions: NSMutableArray`、`unReadCount: NSInteger`、`redDotCount: NSInteger`、`showRedDot: BOOL`。

`ThemeSessionMgr` 的 ivars：`sessionGroups: NSMutableArray`、`lastCheckLoadDataTime: double`。

| 地址 | 方法 |
|---|---|
| `0xc0f6fc` | `+[ThemeSessionGroup allGroup]` |
| `0xc0ffd0` | `+[ThemeSessionGroup createGroupWithItem:]` |
| `0xc14ed8` | `+[ThemeSessionMgr shared]` |
| `0xc15b94` | `-[ThemeSessionMgr sessionGroups]` |
| `0xc175c0` | `-[ThemeSessionMgr updateGroups]` |
| `0xc18e38` | `-[ThemeSessionMgr checkLoadData]` |
| `0xc275cc` | `-[ThemeSessionMgr isSession:belongToCustomGroup:]` |
| `0xc278c8` | `-[ThemeSessionMgr currentGroup]` |
| `0xbcedd0` | `+[ThemeBoxUtil defaultGroups]` |

完整 method 列表在 `/tmp/themebox-static-all-methods.txt`；原始 otool 元数据在 `/tmp/themebox-static-objc.txt`。

## 自定义成员判定已证实

`isSession:belongToCustomGroup:` 的指令在 `0xc27840/0xc277ac` 取 group 的 `value`（selref `0x1481cf0`），`0xc27758` 取 session 的 `m_nsUserName`（selref `0x14814f0`），`0xc27780` 发送 `containsObject:`（selref `0x1481590`）；返回 Boolean。

对应语义：`[group.value containsObject:session.m_nsUserName]`。这是用户名数组的包含判定，没有发现这一方法内部使用 NSSet 或复杂规则表达式。

## 默认分组精确恢复

`+[ThemeBoxUtil defaultGroups]` 在 `0xbcfbb4` 及后续字典调用构造 `name/type` 两键字典；`0xbcfd0c` 以 count=5 构建数组。另一混淆重复分支也构建同样 5 个字典。

| 顺序 | name | type | name CFString | type CFString |
|---|---|---|---|---|
| 1 | 全部 | all | `0x153d090` | `0x153d030` |
| 2 | 私信 | chat | `0x153d010` | `0x153cfb0` |
| 3 | 群聊 | room | `0x153d070` | `0x153cf50` |
| 4 | 企业号 | openim | `0x153cfd0` | `0x153cf90` |
| 5 | 服务号 | brand | `0x153cf70` | `0x153cf30` |

字典键 CFString `0x153cff0`→字符缓冲 `0x153b2d1`→`name`；`0x153d050`→`0x153cf1f`→`type`。

恢复方式：逐条读取 `ldrb/ldrh → eor → strb/strh` 的静态源字节与 XOR 常量。例：

```python
from pathlib import Path
b = Path('/Users/zhangshichao/Downloads/Telegram Desktop/ThemeBox.dylib').read_bytes()
# 0xbcf434–0xbcf478，对应 all\0
print(bytes(x ^ k for x, k in zip(b[0x153cefa:0x153cefe], [0xe6, 0xed, 0x45, 0x1a])))
# 0xbcf538–0xbcf570，对应 UTF-16LE 全部\0
keys = b''.join(x.to_bytes(2, 'little') for x in [0xce0f, 0x9dcc, 0xfca9])
print(bytes(x ^ k for x, k in zip(b[0x153cf02:0x153cf08], keys)).decode('utf-16le'))
```

其他明确解密块：`chat`=source `0x153ceb8` XOR `[c9,08,66,de,af]`，指令 `0xbcf620–0xbcf670`；`room`=source `0x153cef0` XOR `[78,fb,4e,1b,49]`，指令 `0xbcf578–0xbcf5c8`；`brand`=source `0x153cea0` XOR `[3a,c8,48,a1,2f,11]`，指令 `0xbcf760–0xbcf7c8`；`openim`=source `0x153ced2` XOR `[30,f4,59,01,2a,ea,c7]`，在 `0xbcf4cc–0xbcf4e8` 与 `0xbcefc0–0xbcf024` 两块组合。

## 持久化与账号隔离边界

`-[ThemeBoxConfig sessionGroups]` (`0x243640`) 在 `0x243d00/0x244008` 读取 `objectForKey:`；`-[ThemeBoxConfig setSessionGroups:]` (`0x2440b0`) 在 `0x244210/0x2446cc` 写入 `setObject:forKey:`。

两者键都是 `MAIN_SESSION_GROUPS`：getter CFString `0x14a33c0` 和 setter CFString `0x14a33e0` 指向同一静态字符缓冲 `0x14a33a0`，length=19。可直接复现：

```python
k = [0x62,0x70,0xf5,0x74,0xe3,0x4e,0xfa,0x4c,0xcd,0xe3,
     0x37,0x15,0xdc,0x46,0x29,0x54,0x88,0x02,0x89,0xa5]
print(bytes(x ^ y for x, y in zip(b[0x14a3380:0x14a3394], k)))
# b'MAIN_SESSION_GROUPS\x00'
```

XOR 指令块：`0x243a1c–0x243a70` 还原前 6 字节，`0x243bdc–0x243cac` 还原后 14 字节。

`ThemeBoxConfig.init` (`0x16b62c`) 在 `0x16bce8` 调 `ThemeBoxMgr.shared`，`0x16bd00` 调 `userDefaults`，持有该 NSUserDefaults 对象。`ThemeBoxMgr.init` (`0xa212fc`) 在 `0xa21a50/0xa21fcc` 发送 `initWithSuiteName:`，参数是固定 CFString `0x1529020`，length=20，缓冲 `0x1529000`，解出 `com.tencent.themebox`。静态常量折叠输出前 14 字节和后 6 字节见 decoded.txt；缺失的第 15 字符可独立由 `b[0x1528fee] ^ 0x04 == ord('e')` 验证（源写栈 `0xa21e04–0xa21e08`，XOR/写目标 `0xa21b38–0xa21b48`）。

因此已观察到的存储域与分组键是固定值，**这一条配置持久化路径没有显式按微信账号拼接键或域名**。这支持“未看到账号隔离”，不能仅凭局部静态审计绝对宣称插件所有代码都不可能在其他位置迁移/替换 defaults；也未进行多账号运行验证。

`ThemeSessionMgr.sessionGroups/updateGroups` 读取 `ThemeBoxConfig.shared.sessionGroups` 并调用 `createGroupWithItem:`、`mutableCopy`、`addObject:`，其模型缓存与配置存储分离。

## 原生数据来源与数据集合替换

`checkLoadData` 的 `0xc212ac` 调 `getServiceWithClassName:`，参数 CFString `0x15492e0`→`MMNewSessionMgr`；`0xc212cc` 调 `valueForKey:`，参数 CFString `0x1549340`→`m_arrSession`；`0xc212f8` 调 `arrayWithArray:` 复制原生会话数组。`0xc23ac0–0xc23b04` 有同样重复分支。

常量折叠恢复字符数据：`0x1549285`→`MMNewSessionMgr\0`（解密块 `0xc1c3d4–0xc1c4ac`）；`0x154925a`→`m_arrSession\0`（`0xc1c680–0xc23154`）；`0x1549225`→`MMSessionInfo\0`；`0x15491f0`→`brandsessionholder\0`。

前段 stripped 函数 `0x49b14` 引用/注册 `rebuildMainSessions/resortSessions/updateMainSessionList/recountUnReadCount/foldSessionCount`。函数 `0x4d124` 在 `0x4e3f0` 取 `currentGroup.sessionInfo`，`0x4e4c4` 取 `topSessions`，`0x4e530` 取 `mutableCopy`，`0x4e5bc` 发送 `setTopSessions:`；在 `0x4eb00` 取 `normalSessions`，`0x4ec34` 发送 `setNormalSessions:`；`0x4ee84` 发送 `setTotalTopSessionCount:`。这是从 native 会话集合取数层接入；不是单纯靠 UITableView 行高/隐藏行达成筛选。宿主具体类名由另一代理进一步确认。

`0x50b38/0x51464/0x51ce8` 三个 Hook 函数分别引用 `updateMainSessionList/resortSessions/recountUnReadCount`，并都读取 `enabledMainSession` 和调用 `checkLoadData`。

## 未读、通知、节流：已证实内容及限制

`checkLoadData` 确实读取 `m_bIsTop` 并访问 `normalSessions/topSessions`；读取 `m_bShowUnReadAsRedDot/m_uUnReadCount`，读写组级 `unReadCount/redDotCount`，还读取 `m_uAtAllCount/m_uAtMeCount/m_uNewNotifyMsgCount/m_uAACount/m_uTransferCount/m_uNewInvCount` 参与相关分支。**尚未完整恢复每个提醒字段到 showRedDot/redDotCount/unReadCount 的精确规则，不能把这些字段读取直接等同于某套完整产品语义。**

`0xc25e80` 调 `GetTotalUnreadCount`。`0xc26128` 调 `postNotificationName:object:userInfo:`；通知名字 CFString 最终解密为 `ThemeBoxSegmentedViewUpdateBadgeNotification`（字符缓冲 `0x15493d0`），通知字典相关常量 `index/number/red` 也被还原。

节流方面：`0xc18ed0` 从 literal `0x141e8c0` 加载 d9=double `0.3`；`0xc20194` 调 lastCheckLoadDataTime；`0xc2021c` 计算两个时间之差；`0xc20220` 与 d9 比较；`0xc20224` cset mi，明确存在差值 `<0.3秒` 的条件。**尚未完整证实该条件之后的早退/重试/最终事件保留，不能称作可靠防丢事件的 debounce，也未测 CPU/FPS/耗电。**

## 本次辅助产物

- `/tmp/themebox-static-objc.txt`：otool Objective-C 元数据。
- `/tmp/themebox-static-all-methods.txt`：方法名和精确 IMP 映射。
- `/tmp/themebox-static-manager-asm.txt`：group/models/manager 指令。
- `/tmp/themebox-static-manager-selectors.txt`：manager 内 selector 引用。
- `/tmp/themebox-static-hook-asm.txt`、`/tmp/themebox-static-hook-selectors.txt`：早期 Hook 指令和 selector。
- `/tmp/themebox-static-default-asm.txt`：defaultGroups 及随后代码；defaultGroups 终止于下一方法 `0xbd00c8`。
- `/tmp/themebox-static-config-asm.txt`、`/tmp/themebox-static-config-init.txt`、`/tmp/themebox-static-mgr-init.txt`：配置读写和 suite 初始化。
- `/tmp/themebox-static-decoded.txt`：静态折叠恢复的字符缓冲和对应写指令范围。
- `/tmp/themebox-static-decode.py`：只解释常量算术与已知内存的辅助折叠脚本；不运行插件，不是完整反编译器；非连续控制流导致部分字符缺失应另行核对。
