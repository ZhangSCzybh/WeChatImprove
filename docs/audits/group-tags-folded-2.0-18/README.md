# 2.0-18：原生标签选择与分组内折叠聊天

本次只处理自定义组成员入口和 ChatBox 折叠列表；不改定时任务业务、微信原生折叠存储、主会话数据库或密友配置。开发环境仍为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，`main`，基准提交 `21bf426cdcf8f5e1af76c5c962eeee5b0e509303`。开始时已有未提交的 2.0-16/17 修改，均保留。没有连接 iOS 设备，未安装、重启微信或写真实账号数据。Host 测试采用临时二进制、UIKit/微信服务替身和内存偏好。

## 需求 1 的结论与处理

自定义组保存 `id/name/members/created/updated`；`sessionUserNames` 对应 members。选人菜单的 `WEContactSelectTypeAll` 没有被保存成分组类型，`customTabWithName:sessionUserNames:` 创建的是 `WETabTypeCustom`。顶部预设“全部”是另一项 `preset_0`。因此无需任何成员迁移或自动清空：仅从菜单移除“全部”，保留已有自定义组和成员集合；顶部预设“全部”继续存在。此前从“全部”入口保存的好友、群聊、服务号、自己和无法解析成员，打开菜单或取消时均不写配置。

类型菜单现在只有 **私聊 / 群聊 / 标签 / 取消**。三个入口均使用共享原生选择器，不再创建 `WEContactSelectViewController` 或插件自己的 PageSheet。

标签采用微信真实的批选流程：原生好友多选页完成呈现 → 原生 `onSelectContactTag` → 微信原生标签列表 → 标签成员合入好友页实时勾选 → 原生好友页搜索/调整 → 完成后保存。标签列表的原生展示样式由微信控制；8.0.78 自己使用 `MMPageSheetAdapter`。不将这个原生标签弹层冒充自制的全屏标签列表，也不在好友选择器上伪造 tagName/scene。具体函数地址、签名、调用链和静态证据局限见 [标签原生证据](native-tags/README.md)。

标签和私聊编辑替换普通好友类别，其他成员保留；群聊编辑替换群聊类别。最终集合去重并沿用 updateTime/save/setup/reload。预选来自当前记录。标签批选只改选择器内存，外层取消不提交。原生 Done 使用实时 `m_selectView.m_dicMultiSelect`，不是初始 seed。标签批量回调即使绕过逐联系人 delegate，最终提交仍校验类别、账号 epoch、隐私 revision 和分组定义身份。

菜单收尾继续使用 `CSSettingsAfterDismissingSheet`：已关闭直接继续，关闭中等待该 sheet 的 transition coordinator，转场取消则停止，尚未关闭时只 dismiss sheet。随后标签页还须等待好友页实际 presentation completion；无固定延时。宿主不可见、有竞争模态或失效配置时停止。隐私/账号失效会遮住原生父页面和标签子页面，并仅关闭该子模态，保留外层原生取消。

## 需求 2 的可行性与边界

总体为 **部分可行**：分组过滤、组内数量与零成员隐藏可行；每组独立的微信原生折叠状态没有已核实的存储接口。本次实现前已将该结论和展示层方案告知用户。

| 问题 | 核实结果 / 处理 |
| --- | --- |
| 原生入口来源 | `ChatBoxMgr.updateChatBoxSessionWithSortTime:` 创建 `chatroom_session_box` 的 MMSessionInfo，再交给 MMNewSessionMgr。原生消息摘要是全局的 |
| 数量来源 | `chatBoxSessions` 是全局成员集合；聚合 row 的 `m_uUnReadCount` 实际来自 `isChatBoxSessionUnread` 的 BOOL，不能当会话数 |
| 点击与子页数据 | 主列表原生点击识别 `chatroom_session_box`，创建并 Push `ChatBoxSessionListViewController`。子页 count/cell/select 直接读 ChatBoxMgr；继续保留当前 table proxy/displayPath 到 native path 的转换 |
| 能否过滤内容 | 可以。旧实现把 folded 的 enabled 强制关掉，投影选中 preset_0；现将“启用过滤”和“显示分组栏”分离。折叠页使用当前账号选中组，仍无分组栏 |
| 能否改入口数量 | 可以做展示层数量。以同一 CSGroupProjection 成员/重复过滤/隐私规则计算折叠可见集合，显示“折叠的聊天（N）”，确认 0 时隐藏入口 |
| 来源未知 | 接口不匹配、不可读或快照无效时保留中性入口，不伪造 0、不沿用旧账号精确数量，不显示全局消息摘要 |
| 折叠状态及切组 | 原生仍是一个全局集合，不另建每组 folded/unfolded 标记。折叠页跟随当前分组，返回主列表切组后重新进入按新组过滤；另一个活跃 owner 改选组时也刷新 |
| 隐私与打开会话 | 密友隐藏先参与成员过滤，隐藏者不计入 N；打开仍保留 CSCloseFriendShouldHideUserName 和当前 displayPath/用户名身份校验，不能借旧 index 打开已隐藏/组外会话 |

