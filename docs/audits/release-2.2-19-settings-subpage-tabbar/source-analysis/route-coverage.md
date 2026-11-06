# 2.2-19 路径覆盖说明

每行的“主机验证”均指**按生产 interface 链生成类声明，执行完整生产共享基类及四个纯编辑器抽取 getter**；不执行子页自身业务实现、不执行实际菜单点击或 UIKit 导航。具体每类样本在 tabbar-navigation-validation 的 samples.json。所有真机栏明确未验证；不能将“共用基类”记作各页面已上真机通过。

| 页面/路径 | 目标类型 | 继承/声明 | 源入口 | 主机验证 | 真机 |
| --- | --- | --- | --- | --- | --- |
| 捉迷藏呀 | `CSCloseFriendSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:978` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 账号信息 | `CSAccountDetailViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:982` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 顶栏信息 | `CSNavigationTitleSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:987` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 头像设置 | `CSAvatarSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:992` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 后台运行 | `CSBackgroundRunViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:997` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 后台模糊 | `CSBackgroundBlurSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1001` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 触摸轨迹 | `CSTouchTrailViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1006` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 游戏辅助 | `CSGameCheatsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1011` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 收藏验证 | `CSFavoriteSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1016` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 界面简化 | `CSWCEnhanceViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1021` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 界面净化 | `CSUICleanViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1026` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 气泡样式 | `CSBubbleStyleSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1031` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 列表圆角 | `CSListCornerRadiusSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1036` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 底栏样式 | `CSTabBarStyleSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1041` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 布局设置 | `CSLayoutSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1046` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 聊天分组 | `CSChatGroupSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1051` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 入口设置 | `CSEntrySettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1056` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 附件布局 | `CSChatAttachmentSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1061` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 信息时间 | `CSMessageTimeSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1066` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 文本占位 | `CSInputTextSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1071` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 防止撤回 | `CSRevokeSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1076` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 红包功能 | `CSRedEnvelopSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1081` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 自动收款 | `CSReceiveTransferSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1086` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 消息手势 | `CSMessageGestureSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1091` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 语音转发 | `CSVoiceForwardSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1096` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 人工智能 | `CSAIReplySettingsViewController` | `CSAISettingsPage` | `Controllers/CSCustomViewController.m:1100` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 定时任务 | `CSScheduledTaskSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1103` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 表情功能 | `CSImageStickerSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1106` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 复读功能 | `CSRepeatSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1110` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 版本控制 | `CSVersionSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1115` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 更新控制 | `CSUpdateControlViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1120` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 重置设置 | `CSResetSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1125` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 备份配置 | `CSBackupSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1130` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 版本信息 | `CSReleaseNotesViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:1135` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 密友设置（头像五击） | `CSCloseFriendSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSCustomViewController.m:654` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 备份 → 恢复预览 | `CSBackupPreviewViewController` | `CSSettingsTableViewController` | `Controllers/CSBackupPreviewViewController.h` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 重置设置 → 预览重置 | `CSBackupPreviewViewController` | `CSSettingsTableViewController` | `Controllers/CSBackupPreviewViewController.h` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 备份 → 配置修复 | `CSBackupRepairViewController` | `CSSettingsTableViewController` | `Controllers/CSBackupSettingsViewController.m` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 配置修复 → 导航栏分隔图片 | `CSNavigationTitleSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSNavigationTitleSettingsViewController.h` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 配置修复 → 底栏图标 | `CSTabBarStyleSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSTabBarStyleSettingsViewController.h` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 配置修复 → 触摸轨迹图片 | `CSTouchTrailViewController` | `CSSettingsTableViewController` | `Controllers/CSTouchTrailViewController.h` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 配置修复 → 联系人分隔图片 | `CSContactSeparatorSettingsViewController` | `CSSettingsTableViewController` | `Controllers/CSContactSeparatorSettingsViewController.h` | 生产共享基类执行；子页实现未执行 | 未验证 |
| AI → 选择预设/能力选项 | `CSAIOptionsPage` | `CSAISettingsPage` | `Controllers/CSAIReplySettingsViewController.m` | 生产共享基类执行；子页实现未执行 | 未验证 |
| AI → 管理预设 | `CSAIPresetsPage` | `CSAISettingsPage` | `Controllers/CSAIReplySettingsViewController.m` | 生产共享基类执行；子页实现未执行 | 未验证 |
| AI → 已开启的会话 | `CSAIConversationsPage` | `CSAISettingsPage` | `Controllers/CSAIReplySettingsViewController.m` | 生产共享基类执行；子页实现未执行 | 未验证 |
| AI → 会话详情 | `CSAIConversationPage` | `CSAISettingsPage` | `Controllers/CSAIReplySettingsViewController.m` | 生产共享基类执行；子页实现未执行 | 未验证 |
| AI → 回复记录 | `CSAIHistoryPage` | `CSAISettingsPage` | `Controllers/CSAIReplySettingsViewController.m` | 生产共享基类执行；子页实现未执行 | 未验证 |
| AI → 模型连接 | `CSAIConnectionEditor` | `UIViewController` | `Controllers/CSAIReplySettingsViewController.m` | 只执行生产抽取getter | 未验证 |
| AI → 新增/编辑预设 | `CSAIPresetEditor` | `UIViewController` | `Controllers/CSAIReplySettingsViewController.m` | 只执行生产抽取getter | 未验证 |
| 定时任务 → 新建/编辑任务 | `CSScheduledTaskEditor` | `CSSettingsTableViewController` | `Controllers/CSScheduledTaskSettingsViewController.m` | 生产共享基类执行；子页实现未执行 | 未验证 |
| 定时任务 → 消息内容 | `CSScheduledTaskTextEditor` | `UIViewController` | `Controllers/CSScheduledTaskSettingsViewController.m` | 只执行生产抽取getter | 未验证 |
| 定时任务 → 时间选择 | `CSScheduledTaskTimeEditor` | `UIViewController` | `Controllers/CSScheduledTaskSettingsViewController.m` | 只执行生产抽取getter | 未验证 |
| 配置修复 → 其他插件设置（再次打开根宿主） | `CSNativeSettingsHostController` | `MMUIViewController (dynamic)` | `Controllers/CSBackupSettingsViewController.m:67` | 原生init YES静态证据 + 根页替身 | 未验证 |

源声明共派生 44 个共享基类后代、4 个 plain editor；增加密友两个入口标签后主机模型 50 条 route。子页请求包含的所有类型逐行列出，也保留根列表其余真实功能目的页。

反向模型覆盖子页→根列表→插件列表→微信主界面、四 tab 轮换、两次重复进入退出、modal 独立入口、底栏样式开/关。模型只验证导航政策不粘滞、非插件页面仍默认 NO；它没有运行样式 adapter，因此不能证明实际圆角、描边、缩放、图标、文字、未读角标或点击区域的视觉/事件行为。样式生产实现由既有 tabbar suite 回归，真机完整外观/点击仍未验证。

`WEContactSelectViewController` 虽由 Makefile wildcard 编译，当前 Controllers/Hooks 中没有 alloc/new/push 使用。CSChatGroupSettingsViewController 仅使用其 enum，实际联系人流程走 CSNativeContactPickerPresent/PresentTags 的原生 modal；本轮不改它。系统图片/颜色/文件选择器、原生联系人 modal 也不被全局改写；真机 modal 表现未验证。
