# 2.1-30 小程序返回隐私查询与顶部卡片布局收口

本版完成两个源码缺口的最小修补、主机红绿回归、双方案构建与包校验。**这不是两条自然返回路径已在真机消失的验收报告。** 本轮 USB 设备数为 0，Xcode 已配对设备 unavailable；没有连接、附加、安装、启动或重启微信，没有修改账号、设置、数据库。真实小程序生命周期与顶部 UIKit 次数仍是 unknown，不能以主机替身输入或视频像素代替。

基线为未修改的 2.1-29 提交 `73e8e78ad5bbc87cb2b73bcf64ed8e0e9ac13f8e`。当前仅交付一个版本：`packages/2.1-30-miniapp-return-and-top-flicker/`，按注入环境选择同版本 rootful 或 rootless。

## 1. 小程序返回：已确认的源码漏洞与未确认的自然生命周期

已有保护只在 `MainFrameTableView.layoutSubviews` 建立 Display 索引边界。UI 代理的 section／row 数量、cell、行高和 section 几何查询却可能在外层 Native scope 中、在该布局入口之前到达。旧代理沿用 Native scope，跳过过滤投影直接问原生 target：即使现有投影与隐私策略已经匹配，第一份行集合和分组仍可能来自完整原生列表。策略 blocked／投影不匹配时也未在这些查询入口拒绝交付。

完整生产 proxy、projection、refresh、路径映射与保护布局方法的受控回放确认这一漏洞：

| 受控查询出口 | 旧 29 | 修复 30 |
| --- | ---: | ---: |
| 标准 appearance 回调输入次数 | 0 | 0 |
| 在首次 UI 查询前经过 table.layoutSubviews | 0 | 0 |
| 首份 section 行数 | `[2,5,18]` | `[2,2,14]`，与过滤稳定态相同 |
| 调用受保护原生 cell getter | 2 | 0 |
| 普通组首行 y（替身几何单位） | 586 | 318，与稳定态相同 |
| UI 查询引起全表 reload／局部 reload／offset 写入 | 0／0／0 | 0／0／0 |
| blocked 状态 section 数／目标行高／受保护 getter | 3／70／1 | 0／0／0 |

修复在 proxy 查询入口检查 policy、账号、投影有效性及 privacyRevision；就绪时只在该 UI 查询内建立 Display scope。未就绪时数量／几何中性返回，过期的 required-cell 请求返回无内容、不可交互的非 nil cell；现有敏感行沿用原有 shield。这个门不触发 refresh、layout、recovery、offset 写入或排队延时，正常策略发布路径负责恢复内容。已有同 revision 的安全投影即使 dirty 也可保留，不强制整表重建。原始 native bridge／显式 native action 仍直达 original target，锁定／解锁规则未改。

逐场景原始计数、输入与同 hash 红绿测试在 [miniapp-probe](miniapp-probe/README.md)。每个受控首次样本的行顺序、section、逐行 y／height、卡片首尾角色、offset 均与过滤稳定态比较。这里的“首次样本”不是一次屏幕提交；fixture 会重问各行，不可用其采样数代替实际 publication／layout／frame 次数。

原录屏只确认修复前确有内容窗口与结构变化：本工具链 0-based 100–103 的已露出上部列表区域无业务内容；104–113 含两处应隐藏会话；114 改变。10 个样本至下一 PTS 为 333.333ms；首组白底扫描起点约 445→356px。与用户文字表有一帧起点差，原始 PTS 和双编号均保留，没有补帧。**没有由此推断手机是否走了 viewWillDisappear／viewWillAppear，或策略何时到达。**

## 2. 会话返回：绘制证据与修复边界

本次视频的 52／53／54 帧不能仅因白卡未达到 RGB255 就判漏绘。对稳定帧做同一区域的文字／底板水平配准与统一亮度拟合，位移为 -113／-73／-34px，平均绝对残差为 2.059／1.360／0.778；卡内／卡下灰底分别为 233／214、240／221、248／227。白底与灰底共同变亮，且圆角部分尚在屏外或被前景页面遮住。数据支持转场横移与共同遮暗可以解释这段可见差异，**未确认具体 UIKit 合成层，也不能排除更短的异常**。稳定 55–98 帧几何位置不变，少量压缩像素仍变化。

另外确认一个独立源码收口缺口：直接 `MMTableViewCell` 的原生布局会调整 contentView width／x，但原 hook 没有同步校正已存在的 session card，可能要等下一次 table／VC 布局。已对微信 8.0.78 的相关方法作有界静态核查，地址、二进制 hash、完整 `.asm` 与限制在 [top-transition](top-transition/README.md)。未发现这个原生方法直接清除插件 card 或替换 contentView；这两种输入只作为防御测试。

生产仅在原 MM cell layout 完成后，要求实际类恰为 MMTableViewCell 且已持有 session card，调用既有 `CSListCornerRefreshSessionGeometry`。不改任何圆角、颜色、分组角色算法；New/Fake 子类和外层 table depth guard 保持。真实 width/x 操作的受控输入计数为：

| 同一受控 cell-layout 出口 | 旧 29 | 修复 30 |
| --- | ---: | ---: |
| 原生 cell layout | 1 | 1 |
| card refresh／apply 入口 | 0／0 | 1／1 |
| content width | 390 | 390 |
| card／mask width | 412（仍旧值） | 352（正确值） |
| card frame setter | 0 | 1（必要的宽度同步） |
| offset y | 120 | 120 |
| host reloadData／模型查询 | 0／0 | 0／0 |

