# 小丑菜单与时间修复：真实 UIKit 回归证据

`presentation-green.log` 保存首轮执行 `bash Tests/verify-clown-presentation.sh` 的成功输出：319 checks，退出码 0。测试使用实际 Mac Catalyst UIKit/Foundation/QuartzCore 以及随机 UUID 的独立 NSUserDefaults suite，退出时清理该 suite；不启动服务、不连接用户数据库、不安装插件、不改写旧发布包。

## 已验证行为

- 修改后的系统时间仍由原生标签接收实际 UIKit `hitTest`，覆盖显示区域中心、左边缘、右边缘；随后调用原生私有对象的 tap callback double，再执行生产 `CSClownTimeDisplayModeDidChange`，验证两种格式来回切换。
- 原生 toggle 接收原始 `showingTime=1700000000`，本地替换日期为 `2026-11-09 14:30`，详细模式显示“11月9日 星期一 14:30”。保持详细模式再次修改为 `2026-11-10 06:15` 后显示“11月10日 星期二 06:15”。模型真实时间和原始文字不变。
- 时间 source 的 alpha、原生 tap recognizer、退出时的 frame/mask 均保留/恢复；插件长按不取消或延迟原生触摸，允许与 tap 同时识别。overlay 不接管触摸。
- 文本、图片、金额替换后原生 source 仍可由 UIKit 命中，原生 gesture 仍附着；恢复原生 mask，且不覆盖 native 在替换期间新设置的 mask。
- 真实生产 `CSClownMenuAdapter` 为 `1.00`、`1,000.00`、`$1.00`、`HK$1.00`、`USD 1.00`、`1.00 USD`、` EUR 1,000.00 `、`1.00元` 均生成“修改金额”。经菜单 target 的实际 action → production capture → 实际 UIAlertController/textField → production session → overlay → restore 验证；替换只改数字，currency 前后缀和空白保持。
- 原有离开会话、cell 复用、长文字拆分/缓存高度、异步选图、开关关闭、账号边界回归一并运行。

## 旧 2.3-5 的失败证据

运行以下命令可在本机重新生成两组 red 日志及完整 clang argv（JSON）：

```sh
python3 docs/audits/clown-menu-time-fix-2026-11-09/tests/reproduce-old-snapshot-red.py
```

脚本从旧审计 `build-result.json` 读取 2.3-5 的原始临时 build snapshot，使用该 snapshot 的生产 presentation、menu adapter、session、preferences、layout、native bridge 等代码；只将本轮测试源复制到 Python `TemporaryDirectory` 编译。脚本不会覆盖当前 checkout 或旧 snapshot 的任何生产文件，执行前后对两组生产源 SHA-256 作一致性检查。

旧包没有本次新增的 `CSClownTimeDisplayModeDidChange` 符号，因此临时候选测试源仅增加同名 no-op helper 以满足链接；该桩不实现修复。两个场景分别调整 main 中首个测试顺序，原有其他函数仍保留：

1. `amount-menu-old-snapshot-red.log`：旧包在纯 `1.00` 转账标题下没有“修改金额”，在 `menu.count==1` 断言失败。证明问题发生于实际生产菜单构建，后续编辑器尚未打开。
2. `native-time-old-snapshot-red.log`：旧包隐藏原生标签时将 layer opacity 设零，真实 UIKit 的 `UIView.alpha` 同时归零，替换后的 alpha 保留断言失败。独立 UIKit 测试同时证明 opacity=0 会使原生 label 从 hit-testing 消失。

## 本轮同时发现的缓存恢复问题

首次运行当前测试时，已有 `TestRetargetedControllerRestoresCachedHeights` 在会话 controller 被保留但 `testChat` 改变后失败：旧 session 已 invalid，但 table reloadCount 未增加。生产 `CSClownPageForController` 在 invalidation 之前读取 `needsNativeReload`，使 invalidation 新置的 YES 丢失。主任务将读取时序改为 invalidation 后合并 reload 标记，新 session 会刷新原生高度缓存。修复后同一完整测试首轮通过 319 checks。后续主任务增加的整页时间联动测试及更新计数由主任务另行记录。

这说明旧 2.3-5 另有该缓存恢复缺陷；不能将旧包此前 151 checks 的成功记录解释为该最终追加场景已验证通过。

## 证据边界

UIView/UILabel/layer、frame、alpha、mask、实际 hitTest、UITableView 高度缓存、字体测量、gesture recognizer 对象、UIAlertController 与 textField 均来自实际 Mac Catalyst UIKit。WeChat 私有 message/controller/menu 类、系统 Photos 的 presentation boundary、原生 toggle callback 是明确的 doubles。时间测试先执行真实 hitTest，再仅手动调用其私有 tap boundary；没有注入真实 UIKit touch stream，也不代表已完成 iPhone 上微信的点击/长按端到端验收。原生 double 的详细时间字符串只用于验证 native callback 改变了原始标签；替换格式断言针对未改动的生产 formatter。
