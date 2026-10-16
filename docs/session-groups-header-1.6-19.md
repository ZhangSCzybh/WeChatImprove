# 1.6-19：分组包装表头改变微信 inset 语义

后续设备反馈：用户已明确确认“现在问题解决了”。1.6-20 保留本版表头识别修复，并按用户要求移除排查专用日志。以下记录保留当时分析过程与验证边界。

## 实机反馈先纠正了什么

1.6-18 在 iOS 27.0.1 / 微信 8.0.78.34 仍有问题。新视频可见私聊分组初始搜索框在正常位置，从“我”返回后顶部出现空白，后续切换通讯录和其他分组也保持异常。新日志有大量重复的 `inset-repair-before` 和 `inset-repair-not-applied`：

| 阶段 | contentInset getter | adjusted.top | offset.y |
| --- | ---: | ---: | ---: |
| 私聊初始正常 | 0 | 103 | −103 |
| 返回后、修正前 | 103 | 206 | −206 |
| 调用原生成对 setter 后 | 103 | 206 | −103 |
| 后续布局 / 重载前 | 103 | 206 | −206 |

修正已触发，offset 短暂变化，但 getter 读回值不变，布局又恢复至 −206。继续循环写 offset 无法解决问题。前两版将 `MMTableView.contentInset` 等同于 UIKit 原始 inset 的假设不成立，基于该假设的采样/差值补偿在本版全部删除。

## 同版本原生实现的证据

本机已有第三方打包的微信 IPA，Info.plist 为 8.0.78 / 8.0.78.34。只提取和静态读取主可执行文件，没有启动 IPA、注入运行进程或改写原始包。版本匹配不等于证明其二进制与用户手机当前加载镜像逐字节相同。

REA 成功识别 IPA 与 Mach-O 并给出 SHA-256；`inspect_macho` 对此大文件超时。后续使用限定范围的 Mach-O Objective-C 类/方法表及 chained pointer 解析定位方法，再用 Xcode LLVM 反汇编相应地址。没有运行全量反编译，也不将静态路径称为设备执行栈。二进制身份、selector 引用与汇编片段保存在 [证据目录](evidence/session-groups-1.6-19/manifest.json)。

| 原生方法 | 静态地址 | 确认行为 |
| --- | --- | --- |
| `MMTableView.hasSearchBarHeader` | `0x11672b110` | 读取 `self.tableHeaderView`，识别 `UISearchBar` 或 `WCSearchBar`，不递归查找普通容器内的子视图。 |
| `MMTableView.contentInset` | `0x116728d34` | 根据 enable/force 标志和 hasSearchBarHeader，返回 superclass 的 contentInset **或 adjustedContentInset**。 |
| `MMTableView.setContentInset:` | `0x116728b28` | 使用同一判断选择接受传入 top 的手动路径，或清零 superclass inset 的自动路径；手动路径另有底部修正。 |
| `NewMainFrameViewController.setSearchBarToTableHeaderView` | `0x105126124` | 获取 `searchBar` 后调用主表 `setTableHeaderView:`。 |
| 原生成对 setter | `0x10510e3b4` | 设置容器标志、关闭滚动、调用表格 setContentInset 与 setContentOffset，再恢复滚动/容器标志；没有绕开 MMTableView 的 inset 语义。 |

`initTableHeaderView` 的实例化类引用也指向 `WCSearchBar`。表格模式的条件可概括为：

```text
automaticContract = !enableContentInsetForAdjustAutomatic
                    && (bForceContentInsetAdjustAutomatic || hasSearchBarHeader)

getter:
  automaticContract → super.adjustedContentInset
  otherwise         → super.contentInset
setter:
  automaticContract → super 的原始 inset 清零
  otherwise         → 接受传入 top（底部还有独立处理）
```

这些是原生实现的语义，不是新增的生产逻辑。生产代码仍调用微信自己的判断方法，不硬编码上述条件、搜索栏类名或二进制地址。

## 源码冲突与修复

