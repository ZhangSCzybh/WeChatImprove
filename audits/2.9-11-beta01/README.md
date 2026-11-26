# 2.9-11-beta01 构建与核心核验

本轮在既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 完成修复，构建完整 Rootless、Rootful 包及双架构动态库。没有安装到设备、启动服务、操作数据库或执行 `make clean`，历史包继续保留。

## 问题与修复边界

用户视频中，语音转文字新消息已加入连续气泡，但新接缝仍比上方大。上轮动画 fixture 直接写入最终位置，未模拟原生 model readiness 和 Cell 布局缓存的门禁，导致遗漏了“动画标志已清、真正布局尚未发生”的阶段。

复用此前对微信 8.0.80 / 8.0.80.34 的静态核验：BaseChatCellView.layoutSubviews 在 model readiness 为真时提前返回；Text 的一次性 readiness 标志会消费一轮；Cell cache 有效时也不进入 layoutInternal。静态依据没有宣称观察了本轮设备执行。

本版在有效绑定的动画结束后记录每个 Cell 的待恢复状态，失效 Cell 缓存，并把行高刷新合入现有事务。真正完成 CommonMessageCellView.layoutInternal 且入口 token 仍一致后才解除几何采样隔离。若原生首轮提前返回，仅异步补一次布局请求；页面切换时保留恢复状态，复用和新动画不会消费旧 token。普通文字 fallback 和未知版本保护保持原规则。

## 本轮验证

- 正式核心入口：`bash Tests/verify-merge-bubble-integration.sh --voice-animation-core`，6 场景、386 checks 通过。覆盖 cache-clean、model gate 早退、重试排队后页面切换、持续阻挡的有界行为、嵌套 completion token、同 identity 正文增长和发送追加；最终接缝通过实际 frame 检查为配置的 2pt。
- 实际旧 adapter 对照失败；临时移除同 token 保护的对照也失败。见 logs/voice-animation-core-*.log。
- 合并策略 235148 项、适配器 41190 项通过；消息手势与共享生命周期 370 项通过。本轮没有重跑无关功能全量矩阵。
- 两种 scheme 全量编译 297 个源单元，均为 arm64 / arm64e，最低 iOS 15.0，0 error；每种构建 8 条既有弃用 API／链接器 warning，详细记录在 artifact-validation.json 和 logs/。
- 解包核验包 ID、版本、安装路径、注入 plist、双架构、最低系统版本、staging 哈希；四组 dSYM UUID 匹配；symbols.zip CRC 通过；诊断标记未进入新库。
- source-manifest.json 覆盖构建输入；两种构建完成后源码哈希一致。测试入口后续改动只影响测试文件。
- 真机未复测；主机回归不能证明设备视觉验收完成。

## 产物和复现

产物见 ../../packages/2.9-11-beta01/；构建目录和视频文件 SHA256 见 build-context.json。构建使用每种 scheme 独立的 _THEOS_LOCAL_DATA_DIR、_THEOS_SWIFT_AUXILIARY_DIR，KEEP_LOGOS_INTERMEDIATES=1，不触发清理。

`python3 audits/2.9-11-beta01/validate-artifacts.py` 可重新执行当前本机产物核验。build-context.json 的临时构建目录需要仍存在。
