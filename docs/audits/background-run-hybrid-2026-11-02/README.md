# 2.2-4 后台任务优先与按需音频

日期：2026-11-02。用户已确认推荐方案并授权修改、编译打包。基于当前 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove`、分支 main、2.2-3 基线 HEAD `18905463` 增量修改。没有启动/切换服务、端口、数据库、账号或设备环境，没有向手机安装。

## 实现

- 进入后台先申请有限 UIKit 任务；有限预算不足10秒时再尝试静音音频，任务申请失败时允许一次音频兜底。低于5秒且无法接力时结束本轮。
- 新增可注入 CSBackgroundRunRuntime：独立任务记录、到期先结束自身标识、主线程通知、幂等释放，可取消单次检查。旧任务到期/迟到检查有身份与代次隔离。
- 26秒任务轮换使用单调时钟，先申请新任务成功再结束旧任务；申请失败保留有效旧任务并停止本轮周期申请。此操作不保证刷新系统总后台预算。
- 最多一个单次检查与播放器。预算充足时安排到预算边界/轮换节点，临界或恢复观察窗口约1秒检查。不会补执行迟到心跳；重复通知不推迟已有检查。
- 音频至少播放10秒，有限预算>=15秒连续3个相隔至少1秒的观察才退出。极大值、NaN、负预算清空恢复观察，不据此反复启停。
- 继续使用原8秒/16kHz/单声道/16-bit全零PCM WAV；保留通话、录音、宿主接管和系统中断优先规则及音频会话所有权保护。
- 新增 canAttemptBackgroundWork，覆盖有效有限任务或实际持有的音频。AI后台资格两处改用该属性，保留账号/配置/授权与约45秒节流；任务和音频状态变化独立触发通知。
- 设置显示实际任务/音频/避让/停止原因及后台音频声明。保留原defaults suite、BackgroundRunEnabled与历史备份兼容，最近结果仍只在当前进程内保存。
- 独立审查发现并修复“音频激活栈内任务到期造成提前清理”的重入问题，见 [审查记录](review-runtime-manager.md)。

设计与执行记录见 [已批准设计](../../superpowers/specs/2026-11-02-background-run-hybrid-design.md)、[实施记录](../../superpowers/plans/2026-11-02-background-run-hybrid.md)。参考附件为静态机制证据，不作为真机效果证明。

## 验证

| 检查 | 结果 |
|---|---:|
| 后台混合策略、生命周期、到期与重入 | 138项通过 |
| 真实音频层与提取的生产Hook回归 | 186项通过 |
| Runtime任务与单次检查 | 46项通过，iOS15 arm64/arm64e源对象通过 |
| AI管理器 | 863项通过，双架构源对象通过 |
| AI后台同步节流 | 115项通过，双架构源对象通过 |
| 原生完整同步观察 | 828项通过，含7个独立ABI拒绝场景；双架构源对象通过 |
| 定时任务管理器 | 2360项通过 |
| 定时任务规则 | 387项通过 |
| 备份登记 | 1404项通过 |
| 备份兼容 | 66项通过 |

合计6393次报告中的checks/assertions。全部使用独立defaults、临时存储、原生替身和可控时钟；没有发送真实消息、交易或在电脑播放音频。afinfo与PCM逐样本检查确认原静音素材格式。完整命令、退出码、日志、计数见 [整合结果](tests-integration.json)、[后台结果](test-background-run-result.json)、[Runtime结果](test-background-runtime-result.json)。

## 编译与产物核验

Rootless和Rootful使用各自全新临时对象、staging及输出目录，全量编译、链接、打包均退出0；每个方案6条警告，与2.2-3规范化后的完整警告多重集合一致，没有新增警告。构建前后生产输入哈希一致。原有1345个`.theos`/`packages`文件及目录保全，未运行make clean。

解包核对版本2.2-4、arm64/arm64e、最低iOS15.0、原注入filter、实际安装路径和staging payload SHA256一致。新Runtime类、后台能力接口与任务接口存在；保留原AI、定时任务等关键符号。Rootless安装于`/var/jb/Library/MobileSubstrate/DynamicLibraries/`，Rootful于`/Library/MobileSubstrate/DynamicLibraries/`。两方案共四份dSYM UUID与包内两架构逐一匹配，symbols ZIP通过CRC，3个交付文件SHA256复核通过。

证据：[构建结果](build-result.json)、[产物核验](package-verification.json)、[历史产物保全](historical-artifacts-after-packaging.json)。生产输入清单保存在build-input-sha256.json及build-input-sha256-after.json，临时构建路径在build-directory.txt。

## 交付

- [Rootless安装包](../../../packages/2.2-4-background-run-hybrid/com.wechat.improve_2.2-4_iphoneos-arm64.deb)
- [Rootful安装包](../../../packages/2.2-4-background-run-hybrid/com.wechat.improve_2.2-4_iphoneos-arm.deb)
- [调试符号](../../../packages/2.2-4-background-run-hybrid/com.wechat.improve_2.2-4_symbols.zip)
- [SHA256SUMS](../../../packages/2.2-4-background-run-hybrid/SHA256SUMS)

沿用设备原来的注入与安装方式。未越狱签名IPA仍须由原注入/签名流程集成，本次提供Theos deb及对应调试符号，不修改宿主打包或签名配置。

## 真机验收范围

在原微信、账号、注入和签名环境安装对应产物后，查看设置中的前台待机、后台任务、音频接力及最近结果；比较相同锁屏时长下AI免打扰群回复和定时发送，并确认通话/录音/语音消息及回前台/关闭后的资源释放。耗电与温升采用相同网络、充电、亮度及业务负载与2.2-3对照。

主机回归和编译不证明真实iOS驻留时长、后台消息必达或省电比例。系统一直返回极大预算时，首次接力音频可能持续至前台/关闭/冲突/失败；系统挂起、结束进程、用户强退或重启后无法依靠该功能自行唤醒微信。
