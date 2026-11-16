# 2.6-6-beta03 后台开销优化第三批

发布日期：2026-11-16。本包累积 beta01、beta02，并加入主周期定时器复用、发布/记录减少重复读取及摘要按需生成。当前后台逻辑以本记录和冻结源码为依据；2.6-5 审计继续描述其历史版本。

## 本次更新

- **复用主周期定时器**：主周期使用一个 repeats:YES 的 NSTimer，不再每次重建。下次触发从本次实际触发开始按设置间隔安排；处理耗尽整期时，处理结束后再顺延一个间隔。延迟或长处理不补跑错过的周期。
- **保留独立单次检查**：首次约 1.5 秒、恢复约 0.4 秒继续单次调度；定时器取消、代次隔离、处理中的重入保护保持。Manager 的 nextPeriodicDeadline 跟随真实触发与长处理顺延，使第二批预算覆盖判断与实际节奏一致。
- **减少状态发布的重复读取**：一次 publish 共用同一份音频状态读取，用于展示及执行资格判断，不跨音频操作缓存所有权校验。
- **优化有界内存记录**：顺序到达的事件直接追加；迟到事件继续按单调 elapsed 稳定插入，保留首事件和最近 79 条、80 条上限、相同时间稳定顺序、墙钟日期校正与真实到期快照。同次检查复用预算文案；只读事件条数不复制数组，完整快照继续不可变。
- **摘要按页面用途生成**：设置页只构建实际显示的 9 条概要，记录详情与复制仍保留完整 12 条。第一批前台可见门禁、通知合并、多 Scene 与页面释放保护保持。

## 累积后台行为

进入后台且有资源需求时申请有限任务，首次约 1.5 秒检查，周期默认 25 秒、可配置 10–30 秒；恢复机会延迟约 0.4 秒检查。只有实际检查时系统报告的有限剩余时间大于 0 且不足 30 秒，才按条件请求单次微信主包 blank.caf 混音音频和任务替换。

第二批的恢复复用条件保持：重开周期的恢复检查已成功播放并续接任务、同代任务及音频租约仍有效、没有干扰和失败，且有限余量足以覆盖下次周期并留出 1 秒余量时，1.5 秒检查仍执行并记录“资源复用”，跳过这一次重复音频与任务申请。占用、中断、媒体服务/路由变化、失败、任务变化或余量不足时继续原回退；成功找到的 URL 可缓存，缺失与查找异常不缓存失败结果，播放器不复用。

微信自身音频优先让出；其他 App 音频采用 MixWithOthers。系统中断停用当前音频时保留仍有效的有限任务与周期尝试，实际能否重新激活由系统决定。前台或没有后台需求时继续跟踪宿主状态，抑制无用投递；AI 只在执行资格变化时更新后台同步条件，旧通知兼容。返回前台或关闭最后需求时释放本插件资源。

本版没有增加轮询、持久日志或无限循环播放器。定时器复用减少创建与释放，基础检查频率仍受设置控制；播放或任务获准不证明 iOS 增加预算，也不能证明微信全程持续执行。

## 安装包与附件

用户当前为 **Rootless** 环境，选择下方主安装包。

| 产物 | 内容 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-6-beta03_iphoneos-arm64.deb) | `iphoneos-arm64`；`/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-6-beta03_iphoneos-arm.deb) | `iphoneos-arm`；`/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 与本版 Rootful 包内动态库逐字节一致 |
| [调试符号](symbols.zip) | 两方案各含 arm64 / arm64e dSYM，共四份 |
| [SHA256 校验清单](SHA256SUMS) | 两个 deb、动态库与符号附件的校验值 |

两个安装包均含 **arm64 + arm64e，最低 iOS 15.0**，使用 iPhoneOS 27.2 SDK。包版本、插件显示版本与内置更新说明一致为 `2.6-6-beta03`。独立的 [beta01](../2.6-6-beta01/README.md)、[beta02](../2.6-6-beta02/README.md) 产物和说明完整保留。

## 构建与验证

构建前冻结 42,933 个输入至 `.theos/release-2.6-6-beta03/source/` 并核对 SHA256。两个方案从同一快照、全新独立缓存全量构建，未执行 make clean、install 或 Git 提交。

从仓库根目录复现的等价命令：

```bash
make -C "$PWD/.theos/release-2.6-6-beta03/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootless PACKAGE_VERSION=2.6-6-beta03 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta03/rootless" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta03"

make -C "$PWD/.theos/release-2.6-6-beta03/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootful PACKAGE_VERSION=2.6-6-beta03 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta03/rootful" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta03"
```

本批主任务已经完成以下实测回归与独立编译，打包沿用这些证据，不重复运行测试：

| 验证 | 结果 |
| --- | --- |
| Records | 414 项通过 |
| Hybrid（含调度、长处理、复用与回退） | 569 项通过 |
| Audio | 145 项通过 |
| 后台核心小计 | **1,128 项通过** |
| Runtime | 77 项通过；iOS arm64 / arm64e 独立编译通过 |
| UI | 30 项通过；双架构语法检查通过 |
| 本批实际回归小计 | **1,235 项通过** |
| AI | **880 项沿用 beta01**；AI 代码未变，本批未重跑 |
| 总覆盖 | **2,115 项** |

Rootless / Rootful 全量编译、链接、ldid 签名与打包均成功；两方案、双架构的 Manager、Runtime、Audio、UI 和更新说明均确认重编。产物核验通过真实 Debian 元数据、slices、最低系统版本、安装位置、仅 dylib/plist 的载荷、注入 plist、逐架构 SHA1/SHA256 CodeDirectory 页面与特殊槽位哈希、四份 dSYM UUID、符号 ZIP CRC 与 12 文件哈希、独立 dylib 一致性和四附件 SHA256。

构建后 42,933 个冻结输入 SHA256 不变；已有 1,284 个构建与历史发布文件的 SHA256、大小、修改时间均不变，包括 beta01 / beta02 全部产物与 README。工程已有的弃用 API / 链接选项警告继续保存在构建日志中。

命令、返回码和耗时见 `.theos/release-2.6-6-beta03/build-results.json`，冻结输入与验证依据见 `source-freeze.json`，完整产物核验见 `validation.json`；日志与源码快照也保存在该目录。

本包尚未安装到手机。实际音频共存、微信语音/录音/通话恢复、锁屏持续性、CPU 与耗电变化需在原 Rootless 环境验收；主机检查不能换算为手机性能改善比例。
