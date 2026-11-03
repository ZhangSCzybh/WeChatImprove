# 分组栏布局与图层更新去重验证

本轮只修改 `Controllers/WESessionTabContainerView.m`。没有修改用户设置、关闭用户动画、连接或操作手机。

源码证据不能证明此前静置约 60 次/秒 CA 提交来自本分组栏。旧正式静置窗口 `TabLayout` 为 0，Tab 更新仅 1 次且 Unchanged；分组容器没有周期定时器或 `CADisplayLink`。因此本轮处理的是确定存在的重复工作，不宣称已经解决真实设备持续提交的来源。

改动：

- 标题按实际文字和 UIFont 缓存尺寸；角标按可见文字和 UIFont 缓存宽度。
- 容器按 viewport 尺寸及显式失效位复用按钮布局。字体、trait、分组记录和实际角标占位变化仍触发布局；安全区和搜索按钮改变 viewport 后重新布局。
- 相同几何不重复写入按钮、标签、胶囊、滚动视图或指示器的 frame/bounds/position 等属性。
- 重复胶囊配置仅在颜色实际改变时更新颜色，仅在创建或样式启用时请求布局。
- 同一选中项的重复发布确认提前返回，不强制 `layoutIfNeeded`。真正切组仍先同步几何；交互切组保留手指当前几何。
- 相同动画目标保留在途动画；显式关闭动画会取消在途动画，同时避免重复写模型图层。
- 未读数从 100 变到 101 时仍更新完整无障碍描述，可见角标同为 `99+` 时不重新布局。

`run-ui-validation.py` 直接从指定源码提取实际方法体编译运行；视图、字体测量和 UIKit 父类由确定性主机替身提供，Core Animation 图层与动画使用 macOS QuartzCore。测试验证几何与失效契约，不能替代真机 UIKit 绘制、CPU 或 CA 提交实测。特别是实际 UIButton 父类可能在布局期间自行改写其 titleLabel，夹具计数只说明自有方法中的重复写入已被去重。

验证结果：

| 项目 | 结果 |
|---|---|
| 当前源码行为断言 | 135 / 135 通过 |
| 1,000 次稳定布局及选中确认 | 自有视觉属性写入 0，文字测量 0，同步布局 0 |
| 冻结 2.2-9 同一驱动 | 写入 74,000，测量 9,000，同步布局 1,000；16 项去重断言失败，属于预期负对照 |
| 故障注入负对照 | 4 / 4 被夹具捕获 |
| 实际 iOS 27.2 SDK 语法检查 | arm64、arm64e 均 exit 0 |

行为断言覆盖首次布局、宽高变化、安全区、搜索按钮、字体大小、Dynamic Type、同字体对象、角标显隐与 `99+`、红点、分组重命名/排序/删除/空分组、胶囊重复配置和颜色、空标题、同目标动画保留/取消、实际切组、交互预览与提交。

四种故障注入分别移除字体缓存失效、角标布局失效、指示器动画取消，或重新加入稳定选中项的强制布局。只修改 `ui-validation/` 内的独立源码副本，没有改写生产源码。

重跑命令：

```sh
python3 docs/audits/session-groups-efficiency-2026-11-03/ui-validation/run-ui-validation.py
python3 docs/audits/session-groups-efficiency-2026-11-03/ui-validation/run-negative-controls.py
python3 docs/audits/session-groups-efficiency-2026-11-03/ui-validation/run-ui-validation.py --source docs/audits/session-groups-efficiency-2026-11-03/baseline-2.2-9/Controllers/WESessionTabContainerView.m --label baseline-2.2-9
```

最后一条应返回 1，表示旧版没有满足新增的去重契约；检查详情见 `baseline-2.2-9-result.json`。其余两条应返回 0。
