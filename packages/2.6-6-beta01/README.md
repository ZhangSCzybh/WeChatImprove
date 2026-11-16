# 2.6-6-beta01 后台开销优化第一批

发布日期：2026-11-16。本包对应第一批已验证改动，供原 Rootless 注入环境验收。

本版减少与实际后台需求无关的通知和界面重建：

- 前台或没有后台需求时，继续跟踪微信音频会话状态，暂停向后台管理器投递无用宿主音频通知；重新产生后台需求时先恢复通知，再读取真实占用。
- 后台状态通知区分执行资格与展示变化。AI 在执行资格变化时更新后台同步条件，纯展示变化不再触发完整配置刷新；旧通知仍兼容，账号与授权规则保持。
- 后台运行设置页只在本页可见、App 和所属 Scene 活跃时重建。离屏或被其他页面覆盖时标记待更新，重新显示或恢复前台后刷新一次；同一批主队列通知合并，排队回调再次核对可见性，且不保留已退出页面。

首次约 1.5 秒、默认 25 秒且可设 10–30 秒的周期、0.4 秒恢复检查保持。继续使用微信主包 blank.caf 单次混音播放，保留微信音频优先、有限后台任务、80 条内存事件与单调排序，不新增定时器或持久日志。实际后台执行取决于 iOS 与微信服务。

## 安装包与附件

用户当前环境为 **Rootless**，使用下方主安装包。

| 产物 | 内容 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-6-beta01_iphoneos-arm64.deb) | `iphoneos-arm64`；`/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-6-beta01_iphoneos-arm.deb) | `iphoneos-arm`；`/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 与本版 Rootful 包内动态库逐字节一致 |
| [调试符号](symbols.zip) | 两个方案各含 arm64、arm64e dSYM，共四份 |
| [SHA256 校验清单](SHA256SUMS) | 两个 deb、动态库与符号附件的校验值 |

两个方案均包含 **arm64 + arm64e，最低 iOS 15.0**。包版本、插件显示版本和本版内置更新说明均为 `2.6-6-beta01`。

## 构建与验证

构建前冻结 42,933 个源码、头文件、测试与元数据输入至 `.theos/release-2.6-6-beta01/source/`，逐文件 SHA256 核对；后续源码修改不进入本包。Rootless / Rootful 各使用全新的独立缓存，全量编译、链接、签名和打包，未执行 make clean 或 install。

从仓库根目录复现构建：

```bash
make -C "$PWD/.theos/release-2.6-6-beta01/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootless PACKAGE_VERSION=2.6-6-beta01 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta01/rootless" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta01"

make -C "$PWD/.theos/release-2.6-6-beta01/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootful PACKAGE_VERSION=2.6-6-beta01 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta01/rootful" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta01"
```

本次打包沿用本批已完成的回归与双架构源码编译结果，没有重复运行测试：

| 验证 | 结果 |
| --- | --- |
| 后台核心摘要、时序、音频、任务与运行时 | 891 项通过 |
| AI 管理器与通知过滤回归 | 880 项通过 |
| 设置页可见性、多 Scene、合并与释放验证 | 30 项通过 |
| 合计 | **1,801 项通过** |
| iOS 15.0 双架构对象编译 | 已通过；本次两方案又完成全量构建 |

包后核验通过：真实 Debian 元数据、双架构与最低系统版本、安装位置、包内仅 dylib/plist、注入 plist 内容、每架构 ldid CodeDirectory 的 SHA1/SHA256 页面及特殊槽位哈希、四份 dSYM UUID、符号 ZIP CRC 与 12 个文件逐项哈希、独立 dylib 一致性，以及四个附件 SHA256。

冻结的 42,933 个输入构建后 SHA256 不变；既有 1,272 个受版本管理的构建文件及历史发布文件，其 SHA256、大小、修改时间不变。历史包继续保留。

构建命令与返回码见 `.theos/release-2.6-6-beta01/build-results.json`，产物核验见 `validation.json`，完整日志、冻结清单和源码也在该目录。既有工程的弃用 API / 链接选项警告仍可在日志查阅。

本包尚未安装到手机；后台实际持续性、音频共存、微信语音/通话恢复、锁屏、CPU 与耗电变化需使用本版在原 Rootless 环境验收。
