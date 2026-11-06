# 2.2-18：返回设置列表时的留白跳变

基线为任务开始时冻结的 **2.2-17 未提交工作树**，不是 Git HEAD。项目 checkout 为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`；HEAD 保持 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`。2.2-13～2.2-18 仍未提交。没有切换服务、端口、数据库、微信账号、偏好设置或真实 Keychain。

## 修复位置与证据强度

代码层可以确认的缺口在 `Controllers/CSCustomViewController.m` 的主列表 `setupUI`：原先创建 `UITableViewStyleInsetGrouped` 后，保留 UIKit 默认的 section 标题高度估算。返回会在 `viewWillAppear:` 第 151 行、`viewDidAppear:` 第 175 行各调用一次 `reloadData`，再次使表格测量失效。这允许分组标题在实际测量前采用估算几何，再被实际高度替换；它能移动首卡及整个分组内容，同时不移动资料 header 内的微信号。

个人资料 `tableHeaderView` 在第 513 行按固定 150pt 创建；其头像、昵称、微信号使用固定 frame。返回路径没有修改这个 header 的 frame，也没有根据 nav bar、safe area、头像下载或字号重新计算其高度。主列表自身继承 `UIViewController`，不由 `CSSettingsTableViewController` 的子页布局负责。`CSNativeSettingsHost` 只承载该子控制器并转发 appearance。

Apple SDK `UITableView.h:364` 将 `sectionHeaderHeight` 默认值列为 `UITableViewAutomaticDimension`；第 367 行将 `estimatedSectionHeaderHeight` 默认值列为 `UITableViewAutomaticDimension`，明确写着 `set to 0 to disable`。SDK 文件的绝对路径、SHA256、原始注释保存在 [RESULT.json](header-gap-validation/RESULT.json)。

本轮只在 `CSCustomViewController.m:921` 增加：

```objc
self.tableView.estimatedSectionHeaderHeight = 0;
```

这是关闭估算的公开 API，**不是把实际标题高度或留白设成 0**。实际高度仍由原生标题测量得到。业务修复 +3/−0（1 行 setter、2 行解释注释）；原有两次刷新保留，以免改变授权回调重新进入、切号或配置更新行为。未改 row/footer 高度、section top padding、滚动偏移、安全区、密码、生物识别、密友状态机或手势。

**已验证的是生产方法中“允许估算→实际”这一可测边界，以及禁用后契约模型不再产生中间间距；并未动态跟踪该 iPhone 的 UIKit 私有测量调用。** 录屏支持分组几何变化，不能单独证明具体 UIKit 回调。设备上的真实默认估算值、首帧和动画时序仍未验证，不能宣称已在真机证明修复完成，也不能编造“18px 由某个固定 padding 算出”。

## 录屏复核与测量差异

原视频 SHA256：`0114183b48080011124a10ea595a3e84083fb08dae96f34a47b75e6de1a43116`。统一采用从 1 开始的真实解码帧序号，f001 为第一帧，不是时间码；ffmpeg 使用 `-fps_mode passthrough`，不补齐、不复制帧。

用户原测量表完整保留如下，标注为**用户提供、未由本地附件复现**：

| 帧区间 | 用户时间 | 用户白卡顶边 y | 用户说明 |
| --- | --- | ---: | --- |
| f001–f021 | 0.00–0.70s | 480 | 进入子页前基线 |
| f022–f035 | 0.70–1.17s | — | push |
| f036–f042 | 1.17–1.43s | — | 子页静止 |
| f043–f050 | 1.43–1.67s | — | pop |
| f047–f057 | 1.57–1.90s | 498 | 返回后偏大 18px |
| f058–f062 | 1.93–2.07s | 498→480 | 四帧动画收回 |
| f062–f095 | 2.07–3.17s | 480 | 恢复基线 |

用户还提供微信号 y=280 全程不动、115 帧、约 12pt 的换算。这些来源事实保留，但没有拿来选择生产高度。

本地 ffprobe 与实际解码均为 **114 帧**、592×1280、3.833333s；五张提供的关键帧与相同序号解码 RGB **全部逐字节一致**。白卡算法对 x=120..470 的灰度行均值，在 y=340..550 搜索首个连续 8 行均≥250 的位置；另以文字墨迹包围框和整块列表竖直配准独立复核。

