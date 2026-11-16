# 2.6-7 防封检测整理正式版

发布日期：2026-11-16。正式整理防封检测模块，包含此前能力接入、微信 8.0.80.34 真实接口适配、诊断与兼容修复，并清理重复状态及无消费代码。当前用户环境为 **Rootless**，使用下方主安装包。

| 产物 | 内容 |
| --- | --- |
| [Rootless 主安装包](com.wechat.improve_2.6-7_iphoneos-arm64.deb) | `iphoneos-arm64`；安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-7_iphoneos-arm.deb) | `iphoneos-arm`；安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| [独立动态库](WeChatImprove.dylib) | 与本版 Rootful 包内动态库逐字节一致 |
| [调试符号](symbols.zip) | 两方案各含 arm64 / arm64e dSYM，共四份；供定位崩溃使用，不属于运行时调试代码 |
| [SHA256 校验清单](SHA256SUMS) | 两个 deb、独立动态库及符号附件的校验值 |

两个安装包均包含 **arm64 + arm64e，最低编译目标 iOS 15.0**。Debian 包版本、插件内显示版本、当前更新内容和下载入口统一为 **`2.6-7`**。设置入口为“插件设置 → 账号与安全 → 防封检测”，页面标题“反检测”。

## 正式版清理

- **精简重复接口缓存。** 原来每次状态更新都会构建整份接口记录，但后续只读取其中的尝试签名。现在仅保存实际使用的签名字符串，诊断时实时核对接口，减少重复反射与无消费记录。
- **移除未使用的调用计时。** 删除没有页面或测试读取的最近调用时间字段、Mach 时钟读取和时间换算；调用、应用、透传与异常计数保留，最近结果使用明确的初始状态区分“尚无完成记录”和“已应用”。
- **删除重复诊断输出。** 每项能力已展示的接口不在末尾重复列出；额外动态接口、包信息资源、本机 IDFV 和应急停用状态仍保留。
- **收紧测试接口的构建边界。** 原始状态读取 API 改为仅在测试宏内编译，生产内部使用静态函数；其他 fixture 接缝继续受编译条件保护。正式包逐架构拒绝测试 API、测试宿主状态及 fixture 输出字符串。
- **统一正式版资料。** 更新正式版号、内置更新内容与当前下载链接，合并当前功能说明中的测试版叙述。测试源保留在 `Tests/`，用于后续回归。

适配层未发现生产日志或可删除的静态死函数；保留实际使用的 B/c、整数 ABI、异常传播、关闭透传、签名拒绝和原调用链。当前宿主缺少目标的兼容分支仍有明确职责，未因单一版本缺类而移除。原有 **28 项能力、30 个用户布尔设置及默认值**保持一致。

## 微信 8.0.80.34 接口范围

