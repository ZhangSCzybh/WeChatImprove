# 3.0-2 完整版构建与核心核验

沿用 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout、Objective-C／Logos／Theos 与现有 SDK。项目是微信注入插件，本轮没有需启动的网页 URL、前后端端口或数据库；没有启动服务、切换 checkout、安装设备或修改账号数据。

## 变更与兼容

- 底栏宽度输入改为 60–100% 的百分比，输入 80 表示 80%，留空或 0 恢复默认 90%；写入既有 scale 并清除旧 content_width，之后只做一次配置通知和预览刷新。预览与原生底栏继续共用几何函数。
- 旧 pt 宽度保持有效，设置页只折算展示；加载、预览与其他设置变化不迁移配置。主动输入比例或选择快速风格才清除旧覆盖。窄屏继续保留最小宽度。
- 分离功能键直径上限从 72 改为 80pt，输入、偏好、最终几何、预览的最大尺寸基准和备份验证一致；默认仍是 52pt。保留 0–32pt 间距及边缘限制。
- 保留本轮开始前用户已经修改的 72%／80%／90% 快速风格宽度和 54／60／62pt 高度；名称仍是紧凑低调、均衡默认、舒展高光，选择列表只显示名称。
- control、版本头和内置说明统一为 3.0-2 完整版，历史发布条目及产物保留。README、随包说明同步更新。

基线有 42687 个构建输入，预先存在的两个变更见 preexisting-source-delta.json：快速风格几何头与内置发布说明。本轮没有覆盖这些既有修改。相对任务开始时仅 8 个构建输入变化，详见 source-delta.json；测试和文档另行更新，其他既有工作保持。

## 聚焦验证

- `bash Tests/verify-tabbar.sh` 退出码 0：几何、选中图标／原生恢复、Neo 97 项、现代层级累计 121 项触摸检查、结构生命周期 1151 项及偏好／原生生命周期全部通过。结构检查较 3.0-1 增加 485 项。
- 新覆盖包括 80／81／NaN 偏好与最终布局、44pt 主栏搭配 80pt 按钮的上下缘命中、旧 pt 读入保留与主动清除、三结构 × 双方向 × 60%／80%／100% 的原生控件 frame、保持高度和关闭恢复。
- `bash Tests/verify-backup-registry.sh` 退出码 0，通过 2459 项断言；较 3.0-1 增加 4 项，包含 80 接受、81 拒绝。
- 设置页、偏好、预览、备份注册与发布说明通过 arm64／arm64e 的 iOS 15 严格语法检查，使用 -Wall／-Wextra／-Werror，排除既有 deprecated-declarations、sign-compare、unused-parameter。git diff --check 通过；安装包版本与显示版本一致，dpkg 确认 3.0-2 高于 3.0-1。
- Rootless、Rootful 各完整编译 298 个源单元，两种架构合计 596 步，均为 0 error。每方案 8 条 warning 的位置、内容及数量与 3.0-1 相同；按诊断位置和文本比较 Counter，忽略并行日志顺序，见 warning-comparison.json。
- 独立只读审查确认输入保存顺序、旧配置无被动写入、快速风格保留和预览刷新。比例显示保留正常百分比精度，仅将旧 pt 的折算展示到一位小数。

没有扩展到与本轮变更无关的全功能测试矩阵。具体命令、退出码与日志见 test-results.json、syntax-results.json、logs/。

## 产物与环境

解包核验包 ID、版本 3.0-2、两种安装路径、注入 plist、arm64／arm64e、最低 iOS 15.0、staging 库哈希、四组 dSYM UUID、必需 API、百分比输入与 80pt 的最终字符串、临时诊断标记缺失以及 symbols.zip CRC。中文 NSString 按 Mach-O 实际 UTF-16 编码检查。重签动态库与 Rootful 包内库一致，结果见 artifact-validation.json。

42687 个构建输入在编译与核验后与冻结清单一致。两种方案均使用独立临时构建目录，未执行 make clean。任务开始前的 1461 个 `.theos` 与 packages 文件全部保留且哈希不变，包括 3.0-1 与两份既有零散 spc 安装包；结果见 environment-preservation.json。SHA256SUMS 覆盖两个 deb、重签库、调试符号及 README，均已逐项核验。

本轮未安装原设备，不能据主机测试与编译推定真机画面、触摸体验和插件共存已验收；应在用户既有设备、账号和注入环境确认。

## 复现

产物位于 `../../packages/3.0-2/`。build-context.json 记录 SDK、checkout 和临时目录，build-commands.json 与两份 build 脚本记录完整打包命令。临时目录保留时可用 `python3 audits/3.0-2/validate-artifacts.py` 重验产物，之后在 packages/3.0-2 执行 `shasum -a 256 -c SHA256SUMS`。