| 本地解码帧 | 实际 PTS | 白卡 top y | 分组标题墨迹 y | 微信号墨迹 y | 列表相对 f011 的位移 |
| --- | --- | ---: | --- | --- | ---: |
| f001–f021 | 0.000000–0.666667s | 413 | 386–402 | 318–336 | 0px |
| f047 | 1.533333s | 390 | 362–378 | 318–336 | −24px |
| f048–f054 | 1.566667–1.766667s | 389 | 362–378 | 318–336 | −24px |
| f055–f057 | 1.800000–1.866667s | 390 | 362–378 | 318–336 | −24px |
| f058–f094 | 1.900000–3.100000s | 413 | 386–402 | 318–336 | 0px |

本地附件呈现“下方分组先压缩约 24px，再恢复”；白卡边缘阈值有 1px 亮度/抗锯齿误差。f057→f058 已恢复，没有测到 f058～f062 的四帧渐变。480/498 落在本地白卡内部。视频不含实际 UIKit bounds/scale，不能据此确定点值或系统估算高度。

完整逐帧 CSV、PTS、灰度行均值、工具命令和来源 SHA 见 [独立视频报告](video-analysis/README.md)、[provenance](video-analysis/provenance.json)。

![旧版本录屏的 f011 / f055 / f070 复测标线](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/release-2.2-18-settings-return-header-gap/video-analysis/comparison-annotated.png)

## 先红后绿，逐阶段捕捉中间态

采用逐字抽取生产 `setupUI` / `viewWillAppear:` / `viewDidAppear:` / `viewWillDisappear:` 的 Objective-C 主机测试，UITableView 边界是公开估算契约 double，**不是真实 UIKit 实现**。三种实际标题高度、四种正反方向估算误差、三种滚动/回弹位置均独立输入，不使用录屏像素拟合错误值。

| 运行 | 通过断言 | 失败断言 | 场景 | 几何阶段样本 |
| --- | ---: | ---: | ---: | ---: |
| 未修改冻结 2.2-17，正式红档 | 33,696 | 3,456 | 432 | 6,048 |
| 单 setter 修复，2.2-18 | 37,152 | 0 | 432 | 6,048 |

每场景采样 14 阶段，覆盖进入前、push 首帧和中途、pop 可见前和首帧、测量后、didAppear、转场完成等待测量、最终态、交互返回取消和再次返回。每阶段记录 header 高度、分组高度、首卡 y、微信号 y、inset、adjusted inset、offset 和 reload 次数。

旧代码八个中间阶段各 432 次 gap 失败，合计 3,456；两个最终态 864/864 原本全部通过。**只比较进入前和返回终值会漏掉全部红点。** 新代码 6,048 个阶段样本均保持各自基线；原有 header、微信号、滚动位置和 inset 不被改写。

红绿 fixture 与 runner SHA256 分别相同，未修改断言或期望凑绿。红档保留生产全文、方法抽取、fixture/runner 快照、编译命令、源文件运行前后哈希及所有样本：

- [正式红日志](header-gap-validation/red-final-2.2-17/run.log) / [红 provenance](header-gap-validation/red-final-2.2-17/provenance.json)
- [绿日志](header-gap-validation/green-2.2-18/run.log) / [绿 provenance](header-gap-validation/green-2.2-18/provenance.json)
- [逐阶段统计](header-gap-validation/RESULT.json) / [完整测试边界说明](header-gap-validation/README.md)

## 返回与 push 路径覆盖范围

真实菜单分支核对：顶栏信息、头像设置、触摸轨迹、界面简化、界面净化、气泡样式、列表圆角、底栏样式、布局设置、附件布局；另核对密友普通入口和头像五击快捷入口。

上述 12 个标签均执行同一个生产父列表生命周期，共 432 个主机场景。**测试没有实例化这些子页、运行真实导航或系统转场，所以不算 12 条真机路径实测。** 它证明共享父列表配置在这些入口标签下的契约，不证明子页私有行为。

旧录屏只实测了头像设置这一条设备返回。push 子页可测区域 f025～f043 白卡维持约 208px，f034 的 207px 属阈值误差；没有看见约 24px 的对称阶跃。f022～f024 被水平转场遮挡，不能排除不可见区域变化。主机 push 两阶段旧版和新版均为 864/864 gap 样本通过。

**修复后的所有真机返回路径和 push 首帧均未验证。** 当前没有已启动设备或安装的 iOS simulator runtime。真机手势、返回首帧、转场观感、不同字号/方向、系统版本组合和真实 Keychain 均未验证。

## 原始失败豁免

**100 个原始脚本中 18 个仍未通过，本轮按用户授权豁免。** 原始 `script_count=100`、`passed=82`、`failed=18`、100 条 runs、18 条 failures、退出码与诊断保留。其历史日志属于继承的 2.2-17 证据，不冒充本轮重跑。

