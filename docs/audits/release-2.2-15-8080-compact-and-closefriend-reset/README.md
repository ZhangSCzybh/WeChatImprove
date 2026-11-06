# 2.2-15：微信 8.0.80 紧密间距与密友凭据恢复

> 历史版本记录：2.2-16 已撤回本版无密码凭据重置。其专用测试与独立审查已按用户要求移除，删除文件的 SHA-256 清单保存在 2.2-16 审计。下文描述的是 2.2-15 历史产物，不代表当前功能；历史安装包保持原样。

本次在任务开始时的 **2.2-14 未提交工作树**上修复并发布，基线是本目录 `baseline-2.2-14/`，不是 Git HEAD `a227b167`。保留此前 2.2-13 / 2.2-14 的所有工作，不提交、不 reset / checkout / stash、不 make clean、不覆盖历史包。项目是 Objective-C / Logos / Theos 的 iOS 微信插件；本次没有切换服务、端口、用户数据库、系统 Keychain 或用户偏好。所有主机测试均使用隔离临时文件或注入的 native/UIKit/secure-record doubles。

## 结论与验证边界

紧密间距已查到确定的生产断点：**2.2-14 只放行了 Merge profile，漏掉 `CSBubbleStyleAdapter.m:280` 的气泡模板版本门槛**。该门槛仍只接受 8.0.78，使 8.0.80 的模板边距获取失败，首次行高投影保持原生值，并被冻结。本次只扩展已核验的 8.0.80 / 8.0.80.* 模板入口，没有调小间距常量，也没有删除安全回退。

密友恢复在原密码输入框增加“忘记密码”，经当前账号标识确认、风险二次确认后，只重置当前账号的凭据，保留加密名单与保护选项。名单在新密码设好之前继续按原保护规则隐藏。重置中断以既有 account-scoped forward-only intent 继续完成。

这是已经在主机复现并转绿的生产门槛修复，**不是“改了但不知道断在哪里”**。真实重签微信中的 hook 安装、最终像素/逻辑点间距、系统转场与大礼包其他注入插件组合仍 **未验证**；没有编造设备观测。

## 紧密链路：五项逐项排查

详细证据见 [原生调查](native-validation/FINDINGS.md)、[逐 hook ABI 表](native-validation/hook-abi-audit.md)、[定点反汇编命令](native-validation/disassembly-commands.json)、[联合红绿测试](compact-validation/FINDINGS.md)。

1. **安装条件与签名**：覆盖 MessageMergeHooks、BubbleStyleHooks 以及真正负责后置 Render 的 MessageGestureHooks，共 64 个声明；62 个 ABI 匹配，0 个返回值/参数 mismatch，2 个旧 addMessageNode 变体在样本中不存在，单独标为 legacy 缺失。该缺失不参与初始文本的 height/cell/willDisplay 路径。现有 Logos `%init` 不使用上次搜索模块的 ABI 拒绝器。没有手机进程安装日志，因此不把静态可安装条件称作设备逐点安装成功。
2. **残留门槛**：`CSMessageMergeAdapter.m:421` 已放行 .80，但下游 `CSBubbleStyleAdapter.m:280` 仍只放行 .78；`CSBubbleStyleModelInsets` 失败后，`CSNativeProfile` 在 `CSMessageMergeAdapter.m:431/432` 拒绝几何 profile，`:487` 的 appliedDelta 保持 0，`:497` 冻结决定。`:653` 的 no-late-shrink 保护防止后续 Render 再偷偷缩行，解释为何完全没有紧缝。
3. **方法仍在实际链路**：IPA 中 `tableView:heightForRowAtIndexPath:` 的 ABI 是 `d32@0:8@16@24`，IMP `0x100335424`；`0x100335524` 调用 cellDataForRow，`0x100335540` 调用 rowHeight。BaseChatViewModel.rowHeight 的 `0x1002abfd8` 继续调用 measure 并 ceil/cache。普通 Text 的 cellDataForRow 返回自身，cellViewClassName 返回 TextMessageCellView，外层实际按此创建/复用。不是只看到了无人再调用的旧 selector。
4. **后续覆盖**：ChatTableViewCell.layoutSubviews 在 `0x100fd985c` 设置 m_cellView.frame，随后 layoutIfNeeded / onAppear。既有 lifecycle 在 native layout 完成后才 Render；已核函数中没有之后再次写 frame 的指令。新联合测试连续四轮恢复原生 origin 再 Render，2pt seam 与行高均不漂移。其他插件的设备端覆盖未验证。
5. **compact 设置值**：UI 的“紧密”写新键 `com.wechat.enhance.merge_messages.spacing_mode=1`；compact 枚举值为 1。真实 Policy 优先新键，仅缺失时读取旧键 `com.wechat.enhance.consecutive_messages.spacing` 的负数兼容值。测试断言新键 compact 优先旧 normal、新 normal 优先旧 compact、旧负值兼容；日志包含 actual/expected。没有擅自宣称读到了用户手机的偏好值。

