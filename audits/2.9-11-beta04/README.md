# 2.9-11-beta04 构建与核心核验

在用户既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 优化底栏设置页，沿用 Objective-C/Logos/Theos。此项目是微信注入插件，没有本轮需启动的网页 URL、前后端端口或数据库；未切换 checkout、启动/重启服务、安装设备或修改账号数据。

## 界面调整

- 预览整行 280→152pt，画布 236→104pt；去掉内部重复白色圆角框，统一卡片背景及内边距，保留简短点选提示。
- 使用共享几何，再将有效主栏与功能键的联合边界归零，放在单一 sample 容器内居中、统一缩放。以相同主栏高度下的最大功能键高度保留空间，调整大小/间距或切换结构时缩放比例稳定；上移配置以 ±8pt 相对示意表达，并预留阴影空间。
- 结构选择使用普通灰色分组标题，移除大号图标、粗体标题和重复副说明；结构行 132→64pt、三段控件 34pt、左右内距 15pt，背景和原生分组圆角与其他设置一致。页脚按当前选项显示。
- 相对 beta03 仅五个构建输入变化：设置控制器、预览视图、版本头文件、control、内置发布说明。实际底栏几何、偏好、路由、Hooks 与其他源码哈希不变，详见 `source-delta.json`。

## 聚焦验证

- 设置/预览源码通过 arm64、arm64e 的 iOS 15 语法检查，使用 -Wall/-Wextra/-Werror 并排除原有 deprecated-declarations、sign-compare、unused-parameter；命令见 `test-results.json`。
- `bash Tests/verify-tabbar.sh` 全部通过：几何、选中图标/原生恢复、Neo 97 项检查、现代原生层级累计 121 项触摸检查、结构生命周期 290 项检查及偏好/原生生命周期。见 `logs/tabbar.log`。
- 最终只读审查核对点击、RTL、重复 layout、稳定缩放和阴影极值，未发现阻塞缺陷。
- Rootless、Rootful 各完整编译 298 个源单元、两种架构，各 596 个编译步骤，均为 0 error。每方案 8 条 warning 的内容和数量与 beta03 一致，来自已有弃用 API/链接器选项，无新增 warning。
- 配置备份、快捷面板路由本轮未修改，没有重复其前版已通过的测试，也未运行无关功能全矩阵。

## 产物与环境

已解包核验 ID、版本 2.9-11-beta04、安装路径、注入 plist、arm64/arm64e、最低 iOS 15.0、staging 库哈希、四组 dSYM UUID 和 symbols.zip CRC。重签 dylib 与 Rootful 包内库一致。详见 `artifact-validation.json`。

冻结的 42687 个构建输入在构建后哈希一致。使用两套独立临时目录，未执行 `make clean`。基线记录 1431 个原有文件，其中 1430 个实际构建/历史产物文件哈希全部不变；仅 macOS 目录元数据 `packages/.DS_Store` 在此期间更新，保留其当前状态，没有为匹配基线而覆盖。详见 `environment-preservation.json`。

SHA256SUMS 覆盖两个 deb、重签动态库、调试符号及随包 README。beta03 和所有历史包、原有 .theos 缓存保留。

本轮为主机核验，未安装原设备，实际设置页画面仍需在用户既有设备注入环境确认。

## 复现

产物在 `../../packages/2.9-11-beta04/`。`build-context.json` 记录 SDK、checkout 与临时路径，`build-commands.json`、`build-rootless.sh`、`build-rootful.sh` 记录命令，`logs/` 保存输出。临时目录仍在时可执行 `python3 audits/2.9-11-beta04/validate-artifacts.py` 重验产物。