输入旧宽 450／x=-40 是受控条件，不是手机计数。旧 hook 到后续 table 出口才修正为 352；新 hook 当次 cell 出口即正确。后续 table 仍核对一次既有几何，不能把两个核对入口叫作两次重建。正常宽度／位置未变的兼容样本，card frame／background 写入和 display invalidation 都为 0，同一卡／mask／path 与 offset 保留。**没有证明该源码缺口就是录屏的实际残留来源，也没有重新认定重复交付。**

## 3. 修改与保护

实际行为修改只有两处：`Controllers/CSGroupListAdapter.m` 的 UI proxy 查询就绪门与 Display scope；`Hooks/ListCornerRadiusHooks.xm` 的 MM 直接业务 cell 布局收口。版本元数据四处同步 2.1-30：control、版本头、应用内说明、README。没有修改密友规则、解锁语义、底栏角标、AI、备份、搜索代码或圆角 renderer。

修复前已向用户提供四组共六处完整定义的原始字节 SHA256，见 [source-guards.md](source-guards.md)。修复后、构建前与最终检查均 6／6 通过，包含 26 suspend、27 refresh 与 publishProjection、28 performVisibleLayout、29 active-user 归属函数与 hook。不是 token 归一化，也没有空白例外。

`production.patch` 保存最终输入差异，`input-differences.json` 对照任务起始 42513 份生产输入。没有延时、渐变、快照、整表刷新替代局部更新或新的滚动恢复。旧全表刷新路径本体与全部保护方法保留原字节。

## 4. 红绿与限定回归

| 套件 | 未改 29 正式红 | 修复后成功数 |
| --- | ---: | ---: |
| 容器返回，真实代理与过滤／几何回放 | 1052 检查／378 失败 | 996／0 失败 |
| 独立就绪契约 | 82／34 失败 | 82／0 失败 |
| 顶部布局收口，三种受控输入 | 14／3 失败 | 14／0 失败 |
| 顶部不变内容／子类／嵌套布局兼容 | 旧29也是11／0，故不作红测 | 11／0 失败 |
| 指定既有回归，含相关圆角兼容 | — | 3863／0 失败 |

正式缺陷红测共 1148 个断言／415 失败，**红测的通过项、旧版兼容控制和重复测量不计入修复成功数**。当前独立成功断言共 **4966**。核心回放红绿总数差 56，是同一测试源码在旧代码的八次逐行比较中各多获得七条原生行，导致动态断言数不同；没有删除测试。每套正式红绿测试源与提取脚本 hash 均相同。

既有九套范围为 lifecycle、launch-banner、viewport、search、close-friend-session、return-privacy、return-layout、return-banner、list-corners。详见 `regression-result.json` 与原始日志。生命周期 extractor 原先宽泛匹配方法名，新增私有声明后误配；仅将测试提取标记收紧为完整方法体开头。失败编译保留 `*.initial-extractor-failure.*`。随后一次既有 250ms 定时器断言失败，日志独立保留；七份提取文件与旧29逐字节相同，随后顺序运行旧29／当前源码各239／0，不修改定时器或断言。额外控制运行不重复计入3863成功数。

## 5. 构建、历史保护与包校验

构建使用全新临时 `_THEOS_LOCAL_DATA_DIR`／build 目录，未运行 make clean。rootful、rootless 各含 arm64／arm64e，均 exit0；各 **6 条警告**与 2.1-29 去 ANSI 后的完整多重集合一致。原警告为 UILocalNotification×2、statusBarFrame×2、ld multiply_defined×2，没有新增项。

42513 份生产输入构建前／后／包验证时相同；任务开始记录的1325个既有 packages／.theos 文件和88个历史 packages 文件均保留原 hash。现有 Finder `.DS_Store` 改动保持原状，未纳入提交；反馈媒体与派生图像不上传。

双包的 control、架构、安装前缀、payload、部署版本／依赖、四份 dSYM UUID、符号归档 CRC、12份符号文件与 SHA 清单全部通过。原始日志与机器结果在 `build-result.json`、`package-verification.json`、`final-verification.json`。

| 产物 | SHA256 |
| --- | --- |
| `com.wechat.improve_2.1-30_iphoneos-arm.deb` | `ad39334ee627f07b46231d8c9568f333c4c19f21b23da200d8382b489e5a0c9a` |
| `com.wechat.improve_2.1-30_iphoneos-arm64.deb` | `f7f701e8dd5019d03543242189a06d1e63f29ba34fa4e84bfff71f2d48440ee0` |
| `com.wechat.improve_2.1-30_symbols.zip` | `85165420b52d0893a296e15b535ecfaa65e43c534a5afc5922bc91fb9c96b6b9` |

## 6. 真机仍需确认，不能填零

`runtime-availability.json` 与 `requested-runtime-counts.json` 把以下真实值保留为 null：小程序容器与列表标准 appearance 顺序／次数、原生与显示 scope、策略／投影是否就绪、内容与布局提交次数、业务 cell delivery、banner superview 身份／add/remove、实际 layoutSubviews／setFrame／drawRect／background setters、reloadData／reloadRows、offset轨迹、动画开始结束关系、修复后未过滤帧／卡底异常帧。

顶部可选只读观察器在 `top-transition/runtime-top-transition-observer.js`，仅做本地语法／签名解析检查，未附加设备，不能替代实际计数。它已有顶部生命周期、cell／卡片／layer、导航与刷新覆盖，但**没有完整的小程序容器生命周期、proxy查询、index scope／policy readiness覆盖**，不能把该探针当作小程序事件链已闭环。后续设备采集应先补这几项，并在进入目标路径前建立基准；缺 hook／缺对象身份／缺日志都不能算0。方法日志与30fps视频还需按时间对齐；探针本身也可能扰动时序。

本轮结论为：源码已修、主机受控路径已绿、包已构建；两条自然路径的真实根因归属与修复后画面仍未在真机验收。账户和数据保持原环境。
