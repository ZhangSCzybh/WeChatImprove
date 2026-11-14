# 2.6-4 后台运行记录与音频共存

发布日期：2026-11-14。

本版完善后台运行记录，并调整音频让出策略：其他 App 播放音乐、播客或视频音频时，微信的保活短音频继续按原有检查时序尝试混音播放；微信自身接管音频时仍优先让出。

## 本次更新

- **检查与到期分别记录**：首次检查、最近周期检查、周期检查次数和系统到期时间独立显示。详情中的“最后评估”可能来自系统到期通知，不会覆盖首次与周期检查摘要。
- **可查看、复制事件时间线**：记录进入后台、实际检查、剩余执行时间、短音频尝试、后台任务申请、系统到期、停止与返回前台。每次后台过程最多保留 80 条内存事件，超出时保留开始事件与最近 79 条，并显示省略数量；下一次后台过程重新记录，不写入磁盘。
- **外部音频混音共存**：移除正常检查、播放入口与恢复检查对外部音频提示的阻断，继续使用 `Playback + MixWithOthers`。外部静音提示变化不再额外安排恢复检查或重播。
- **微信音频与系统中断保护**：微信自身接管音频会话时仍让出，释放后等待完整的 0.4 秒重新检查。电话、Siri 等真实系统中断仍遵守 `ShouldResume` 恢复许可；音频服务异常与会话所有权保护继续保留。

首次检查仍在进入后台约 1.5 秒后执行，周期默认 25 秒，可设置 10–30 秒；仅当实际检查时系统报告剩余执行时间大于 0 且不足 30 秒，才尝试单次播放微信主包的 `blank.caf` 并续接后台任务。音频播放与任务申请均不保证系统补充执行时间，时间线也不能证明全程持续保活。

包版本、插件显示版本、内置更新说明和仓库当前版本说明均已同步为 `2.6-4`。

## 安装包与附件

用户当前使用 **Rootless** 环境，应选择下方的 Rootless 安装包。

| 产物 | 说明 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-4_iphoneos-arm64.deb) | Debian 架构 `iphoneos-arm64`，安装目录为 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-4_iphoneos-arm.deb) | Debian 架构 `iphoneos-arm`，安装目录为 `/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 从本版 Rootful 包提取，与包内动态库的 SHA-256 一致 |
| [调试符号](symbols.zip) | 含 Rootless、Rootful 各自的 arm64 / arm64e dSYM，按方案与架构分目录，共四份 |
| [SHA-256 清单](SHA256SUMS) | 两个安装包、动态库和符号压缩包的校验值 |

两种安装包均包含 `arm64`、`arm64e`，最低编译目标为 iOS 15.0，使用本机 Xcode 的 iPhoneOS 27.2 SDK 构建。

## 构建与验证

两个方案分别在新的 `.theos/release-2.6-4/rootless/`、`.theos/release-2.6-4/rootful/` 中全量构建，产物写入本目录。构建命令在仓库根目录运行：

```bash
make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootless \
  PACKAGE_VERSION=2.6-4 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-4/rootless" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-4-background-audio"

make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootful \
  PACKAGE_VERSION=2.6-4 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-4/rootful" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-4-background-audio"
```

主机回归命令与结果：

```bash
bash Tests/verify-background-run.sh
bash Tests/verify-background-run-runtime.sh
```

| 验证范围 | 结果 |
| --- | --- |
| 后台记录、独立检查摘要、事件上限、生命周期与过期回调 | 268 项断言通过 |
| 外部音频共存、首次与周期检查、微信接管与释放、系统中断与生命周期竞争 | 262 项断言通过 |
| 短音频播放、混音配置、播放结束、原生所有权与资源释放 | 60 项断言通过 |
| 原生任务到期、任务所有权与单次检查运行时 | 47 项断言通过 |
| 合计 | **637 项断言通过** |

产物核验结果：

- Rootless / Rootful 全量编译、链接、签名和打包成功。本次修改的后台控制器与版本说明控制器没有编译警告；保留项目已有的弃用 API 和 `-multiply_defined` 链接选项警告。
- 两包包名为 `com.wechat.improve`，版本为 `2.6-4`；Debian 架构与安装路径匹配各自方案，动态库均包含 arm64 / arm64e，两个架构的最低系统版本均为 iOS 15.0。
- 包内仅含插件动态库和注入 plist；plist 与源码解析内容一致，每个架构均存在代码签名，Rootless 的 `/var/jb` RPATH 已核验。
- 包内包含 `2.6-4` 版本文字与后台记录类；四份 dSYM 的 UUID 均与对应动态库一致，符号压缩包 CRC 与四项产物的 SHA-256 均通过核验。
- 构建前后的 42,587 份输入文件 SHA-256 一致；构建前已有的 1,260 份安装包目录文件及受版本管理的构建文件，其 SHA-256、大小和修改时间均保持一致。
- `git diff --check` 通过，仓库交付链接已核对。

本机构建日志、回归日志、输入清单和产物核验数据保存在 `.theos/release-2.6-4/`。历史版本安装包继续保留。

本版尚未安装到手机。原设备上的外部音乐共存、微信语音与通话让出、锁屏运行和耗电情况仍需使用本版安装包实测。
