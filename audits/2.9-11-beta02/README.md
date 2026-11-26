# 2.9-11-beta02 构建与核心核验

本轮在用户既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 实现底栏扩展并编译完整 Rootless、Rootful 包，沿用本机 Theos 和 iPhoneOS SDK。此项目是微信注入插件，没有网页 URL、前后端监听端口或本次需要切换的数据库；没有启动/重启服务、安装设备、修改账号或迁移数据。

## 实现范围

- Objective-C/Logos/Theos：沿用 `TabBarStyleHooks`、`CSTabBarNativeAdapter`、`CSTabBarPreferences`，兼容 MMTabBar 和 WCTabBarView 两套原生控件。
- 总开关下新增交互预览，下面使用橙色图标、标题、副说明与三段选择切换经典悬浮、分离功能键、居中功能键。预览和真实底栏共用 `CSTabBarGeometry.h`，示例不执行快捷动作。
- 分离模式间距 0–32pt、功能键直径 44–72pt；窄宽自动保护四入口。大按钮与主栏共中心并整体上移，结构底端继续遵守已有 lift。
- 居中模式按底栏总宽 1/5 自适配，比例 0.75–1.25；原生四入口保留索引，按 2 + 功能键 + 2 排列，RTL 同步兼容。
- 功能键默认 scan，独立选择现有 21 个快捷入口，复用快捷面板的名称、SF Symbol 和路由。保留现有原生导航、账号与转场检查。
- 命中和滑动选择排除分离间距及居中功能槽；列表避让覆盖整个结构；新旧快照显示功能键且不执行动作，关闭后恢复原生。
- 设置按功能键、尺寸位置、背景边框、切换交互、图标、标签文字分类；五项新增配置纳入备份/恢复/重置。

## 聚焦核心验证

- `bash Tests/verify-tabbar.sh`：几何、选中图标与原生恢复、121 项原生触摸检查（含原有 97 项 Neo 检查）、176 项结构生命周期检查、偏好和原生生命周期全部通过。新增覆盖两套底栏、两种新结构、RTL、大按钮、间距穿透、中心槽释放不切页、路由来源、快照和关闭恢复。见 `logs/tabbar.log`。
- `bash Tests/verify-backup-registry.sh`：2425 assertions 通过，包含新增枚举、间距、尺寸、比例和全部 21 个动作的配置校验。
- `bash Tests/verify-quick-panel-preferences.sh`：隔离 defaults suite 通过。
- `bash Tests/verify-quick-panel-router.sh`：396 checks 通过。
- `bash Tests/verify-quick-panel-gesture.sh`：745862 checks 通过，含 200000 对确定性随机输入。见 `logs/quick-panel-gesture.log`。
- 新设置/预览通过 arm64、arm64e 的 iOS 15 目标语法检查；最终两种 scheme 各完整编译 298 个源单元、两种架构，均为 0 error。每种构建有 8 条与 beta01 同类的已有弃用 API/链接器 warning，新底栏文件没有编译 warning。
- `git diff --check` 通过；未重跑无关功能的全量测试矩阵。

## 产物核验与环境保留

已解包核验 ID、版本 2.9-11-beta02、Rootless/Rootful 安装路径、注入 plist、arm64/arm64e、最低 iOS 15.0、staging 库哈希、四组 dSYM UUID 和 symbols.zip CRC。重签用 dylib 与 Rootful 包内库一致；库内包含新预览类、功能键入口和版本，新包继续包含既有消息合并修正接口。详见 `artifact-validation.json`。

`source-manifest.json` 覆盖构建输入，构建结束后全部源码哈希一致。构建采用两套独立临时目录，未执行 `make clean`；逐项比对确认全部 1419 个既有 `.theos` 和历史包文件哈希不变，详见 `environment-preservation.json`。

当前交付为本机编译产物，未安装到原设备。实际画面、触摸手感、红点更新、快捷动作的原生页面以及注入组合仍需原设备验收；主机检查不视为真机通过。

## 复现

产物位于 `../../packages/2.9-11-beta02/`。`build-context.json` 和 `build-commands.json` 记录当前 checkout、SDK 使用环境和独立构建路径；`logs/` 保存两种完整构建日志。临时构建目录仍在时，可使用 `python3 audits/2.9-11-beta02/validate-artifacts.py` 重新核验。