完整 18 项继续使用原字节 [WAIVER.md](WAIVER.md)，本轮授权原文、路径、SHA 和继承验证见 [WAIVER-CONTINUATION.md](WAIVER-CONTINUATION.md)。

`gate_status` 为 `waived_by_user_explicit_authorization; 18 baseline failures accepted for 2.2-18 by continued waiver`，不是 pass / green / all-clear。七项核心、原 82 个非豁免脚本以及本轮新增测试仍为独立门槛，任何新增失败必须停止出包。

## 回归、构建、产物与保护

冻结生产输入后实际执行 **91/91 任务退出码为 0**：9 个现代 suite 加原先通过的 82 个脚本；本轮新增视觉契约测试另计，不与原始 100 脚本统计混在一起。323 个既有 fixture/runner 字节不变，原断言和期望未修改。详见 [CORE-REGRESSIONS.json](CORE-REGRESSIONS.json) 和 [本轮复跑记录](release-core-revalidation/SUMMARY.md)。

| 核心门槛 | 本轮实际通过 / 失败 |
| --- | --- |
| 快捷页完整重置、中断恢复 | 259 / 0 |
| 重置后设密、锁定、解锁 | 105 / 0 |
| 头像五击入口 | 90 / 0 |
| 2.2-16 回滚与残留清理 | 232 / 0 |
| 气泡紧密 | 1,436 / 0；compact 2pt，normal 21/24pt |
| 2.2-14 四项 | 4 suites / 0；设置 5,114、搜索/长按标题 357、底栏 6 验证步骤、Merge 每受支持版本 17,566（3 版本）及 policy 235,148，均无失败 |
| 消息布局及会话/列表/隐私主链 | 原 82 脚本 82 / 0；其中消息布局六套 1,048,295 / 0、布局偏好 10,013 / 0、列表圆角 1,631 / 0、group header 46 / 0、indicator 91 / 0、隐私 38 / 0 |

分项存在重叠，不将其累加成新的总断言数。100 个原始脚本中 18 个仍未通过，本轮按用户授权豁免；这不是“全量回归通过”。

两 scheme 均执行 `make package -j1`，分别使用独立临时 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`、`THEOS_PACKAGE_DIR`。编译输入与前述回归的冻结生产输入逐文件一致；没有 `make clean`、历史包覆盖或 Git 状态重置。命令、临时路径、编译日志、产物输入 SHA 和 dSYM UUID 在 [build-result.json](delivery-build/build-result.json) 中。

| 警告多重集对比 2.2-17 delivery-build-final | 基线 | 2.2-18 | 新增 |
| --- | ---: | ---: | ---: |
| rootful arm64 | 4 | 4 | 0 |
| rootful arm64e | 4 | 4 | 0 |
| rootless arm64 | 4 | 4 | 0 |
| rootless arm64e | 4 | 4 | 0 |

仅去掉 ANSI 与诊断行列号；保留源文件、架构、完整诊断和重复次数。详见 [warning-comparison.json](delivery-build/warning-comparison.json)。

另对实际消费的四个 `CSCustomViewController.m` 编译对象定点反汇编：arm64 `0x4674 fmov d0,xzr` → `0x4678` 调用 `setEstimatedSectionHeaderHeight:`；arm64e `0x4b88 movi.2d v0,#0` → `0x4b8c` 调用同一 setter。两 scheme 一致。对象 SHA、deb/dylib SHA 和 dSYM UUID 绑定在 [packed-fix-verification/result.json](packed-fix-verification/result.json)。这是修复进入编译产物的证据，**不是设备执行轨迹**。

本次五个交付文件位于 `packages/2.2-18-settings-return-header-gap/`。重签用 dylib 来自 rootful deb，字节完全相同，均含 arm64 / arm64e；symbols.zip 含两 scheme、两架构符号，UUID 已匹配。

| 文件 | 字节 | SHA256 |
| --- | ---: | --- |
| `SHA256SUMS` | 410 | `29ebd9e94d95d3390ca774c0cbcd4523cfcdc87bd5595ef54312962c12a9d34f` |
| `WeChatImprove.dylib` | 7170112 | `732e31d78075f4b67229f54e3862bbf849aad0f1cdfa67ae46bfdf65465b10c8` |
| `com.wechat.improve_2.2-18_iphoneos-arm.deb` | 1648252 | `cc26d3533d391cc5c007adaa422e7f7cca0c02509945e8ca8fcc3aaa5e1639ce` |
| `com.wechat.improve_2.2-18_iphoneos-arm64.deb` | 1647542 | `402fe31f38440628d9cbfc984b4fc6c36fe4fc20aa86b1f5376b78b2967e4632` |
| `com.wechat.improve_2.2-18_symbols.zip` | 11708412 | `e514ab81ee2ff096b8b5d059449315821ee7f5ff2b869a6ea4419e634a1a075c` |

