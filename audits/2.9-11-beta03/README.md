# 2.9-11-beta03 构建与核心核验

本轮继续使用用户既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout，优化底栏分离和居中功能键并编译完整 Rootless、Rootful 包。此项目是 Objective-C/Logos/Theos 微信注入插件，没有网页 URL、前后端监听端口或本轮需要切换的数据库；未启动或重启服务，未安装设备，未修改账号或数据。

## 本轮实现

- 分离模式以相同按钮尺寸、默认 12pt 间距确定主栏宽度。改变间距时整组围绕原中心展开；达到宿主边缘后限制有效间距，主栏宽度不变。保留 44–72pt 按钮大小与 0–32pt 间距范围。
- 居中模式范围由 75%–125% 扩大为 75%–180%，宽度按总宽 1/5 乘比例，最小保护 44pt。高度和图标随比例增大；高度超过主栏时整体上移，保持原有底端及 lift。正常宽度下与相邻原生槽每侧叠放 8pt，窄宽适当减小，保留完整 28pt 相邻图标空间。
- 居中按钮默认轮廓 1.25pt、黑/白透明度 .18；阴影浅色 .16、深色 .24，半径 8pt、向下偏移 3pt。真实功能控件位于原生入口和追踪控件上方，重叠区域优先命中功能键；整个功能键区域不参与拖动切页。
- 预览和真实底栏共用包含 hostWidth 的几何接口，尺寸、圆角、轮廓、阴影与图标同步。预览画布增至 236pt，避免最大偏移和大按钮组合裁切。
- 偏好读取、设置输入、备份校验范围统一更新至 1.8；版本、内置说明及 README 同步 beta03，保留 beta02 历史记录及其他既有代码。

## 聚焦核心验证

- `bash Tests/verify-tabbar.sh` 全部通过：几何、选中图标/原生恢复、Neo 97 项检查、现代原生层级累计 121 项触摸检查、结构生命周期 290 项检查、偏好/原生生命周期。记录见 `logs/tabbar.log`。
- 新增覆盖 gap 12→32 主宽不变、真实偏好确实读取 1.8、居中高度/图标/阴影/实际层级、重叠命中、原生拖动排除、窄宽及 RTL 完整图标安全，继续覆盖两套微信原生底栏快照与关闭恢复。
- `bash Tests/verify-backup-registry.sh` 通过 2425 项断言，包含新的 .75–1.8 范围，见 `logs/backup-registry.log`。
- 只读定向评审核对几何、层级/命中和预览一致性，未发现阻塞问题。
- Rootless、Rootful 各完整编译 298 个源单元、arm64 和 arm64e 两种架构，共各 596 个编译步骤，均为 0 error。每种方案 8 条 warning，与 beta02 逐项一致，来自已有弃用 API 和链接器选项，新底栏修改无新增 warning。
- 未重复执行无关功能的全量测试矩阵；快捷面板动作清单、路由和手势策略的既有 beta02 回归记录继续保留，本轮没有重新执行这些套件。

## 产物和环境保留

已解包核验 package ID、版本 2.9-11-beta03、Rootless/Rootful 安装路径、注入 plist、arm64/arm64e、最低 iOS 15.0、staging 库哈希、四组 dSYM UUID 及 symbols.zip CRC。重签 dylib 与 Rootful 包内库一致；库内包含新预览类、功能键入口及版本，并保留现有消息合并相关接口。详见 `artifact-validation.json`。

`source-manifest.json` 记录 42687 个构建输入文件哈希，编译结束全部一致。使用两套独立临时构建目录，未执行 `make clean`；1425 个原有 .theos 和历史包文件逐项哈希未变，详见 `environment-preservation.json`。没有重置、替换或切换用户数据。

SHA256SUMS 覆盖两个 deb、重签动态库、调试符号和随包 README。当前交付为主机编译核验，尚未安装原设备；原生界面的实际画面、触摸手感、红点与快捷动作页面仍需在既有设备注入环境确认，主机通过不视为真机验收。

## 复现与记录

产物位于 `../../packages/2.9-11-beta03/`。`build-context.json` 记录 checkout、SDK 和独立构建目录，`build-commands.json` 与 `build-rootless.sh`、`build-rootful.sh` 记录实际完整构建命令，`test-results.json` 及 `logs/` 保存本轮回归与构建记录。临时构建目录仍在时，可执行 `python3 audits/2.9-11-beta03/validate-artifacts.py` 重新核验产物。