原生入口的全局最后消息、时间、红点不适合原封不动展示在分组内。复用现有单一 `CSCloseFriendSessionCover`，显示中性标题及可靠组内数量；不叠加第二个 cover，不改原生 row、ChatBoxMgr、消息和未读存储。Cover 不吃点击，cell 复用/退出该展示状态会恢复原视图隐藏与无障碍属性。入口所属分组的角标从折叠子会话的可靠未读计算，不传播其它组的全局红点。普通行角标算法保持原分支。

详见 [折叠原生证据](native-folded/README.md)。以上是微信 8.0.78 二进制静态证据和本项目源代码结论，不等同于真机执行观测。

## 先失败后修复

- `group-menu-red.log`：旧菜单仍有“全部”，违反仅私聊/群聊/标签断言。
- `group-tags-red.log`：旧标签路线进入自制菜单/PageSheet，违反共享原生选择器断言。
- `folded-red.log`：旧 folded 强制 All，组外内容/坐标、空组入口、分组数量和组外未读等断言失败。

最终 **9 个相关脚本 / 11 个运行配置，共 2,294 项检查，0 失败**；未运行全量脚本。数字指断言/检查数量，并非 2,294 个独立场景。

| 范围 | 检查数 |
| --- | ---: |
| 分组选人（含标签与菜单竞态） | 609 + 2 |
| 共享原生选择器 | 196 |
| 定时任务选择入口的设置容器 | 278 |
| 分组偏好 | 23 |
| 折叠会话与隐私展示 | 85 + 19 |
| 分组业务行 | 633 |
| 分组增量更新 | 180 |
| 分组角标 | 136 |
| 分组生命周期 | 103 |
| 选择稳定性 | 30 |

详细运行模式、日志路径和摘要见 `regression-results.json`；折叠实现的新增用例与边界见 [folded-implementation.md](folded-implementation.md)。测试直接执行抽出的生产设置/适配方法及真实投影/偏好/原生桥接代码，UIKit、微信服务及原生页面由 host 替身提供；它们验证调用合同和不变量，不能替代真实 UIKit 动画及微信私有页面验收。

## 构建与环境保留

`build-environment.json` 记录本次独立 rootful/rootless 缓存及输出目录，复用 2.0-17 编译缓存。只编译打包，不执行 `make clean`，不覆盖既有 `.theos` 与历史 deb。`verify-packages.py` 在发布版本文件前检查 package Version/Architecture、路径前缀、arm64/arm64e slices、dSYM UUID、首初始化器及测试替身未打入；同时核对任务开始时全部 47,261 个文件的摘要，除明确列出的相关源文件/测试/版本文档外必须保持不变。最终结果见 `packages.json`、`preservation.json`、`source-sha256.json`。

## 真机验收

1. 分别用插件“弹窗样式”和“全屏/push”进入自定义组编辑。菜单只能看到私聊、群聊、标签、取消；顶部预设全部仍正常。
2. 选一个此前通过“全部”入口添加、同时包含好友/群聊/服务号的旧组。确认升级后成员未变；分别打开私聊、群聊、标签后取消，记录和时间不能被重写。
3. 标签打开微信原生标签列表；选一个含多个成员的标签，回到原生好友页搜索、增减勾选并完成。确认保存去重、再次打开预选正确，原有群聊/服务号/不可解析成员保留。再做一次标签批选但取消外层，确认未提交。
4. 两种宿主下均覆盖菜单正在收起时选入口、取消、完成；插件容器不可被关闭。打开标签页期间锁定密友、切账号或让配置发生变化，旧选择不得写回；返回取消仍可用。
5. 建 A/B 两组，分别包含不同折叠会话，再加一个共同成员；逐组核对“折叠的聊天（N）”及点入后的列表，确认只能看到本组成员，共同成员可以出现在两组；0 成员组不显示该入口。
6. 隐藏/解锁密友，核对入口和子列表同步减增，隐藏者不贡献数量和红点。快速来消息使折叠顺序变化后点击行，应打开当前这一行对应的会话，不能打开旧 index 的会话。
7. 在折叠子页返回主列表、切换分组再进入，内容应跟随新组；在一个组里取消微信原生折叠后，其他包含该会话的组同步变化，这是全局原生状态的预期。
8. 关闭聊天分组，原生折叠展示恢复；密友原有隐藏门禁仍生效。核对 cell 复用、浅/深色与无障碍标题，无其它分组消息摘要泄漏。
