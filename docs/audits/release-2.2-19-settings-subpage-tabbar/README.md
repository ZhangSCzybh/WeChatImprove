# 2.2-19：插件设置子页原生底栏泄露

基线是任务开始时冻结的 **2.2-18 未提交工作树**，不是 Git HEAD。工作目录为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，HEAD 保持 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`。2.2-13～2.2-19 不提交；未更换 checkout、服务、数据库、账号、偏好或真实 Keychain。

## 已定位的决策链与修复层级

**根宿主继承微信的隐藏声明，插件 push 目的页却返回 UIKit 默认 NO；微信 8.0.80 原生 owner 在准备转场时据此重新显示底栏。** 这不是通过修改外观掩盖的问题，也不是把根宿主的属性改掉：导航目的页变了，原生 owner 采用了新页面自己的属性。

1. `Hooks/CustomEntryHooks.xm:261` 使用 `CSNativeSettingsControllerClass()` 注册插件入口。`Controllers/CSNativeSettingsHost.m:17–25,30–47` 动态创建继承 `MMUIViewController` 的宿主，`CSCustomViewController` 作为它的内容 child。
2. 用户指定 8.0.80 IPA 的原生 `MMUIViewController initWithNibName:bundle:`，IMP `0x115878564`，在 `0x1158785cc` 取 `setHidesBottomBarWhenPushed:`，`0x1158785d8` 令 `w2=1`，`0x1158785dc` 调用。因此根宿主获得 YES。
3. 插件表格子页继承 `CSSettingsTableViewController → UITableViewController`；AI 和定时任务的四个纯编辑页继承 `UIViewController`。2.2-18 没有给这些页面声明 `hidesBottomBarWhenPushed`。Apple SDK `UINavigationController.h:152` 明确其默认值为 NO。
4. 微信 `WCTabBarBaseNavigationController` 在 push / willShow / didShow 向 tab controller 转发。`WCTabBarController transitionForNavigationController:destinationViewController:animated:` 在 `0x1157db648` 读取 **destination** 的属性，用作 `targetHidden`。它没有将栈内祖先的 YES 合并到目的页。
5. `prepareTabBarForTransition:` 的 targetHidden=NO 分支在 `0x1157dbb58–0x1157dbb68` 调用 **原生** `setTabBarHidden:NO animated:NO`，并准备原生转场 copy。这是基线从隐藏根宿主进入默认 NO 子页时主动显示底栏的位置。
6. `finishTabBarTransition:cancelled:` 依据取消状态选择 sourceHidden/targetHidden、恢复 live bar 并移除 copy；didShow 无活动转场时走 `syncTabBarVisibilityForNavigationController:`，在 `0x1157dc088` 再读 **topViewController** 的属性并同步。

原生映像 SHA256 为 `571c5b8cf8732eb5402ffddcbeb93830cb6695bad180be5613ad4167764524e9`。方法身份来自 Objective-C method list 的 selector / encoding / IMP，不能把 objdump 最近的残留符号标签当方法名。16 份定点反汇编、metadata、命令、工具与输入 SHA、REA 绑定/关闭状态详见 [来源报告](source-analysis/README.md) 和 [独立复核](video-analysis/independent-static-review.md)。本轮使用 [reverse-engineer-anything skill](/Users/zhangshichao/.agents/skills/reverse-engineer-anything/SKILL.md) 核对用户指定原生制品。

修复仅在插件页面声明：

```objc
- (BOOL)hidesBottomBarWhenPushed { return YES; }
```

共享基类位于 `Controllers/CSSettingsTableViewController.m:11`，四个纯编辑页位于 `Controllers/CSAIReplySettingsViewController.m:143,188` 与 `Controllers/CSScheduledTaskSettingsViewController.m:67,99`。getter 在 view load 前及 new / style / coder 初始化路径均可读，不依赖 appearance 回调。没有全局写底栏 hidden / alpha，没有遮罩、截图、延迟、inset 绕行、转场替换，也没有关闭样式。主界面和非插件类未覆写该属性，显示、隐藏、取消与恢复仍由微信原生导航决定。

`TabBarStyleHooks.xm` 对 hidden/alpha 原参数转发 `%orig`，adapter 装饰原生控件和原生转场 copy；两者本次逐字未改。底栏带着真实图标、角标和样式出现，与上述 native copy / live bar 决策相符；图像不能区分这两个对象的身份。

## 请求的真实阶段日志：未取得

在生产修改前检查可用性：没有安装的 simulator runtime，也没有 booted simulator；已配对 iPhone 与 Watch 均 unavailable，没有可连接的 WeChat 进程。未启动或改动设备。

[STATUS.json](runtime-evidence/STATUS.json) 对 push 起始/中途/完成、pop 起始/完成、根列表出现、返回原生插件列表、退出主界面这 8 个阶段逐一记 `captured:false`；真实 `MMTabBar hidden/alpha/superview/frame/window` 与 VC 类型 / hide policy / modal / child 均为 `null`，**未验证**。用户要求的实际对象日志没有取得，不把反汇编、录屏或主机模型填作设备日志。

主机阶段样本另存测试目录，所有样本均注明 `host-policy-model; NOT device runtime`。它们验证生产声明与已知 native 读取契约，不能证明真实 UIKit 的逐帧对象状态、可见性、点击或视觉恢复。

## 视频逐帧复核

源 `docs/feedbacks/2026-11-06-settings-subpage-tabbar-leak.mp4` 的 SHA256 为 `cb320e249770f6691940ce4ae316c368a0e3d1b3b95a0847d2a703189358c5bc`。独立 passthrough 解码为 HEVC、592×1280、182 帧、6.133333 秒；f001 为第一个真实解码帧，PTS 另列，不补帧。11 张编号关键帧与对应解码 RGB 完全一致。

用户给出的绿色 ROI 为 y=1160..1270，条件 g>120、g-r>50、g-b>30。主窗口复现为 f073–f095、f120–f143。f073 在 x546..591 露出，随后向左进入；f085 稳定 bbox x88..507、y1174..1251，坐标差 419×77，含端点像素为 420×78。f073 到 f085 为 12 个帧间隔，约 0.40 秒。f150 两个孤立绿色噪点未删除，保留原始统计。

**对“f095→f096 / f143→f144 单帧消失”的解释需修正：** f096 / f144 胶囊仍可见，已上移至约 y1048..1123，超出原 ROI；f096 上方 ROI 命中 2,182 个绿色像素，bbox x90..503；f144 为 2,231，x132..547。底栏随后随退出子页移出，仍可见到 f099 / f147，f100 / f148 才离屏。因此固定底部 ROI 归零不能证明当帧 hidden/alpha 被改写。原始用户测量、反例、完整 182 帧数据、PTS 与 RGB SHA 均保留在 [视频报告](video-analysis/README.md)。

![固定 ROI 漏掉上移底栏的反例](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/release-2.2-19-settings-subpage-tabbar/video-analysis/pop-roi-counterexample.png)

## 红档、绿档与中间态

[正式红档](tabbar-navigation-validation/red-runtime-2.2-18/run.log) 在未修改的 2.2-18 生产代码上编译退出 0、运行退出 1。完整共享基类直接编译；四个纯编辑器只抽取生产 getter。其他页面按实际 interface 继承链生成声明，**没有执行这些子页的业务本体或实际导航**。原生 destination/top 读取关系由上面的原生反汇编独立提供。

| 运行 | 断言 | 通过 | 失败 | 路由标签 | 阶段样本 |
| --- | ---: | ---: | ---: | ---: | ---: |
| 未修改 2.2-18 | 101,400 | 83,400 | 18,000 | 50 | 49,200 |
| 修复 2.2-19 | 101,400 | 101,400 | 0 | 50 | 49,200 |

50 个标签对应 44 个共享表格基类后代、4 个纯编辑器、密友两入口别名。600 种 route / style / container / initializer 组合各走两轮。每轮采样 push 的 12 个中间阶段及完成，pop 中间、取消、完成，根列表、原生插件列表、主界面与四 tab 来回切换。

红档中每个 push-middle 阶段有 600 次可见性违规，共 **7,200 次中间态失败**；push 完成另有 600 次。18,000 总失败还包括属性声明与 pop 取消/中间状态。进入前、返回后根列表原本都通过，故只比较首尾会漏掉问题。绿档的全部 49,200 个阶段样本符合导航政策。

[红绿对照](tabbar-navigation-validation/red-green-result.json) 保留 4 个 fixture / runner 的相同 SHA、两次 source_unchanged=true、完整生产全文、方法抽取、编译/运行命令、输入前后哈希及全部样本。正式红档之前的两次夹具编译预检失败也原样保留，不伪装成有效红点。本轮不改任何既有断言、夹具、期望或生产测试后门。

12 个 push-middle 样本是同一政策状态的重复采样，不是 12 帧真实 UIKit 动画，也不模拟原生转场运动。模型的 style 开/关是输入标签，不能验证实际样式；nativeBarCount 固定为 1，也是模型状态，不能证明真机没有重复 view。它验证的是缺失声明造成的决策差异，而不是实现微信整个导航。详见 [测试边界](tabbar-navigation-validation/README.md)。

## 逐路径与反向覆盖

[逐页面路径表](source-analysis/route-coverage.md) / [机器可读表](source-analysis/route-coverage.json) 列出 53 条真实菜单或嵌套路径，映射到上述 50 个模型标签。相同目标页复用同一类型，不把标签数说成独立 UI 运行次数。

| 用户要求的页面 | 本轮验证方法 | 新包真机 |
| --- | --- | --- |
| 账号信息、收藏验证 | 实际继承链 + 执行生产共享基类的导航政策 | 未验证 |
| 顶栏信息 → 页面标题“顶栏头像设置”、头像设置 | 同上；旧视频仅覆盖这两类实际页面 | 未验证 |
| 触摸轨迹、界面简化、界面净化 | 实际继承链 + 执行生产共享基类的导航政策 | 未验证 |
| 气泡样式、列表圆角、底栏样式 | 同上；底栏样式自身 suite 另跑 | 未验证 |
| 布局设置、附件布局 | 实际继承链 + 执行生产共享基类的导航政策 | 未验证 |
| 密友普通入口、头像五击入口 | 两入口指向同一 CSSettingsTableViewController 后代；独立模型标签及原功能回归 | 未验证 |
| 备份、恢复预览、重置预览、修复、修复中的设置跳转 | 逐入口核对 + 共享基类政策；重新打开根宿主单独记录 | 未验证 |
| AI 全局、会话列表/详情、回复记录、预设、选项 | 逐入口核对 + 共享基类政策 | 未验证 |
| AI 连接编辑、预设编辑 | 执行各自生产 getter | 未验证 |
| 定时任务列表/编辑、内容/时间编辑 | 共享基类或各自生产 getter | 未验证 |

原生联系人 modal、系统图片/颜色/文件选择器不做全局属性改写。`WEContactSelectViewController` 虽被 Makefile wildcard 编译，但当前仅借用其 enum，没有实例化/push 调用；实际选人走原生 picker，因此未改这个无使用路径的页面。

反向模型覆盖子页→根列表、根列表→原生插件页、退出→微信主界面、四 tab 两轮切换、再次进入/退出、交互返回取消、独立 modal，以及样式开/关。生产修复不写 bar / tab controller，不创建任何新 view，不改 style adapter、图标、文字、角标或选中逻辑。

**真实主界面底栏恢复、圆角/描边宽度/缩放/自定义图标/隐藏文字/未读角标/“我”选中态、点击区域、四 tab 无闪烁/残留/重复、第二次进出以及关闭样式后的整条路径全部未验证。** 旧视频不包含这些反向设备场景，不能以未改代码和主机模型替代设备验收。

## 是否由 2.2-18 引入

[实际冻结版本对比](REGRESSION-ATTRIBUTION.json) 与 [扩展源对比](source-analysis/navigation-17-vs-18.json) 核对 2.2-17→2.2-18 真实工作树，未以旧 HEAD 推断。共享基类、四编辑器所在 unit、原生宿主、入口、底栏 adapter 和 hooks 均逐字相同；根列表实际差异仅为 section 标题估算的 3 行。**已定位的默认 NO 属性缺口在冻结 2.2-17 源中已存在，不是 2.2-18 新增的导航/可见性改动。** 未取得 2.2-17 真机复现，最早出现同一视觉现象的版本未知。

## 原始失败豁免

**100 个原始脚本中 18 个仍未通过，本轮按用户授权豁免。** 原始 script_count=100 / passed=82 / failed=18、100 条 runs、18 条 failures、退出码与诊断均保留。这些是继承的历史原始结果，不冒充本轮执行。16 个 fixture compile incompatibility 与 2 个 extractor contract incompatibility 的原 [WAIVER.md](WAIVER.md) 字节不变；本轮仅新增 [授权延续](WAIVER-CONTINUATION.md)，授权源为 `docs/feedbacks/2026-11-06-settings-subpage-tabbar-leak.txt`。

`gate_status` 为 `waived_by_user_explicit_authorization; 18 baseline failures accepted for 2.2-19 by continued waiver`，不能解读为 pass / green / all-clear。18 项以外出现新红必须停止，不另行扩大豁免。

## 本轮发布执行记录

回归、构建、实际包校验、逐架构警告、历史包与主树保护见下方发布完成记录及其原始 JSON。分项存在重叠，不相加冒充总断言数。此处的主机和编译结果不改变上面所有真机未验证结论。

### 核心回归实际结果

冻结输入后，本轮 **92 / 92 任务退出 0**，包含原仍绿 82 脚本与 10 套现代 suite；本轮新增导航测试独立计为 101,400 / 0。325 个既有 fixture / runner 原字节不变，源输入在执行前后保持一致。原始 18 项仍按上面的限定授权豁免，没有新增豁免或新失败。详见 [CORE-REGRESSIONS.json](CORE-REGRESSIONS.json)、[本轮 result.json](release-core-revalidation/result.json) 和 [run-core.log](release-core-revalidation/run-core.log)。

| 核心门槛 | 本轮通过 / 失败 |
| --- | --- |
| 快捷页完整重置、中断恢复 | 259 / 0 |
| 重置后设密、锁定、解锁 | 105 / 0 |
| 头像五击入口 | 90 / 0 |
| 2.2-16 回滚、残留 marker 清理 | 232 / 0 |
| 气泡紧密 | 1,436 / 0；compact 2pt、normal 21/24pt |
| 2.2-14 四项 | 4 suites / 0：设置 5,114 / 0、搜索/长按标题 357 / 0、底栏 6 验证步骤 / 0、Merge adapter 每受支持版本 17,566 / 0（3 版本）及 policy 235,148 / 0，含 8.0.80 |
| 消息布局与会话/列表/隐私主链 | 原仍绿 82 脚本 82 / 0；消息布局六套 1,048,295 / 0、布局偏好 10,013 / 0、列表圆角 1,631 / 0、group header 46 / 0、indicator 91 / 0、隐私 38 / 0 |
| 2.2-18 返回间距 | 37,152 / 0，432 场景 × 14 阶段，6,048 样本 |
| 本轮新导航政策 | 101,400 / 0，50 标签、49,200 阶段样本 |

分项有重叠，不累加作总断言数。**100 个原始脚本中 18 个仍未通过，本轮按用户授权豁免**，不声称“全量回归通过”。

### 相对冻结 2.2-18 的源文件范围

只改 7 个生产/发布文件，合计 **+19 / −8**；其中行为修复 3 文件 **+7 / −0**。新增审计、测试、录屏派生物及交付包另计。下面的哈希与行数来自实际冻结工作树，未以旧 HEAD 代替基线。完整补丁见 [2.2-19-production.patch](2.2-19-production.patch)，机器可读记录见 [SOURCE-CHANGES.json](SOURCE-CHANGES.json)。

| 文件 | 增 / 删 | 2.2-18 SHA256 | 2.2-19 SHA256 |
| --- | ---: | --- | --- |
| `Controllers/CSSettingsTableViewController.m` | +3 / −0 | `78b4ae44fdbc8910c5fdf674d9a24bd926a39854fee865bfe7cca3201bdd7937` | `f9848ca17c2bb9c325994040b434e5aff4e9fc2020aaabcf87f520e23974f03e` |
| `Controllers/CSAIReplySettingsViewController.m` | +2 / −0 | `6ba96063b229d4a7f766a3d3e63fb43091b0744a5fc896ae2b6d1710349e88c8` | `d95767accc0059060eb053d502b39d91a3426f741663642863dd39c425dfa2b2` |
| `Controllers/CSScheduledTaskSettingsViewController.m` | +2 / −0 | `058b4c2f1b388b80666886a1501efac0006f08fe7126ea1f1580b09c7cb8f868` | `b4a7989995420b1e0f0e66bfe4928bb45d7cbe7b5309087d205813dcde496315` |
| `Controllers/CSReleaseNotesViewController.m` | +4 / −0 | `054937db8b339dce2b2b6691ac332c4c5475ff96d24ab5778ed5486d841dcff5` | `7f8fe9361b87c58a67e45360e57a433b4ec8380ba735aa50a76a1bf214816c09` |
| `Headers/CSUserInfoHelper.h` | +1 / −1 | `d6cec59fae4866c1237797fcec20898fa2bca0219cac074a3d0481940b5366bd` | `36a1d1d2634692f77160d25ad103d4201527c1bbc9d53661f8ead8ac9eae8b48` |
| `control` | +1 / −1 | `c87e5f407cd90b477ffd327ef22fe1b4bb146cdf09e16da0d3a0f86dcf444b91` | `371e06fbec4c301187b1540d2459709dc8fa369f8907b94e7d7d829477fc0ecd` |
| `README.md` | +6 / −6 | `64ce847fa310a317e4bad0916d5b8a98a2b20cb978ea7a5d710758346bc1741d` | `0ec961531a86abf101a8f071ccf1ce389b2a6138f33cca706efc525377841f05` |

### 构建、警告与交付校验

rootful / rootless 分别 `make package -j1`，每个 scheme 独立临时 `_THEOS_LOCAL_DATA_DIR` / `THEOS_BUILD_DIR` / `THEOS_PACKAGE_DIR`，编译采用冻结生产输入。未执行 make clean，没有覆盖历史 packages 或主树 .theos。实际命令、路径、objects、输入 SHA、dSYM UUID 与包身份见 [build-result.json](delivery-build/build-result.json)。重签注入 dylib 从 rootful deb 提取且逐字相同；两个 deb 的动态库及交付 dylib 均为 arm64 + arm64e fat，symbols.zip 包含两个 scheme 的匹配符号。

| 警告多重集（对比 2.2-18） | 原数量 | 本轮数量 | 新增 |
| --- | ---: | ---: | ---: |
| rootful arm64 | 4 | 4 | 0 |
| rootful arm64e | 4 | 4 | 0 |
| rootless arm64 | 4 | 4 | 0 |
| rootless arm64e | 4 | 4 | 0 |

仅去 ANSI 与诊断行列号，保留源文件、架构、完整诊断和重复次数。原始日志和 [warning-comparison.json](delivery-build/warning-comparison.json) 留档；没有用过滤警告或抑制新诊断凑零。

交付目录 `packages/2.2-19-settings-subpage-tabbar/`：

| 文件 | 字节 | SHA256 |
| --- | ---: | --- |
| `SHA256SUMS` | 410 | `c100fe5329561704510e6a4274f8454b19d1f2fb8d63c2c3e710a0c0007fd469` |
| `WeChatImprove.dylib` | 7170112 | `5f9079eb8258b082967744b030494e7ff38b07bb3bbb0d882e60396aefcaddb8` |
| `com.wechat.improve_2.2-19_iphoneos-arm.deb` | 1645916 | `b3fdf283faef4b1fe09d99856e3fd6b229094fcca81f5182d7105ce189c67c13` |
| `com.wechat.improve_2.2-19_iphoneos-arm64.deb` | 1648320 | `a058da1d7a563be546d9556079268a0d031828c180f62b053c049c5e0078ce39` |
| `com.wechat.improve_2.2-19_symbols.zip` | 11710002 | `d7e2321ae154c5aaa59c867df858fb184e7fbb446f92f46e1f11d79cb5aa31e7` |

根任务再次实际执行 `shasum -a 256 -c SHA256SUMS`：

```text
WeChatImprove.dylib: OK
com.wechat.improve_2.2-19_iphoneos-arm.deb: OK
com.wechat.improve_2.2-19_iphoneos-arm64.deb: OK
com.wechat.improve_2.2-19_symbols.zip: OK
```

分别实际运行 `dpkg-deb -f ... Version`：

```text
com.wechat.improve_2.2-19_iphoneos-arm.deb: 2.2-19
com.wechat.improve_2.2-19_iphoneos-arm64.deb: 2.2-19
```

`xcrun lipo -archs WeChatImprove.dylib`：

```text
arm64 arm64e
```

命令、exit code、stdout、所有五文件 SHA 留在 [ROOT-ARTIFACT-CHECKS.json](ROOT-ARTIFACT-CHECKS.json)，构建代理自己的独立检查见 [post-build-checks.log](post-build-checks.log)。

### 环境与历史数据保护

测试冻结输入与构建输入 **42,522 项逐文件相同**，不仅是各自运行前后稳定。见 [test-build-input-binding.json](test-build-input-binding.json)。

| 保护对象 | 核验文件 | 结果 |
| --- | ---: | --- |
| 冻结 2.2-18 全部基线 | 42,524 / 42,524 | 保持 |
| 出包前历史 packages | 204 / 204 | 保持 |
| 主树 .theos | 1,237 / 1,237 | 保持 |
| HeadersFile 完整集合 | 42,142 / 42,142 | 保持 |
| 旧 2.2-18 审计（从准备时刻起完整集合及字节） | 43,268 / 43,268 | 保持 |
| 显式七文件以外冻结输入 | 42,517 / 42,517 | 保持 |
| 既有复制 fixture / runner | 325 / 325 | 保持 |

完整核对见 [final-scope.md](final-scope.md) / [final-scope-result.json](final-scope-result.json)。任务开始额外冻结的 6 份旧 gate、waiver、授权、core、final-status 证据也保持，见 [inherited-evidence-final.json](inherited-evidence-final.json)。新增导航 fixture 的四个红绿 SHA 相同另有记录。

未执行 git reset / checkout / stash / commit 或 make clean，根 `Tests/` 继续不存在，未恢复用户移除的内容。HEAD 仍为 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`，2.2-13～2.2-19 继续未提交。没有切换用户环境、修改真实数据库或 Keychain，也没有部署或安装到设备。

