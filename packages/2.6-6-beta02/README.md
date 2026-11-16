# 2.6-6-beta02 后台开销优化第二批

发布日期：2026-11-16。本包包含 beta01 第一批优化，并加入恢复后重复请求抑制与成功音源 URL 缓存，供原 Rootless 环境验收。

## 本次更新

- **保留 1.5 秒检查**：后台周期重新打开后，0.4 秒恢复与 1.5 秒首次检查仍按原时序执行，首次检查和剩余预算继续记录。
- **严格条件下复用资源**：仅当恢复检查已成功播放并续接任务、任务与音频租约仍属同一代且有效、没有干扰或错误，并且系统报告的有限余量足以覆盖下次周期且留出 1 秒余量时，在首次检查记录“资源复用”，跳过这次重复音频和任务申请。
- **保留失败回退**：微信音频占用、系统中断、媒体服务或路由变化、音频失败、任务变化、预算不足等撤销复用资格；原检查、真实错误处理及申请失败时保留旧有效任务的行为保持。播放或申请成功不等于 iOS 增加了预算。
- **缓存成功音源查找**：仅缓存微信主包成功找到的 blank.caf URL；缺失与查找异常不缓存失败结果。每次实际新播放仍按原规则创建单次播放器，不缓存播放器或失败状态。
- **延续第一批**：按后台需求投递宿主音频通知、按执行资格变化更新 AI 同步条件、设置页仅在前台可见时合并刷新。

默认 25 秒且可设 10–30 秒的周期唤醒与 0.4 秒恢复时序保持；保留 80 条内存事件、单调排序和既有失效事件，不新增定时器或持久日志。此优化减少特定恢复场景中的重复请求，实际执行权与预算由 iOS 决定。

## 安装包与附件

用户当前环境为 **Rootless**，选择下方主安装包。

| 产物 | 内容 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-6-beta02_iphoneos-arm64.deb) | `iphoneos-arm64`；`/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-6-beta02_iphoneos-arm.deb) | `iphoneos-arm`；`/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 与本版 Rootful 包内动态库逐字节一致 |
| [调试符号](symbols.zip) | 两方案各含 arm64 / arm64e dSYM，共四份 |
| [SHA256 校验清单](SHA256SUMS) | 两个 deb、动态库与符号附件的校验值 |

两方案均为 **arm64 + arm64e，最低 iOS 15.0**。包版本、插件显示版本和内置更新说明统一为 `2.6-6-beta02`。独立的 [beta01 发布包](../2.6-6-beta01/README.md) 及更早版本完整保留。

## 构建与验证

构建前将 42,933 个输入冻结至 `.theos/release-2.6-6-beta02/source/` 并核对 SHA256。两方案从同一快照、全新独立缓存全量构建，未执行 make clean 或 install。

从仓库根目录运行的等价命令：

```bash
make -C "$PWD/.theos/release-2.6-6-beta02/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootless PACKAGE_VERSION=2.6-6-beta02 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta02/rootless" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta02"

make -C "$PWD/.theos/release-2.6-6-beta02/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootful PACKAGE_VERSION=2.6-6-beta02 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta02/rootful" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta02"
```

本批主任务已完成统一后台集成回归，打包沿用该结果与未受影响的第一批 AI/UI 结果：

| 验证 | 结果 |
| --- | --- |
| 后台记录 | 414 项通过 |
| 后台时序、恢复、复用条件及回退集成 | 546 项通过 |
| 音频所有权、URL 缓存及失败处理 | 145 项通过 |
| 本批后台集成小计 | **1,105 项通过** |
| AI（沿用第一批） | 880 项通过 |
| 设置页（沿用第一批） | 30 项通过 |
| 合计 | **2,015 项** |

Rootless / Rootful 全量编译、链接、ldid 签名和打包成功；两方案、双架构的 Manager、Audio 与更新说明确实重编。产物核验通过真实 Debian 元数据、slices、iOS 15.0、安装目录、仅 dylib/plist 的包内载荷、注入 plist、逐架构 SHA1/SHA256 CodeDirectory 页面及特殊槽位哈希、四份 dSYM UUID、符号 ZIP CRC/12 文件哈希、独立 dylib 一致性和四附件 SHA256。

42,933 个冻结输入构建后不变；既有 1,278 个构建与历史发布文件的 SHA256、大小和修改时间均不变，包括 beta01 全部附件与发布说明。

构建命令/返回码、完整日志、冻结源码、输入清单和核验数据保存在 `.theos/release-2.6-6-beta02/`，分别见 `build-results.json`、`source-freeze.json` 与 `validation.json`。工程已有的弃用 API / 链接选项警告仍见日志。

本包尚未安装到手机；恢复后的实际请求次数、微信音频共存、锁屏持续性、CPU 与耗电变化需在原 Rootless 环境验收。
