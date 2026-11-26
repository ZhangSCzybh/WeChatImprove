# 2.9-11-beta05 构建与核心核验

在用户既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 补齐底栏尺寸设置，沿用 Objective-C/Logos/Theos。此项目是微信注入插件，没有本轮需启动的网页 URL、前后端端口或数据库；未切换 checkout、启动/重启服务、安装设备或修改账号数据。

## 功能与持久化

- “底栏结构”新增标准“快速风格”入口，仅提供迷你（60% × 44pt）、紧凑（75% × 48pt）、中等（90% × 52pt）。纯 C helper 统一默认值与匹配判定，没有额外的预设状态键。
- 用户主动选择风格时批量写入 scale 与 height，移除手动 width，再经一次 finishSavingSettings 同步和通知。页面加载、重建分组、切换结构、更新预览均不应用预设。
- 新 content_width 配置缺失或为 0 时复用旧 FloatingRect，兼容已保存比例；有限 NSNumber 且 176–1024pt 时优先于比例，实际宽度裁到宿主。非法类型、负值、非有限及越界配置回退自动；手动输入在 UI 端规范化。
- 宽度、高度保存后同步更新输入、详情及快速风格匹配状态；不匹配时显示“自定义”。新键纳入备份、恢复与重置。
- 预览在实际 window 宽度建立自然几何，再按卡片宽高统一缩放；绝对点数不会因预览画布较窄提前饱和。保持原先紧凑行高和阴影留白。
- 底部“功能说明”改为短行和 Alert，保留原说明并补齐预设、自定义及即时生效规则；快速风格 ActionSheet 有 iPad popover 锚点。
- 相对 beta04 共 10 个构建输入变化，无删除；见 source-delta.json。保留其他既有功能及用户已有未提交修改。

## 聚焦验证

- `bash Tests/verify-tabbar.sh` 全部通过：几何、选中图标/原生恢复、Neo 97 项、现代原生层级累计 121 项触摸检查、结构生命周期 666 项、偏好/原生生命周期。新增覆盖自定义宽优先比例、300→320pt 连续变化、宿主裁边、0 恢复旧比例、非法配置及三结构/RTL/关闭恢复。
- `bash Tests/verify-backup-registry.sh` 通过 2455 项断言，新键测试包括 0、176–1024pt 有效范围及非法类型/越界/非有限值拒绝。
- 设置控制器、预览、原生适配器和内置发布说明通过 arm64/arm64e 的 iOS 15 严格语法检查。使用 -Wall/-Wextra/-Werror，并排除已有 deprecated-declarations、sign-compare、unused-parameter。命令见 test-results.json。
- 设置实现只读终审为 0 个阻塞问题，覆盖手动尺寸保留、单次显式预设写入、输入刷新、说明完整及 iPad 呈现。
- Rootless、Rootful 各完整编译 298 个源单元、两种架构，各 596 个编译步骤，0 error。每方案 8 条 warning 与 beta04 的位置、内容及数量一致；比较忽略并行输出顺序及诊断位置之前交错的源码片段，保留诊断位置与完整消息，见 warning-comparison.json。
- 没有运行与本轮变更无关的功能全矩阵。

## 产物与环境

已解包核验 ID、版本 2.9-11-beta05、安装路径、注入 plist、arm64/arm64e、最低 iOS 15.0、staging 库哈希、四组 dSYM UUID 和 symbols.zip CRC。重签 dylib 与 Rootful 包内库一致，新配置键与弹窗方法存在，既有临时诊断标记缺失；见 artifact-validation.json。

冻结的 42687 个构建输入在构建后哈希一致。两套构建使用独立临时目录，未执行 make clean。基线 1437 个原有文件在最终核验时全部哈希不变；见 environment-preservation.json。原有 .theos 缓存、beta04 及全部历史安装包保留。

SHA256SUMS 覆盖两个 deb、重签动态库、调试符号及随包 README，已逐项验证。

本轮为主机核验，未安装原设备，实际画面及触摸仍需在用户既有设备注入环境确认。

## 复现

产物在 `../../packages/2.9-11-beta05/`。build-context.json 记录 SDK、checkout 与临时路径，build-commands.json、build-rootless.sh、build-rootful.sh 记录命令，logs 保存输出。临时目录仍在时可执行 `python3 audits/2.9-11-beta05/validate-artifacts.py` 重验产物。
