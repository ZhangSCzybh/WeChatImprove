# 2.0-10：聊天分组未读红点残留

## 结论与证据范围

定位到 `CSGroupProjection.m` 中两条会确定产生错误红点的分支，并修复为：只有 `unreadCount > 0 && redDot` 的行贡献分组红点。生产行为变更仅这一处；原始会话数据、数字统计、成员归属和刷新时序没有改动。

修复前的原生字段读取、投影、适配器发布、顶部按钮更新串联测试，最初 125 个断言出现 40 个失败。补齐同计数下红点撤销及多成员清零边界后，同一份最终测试对照保存的修复前投影为 **136 个断言、46 个失败**；修复后 **136 个断言、0 个失败**。完整相关回归为 **1,107 个断言、0 个失败**。

这些结果证明了代码级的两条残留路径及修复效果。当前未连接真机，用户没有提供发生残留时各行的原生字段快照，不能据此区分用户那次现场究竟命中了哪一条，也不把宿主测试称为真实微信 UI 验收。

## 完整链路

| 环节 | 数据和行为 | 代码 |
| --- | --- | --- |
| 原生输入 | 从主列表逻辑的 `getSessionInfoAtIndexPath:` 读取会话；必要时从 CellData 获取 `m_sessionInfo`。复制 `m_uUnReadCount` 和 `m_bShowUnReadAsRedDot`，不修改原生模型。 | `Controllers/CSGroupNativeBridge.m:250`、`:270` |
| 行分类 | 折叠群、服务号盒子被识别为 aggregate；无用户名行为 business。服务条目按服务分类进入全部/服务号/显式自定义成员组；非服务 aggregate/business 和未知分类沿用各 tab 保留规则。 | `Controllers/CSGroupNativeBridge.m:253`、`Controllers/CSGroupProjection.m:35` |
| 分组归属 | 隐私过滤先排除隐藏会话，再按预设分类、自定义成员和去重设置分派目的 tab。保留行的贡献累积到 `retainedCount/retainedDot`，加入各组；其他行按目的组累积。 | `Controllers/CSGroupProjection.m:200` |
| 数字计算 | dot 模式、aggregate、business 不贡献投影数字；其他行累加 `unreadCount`，用饱和加法避免溢出。 | `Controllers/CSGroupProjection.m:46` |
| 红点计算 | 修复后每行要求正未读数及原生 show-as-dot 标记同时成立。组内合并为 OR，`dotTabs` 和 `retainedDot` 每次重算。 | `Controllers/CSGroupProjection.m:51`、`:216`、`:233` |
| 发布 | 全部 tab 在无隐私过滤时优先用原生 `getTotalUnreadCount` 作为数字；其余情况用投影数字。所有 tab 的 `hasRedDot` 均来自投影。隐藏角标开关会同时置 `count=0`、`hasRedDot=NO`。 | `Controllers/CSGroupListAdapter.m:563` |
| UI 更新 | 容器、按钮都比较数字和红点两项。数字大于 0 优先显示数字，否则有点则显示点；`0/NO` 隐藏 badge 并清除无障碍值，同时请求布局。 | `Controllers/WESessionTabContainerView.m:204`、`:488` |

`badge.redDot` 是插件投影的结果，不是微信直接提供的完整分组角标对象。原生 `m_bShowUnReadAsRedDot` 表达未读的展示方式，不能仅凭这个字段证明存在正未读。此修复也没有把它解释成免打扰设置。

## 刷新时机与排除项

- `onSessionTotalUnreadCountChange:`、`onSessionChanged:`、`newMessageByContact:`、`updateSession:`、`logicUpdateSession:` 等通知通过 `NativeNotification` 包裹原生更新。`beginNativeChangeOfKind:` 先递增模型版本，原生方法执行完后 `endNativeChangeCoalesced:YES` 合并刷新。正常通知合并窗口为 80ms，不增加轮询。
- 列表重建、插入/删除、置顶、账号变化使用原有原生变更入口；返回列表、前台恢复、退出搜索、设置变化会按现有生命周期重新读取/发布。
- 滚动、分组手势和侧滑菜单交互可以暂缓发布，保持 dirty，交互结束后刷新。不可见列表/后台不做被动刷新，返回可见状态再更新；原有隐私发布例外保持不变。
- 原生快照复用检查包含 `unreadCount` 与 `redDot`；`CSGroupRowsMatch` / `CSGroupSectionsMatch` 也比较两项。新增测试证明只改红点位、计数不变时也会生成新投影及变更路径，因此“比较遗漏 redDot”不成立。
- 每次 `refresh` 在 `publishProjection:previous:changes:` 之前独立发布各 tab 角标。`changedUnreadPathsFrom:` 只限制会话 cell 的增量重载，不会阻止 tab 红点更新。
- UI 两层都处理 `0/YES → 0/NO`，不存在只改数字、不处理红点的分支。
- `CSTabBarNativeAdapter.m` 调整底栏原生 badge 的 frame/偏移；它不负责此处的顶部 tab 角标计算，无需修改。

相关刷新位置：`Hooks/SessionGroupHooks.xm:46`、`:200`；`Controllers/CSGroupListAdapter.m:445`、`:601`、`:673`、`:728`。

## 根因与数字/红点分叉

修复前逻辑：

```objc
return row.redDot ||
    ((row.kind == CSGroupRowKindAggregate || row.kind == CSGroupRowKindBusiness)
     && row.unreadCount > 0);
```

