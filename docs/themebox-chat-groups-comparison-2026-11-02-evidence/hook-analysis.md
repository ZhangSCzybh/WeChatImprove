# ThemeBox 聊天分组接入原生列表：静态 Hook 实证

分析对象：`/Users/zhangshichao/Downloads/Telegram Desktop/ThemeBox.dylib`。以下均为 ARM64 Mach-O 静态证据；未加载、执行或注入插件，未观察运行时效果。地址是本样本 unslid VM address；相关映射的文件偏移相同。证据来自 `/tmp/themebox-static-hook-asm.txt`、`/tmp/themebox-static-objc.txt` 与 `otool -Iv`。反汇编的 `_writev+...` 自动标签无意义，导入符号按间接符号表重新解析。

## 核心结论

插件通过替换 `MainSessionMgr.rebuildMainSessions` 的方法实现，先调用微信原实现，再将**当前分组缓存的置顶/普通会话数组写回原生 MainSessionMgr**。确认不是只在 UITableView 显示层映射 indexPath。该结论不意味着它删除数据库记录；这里观测到的是原生内存会话列表属性替换。

直接实证：

```objc
// 概念伪代码，去掉控制流混淆和引用计数；并非反编译器原始源码
void hooked_rebuildMainSessions(MainSessionMgr *self, SEL cmd) {
    original_rebuildMainSessions(self, cmd);
    if (!localFeatureGate() || !settings.enabledMainSession) return;
    ThemeSessionGroup *group = ThemeSessionMgr.shared.currentGroup;
    if (!group || [group.type isEqualToString:@"all"]) return;
    // SessionSelectController / 名称含 SessionSelect 的页面走原生数据，避免污染联系人选择页面
    if (isSessionSelectionController(currentViewController)) return;
    self.topSessions = [group.sessionInfo.topSessions mutableCopy];
    self.normalSessions = [group.sessionInfo.normalSessions mutableCopy];
    self.totalTopSessionCount = self.topSessions.count;
}
```

## 类名、selector、替换函数的完整绑定

类名虽有字节 XOR 混淆，已从原始文件字节和汇编 immediate key 静态解出：

- 加密源 `0x148e938`，输出 `0x148e947`：`MainSessionMgr\0`。
- 加密源 `0x148e918`，输出 `0x148e928`：`MMNewSessionMgr\0`。
- 加密源 `0x148e8e0`，输出 `0x148e900`：`SessionSelectController\0`。
- ObjC classref `0x14888c0` -> `_OBJC_CLASS_$_ThemeSessionMgr`（`/tmp/themebox-static-objc.txt:43396`）。

`0x49b14` 注册函数中的实证链：

| 证据 PC | 含义 |
|---|---|
| `0x4b710..0x4b718` | 将解出的 `MainSessionMgr` 传给 objc_getClass |
| `0x4b734`、`0x4b764..0x4b76c` | 该 Class 保存到全局 `0x15f3598` |
| `0x4a110..0x4a11c` | 从该全局取 Class，以 `rebuildMainSessions` selector 调 class_getInstanceMethod |
| `0x4a138` | Method 保存 `[x29,#-0x78]` |
| `0x4cc64..0x4cc6c` | 原 IMP 保存全局 `0x15f35e0` |
| `0x4cc70..0x4cc7c` | Method 加 replacement `0x4d124`，调 method_setImplementation |
| `0x4cd58..0x4cd60` | 解出的 `MMNewSessionMgr` 传给 objc_getClass |
| `0x4cd84` | 该 Class 保存全局 `0x15f35b0` |
| `0x4bd2c..0x4bd38`、`0x4ae30..0x4ae34` | 用 MMNewSessionMgr 与 foldSessionCount 调 class_getInstanceMethod |
| `0x4c060..0x4c080` | method_getImplementation，原 IMP 暂存 `[sp,#0x48]` |
| `0x4b8ec..0x4b8f4` | 原 IMP 保存全局 `0x15f3608`（另一路也有同样保存） |
| `0x4c984..0x4c990` | 用 replacement `0x5251c` 调 method_setImplementation（另一路 `0x4ac74..0x4ac80`） |

这条绑定不依赖仅凭项目头文件猜测类名。

## rebuildMainSessions 替换行为的关键 PC