## 安装后的待执行设备验收

用本目录 dylib 重签注入微信 8.0.80 后，从原生“插件”列表进根设置，依次点入完整路径表的各页。**从 push 第一个可见帧、中途到稳定态都不应看到四 tab 底栏或其转场副本**；返回与交互返回取消后根列表仍无底栏，再返回原生插件页也无底栏。普通/五击密友页与备份、AI 嵌套页分别走一遍。

退出插件回主界面后，核对原圆角、描边宽度、缩放、自定义图标、隐藏文字、真实未读角标和“我”选中态，逐个点击四 tab、重复进出两轮，检查无闪烁/残留/重复和吞点击。关闭底栏样式再走一轮；同时保留 .18 的返回 header 间距检查。这些是待执行步骤，**没有记作已验证结果**。

需补采实际 8 阶段的 MMTabBar hidden / alpha / superview / frame / window、目的 VC policy、modal 与 child 层级，以区分 live view 与原生 copy；当前 STATUS.json 中相关字段仍为 null。真实导航、点击、视觉外观、未读角标与 UIKit 调度全部 **未验证**。

## 最终制品修复代码核验

[packed-fix-verification](packed-fix-verification/README.md) 对 5 个 getter × rootful/rootless × arm64/arm64e 做 **20 / 20** 组定点检查：每组实际编译 object 与最终包内 dylib 方法均是 `mov w0,#1; ret`，准确返回 BOOL YES。不是只查 selector 字符串，也不止核对源文件。

最终地址由与 dylib UUID 匹配的 dSYM 中精确 Objective-C 方法符号取得；拆出的 thin slice 与 fat 中原始字节 SHA 一致。object SHA 与构建记录、源 SHA 与绿色测试/冻结构建、deb 与交付哈希、dSYM 与 symbols.zip 条目逐项绑定。40 份 object/final 方法窗口、命令与全部 SHA 见 [result.json](packed-fix-verification/result.json)。注入 dylib 与 rootful deb 字节相同。

这证明修复进入实际交付的机器码；**不证明设备动态分派、逐帧原生导航或视觉外观已验证**。最终发布状态另见 [FINAL-RELEASE-STATUS.json](FINAL-RELEASE-STATUS.json)。