BubbleInfo 工厂已核实返回对象 + 三个 BOOL：`@28@0:8B16B20B24`，IMP `0x104d9ed5c`。原生 normal/highlight 背景 wrapper 同样以 useCache:YES 进入此工厂，cache、resizable UIImage、cap insets 与返回链有定点反汇编。修复仍执行原模板边距与图像检查。

上次检查漏过的原因也已定位：.14 merge 测试将 CSBubbleStyleModelInsets 桩成总是成功；旧联合测试定义 CS_BUBBLE_TESTING，跳过生产版本条件。本次新联合测试同时编译真实 Merge + Bubble 及依赖，不定义两个测试宏，用真实 .app Info.plist 的版本和 8.0.80 原生类名/方法签名走生产门槛。

## 密友恢复：清除、保留与安全边界

路径：原“捉迷藏呀”/受保护入口的密码框 → **忘记密码** → 输入展示的当前账号标识 → **仅重置密友凭据？**二次确认 → 设置并确认新密码。选择密码框是因为忘记密码的用户就在此处被阻断，不需要先通过旧密码进入设置。原来需旧密码的“重置密友”整组清理路径保留原语义，新路径不调用它。

清除内容：当前账号 auth 记录中的旧密码校验信息、密码错误/冷却锁定计数、biometric-domain 安全记录，以及进程内临时解锁与认证/搜索令牌。旧密码立即失效。

保留内容：当前账号密友和密群名单、profile.enabled、全部保护选项、muteRecords、加密名单文件及 policy 加密密钥、入口发现记录；微信好友关系、聊天记录和其他账号不变。没有整组清空的技术必要，因为密码校验记录和名单加密密钥本来就是独立资源。

仅有效 pending-password-setup 标记允许“有名单但无 auth”进入重新设密流程；普通 auth 丢失、未知/损坏/读取失败的 intent 或 marker 仍 fail closed。pending 状态只临时暴露重新设密所需的插件/密友入口，保存的隐藏选项不改写，设密后原入口规则恢复；不提前展示名单。

持久顺序：写当前账号 reset intent 并回读 → 写 credential-reset setup marker 并回读 → 删除 biometric-domain → 删除 auth 并核对 → 删除 intent。Runtime 在第一个持久写入前就清除 reveal、使缓存快照失效并发布 blocked；启动时先恢复未完成 intent，再加载名单。新 auth 持久化后才清 marker；如果此间中断，重启验证新 auth 后只清 marker，绝不重新删除新 auth。异步 UI 续接必须复核同账号 epoch/token、前台与当前页面，不能临时拿另一个账号的新 token。

**被削弱的边界**：原来不知道独立密友密码、且不能通过既有认证的人不能进入；现在任何能操作这台已解锁设备并打开微信的人，都可完成无旧密码恢复、设置新密码并查看保留名单。没有加入新的真实身份验证，因此无法阻挡此类有意访问。账号标识输入只是防误触，二次警示也只是知情确认。UI 和发布说明明确写出这一点。缓解措施包括账号隔离、明确输入确认、逐条清除/保留告知、单独风险确认、取消不写入、转后台/切号使操作失效、恢复期间持续隐藏，以及新密码设好才放行。不能把这些措施描述成仍然保有旧独立密码的访问边界。

## 测试与证据

先在 frozen .14 执行新增断言留红日志与源码/fixture SHA，再修改生产代码。既有 Tests 在工作树已被用户删除，因此从 HEAD 只读 `git archive` 提取原字节到本次 audit 的隔离 fixture-project，277 个文件逐一校验，没有还原根 Tests，也没有修改任何旧断言。上一轮 .14 审计 fixture 复制到本次目录运行，避免覆盖旧审计输出。

紧密新增联合测试：红合计 610 检查、96 失败（.80 和 .80.34 各 305/48）；绿为 .78/.80/.80.34 各 369/0、未知 .81 为 329/0，合计 **1,436/0**。红绿测试 SHA 相同。受控发出/接收文本 native seam 是 21/24pt，compact 目标为原算法的 2pt；修复后 compact 2pt，normal 仍 21/24pt；未知/不支持行保留 native 55/67pt 行高。数值来自主机输入与输出，不是截图估算或设备数据。

既有消息回归全部通过：merge policy 235,148；native adapter 17,566；bubble policy 36,979；bubble adapter 2,555；联合布局 2,880 组合 / 744,926 检查；message time 142；gesture 369；attachment 10,610。共 **1,048,295** 检查。

2.2-14 四项回归全部通过：设置布局 5,114 + 双架构 SDK/继承检查；搜索的 legacy / .80 文本与 source-enum voice 回调、IME、迟到回调及首页长按恢复（32）；WCTabBarController/WCTabBarView 的几何、原生交互与样式恢复；.78/.80/.80.34 Merge profile 各 17,566，以及 policy 235,148。旧版本负例和故意破坏场景继续按预期失败，不算当前回归失败。

