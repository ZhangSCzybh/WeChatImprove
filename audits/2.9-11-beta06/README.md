# 2.9-11-beta06 构建与核心核验

在既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 调整快速风格，沿用 Objective-C/Logos/Theos。本项目为微信注入插件，没有本轮需启动的网页 URL、前后端端口或数据库；未切换 checkout、启动服务、安装设备或修改账号数据。

## 本轮改动

- 三组预设由迷你/紧凑/中等改名为紧凑低调/均衡默认/舒展高光；默认高度由 44/48/52 改为 54/60/62pt，宽度比例继续为 .6/.75/.9。
- 风格选择 action 标题直接取名称，移除宽高数值；详情行与功能说明弹窗共用名称和预设 helper，保持显示一致。
- 旧版保存高度与自定义宽高不自动迁移；只有主动选择预设才写入新默认值。全局缺省 contentHeight=52 和实际底栏其他布局规则保持不变。
- 更新现有预设测试，覆盖新高度、无效索引回落、手动宽度不冒充预设，以及旧 44/48/52 组合不匹配新预设。
- 相对 beta05 共 5 个构建输入变化，无删除：共享几何头、设置控制器、版本头、control、内置发布说明。详见 source-delta.json。保留用户其他未提交改动及所有既有功能。

## 聚焦验证

- `bash Tests/verify-tabbar.sh` 全部通过：几何、选中图标/原生恢复、Neo 97 项、现代原生层级累计 121 项触摸检查、结构生命周期 666 项及偏好/原生生命周期。日志见 logs/tabbar.log。
- 设置控制器、预览、内置发布说明通过 arm64/arm64e 的 iOS 15 严格语法检查；使用 -Wall/-Wextra/-Werror，排除原有 deprecated-declarations、sign-compare、unused-parameter。命令见 test-results.json。
- 最终只读审查 0 个阻塞问题，核对名称、顺序、默认值、选项仅名称、弹窗同步及已有手动尺寸保留。
- 备份配置与实际底栏适配器未修改，沿用 beta05 结果，没有重复无关测试矩阵。
- Rootless、Rootful 各完整编译 298 个源单元，两种架构各 298 步，共 596 步；均 0 error。每方案 8 条 warning 与 beta05 的位置、内容和数量相同。比较忽略并行输出顺序与诊断前交错的源码片段，见 warning-comparison.json。

## 产物与环境

已解包核验 ID、版本 2.9-11-beta06、安装路径、注入 plist、arm64/arm64e、最低 iOS 15.0、staging 库哈希、四组 dSYM UUID 和 symbols.zip CRC。重签 dylib 与 Rootful 包内库一致。详见 artifact-validation.json。

42687 个构建输入已冻结，构建后哈希一致。使用两套独立临时目录，未执行 make clean。构建前基线为 1443 个原有文件；最终保留结果见 environment-preservation.json。原有 .theos 缓存、beta05 及全部历史包继续保留。

SHA256SUMS 覆盖两个 deb、重签动态库、调试符号及 README，已逐项验证。本轮未安装原设备，实际画面与触摸仍需在既有注入环境确认。

## 复现

产物在 `../../packages/2.9-11-beta06/`。build-context.json 记录 SDK、checkout 与临时路径，build-commands.json、build-rootless.sh、build-rootful.sh 记录命令，logs 保存输出。临时构建目录仍在时可运行 `python3 audits/2.9-11-beta06/validate-artifacts.py` 重验产物。
