# 2.6-5 后台中断重试与恢复修正

发布日期：2026-11-16。

本版调整后台音频中断策略：电话、Siri 等系统中断停用当前音频后，保留仍有效的有限后台任务与原周期尝试；中断结束即使没有 `ShouldResume` 提示，也等待 0.4 秒重新检查。微信自身音频占用仍主动让出，返回前台或关闭最后一个后台需求时清理本插件资源。

## 本次更新

- **移除长期中断阻断**：不再用 `interrupted` / `resumeBlocked` 锁住后续尝试。没有收到中断结束通知时，周期检查仍可在有执行机会时重试；激活被拒绝时记录原因，等待后续机会。
- **修复微信音频释放后的恢复**：微信停用会话后继续恢复 category / mode，不会因释放代次变化而永久误判占用；失败的配置或激活不再错误撤销保活租约。在途原生调用导致暂时让出时保留原配置快照，失败后可恢复，成功后仍让微信优先。
- **修复媒体服务重置的状态竞争**：媒体服务丢失时建立失效代次，重置时保留微信已恢复的新激活及其进行中的调用。若只收到 Reset，保守保留已观察到的宿主激活，避免覆盖微信音频，等待其明确释放。
- **修复延迟系统到期记录**：任务同步失效时保存真实到期时间与单调 uptime，普通评估、返回前台及关闭最后需求均保留快照；晚回调不会重复记录或污染下一轮。事件按实际经过时间排列，兼容系统日期回拨，保留 80 条上限。
- **同步版本与完整逻辑说明**：Debian 包、插件显示版本、内置更新内容和仓库当前版本均更新为 `2.6-5`。完整入口、时序、让出、恢复、到期、资源清理和审查结果见 [后台运行梳理与审查](../../docs/audits/background-run-2026-11-16/README.md)。

其他 App 音频继续使用混音共存策略。首次检查仍为进入后台约 1.5 秒，周期默认 25 秒、可设 10–30 秒；仅当实际检查时有限剩余时间大于 0 且不足 30 秒，才尝试微信主包的 `blank.caf` 单次短静音播放并申请替换后台任务。不生成替代音源，不无限循环播放，不更改拍动与 AI 的补拉间隔和功能门禁。

系统中断期间继续的是插件的保活请求和重试策略；iOS 仍能拒绝播放、耗尽有限任务、挂起或终止微信。任务申请或播放成功不表示系统一定增加后台执行时间。

## 安装包与附件

用户当前使用 **Rootless** 环境，应选择下方 Rootless 安装包。

| 产物 | 说明 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-5_iphoneos-arm64.deb) | Debian 架构 `iphoneos-arm64`，安装目录 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-5_iphoneos-arm.deb) | Debian 架构 `iphoneos-arm`，安装目录 `/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 提取自本版 Rootful 包，与包内动态库的 SHA-256 一致 |
| [调试符号](symbols.zip) | Rootless / Rootful 分别包含 arm64、arm64e dSYM，共四份 |
| [SHA-256 清单](SHA256SUMS) | 两个安装包、动态库和符号压缩包的校验值 |

两个安装包均含 arm64 与 arm64e，最低编译目标为 iOS 15.0，使用 Xcode 27.2 / iPhoneOS 27.2 SDK 构建。已发布的 2.6-4 与更早产物继续保留。

## 构建与验证

两个方案在新的独立构建目录中全量构建，没有执行 `make clean`。在仓库根目录运行：

```bash
make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootless \
  PACKAGE_VERSION=2.6-5 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-5/rootless" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-5-background-recovery"

make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootful \
  PACKAGE_VERSION=2.6-5 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-5/rootful" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-5-background-recovery"

bash Tests/verify-background-run.sh
bash Tests/verify-background-run-runtime.sh --ios
```

| 验证范围 | 结果 |
| --- | --- |
| 后台摘要、延迟到期、前台/关闭抢先、单调排序、日期回拨、80 条截断与旧回调 | 398 项断言通过 |
| 首次/周期/恢复时序、系统中断重试、微信占用、有限任务、重入和生命周期竞争 | 323 项断言通过 |
| 短音频、会话租约、在途成功/失败、IsBusy、媒体服务代次与新激活保护 | 103 项断言通过 |
| 原生任务结束/到期、真实快照、单次检查运行时 | 57 项断言通过 |
| 合计 | **881 项断言通过** |

原生 Runtime 还通过 arm64 / arm64e、iOS 15.0 目标的独立源码编译。Rootless / Rootful 全量编译、链接、签名和打包成功；本轮修改的后台源码和更新说明控制器无编译警告，项目其他源码仍有既有的弃用 API、废弃链接选项警告。

产物核验覆盖：

- 包名 `com.wechat.improve`、版本 `2.6-5`、Debian 架构和安装目录分别匹配方案。
- 包内仅插件动态库与注入 plist，plist 解析内容与源码一致；动态库均含 arm64 / arm64e，最低 iOS 15.0，每个架构都有代码签名，Rootless 的 `/var/jb` RPATH 正确。
- 包内包含 `2.6-5` 版本文字和后台记录类；四份 dSYM UUID 与对应动态库一致，符号压缩包 CRC 与构建文件逐项一致，四项附件 SHA-256 可校验。
- 构建前后 42,587 份源码输入 SHA-256 一致；已有 1,266 份历史发布文件及受版本管理的构建文件，其 SHA-256、大小和修改时间一致。

本机构建日志、回归日志、输入清单和核验数据位于 `.theos/release-2.6-5/`。本版尚未安装到手机；电话/Siri 期间的实际执行、微信语音/录音/通话恢复、锁屏运行、耗电与温升仍需在原 Rootless 环境使用本版验收。