核验输入为短版本 `8.0.80`、构建号 `8.0.80.34` 的 IPA，检查主程序及 20 个随包 framework，交叉核对 Objective-C 元数据与静态反汇编。IPA SHA256 为 `5cacb443b743793ccfe6026bc81c1f2678cb5cfdcd38584ad73ac7f19ecf4a5f`，主程序 SHA256 为 `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。

| 原有能力 | 已核实的目标 | 完整 ABI |
| --- | --- | --- |
| 替换本地环境检测结果（实验） | `+[JailBreakHelper JailBroken]` | `B16@0:8` |
| 同上 | `-[JailBreakHelper IsJailBreak]` | `B16@0:8` |
| 屏蔽本地检测结果（实验） | `-[WCSHmdtMgr isHmdtEnable]` | `B16@0:8` |
| 同上 | `-[WCSHmdtMgr startTask:behaviorID:config:]` | `v36@0:8I16@20^{TaskConfig=I}28` |

四个目标要求短版本、构建号、方法身份与完整签名同时匹配。JailBreakHelper 先执行原方法保留内部标记等副作用，再按策略替换 BOOL 结果；WCS gate 影响后续初始化缓存，任务入口影响既有实例的后续任务。WCS 范围包含直播采样，不能撤销已经提交的任务，完整初始化或恢复仍需重启微信。

同一手机环境中的两项能力预期各显示“部分安装 2/4”，尚未在新版真机观察。原先其余 **11 项**没有安装目标的能力仍缺少经核实的替代接口。缺少有效 `siri.plist` 时继续保留原查询。这些本地目标未被证明专属于好友验证链；接口安装与计数不能证明服务端接受申请或避免封禁。完整开关、作用范围、资源及停用说明见 [反检测说明](../../docs/features/client-guard.md)。

## 核心回归

| 检查 | 本版实际结果 |
| --- | --- |
| `bash Tests/verify-client-guard.sh` | **14 个独立进程、2576 条断言通过，退出码 0** |
| 断言构成 | 核心 244×2、原查询 129×2、JiDe 原生 106+113、JiDe 查询 189×8、8.0.80.34 专项 48+51 |
| `bash Tests/verify-backup-registry.sh` | **1821 条断言通过**，覆盖精确的 30 个用户布尔设置和本机状态排除 |
| `bash Tests/verify-backup-bootstrap.sh` | **34 项检查通过**；42 个受门禁功能 Hook、9 个独立适配器及 2 个恢复文件完成生成代码核查，iOS arm64 语法和 Objective-C++ C linkage 通过 |
| 防封模块严格语法检查 | 六个实现文件在 iOS arm64 / arm64e 下以 `-Wall -Wextra -Werror` 通过 |

本次清理新增 16 条断言，覆盖诊断去重、资源及额外接口保留、尚无完成记录、准入但尚未完成调用、首次结果和 1000 次并发后的计数与最近结果语义。原有版本门禁、签名拒绝、原方法副作用和异常、参数与指针身份、范围、资源缓存、应急停用和关闭透传覆盖继续通过。

运行时测试使用真实 macOS Foundation 与隔离的测试私有类，Hook 安装边界由 fixture provider 替代 Substrate。所有检查均使用独立临时资源，未修改用户微信账号、偏好或数据库。

## 构建与验收边界

正式包从 **42,961 个输入文件**的固定快照构建，其中 **42,595 个为构建输入**。使用独立的 Rootless / Rootful 缓存，分别约 **23.6 秒、23.2 秒**完成编译打包；未运行 `make clean` 或设备安装命令。

已核验 Debian 版本和架构、准确安装路径、两项载荷与注入 plist、arm64/arm64e、最低 iOS 15.0、Rootless RPATH、逐架构 CodeDirectory SHA1/SHA256 页面与特殊槽哈希、四份 dSYM UUID、符号 ZIP CRC/内容哈希、独立 dylib 与 Rootful 载荷一致性及全部附件 SHA256。四个架构切片均具备 9 个必要模块符号和 8 个宿主目标/版本字符串，均没有测试专用符号或 fixture 调试输出。

两方案各有 8 条既有编译警告，去除终端颜色转义后，数量和消息集合与 beta02 一致，**无新增警告**。冻结输入构建前后保持一致；开始本轮工作时仍在 `packages/` 中的 18 个历史文件，其 SHA256、大小与修改时间保持一致。工作区已有的历史包及审计文档删除保持原状，未被本次清理、构建或提交扩展处理。

本地证据保存在 `.theos/release-2.6-7/`：`source-freeze.json`、`source-inputs.json`、`workspace-source-verification.json`、`regression-results.json`、三个回归日志、`strict-guard-results.json`、`build-results.json`、`validation.json` 与 `warnings-comparison.json`。这些本地构建和分析缓存不进入 Git 提交。

本版尚未安装到用户手机。真实 UIKit 转场、Substrate/PAC、其他插件共存、初始化时机和业务流程仍需原 Rootless 环境确认。当前 Theos 缺少 Roothide scheme，本版未生成 Roothide 专用包。接口存在、签名匹配、安装成功或本机测试均不代表服务端防封效果。
