# 1.6-10：诊断复制入口与布局数据

目标：微信 8.0.78 / Rootless。用户在排查紧密间距时，点击“复制诊断记录”没有反应。

## 已确认的缺陷

CSRevokeSettingsViewController 已给复制项设置 actionBlock，但其 tableView:didSelectRowAtIndexPath: 只取消选中，没有调用 actionBlock。CSSettingTableViewCell 不自动代替控制器分发此点击。此缺陷使复制动作根本没有执行，并非单纯缺少成功提示。

修复点击分发；复制动作完成剪贴板写入后展示“已复制诊断记录”。新增“查看诊断记录”，用可滚动、可选择、不可编辑的 UITextView 展示报告，右上角可复制相同快照。有导航栈时使用返回按钮，无导航栈时以带完成按钮的导航页呈现。报告包含插件/微信/iOS 版本和诊断开关状态，空记录有明确操作说明。

## 合并排查信息

保留 1.6-9 的正常/紧密策略、25pt 目标和内容保护，不在未取得设备证据前再改变压缩策略。

在原有 applied/protected/fallback 阶段外，记录：

- measure：原生行高 row、原始内容尺寸 content、实际高度减少量 delta、保护位 blockers。
- geometry-fallback：目标行高 planned、已布局的内容上/下边界 top/bottom。

blockers 位定义：

| 位 | 对应条件 |
|---|---|
| 0x1 | 内容尺寸缺失、不兼容或不合理 |
| 0x2 | 此布局已被实际视图边界检查拒绝 |
| 0x4 | 当前身份行需保留头像下时间 |
| 0x8 | 较大消息时间字体保护 |
| 0x100 | isShowSourceView |
| 0x200 | shouldShowRoomTodoView |
| 0x400 | isShowAppMessageBlockButton |
| 0x800 | canShowTranslateView |
| 0x1000 | canShowTranslatedText |
| 0x2000 | canShowTextTranslateView |
| 0x4000 | canShowTranslateLoadingView |
| 0x8000 | bSolitaire |
| 0x10000 | foldText |
| 0x40000 | App/引用消息类型 |

这些是当前代码的判定来源，不把私有方法名本身当作其实际语义已被验证。blockers=0 但 delta=0 则需要检查内容高度与预算的关系。

只记录预定义阶段、数值和位标记，不记录正文、账号、会话或消息 ID。诊断默认关闭；关闭后不格式化/追加记录，开启后沿用最多 128 条内存记录。仅在测量决定或几何失败时追加，不增加定时器或每次滚动回调。

## 验证与边界

bash Tests/verify-message-merge.sh：53,201 项策略/数学断言、1,319 项实际适配/导航/时间/诊断断言通过。新增检查诊断开关、数字字段及 128 条容量上限。

设置点击分发和 UI 展示通过源码检查及 iOS arm64/arm64e 编译验证，没有把主机替身测试描述为真实 UIKit 点击/剪贴板验证。构建详情见 chat-diagnostics-1.6-10-validation.txt。

没有设备连接，因此未验证手机上的复制提示、诊断展示及紧密效果。本包解决诊断入口缺陷，不能视为已解决紧密间距不生效。

安装并重新启动微信后，开启兼容性诊断，返回目标群聊，切换正常→紧密并滑动几条消息，再查看或复制记录。拿到记录后确认是保护条件、内容尺寸还是显示回退阻止压缩。没有修改用户数据库、实际偏好或其他已生成安装包。