实际运行 `shasum -a 256 -c SHA256SUMS` 输出：

```text
WeChatImprove.dylib: OK
com.wechat.improve_2.2-18_iphoneos-arm.deb: OK
com.wechat.improve_2.2-18_iphoneos-arm64.deb: OK
com.wechat.improve_2.2-18_symbols.zip: OK
```

分别运行 `dpkg-deb -f ... Version`：

```text
com.wechat.improve_2.2-18_iphoneos-arm.deb: 2.2-18
com.wechat.improve_2.2-18_iphoneos-arm64.deb: 2.2-18
```

## 相对冻结 2.2-17 的改动与哈希保护

生产和版本说明合计 **5 文件，+15 / −8**；下面不计新增审计、测试、录屏派生物和交付产物。逐文件前后 SHA256 与行数来自 `git diff --no-index --numstat`，不以仍停在旧版本的 HEAD 计算。

| 文件 | 增加 / 删除 | 2.2-17 SHA256 | 2.2-18 SHA256 |
| --- | ---: | --- | --- |
| `Controllers/CSCustomViewController.m` | +3 / −0 | `6f602715e9cf5863798accf429f0d02369d33c4214a22aca0d7b015c16519cd7` | `933c2af2174ee391c916a3f43e6c798147cb54cb6293515b9e1119210c2d26f7` |
| `Controllers/CSReleaseNotesViewController.m` | +4 / −0 | `d3eee3cbc5d5c32af38f85fc9ebeaaa527360086877182cfe6fb029f41119596` | `054937db8b339dce2b2b6691ac332c4c5475ff96d24ab5778ed5486d841dcff5` |
| `Headers/CSUserInfoHelper.h` | +1 / −1 | `d20ffbefef03827529f35b0b50517709b3f818d643d90b5d37ca7aefb02f0191` | `d6cec59fae4866c1237797fcec20898fa2bca0219cac074a3d0481940b5366bd` |
| `README.md` | +6 / −6 | `61129793cee6bcb92ab8d4e4556952cf48ccfecd95471e6336adb70707dbfece` | `64ce847fa310a317e4bad0916d5b8a98a2b20cb978ea7a5d710758346bc1741d` |
| `control` | +1 / −1 | `e8933fc97a8f4ca0047f26e3fcf2c2d8c86210671c5e070efd855c7eafc54ac5` | `c87e5f407cd90b477ffd327ef22fe1b4bb146cdf09e16da0d3a0f86dcf444b91` |

| 保护对象 | 验证文件数 | 结果 |
| --- | ---: | --- |
| 冻结的 2.2-17 基线 | 42,524 / 42,524 | PASS |
| 出包前历史 packages | 199 / 199 | PASS |
| 主树 .theos | 1,237 / 1,237 | PASS |
| HeadersFile | 42,142 / 42,142 | PASS |
| 2.2-17 旧审计（从准备时间起完整 set + hash） | 44,688 / 44,688 | PASS |
| 显式五文件外的冻结输入 | 42,519 / 42,519 | PASS |

另外，本任务开始时单独冻结的五份 2.2-17 gate/waiver/授权/core 证据逐字节保持一致，见 [inherited-evidence-final.json](inherited-evidence-final.json)；323 个复制的测试与 runner 输入全部不变，根 `Tests/` 继续不存在。

完整范围核验见 [final-scope.md](final-scope.md) / [final-scope-result.json](final-scope-result.json)。HEAD 仍为 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`，没有提交，2.2-13～2.2-18 留在当前工作树。

## 安装后的设备验收重点

使用本目录 `WeChatImprove.dylib` 重签注入后，先进入插件设置，记录微信号下方到“账号与安全”的间距；进入头像设置再返回，检查**父列表第一个可见帧、返回完成时及随后约 0.5 秒**，间距应一直等于进入前基线。分别用返回按钮、交互返回完成/取消重复，并覆盖上述十个界面定制子页与普通/快捷密友页；再确认 push 可见区域无对称阶跃、原滚动位置保留。

这段是待执行的设备验收步骤，不是已经取得的设备结果。所有新版本真机首帧、手势、视觉间距、系统 UIKit 调度和真实 Keychain 均标为**未验证**。