| 行状态 | 修复前投影数字 | 修复前红点 | 修复后 |
| --- | --- | --- | --- |
| 普通/服务会话未读清零，show-as-dot 标记仍为 YES | 0 | YES，残留 | `0/NO` |
| aggregate/business 无红点标记，但仍有正计数 | 0 | YES，被插件推导出来 | `0/NO` |
| 任一行正未读、show-as-dot 为 YES | 0 | YES | 保留真实红点 |
| 普通数字模式会话，未读 9、show-as-dot 为 NO | 9 | NO | 保留数字 9 |

非服务的保留行会将错误红点带入多个 tab，放大现象。全部 tab 的数字又可直接来自原生总未读，因此完全可能出现“原生数字已为 0，插件投影红点仍为 YES”。不能简单用“全部数字为 0 就强制去掉红点”修复，否则会误删不计入原生总数字的真实 dot 模式未读。

## 修改范围

- `Controllers/CSGroupProjection.m`：红点贡献条件改为 `row.unreadCount > 0 && row.redDot`，去掉 aggregate/business 正计数推导红点。
- `Controllers/CSGroupProjection.h`：说明 row 的 `redDot` 保留原生展示标记，显示红点还需正计数；避免下游误读。
- `Tests/GroupBadgeTests.m`、`Tests/verify-group-badges.sh`：执行生产 bridge、projection，以及从生产文件提取的发布 block 和两个 badge 更新方法。原生模型和 UI 属性容器使用宿主替身，未重写被测计算。
- `Tests/CloseFriendSessionTests.m`：原有“真实聚合红点”fixture 明确设原生 dot 标记；保留原有隐私断言，新增计数残留及计数清零两个断言。不是把旧断言简单改为不显示。
- 版本、更新说明及分组文档同步到 2.0-10。对照源码及 SHA256 保存在 `before/`、`baseline-sha256.json`；此前工作区修改全部保留。

## 复现与回归

在项目根目录运行：

```sh
# 对照修复前实现，预期 exit 1：136 checks, 46 failures
bash Tests/verify-group-badges.sh \
  docs/audits/group-badge-clear-2.0-10/before/Controllers/CSGroupProjection.m

# 修复后，预期 exit 0：136 checks, 0 failures
bash Tests/verify-group-badges.sh
```

失败证据：[最初失败](red.log)、[最终测试对照旧实现](red-final.log)；修复后：[green.log](green.log)。

| 核心回归入口 | 断言数量 | 结果 |
| --- | ---: | --- |
| `verify-group-badges.sh` | 136 | 通过 |
| `verify-group-incremental.sh` | 180 | 通过 |
| `verify-group-business.sh` | 633 | 通过 |
| `verify-group-lifecycle.sh` | 98 | 通过 |
| `verify-group-appearance.sh` | 8 | 通过 |
| `verify-close-friend-session.sh` | 44 + 8 | 通过 |
| 合计 | **1,107** | **0 失败** |

日志存于 [regression](regression/)。只运行分组、列表和角标相关脚本；密友会话脚本用于验证共享投影的隐私过滤边界，未运行密友完整运行时、后台模糊、备份或全量测试。各断言数量包含数据驱动输入与缓存一致性检查，不等同于独立真机场景数量。

新增覆盖：七类原生会话输入、各 tab 清零、同计数下 flag 开/关、冷/热投影、混合组最后一条清零、残留容器计数、真实红点保留、原生总数字为 0 时仍有合法 dot、隐私过滤、隐藏角标设置及无障碍状态。

## 构建与产物

沿用既有独立 Theos 构建缓存，先 rootful 后 rootless 增量编译，不运行 `make clean`。工作目录和配置见 [build-environment.json](build-environment.json)。构建时未覆盖旧 2.0-9 deb 与符号文件；当前版本元数据为 2.0-10。2026-10-26 提交时，安装包目录已清理为当前 Rootless 包和符号包，按目录现状提交。

- Rootful `iphoneos-arm`：已构建并校验；2026-10-26 提交时按当前安装包目录保留状态，不上传该包，可按项目构建说明重新生成。
- [Rootless iphoneos-arm64](../../../packages/com.wechat.improve_2.0-10_iphoneos-arm64.deb)
- [调试符号](../../../packages/com.wechat.improve_2.0-10_symbols.zip)

包校验由 [verify-packages.py](verify-packages.py) 执行，结果及 SHA256 见 [packages.json](packages.json)。校验 Debian 版本/架构、包内 arm64/arm64e、dSYM UUID、原有首构造函数顺序及测试替身不进入产物。

## 真机验收

1. 沿现有签名 IPA 流程加载 2.0-10，完全退出微信再打开，确认插件版本。保持现有账号、会话与分组配置。
2. 给“私聊”及包含该联系人的自定义组制造一条以小红点显示的未读，确认两个 tab 有提示；进入聊天读完后返回，两者均应消失。普通数字角标同样应随已读更新。
3. 同组准备两条真实 dot 未读，只读一条时红点仍保留，读完最后一条后消失。
4. 对折叠群、服务号/订阅号入口及包含它们的自定义组重复读完后返回。入口还有历史内容或内部残留计数，不应自行生成分组红点；仍有真实未读时应保留提示。
5. 清零后切换分组、打开聊天再返回、切后台再回前台，红点不应复现。关闭再开启“隐藏角标”设置，已读组不出现点，有真实未读的组恢复提示。
6. 如启用密友，会话隐藏后不贡献角标；解除隐藏后仅真实未读恢复提示。

如果仍出现残留，请记录是“全部/私聊/群聊/服务号/自定义”哪一组、组内哪些入口仍显示原生未读、最后一条已读后的短录屏，以及微信版本。当前补丁未添加常驻轮询、原生字段写入或微信行为拦截。
