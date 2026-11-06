# 2.2-17：快捷页整组重置密友

源码、红绿验证及隔离候选编译已完成，**尚未出包**。新增及列明验收通过；原 100 个回归脚本实跑为 82 通过、18 失败，冻结的未修改 2.2-16 也存在这些失败。遵守用户“任何一项失败不许出包”，没有生成 2.2-17 交付目录、deb 或 SHA256SUMS，也没有把基线失败默认为放行例外。等待用户明确发布门槛后才能决定出包；不能宣称全部回归通过。

本轮基线是含未提交 2.2-13～2.2-16 改动的当前工作树，准确副本冻结于 `baseline-2.2-16/`，不使用 Git HEAD 重构基线。HEAD 仍是 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`，未提交。冻结 42,524 个输入文件；历史 packages 194 项、主树 .theos 1,237 项分别保存任务开始时的完整 SHA256 清单。项目为 Objective-C / Logos / Theos 插件；没有启动或切换服务、端口、真实微信账号库、Keychain 或用户偏好。没有执行 reset / checkout / stash / make clean，没有恢复用户删除的根 Tests 目录。

## 授权范围与实现

只放开五连击快捷页的 section 2「重置密友」。`Controllers/CSCloseFriendSettingsViewController.m:236` 的拒绝判断由 `(section==2 || (section==0 && row==3)) && quickEntry` 收窄为 `section==0 && row==3 && quickEntry`，修改密码继续拒绝。`resetCloseFriends` 按入口选择 Manager overload；成功后显式 `invalidateQuickEntry`，保留 `resetFinished` 并调用原 `leaveAfterReset` 退出和提示。

Manager `resetFrom:settingsToken:completion:` 的首层说明之后，复用原 `confirmResetFrom:token:completion:` 的 destructive action。Runtime 的 settings proof 只在当前 account / epoch / 随机 visit 内存中有效；最后仍进入原 `resetWithToken:` → 同一 `resetStorage(account,YES)` → 未修改的 `CSCloseFriendReset` / `CSResetIntent` / begin / resume。没有新清理过程或永久授权键。

两级确认各自只有一次选择机会，取消后旧 callback 不能重新激活，也不能借同 visit 下一轮的 proof。每次转场和最终执行均检查前台、页面、账号 epoch、暂停状态及 nonce；执行置于原账号 epoch 互斥内。成功、离页、后台或切号均不能复用原快捷授权。

新增失败测试还定位并修正两个实际边界：缺 auth 的合法旧 state 在最终 `refreshAccount` 会丢 quick reset proof；取消的旧 action 可借下一轮同 visit proof。分别保留 209/2 → 209/0、223/4 → 223/0 红绿日志。前者只在成功重载并恢复同账号/epoch/exact visit 后恢复原 quick proof，普通密码 proof 不恢复；后者用两层各自一次性的选择 guard。仅内存 `resetPending` 禁止未完成整组重置时签发或使用页面 nonce，不改变原 state、credential、snapshot 与删除次序。

普通 Manager `resetFrom:completion:`、Runtime `prepareResetWithPassword:token:error:`、Settings `leaveAfterReset` 的提取方法 SHA256 均与冻结 .16 一致。Reset.h/m、EntryState.m、Bridge.m、Policy.m 以及 Manager 首页搜索方法至文件末尾整段均字节相同。真正整组 intent 的严格性、2.2-16 退休 marker/intent 清理、原搜索和首页长按没有改动。

核心行为改动 5 文件 **+68 / −17**；另有主设置页风险文案、发布说明、版本头、README 和 control 共 5 文件更新。逐文件行数与前后 SHA256 见最终 scope 报告；核心明细在 `quick-reset-validation/production-diff-stats.json`。相对基线的总变更为 10 文件 **+83 / −27**，不含本次新审计材料。

## 两级确认的实际文案

首级标题 **无密码重置须知**，按钮「取消」和「继续」：

> 将清空当前账号的密友和密群名单、全部保护选项、密友密码、生物识别记录及入口发现记录。保护将关闭，“捉迷藏呀”重新隐藏。  
> 微信好友、聊天记录、免打扰设置和其他账号不受影响。此操作无法撤销。  
> 快捷入口不校验密码：任何拿到已解锁手机的人，连点头像 5 下并确认，即可清空整个密友配置。继续后还需再次确认。

末级标题 **重置当前账号的密友？**，按钮「取消」和破坏性样式「重置密友」：

> 将清空密友和密群名单、全部保护选项、密友密码、生物识别记录及入口发现记录。保护将关闭，“捉迷藏呀”重新隐藏。  
> 微信好友、聊天记录、免打扰设置和其他账号不受影响。此操作无法撤销。  
> 快捷入口不校验密码：任何拿到已解锁手机的人，连点头像 5 下并确认，即可清空整个密友配置。

## 删除范围、中断与账号隔离

当前账号的名单和全部选项位于 state 密文；沿用原整组流程删除该文件、发现记录、biometric-domain、auth、policy，最后删除 reset intent。保护回到关闭的空 profile、入口首次隐藏；微信好友、聊天记录、免打扰和其他账号不在清理范围。

最终测试在 state、biometric-domain、auth、policy、reset 删除阶段逐项注入失败，检查 blocked、没有 currentProfile / auth token、不能重新签发或使用 settings nonce；重建 Runtime 后先 resume 完成才开放空状态。两层取消及只展示确认，逐项比较全部测试文件、secure key 集合及 NSData、defaults 原始内容均不变；B 账号完整 key 集合/内容、state 原始字节、discovery 原始 key/value 二进制 plist 均保持一致。

另启动实际独立子进程，在注入 secure writer 持久保存精确 `CSResetIntent` 后、writer 返回及名单清理前对自身执行 `SIGKILL`。父进程核验 signal=9、intent 存在且 state/auth/policy 原字节保留；新 Runtime 通过原 resume 全部清理，B 账号逐字节不变。最终主 fixture 和独立复跑均为 **259/0**。这是 macOS 实际进程被杀与隔离持久化 secure double，未触碰真实 iOS Keychain。

**原机制不是跨文件/defaults/Keychain 的原子事务。** 物理删除期间存在“密文已删、密钥和 intent 尚在”的窗口。验收保证的是 intent 存续或失败期间不发布、读取或修改可用的半完成状态，下次加载先前向恢复；不能声称每项物理数据同一瞬间消失。保持密文先于密钥删除、intent 最后删除的原安全次序。

## 重置后重新设密码：已执行的原路径

完整重置 → Runtime 空 profile、无 credential、非 blocked → 原插件头像长按 2 秒发现“捉迷藏呀” → 原 `presentSettingsFrom:` / `authenticateFrom:` 因 `hasCredential=NO` 选择 `setup=YES` → 原 `passwordPrompt` 两次输入新密码 → 原 `setPassword` 写新 verifier。随后可正常锁定，旧密码失败，新密码成功。

`new-password-validation/` 直接编译真实 Reset/Store/EntryState/Runtime/Crypto/Policy，逐字提取 Custom 长按及 Manager 发现/导航/认证/密码框方法；普通、快捷重置各覆盖同进程和重新构造 Runtime。冻结 .16 原路径先通过 50/0，保留这 50 项后加入快捷链路，同最终 fixture 冻结 .16 红 **51/1**，最终实现独立绿 **105/0**。因此不增加新设密入口，也不放开“修改密码”。代码路径和完整 provenance 见该目录 README 与 `green-release/`。

## 测试结果与发布门槛

| 验证 | 结果 |
| --- | --- |
| 初始未修改 .16 新断言，先于生产修改 | 43 项 / 2 失败，`quick-reset-validation/red/` |
| 最终同 fixture 冻结 .16 → 当前源码 | 54/3 红 → 259/0 绿；独立复跑 259/0 |
| 原完整设密路径 + 快捷重置终态原设密 | 51/1 红 → 105/0 绿 |
| 原消息合并、气泡、整合、时间、手势、附件六脚本 | 1,048,295 项通过 |
| 生产 compact 测量四版本 | 1,436/0；compact 2pt，normal 21/24pt |
| 2.2-14 设置页、搜索/首页长按、新底栏、Merge 门槛 | 四套均通过，原断言保留 |
| 2.2-16 回滚/退休 marker 迁移 | 232/0 |
| 2.2-16 五击/长按/页面授权 | 90/0 |
| 原始 100 个 verify 脚本 | 82 通过，18 失败；冻结 .16 同样失败，未将其称为全绿 |

红绿总数不同是因为冻结 .16 缺少新入口/API，依赖其存在的测试分支无法继续；没有修改既有断言。原历史 fixture 及断言逐字节保护。18 个原脚本失败包含旧测试缺少新 production 声明/抽取方法，以及旧头像“exactly one recognizer”约束与 .16 双手势功能不兼容；逐项脚本、诊断及 .16 对比另见回归门槛报告。已异步向用户澄清是否允许按本次列明验收全部通过、保留并豁免这些已证实基线失败来出包，**无答复不等于豁免**。

## 候选编译与环境保护

`candidate-build/` 为独立源码快照的 `make all`，rootful/rootless 均构建 arm64 + arm64e，全部成功。每个 scheme 的 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`、`THEOS_PACKAGE_DIR` 均独立位于临时目录。与 2.2-16 按 scheme、架构、文件、完整诊断及重复次数比较，多重集每架构 4 条原警告保持一致，**新增为 0**；见 `candidate-build/warning-comparison.json`。

