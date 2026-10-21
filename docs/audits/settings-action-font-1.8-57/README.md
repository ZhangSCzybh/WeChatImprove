# 1.8-57：统一恢复操作字号

本轮按用户反馈修复三处设置页面中的四个操作：气泡样式“恢复默认背景色”“字体恢复跟随微信”，底栏样式“恢复默认设置”，布局设置“恢复默认设置”。

这些操作均通过 `CSSettingItem.actionItemWithTitle:` 进入公共 `CSSettingTableViewCell.configureActionItem:`。该方法额外执行 `systemFontOfSize:17`，而相邻普通项、输入项和开关项沿用 UIKit 默认字体。现在删除这一个字体覆盖，操作行与其他设置行使用相同的原生字体来源。标题、图标、文字颜色、箭头、点击事件及恢复确认逻辑保留。所有页面控制器中的恢复实现、业务配置及 Hook 均与 1.8-56 哈希一致。

本轮仅做与字号修改相称的验证，没有新增模拟字号的测试，也没有运行无关功能回归：

- 核对四个目标设置项都进入公共操作项渲染路径。
- 公共单元格源文件对 arm64、arm64e 完成严格编译检查。
- 完成 `make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-57`。
- 核对包版本、双架构、最低目标 iOS 15.0、dylib 与构建/暂存一致、dSYM UUID、注入过滤、交付文件以及历史安装包完整性。

继续使用开发目录 `/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove` 和分支 `codex/close-friends-148`，基线提交 `dc5dc720`。原项目 main 源码未改变；新包已交付到 `/Users/zhangshichao/Documents/Workspace/WeChatImprove/packages/com.wechat.improve_1.8-57_iphoneos-arm64.deb`。

包 SHA-256：`4c01c23160029e435653ba02cc0f0d91c8547a95a0662661bb76982c3e1808a0`。详细结果保存在 `source-review.json`、`syntax-results.json`、`build-result.json` 和 `validation.json`，可用 `python3 docs/audits/settings-action-font-1.8-57/verify-delivery.py` 复核当前源码与产物。

没有安装到真机或修改真实设置数据。最终屏幕字号仍需安装后对照同页普通设置行验收。