- `0x4d144` 保存 self 到 x23。
- `0x4d9a8` 取原 IMP `0x15f35e0`；`0x4d9dc` 取 rebuildMainSessions selector；`0x4da38` 传 self；`0x4da3c blr x8` 调原实现。**原生重建在分组覆盖之前运行**。
- `0x4da80` 调本地 feature gate `0x4f690`。
- `0x4db54` shared、`0x4dc1c` enabledMainSession。
- `0x4dd2c` 取 ThemeSessionMgr class；`0x4dd44` shared；`0x4de20` currentGroup。`0x4dea0` 的 nil 路径去清理。
- `0x4df08` group.type；`0x4df3c` 与 CFString `0x148e9a0` 比较。其字符指针为 `0x148e976`，长度3，字节解密为 all。`0x4e01c tbnz w22,#0,0x4f1a4`：all 走清理，跳过数组替换。
- `0x4e0d8` 获取当前 controller；`0x4e174` objc_getClass(SessionSelectController)；`0x4e1c4` isKindOfClass；随后还在 `0x4e264..0x4e36c` 做 NSStringFromClass 与 containsString 检查。CFString `0x148e980` 长13；可确认名称判断是选择会话页面保护，精确字符串未在本子任务完整解码。`0x4e3b8` 条件跳往清理区域 `0x4f018`。
- `0x4e43c` currentGroup.sessionInfo；`0x4e4e0` topSessions；`0x4e578` mutableCopy；`0x4e5d8` 向原 self 发送 **setTopSessions:**。
- `0x4eaac` 恢复 self；`0x4eab0` currentGroup.sessionInfo；`0x4eb48` normalSessions；`0x4ebec` mutableCopy；`0x4ec50` 向原 self 发送 **setNormalSessions:**。
- `0x4edcc` self.topSessions；`0x4ee78` count；`0x4eebc` 向 self 发送 **setTotalTopSessionCount:**。

## foldSessionCount 同步分组边界

确认 `MMNewSessionMgr.foldSessionCount` 被 replacement `0x5251c` 接管：

```objc
NSUInteger hooked_foldSessionCount(MMNewSessionMgr *self, SEL cmd) {
    if (!localFeatureGate() || !settings.enabledMainSession)
        return original_foldSessionCount(self, cmd);
    ThemeSessionGroup *group = ThemeSessionMgr.shared.currentGroup;
    if (!group || [group.type isEqualToString:@"all"])
        return original_foldSessionCount(self, cmd);
    return group.sessionInfo.topSessions.count;
}
```

这里将折叠/置顶边界数量与过滤后的当前分组同步。证据：

- `0x528c8` gate；`0x529a0` enabledMainSession；`0x52bd8` ThemeSessionMgr.shared；`0x52cac` currentGroup。
- `0x52dd8` group.type；`0x52e70` 与 CFString `0x148ea50`（同一 all 字符指针）比较。
- `0x53060 cbz w21,0x530f4`：type != all 进入自定义路径。
- `0x53198` sessionInfo；`0x531b0` topSessions；`0x53250` count；`0x53350` 将 count 返回。
- 原生 fallback 调用：`0x52ebc`/`0x53088` 取原 IMP `0x15f3608`，分别在 `0x52f14`/`0x530e8` 调用。

注册区还能看见 `resortSessions` replacement `0x51464`、`recountUnReadCount` replacement `0x51ce8` 等相关接入，但本子任务没有逐条还原其逻辑，不据此断言全部行为。

## 项目头文件的辅助互证

- `/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MainSessionMgr.h:8` 开始明确 topSessions、normalSessions、allTopSessions、totalTopSessionCount，并有 rebuildMainSessions、updateMainSessionList 以及 getNormalSessionAtIndex/getTopSessionAtIndex。这与静态 hook 的类/属性/方法全部吻合。
- `/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MMNewSessionMgr.h:8` 有 m_arrSession；同头文件包含 resortSessions、recountUnReadCount、checkLoadData、foldSessionCount。
- MainFrameLogicController 的 table delegate/dataSource 可以消费 native manager 的数组与边界；未在本子任务证明每个原生下游调用的具体路径。

## 与当前项目架构的区别与优化启示

当前项目保留原生会话模型，通过 `CSGroupProjection + CSGroupTableProxy + CSGroupIndexScope/CSGroupInvocationMapper` 在 UITableView 边界过滤和转换索引，点击等操作再依据 userName/account/epoch 校验身份。ThemeBox 则把当前 group 的缓存列表写进原生 MainSessionMgr，让其下游天然拿到过滤后的数组，并单独协调 foldSessionCount。

ThemeBox 的可推导优点：利用原生后续显示与访问流程，减少 UI 层双坐标映射；分组列表在重建时一次性注入，切换可直接使用缓存数组。可推导风险：对共享原生 manager 的呈现状态产生影响，需要同步原生排序/置顶边界/未读与其它消费者，微信版本变化会影响多个内部接点。这里不能断言它一定发生越界或状态污染，也不能把内存数组替换等同于数据库破坏。

项目方案的优点：分组是视图投影，原生完整会话模型保持完整，身份校验有利于避免异步变更后误操作。代价：native/display 坐标、可选 delegate 和 menu/prefetch/preview 兼容范围更复杂，目前有明确的功能降级。建议保持项目投影架构，优先改进按变更身份的增量快照/统计与按需可见行刷新；若借鉴 ThemeBox，只借鉴从稳定的原生 model 数据源构造分组缓存与一致的边界处理，不宜直接照搬共享数组覆盖。

## 证据限制

本报告证明该样本所含方法注册与有限函数的数据流；未进行运行时兼容性、速度、能耗或崩溃率测试，不能据此给两者实际性能下定论。二进制存在大量混淆伪分支，本文没有将任意未解码段落包装成完整源代码。`/tmp/themebox-static-fold-constants.py` 的线性通用解密输出不可靠，本报告仅使用逐段原字节 XOR 验证得到的明文。