密友新增最终联合测试为 **763 检查 / 0 失败**，49 次子命令均符合预期，其中 7 次在持久化边界 `_exit(75)` 后由独立进程继续恢复。最终同一 fixture 在 .14 上先因缺少无密恢复入口失败（1 检查 / 1 失败），实际旧整组 reset 对比为 18 检查 / 6 失败，确证会丢名单、保护选项、密钥与 discovery；该对比不冒充 .14 原来具有新的无密 API。早期红日志、对应测试快照与后期追加 UI 覆盖分别保存，最终 red-final / green 测试 SHA 相同。名单保留规则与 7 个进程中断点详见 2.2-16 审计中的删除清单（原凭据恢复专用测试已移除）。既有安全回归包括 core 455、runtime 109、scheduling 9、biometric 99、reset 181、migration 59、entry 45 + gesture 26、discovery 与 arm64/arm64e SDK 编译。旧 HEAD 的 recovery fixture 在 frozen .14 也因原有 UIKit/recoveryTarget 声明不完整而不能编译；日志如实保留，不修改旧断言来凑绿。本次复制的现代 .14 privacy fixture 已覆盖该恢复入口并通过。

## 构建、范围与手机验收

构建用 `build-packages.py` 冻结最终源码，rootful/rootless 各用独立临时 `_THEOS_LOCAL_DATA_DIR` / `THEOS_BUILD_DIR` / `THEOS_PACKAGE_DIR`，不触碰主 .theos。产物、源码、对象符号和 dSYM UUID 逐项核验，重签 dylib 必须与 rootful deb 中的动态库字节相同，均包含 arm64 + arm64e。警告按方案、架构、源文件、完整文案、重复次数与 .14 多重集比较，只去颜色和行列号，新增必须为 0。

最终构建与保护检查记录在 `delivery-build/`、`final-scope-result.json`；确切文件/增删行数以本次 .14 快照计算。交付目录为 `packages/2.2-15-8080-compact-and-closefriend-reset/`，保留全部历史包。

手机验收步骤：

1. 用新 WeChatImprove.dylib 重签注入并完全退出/重开微信，确认插件版本为 2.2-15，避免新旧动态库重复加载。仍未提供或修改整份 IPA。
2. 气泡样式选“紧密”，同会话同发送者连续发两条普通短文本：接缝应明显缩小，目标 2 个逻辑点；切回“正常”恢复原生间距。再试接收、滚动出入屏、重进聊天。引用、语音转文字、不同发送者或未知类型不能裁切、重叠或跳动。真机 2pt 尚未测量。
3. 进入密友密码框，点“忘记密码”，按两次确认重设；在设置新密码前取消/杀进程，重进时名单应继续隐藏并可重新设密。设好新密码后原密友/密群和保护选项应在，锁定后旧密码失败、新密码成功。
4. 若有另一微信账号，切换核对其名单、保护选项与密码均未变化。顺便复查设置页顶部、搜索密码/长按首页标题、底栏样式四项上一版行为。

## 最终交付实查

相对 frozen 2.2-14：**11 个生产/版本说明文件，+176 / −16 行**。紧密修复本身只 +3/−2；密友 6 文件 +160/−6；其余为版本与说明。新增测试和审计单独保存在本目录，不计作生产差异。逐项见 [最终范围](final-scope.md)。历史 packages 184/184、主 .theos 1237/1237、冻结基线 42524/42524、HeadersFile 42142/42142 均保持，原 fixture 277+7 字节一致。HEAD 仍 a227b167，未提交。

双方案分别独立构建成功；rootful/rootless × arm64/arm64e 与 .14 警告多重集对比，**每组既有 4 条，新警告合计 0**。最终生产源码与冻结构建输入、密友 green 输入哈希再次核对一致。重签 dylib SHA-256 为 `ef7137478cfeed5164eb3927e35f74ee83b9f2789d4b16632b448d27c5991072`，与 rootful deb 内动态库相同。无设备安装。

在交付目录实际运行 `shasum -a 256 -c SHA256SUMS`，退出 0，原样输出：

```text
WeChatImprove.dylib: OK
com.wechat.improve_2.2-15_iphoneos-arm.deb: OK
com.wechat.improve_2.2-15_iphoneos-arm64.deb: OK
com.wechat.improve_2.2-15_symbols.zip: OK
```

`dpkg-deb -f` 实查：

```text
Package: com.wechat.improve
Version: 2.2-15
Architecture: iphoneos-arm
Package: com.wechat.improve
Version: 2.2-15
Architecture: iphoneos-arm64
```

原样输出分别留在 `checksum-verification.log` / `deb-metadata-verification.log`。构建结果、每个对象符号、dSYM UUID、临时目录实参、warning 多重集均在 `delivery-build/`。原密友恢复独立审查已随该功能的专用测试清理，见 2.2-16 删除清单。