分组的实际表头是普通 UIView，里面放原搜索栏与分组栏。旧钩子在 native row scope 内把 `tableHeaderView` 替换为原生搜索栏；在 display scope / 默认作用域或 updatingHeader 期间则返回包装容器。

因此微信对同一张表的 hasSearchBarHeader 判断依调用域变化，读写 inset 的约定也随之切换。典型回放是 native 域读取有效 top=103，离开该域后按无搜索表头的手动规则写入 top=103，原始 top 因而从 0 增至 103，UIKit 再叠加安全区，得到 206。原生成对 setter 的名称不保证它接受的是 UIKit 原始值。

本版在 MainFrameTableView 的 `hasSearchBarHeader` 原实现执行期间，建立**独立的原生表头读取作用域**：

1. 只有已绑定分组适配器的主表参与，其他表直接执行原方法。
2. 原方法中的 `tableHeaderView` 读取始终返回适配器保留的真实原生表头，因此识别结果与分组包装前一致。
3. 这个作用域与 native/display 行索引域独立，不改变投影行数、Cell、查询路径，也不将原生表头永久替换到画面上。
4. 在 `updatingHeader=YES` 的表头安装过程中同样保持分类一致；读取作用域退出后，UIKit 仍读取实际包装容器。
5. 作用域按线程和表对象隔离，支持嵌套，异常也通过 finally 清除。
6. 原生搜索栏替换、移除、原生顶部区域变化仍由微信真实表头及原判断决定。没有强制返回 YES，也不切换系统自动 inset 开关。

删除 1.6-17/18 的原始基线、历史贡献、已修正重复量、数值匹配、成对 setter 强制修正及采样钩子。保留 1.6-16 的避免无意义重载、短列表不强制行锚点恢复、长列表随 adjusted inset 换算位置的逻辑。

## 诊断改正

`inset` 继续表示微信公开 getter 的读回结果，新增 `raw` 直接只读调用 UIScrollView 的 contentInset 实现，区分真正原始 inset；同时显示 `nativeSearchHeader`、`forceAuto`、`enableInset`。不再把 `adjusted − 微信 getter` 宣称为系统贡献，也不再输出已删除补偿的缓存字段。

预期在原生自动模式下，`inset=103 raw=0 adjusted=103` 可以是完全正常状态，不能因为 inset getter 不为 0 就再去修正。日志仍是用户开启诊断才写入的数字布局记录。诊断记录“清空”功能保留。

## 验证与设备边界

- `bash Tests/verify-group-header.sh`：46 项通过。抽取生产 Logos getter 和 hasSearchBarHeader 钩子，仅将 `%orig` 替换为宿主方法；同时编译生产 `CSGroupIndexScope.m`。宿主按上述反汇编实现分类与 top inset 读写规则。
- 同一组回归使用修改前 1.6-18 钩子：19 项失败，覆盖普通/原生/显示作用域分类不一致、表头发布中间态，以及连续往返时 103 被写入原始 inset。
- `bash Tests/verify-group-viewport.sh`：39 项挂载、刷新、长短列表和锚点回归通过。删除的 59 项旧数值补偿断言随对应实现移除，不再将旧测试总数当作新方案通过数。
- 覆盖 UISearchBar 和 WCSearchBar、不同系统 top、原生 force/enable 标志、非搜索表头、未绑定表、原生表头移除、每表独立作用域、嵌套、异常退出。
- Rootless 完整 arm64 / arm64e 编译及包验证见 `session-groups-header-1.6-19-validation.json`。实际生产源码从用户原 checkout 编译，输出放临时构建目录，保留既有包和用户数据。
- 测试为有原生语义证据支撑的主机回放，不是真实 UIKit/微信设备测试。当前未连接用户手机，不能宣称实机已验收；本轮也没有读取或写入微信数据库。

安装后完全退出并重新打开微信，确认版本 1.6-19。诊断清空后，复核“两条私聊 → 我/通讯录 → 微信”的连续往返、搜索进入退出、下拉原生顶部区域、显示/隐藏分组搜索入口，以及全部长列表滚动位置。若仍异常，新日志可直接区分原始 inset 与微信转换后的 getter，避免再次基于混合语义推断。