只编译候选，没有执行 `make package`，没有最终 deb，因此本轮没有可以实跑的 2.2-17 `dpkg-deb Version` 或 `shasum -a 256 -c SHA256SUMS`；不能用候选 hash 冒充交付校验。目标仍为 `packages/2.2-17-quick-entry-closefriend-reset/` 下 dylib、arm/arm64 deb、symbols.zip、SHA256SUMS，待发布门槛明确且允许出包后生成并实查。

最终 scope verifier 对冻结输入、所有非授权源文件、完整历史 packages、主树 .theos、HeadersFile 及历史断言核对完整集合与 SHA256；旧 .16 审计另保存准备时至收尾的 43,588 文件保护清单，没有改删例外。编译输入 SHA 前后相同。README 明确源码 2.2-17 尚未交付，原 2.2-16 下载链接保留。

## 风险及实际验证边界

快捷入口不验证身份。.16 已允许无密码查看/修改设置，本版进一步允许**任何能操作已解锁手机并到达头像的人，五击并两级确认后不可撤销地清空当前账号全部密友配置**。两级确认只防误触，无法阻止有意操作者；入口隐蔽不构成身份验证。原微信列表不会因进入页面本身解锁，但用户确认完整重置会按要求关闭保护并删除名单。

第五击入口提示、重置两级确认、页面 footer、2.2-17 应用内发布说明及 README 都明确告知该风险。密码规则、生物识别逻辑、隐藏/锁定状态机未放宽，页面授权没有永久化或跨账号。旧有 auth 缺失且整插件入口隐藏导致头像不可达的组合没有另行扩大根入口可见性。

**真机手势、UIKit 转场、微信列表实际显示、iOS Keychain 和设备强杀恢复：未验证。** 所有数值和行为证据均限定为上述主机真实生产逻辑、UI/storage doubles 或 iOS 编译。
