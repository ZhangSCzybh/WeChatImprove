# 3.0-1 完整版构建与核心核验

在既有 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` checkout 发布 3.0-1 完整版，沿用 Objective-C/Logos/Theos。本项目为微信注入插件，没有本轮需启动的网页 URL、前后端端口或数据库；未切换 checkout、启动服务、安装设备或修改账号数据。

## 版本与内容

control Version、kPluginVersionString、内置发布说明字典键和 README 当前版本均统一为 3.0-1。当前说明使用“完整版”，历史 Beta 条目和产物保留。

内置与随包说明汇总底栏三结构、紧凑预览、21 个独立功能键入口、分离/居中尺寸、绝对宽高、三种快速风格、说明弹窗，以及语音转文字连续合并和全部既有模块。保留自定义尺寸优先与仅主动选择时应用预设的规则。

构建前核对与 beta06 相同的 42687 个输入，未发现预先存在的源码差异。发布后相对 beta06 仅三个构建输入变化：control、版本头、内置发布说明；全部功能实现源码哈希一致，无删除。详见 preexisting-source-delta.json、source-delta.json。

## 聚焦验证

- `bash Tests/verify-tabbar.sh` 全部通过：几何、选中图标/原生恢复、Neo 97 项、现代原生层级累计 121 项触摸检查、结构生命周期 666 项、偏好/原生生命周期。日志见 logs/tabbar.log。
- `bash Tests/verify-backup-registry.sh` 通过 2455 项断言，日志见 logs/backup-registry.log。
- 最终内置发布说明通过 arm64/arm64e 的 iOS 15 严格语法检查；使用 -Wall/-Wextra/-Werror，排除原有 deprecated-declarations、sign-compare、unused-parameter。命令见 test-results.json。
- 只读发布审查 0 个阻塞问题，核对版本一致、说明按当前 key 命中、当前无 Beta 标识、历史条目与链接保留，以及当前产物路径。dpkg 确认 3.0-1 高于 2.9-11-beta06。
- Rootless、Rootful 各完整编译 298 个源单元，两种架构各 298 步，共 596 步；均 0 error。每方案 8 条 warning 与 beta06 的位置、内容和数量相同。比较忽略并行输出顺序与诊断前交错的源码片段，保留诊断位置与消息，见 warning-comparison.json。
- 没有扩展到与本轮元数据变更无关的全功能测试矩阵。

## 产物与环境

已解包核验 ID、版本 3.0-1、安装路径、注入 plist、arm64/arm64e、最低 iOS 15.0、staging 库哈希、四组 dSYM UUID、必需 API 和 symbols.zip CRC，确认临时诊断标记缺失。重签 dylib 与 Rootful 包内库一致，见 artifact-validation.json。

42687 个构建输入在构建后哈希一致。使用两套独立临时目录，未执行 make clean。构建前保留基线为 1454 个原有文件；最终结果见 environment-preservation.json。基线中 1453 个文件哈希不变，原有 .theos 与既有版本目录保持不变；仅一份零散的 packages/com.wechat.improve_2.9-11-spc_iphoneos-arm64.deb 在期间从原路径消失。本轮命令未操作该路径，也未执行 make clean；原因未能确认，未尝试重建或覆盖。其原 SHA-256 和差异保留在 environment-preservation.json，不能将本次保留核验标为全文件通过。SHA256SUMS 覆盖两个 deb、重签动态库、调试符号及 README，已逐项验证。

本轮是主机回归、编译与产物核验，未安装原设备。实际底栏画面、触摸体验及语音合并效果仍需在用户既有设备与注入环境确认。

## 复现

产物在 `../../packages/3.0-1/`。build-context.json 记录 SDK、checkout 与临时路径，build-commands.json、build-rootless.sh、build-rootful.sh 记录命令，logs 保存输出。临时构建目录仍在时可运行 `python3 audits/3.0-1/validate-artifacts.py` 重验产物。
