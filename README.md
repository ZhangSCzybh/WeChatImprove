# WeChatImprove

一个功能丰富的微信越狱插件，提供多种界面优化和实用功能增强。

**当前版本：1.5-4**

## 系统要求

- iOS 15.0 或更高版本
- 已越狱设备、支持巨魔
- 已安装 mobilesubstrate (>= 0.9.5000)

## 功能列表

### 消息处理

#### 防撤回

- 开启防撤回：保留对方撤回的消息
- 隐藏撤回消息提示标签：隐藏"对方撤回了一条消息"的提示

#### 消息手势

- 左滑/右滑自定义操作
- 支持引用、复读、删除、撤回、收藏、转发等操作
- 自定义手势触发条件和操作类型

#### 消息时间

- 自定义消息时间显示位置（同行/换行）
- 隐藏聊天界面时间标签
- 精确到秒的时间显示格式

#### 语音转发

- 长按消息菜单新增语音转发功能
- 支持语音消息的转发和保存

#### 复读功能

- 长按消息菜单新增复读功能
- 支持文本、语音、图片、视频、表情
- 自动识别消息类型并复读

### 红包功能

- **自动抢红包**：支持私聊和群聊红包自动领取
- **群红包范围**：全部群/白名单/黑名单模式
- **延迟抢红包**：可设置延迟时间（0-10秒）
- **抢到通知**：通知自己或通知文件传输助手
- **红包详情页汇总**：在红包详情页显示汇总信息
- **领取记录**：统计已领红包次数和累计金额
- **自动回复**：抢到红包后自动回复
- **红包过滤**：根据金额大小过滤红包
- **智能识别**：自动识别红包类型和金额

### 转账功能

- 支持私聊群聊自动收款
- 支持设置延迟时间
- 收款通知可选自己或者文件传输助手
- 转账金额统计和记录
- 转账安全验证机制

### 界面美化

#### 底栏样式

- 功能开关控制是否启用底栏样式
- 自定义底栏图标和选中图标
- 隐藏底栏文字标签
- 自定义底栏背景颜色和边框颜色
- 支持圆角、缩放、位置偏移设置
- 触觉反馈和边框动画效果
- 动态切换底栏样式

#### 气泡样式

- 功能开关控制是否启用气泡样式
- 气泡圆角大小可调节
- 支持浅色模式和深色模式
- 可分别设置发送方、接收方颜色
- 气泡阴影和渐变效果

#### 列表圆角

- 自定义会话列表圆角样式
- 支持左右边距设置
- 顶部会话和普通会话上边距自定义
- 浅色/深色模式背景颜色自定义
- 卡片式布局设计

#### 头像形状

- 自定义头像形状（圆形、方形等）
- 头像边框样式自定义
- 头像大小和位置调整

#### 导航栏标题

- 自定义导航栏标题样式
- 自定义分隔符图片
- 标题颜色和字体设置

#### 触摸轨迹

- 开启触摸轨迹显示
- 自定义轨迹颜色
- 自定义轨迹图片
- 轨迹持续时间和透明度设置

### 界面净化

- 隐藏添加界面二维码
- 隐藏拍一拍消息提示标签
- 隐藏语音红点和转文字标签
- 隐藏我的页面功能
- 隐藏发现页功能
- 隐藏设置页面功能
- 清理无用界面元素
- 简化界面布局

### 输入增强

#### 文本占位

- 自定义聊天输入框占位文本
- 动态占位符显示

#### 聊天按钮布局

- 自定义聊天按钮排列方式
- 按钮样式和大小调整
- 快捷功能按钮添加

### 收藏增强

- 收藏功能增强
- 收藏语音转发
- 批量收藏管理
- 收藏分类和搜索

### 分组功能

- 支持自定义分组
- 滑动切换分组
- 过滤重复联系人
- 分组管理和排序

### 其他功能

- **游戏作弊功能**：支持微信小游戏作弊
- **后台运行保持**：防止微信被系统清理
- **更新控制**：禁用微信自动更新
- **退群监控提示**：监控群聊退出情况
- **全局缩放比例**：调整界面整体缩放
- **聊天窗口字体大小**：自定义聊天字体大小
- **消息加密**：增强消息安全性
- **文件管理**：增强文件传输功能
- **多账号支持**：支持多账号切换
- **主题定制**：自定义界面主题

## 项目结构

```
WeChatImprove/
├── Controllers/          # 设置界面控制器（包含所有控制器文件）
│   ├── CSWCEnhanceViewController.h/m      # 主设置控制器
│   ├── CSTabBarStyleSettingsViewController.h/m    # 底栏样式设置
│   ├── CSListCornerRadiusSettingsViewController.h/m # 列表圆角设置
│   ├── CSBubbleStyleSettingsViewController.h/m     # 气泡样式设置
│   ├── CSRedEnvelopSettingsViewController.h/m      # 红包功能设置
│   ├── CSReceiveTransferSettingsViewController.h/m # 转账功能设置
│   ├── CSMessageGestureSettingsViewController.h/m  # 消息手势设置
│   ├── CSVoiceForwardSettingsViewController.h/m    # 语音转发设置
│   ├── CSRepeatSettingsViewController.h/m           # 复读功能设置
│   ├── CSRevokeSettingsViewController.h/m           # 防撤回设置
│   ├── CSNavigationTitleSettingsViewController.h/m # 导航栏标题设置
│   ├── CSTouchTrailViewController.h/m              # 触摸轨迹设置
│   ├── CSUICleanViewController.h/m                 # 界面净化设置
│   ├── CSLayoutSettingsViewController.h/m          # 布局设置
│   ├── CSInputTextSettingsViewController.h/m       # 输入文本设置
│   ├── CSFavoriteSettingsViewController.h/m        # 收藏设置
│   ├── CSGameCheatsViewController.h/m              # 游戏作弊设置
│   ├── CSBackgroundRunViewController.h/m           # 后台运行设置
│   ├── CSUpdateControlViewController.h/m           # 更新控制设置
│   ├── CSAccountDetailViewController.h/m           # 账户详情
│   ├── CSSettingTableViewCell.h/m                  # 设置表格单元格
│   ├── WESessionTabContainerView.h/m               # 会话标签容器
│   ├── WESessionTabItem.h/m                        # 会话标签项
│   ├── WEContactSelectViewController.h/m           # 联系人选择器
│   ├── WCPLMessagePersistenceAdapter.h/m           # 消息持久化适配器
│   ├── CSChatRoomSelectViewController.h/m          # 聊天室选择器
│   ├── CSRedEnvelopConfig.h/m                      # 红包配置
│   ├── CSRedEnvelopParam.h/m                       # 红包参数
│   ├── CSRedEnvelopParamQueue.h/m                  # 红包参数队列
│   ├── CSReceiveRedEnvelopOperation.h/m            # 红包接收操作
│   ├── CSRedEnvelopTaskManager.h/m                 # 红包任务管理
│   └── CSServiceCenter.h/m                         # 服务中心
├── Hooks/               # Hook实现文件（包含所有Hook文件）
│   ├── RedEnvelopHooks.xm           # 红包功能Hook
│   ├── TabBarStyleHooks.xm          # 底栏样式Hook
│   ├── ListCornerRadiusHooks.xm     # 列表圆角Hook
│   ├── BubbleStyleHooks.xm          # 气泡样式Hook
│   ├── ReceiveTransferHooks.xm      # 转账功能Hook
│   ├── MessageGestureHooks.xm       # 消息手势Hook
│   ├── VoiceForwardHooks.xm         # 语音转发Hook
│   ├── RepeatHooks.xm               # 复读功能Hook
│   ├── RevokeHooks.xm               # 防撤回Hook
│   ├── NavigationTitleHooks.xm       # 导航栏标题Hook
│   ├── TouchTrailHooks.xm           # 触摸轨迹Hook
│   ├── HideSettingHooks.xm          # 设置隐藏Hook
│   ├── HideDiscoverHooks.xm          # 发现页隐藏Hook
│   ├── HideMomentsHooks.xm          # 朋友圈隐藏Hook
│   ├── HideQRCodeHooks.xm           # 二维码隐藏Hook
│   ├── HideChatTimeHooks.xm         # 聊天时间隐藏Hook
│   ├── InputTextHooks.xm            # 输入文本Hook
│   ├── FavoriteHooks.xm             # 收藏功能Hook
│   ├── GameCheatsHook.xm            # 游戏作弊Hook
│   ├── BackgroundRun.xm              # 后台运行Hook
│   ├── DisableUpdateHook.xm         # 更新禁用Hook
│   ├── AvatarHooks.xm               # 头像Hook
│   ├── CSChatAttachmentLayout.xm    # 聊天附件布局Hook
│   ├── CSAvatarShape.xm            # 头像形状Hook
│   ├── SessionGroupHooks.xm        # 会话分组Hook
│   ├── CustomEntryHooks.xm          # 自定义入口Hook
│   ├── MessageTimeHooks.xm         # 消息时间Hook
│   ├── LayoutHooks.xm               # 布局Hook
│   ├── UserInfoHooks.xm             # 用户信息Hook
│   ├── CUtility.xm                  # 工具类Hook
│   └── WCUploadTaskHook.xm         # 上传任务Hook
├── Headers/             # 项目头文件
│   ├── WCHeaders.h                  # 微信相关头文件声明
│   ├── WCPluginsHeader.h            # 插件头文件
│   └── CSUserInfoHelper.h          # 用户信息助手
├── HeadersFile/         # 微信SDK头文件（包含大量微信SDK头文件）
│   ├── AACTool.h
│   ├── AACloseReq.h
│   ├── AACloseRes.h
│   ├── AAJumpInfo.h
│   ├── AAPayReq.h
│   ├── ... (超过1000个微信SDK头文件)
├── control              # 包信息配置
├── Makefile             # 编译配置
├── WeChatImprove.plist  # 插件配置
└── README.md            # 说明文档
```

## 开发说明

### 环境要求

- Theos 开发环境
- iOS SDK
- Xcode Command Line Tools
- 越狱开发工具链

### 编译

```bash
# 进入项目目录
cd WeChatImprove

# 清理并编译打包
make clean package

# 可指定编译方案
make package SCHEME=rootless    # Rootless方案
make package SCHEME=rootful     # Rootful方案
make package SCHEME=roothide    # Roothide方案
```

### 安装

```bash
# 安装到设备（需要配置install.sh中的设备IP）
./install.sh
```

## 技术架构

### Hook 实现原理

本项目使用 Theos 开发框架，通过 Objective-C Runtime Hook 技术实现对微信功能的增强：

1. **Method Swizzling**: 替换微信原生方法实现
2. **Category Extension**: 扩展微信类功能
3. **Associated Objects**: 为现有对象添加自定义属性
4. **NSUserDefaults**: 持久化用户配置设置

### 核心功能模块

1. 红包功能模块
2. 界面美化模块
3. 消息处理模块

## 版本更新

### v1.5-4

- **消息合并：同一发送者的消息只保留首条/末条消息的头像，提升用户体验**
- **消息间距：消息之间的间距**
- **头像位置：自定义头像显示首条/末条消息位置**
- **生效范围：可设置群聊/私聊生效范围**
- **自定义分隔符：针对不同会话设置不同的分隔符**

### v1.5-3

- **授权管理：使用前需关注公众号**

### v1.5-2

- **备份配置：可备份当前插件设置的功能**
- 导入备份：可导入本地备份的配置
- 自动备份：开启后每天自动备份
- 恢复备份：点击备份列表的配置可恢复当前备份的所有配置

### v1.5-1&#x20;

- **性能优化**：大幅提升插件运行效率，减少内存占用
- **日志清理**：优化调试日志输出，提升用户体验
- **问题修复**：修复已知的兼容性问题和小程序冲突
- **稳定性提升**：增强插件在不同微信版本下的稳定性

### v1.5.0

- **底栏悬浮功能**：新增底栏悬浮显示，支持自定义悬浮位置
- **自定义文本图标**：支持底栏文字和图标完全自定义
- **描边动画效果**：新增底栏描边动画，支持多种动画类型
- **圆角比例调节**：精确控制底栏圆角大小和比例
- **悬浮高度大小**：支持自定义悬浮高度和图标大小
- **触觉反馈**：新增底栏点击触觉反馈效果

### v1.4.0

- **全局缩放比例**：支持界面整体缩放，适配不同屏幕尺寸
- **聊天窗口字体大小**：自定义聊天界面字体大小
- **界面适配优化**：优化iPad和横屏模式下的界面显示
- **多分辨率支持**：增强对不同设备分辨率的适配

### v1.3.9

- **分组功能**：新增联系人分组管理功能
- **自定义分组**：支持创建、编辑、删除自定义分组
- **滑动切换分组**：支持手势滑动快速切换分组
- **过滤重复联系人**：智能识别和过滤重复联系人
- **分组排序**：支持分组自定义排序和隐藏

### v1.3.8

- **列表圆角功能**：新增会话列表圆角样式
- **cell圆角设计**：支持单个会话单元格圆角
- **卡片式布局**：实现卡片式会话列表布局
- **自定义边距**：支持左右边距和上下间距自定义
- **颜色主题**：支持浅色/深色模式颜色自定义

### v1.3.7

- **气泡样式功能**：新增聊天气泡样式自定义
- **气泡圆角调节**：支持气泡圆角大小精确调节
- **浅色深色适配**：自动适配系统浅色/深色模式
- **发送接收方颜色**：分别设置发送方和接收方气泡颜色
- **阴影渐变效果**：新增气泡阴影和渐变效果

### v1.3.6

- **转账功能**：新增自动收款转账功能
- **私聊群聊支持**：支持私聊和群聊转账自动收款
- **延迟设置**：可设置收款延迟时间
- **收款通知**：支持收款成功通知设置
- **安全验证**：增强转账安全验证机制

### v1.3.5

- **复读功能**：新增消息复读功能
- **长按复读**：支持长按消息快速复读
- **多消息类型**：支持文本、语音、图片、视频、表情
- **自动识别**：智能识别消息类型并复读

### v1.3.4

- **语音转发功能**：新增语音消息转发功能
- **语音保存**：支持语音消息保存和转发
- **格式转换**：自动转换语音格式兼容性

### v1.3.3

- **消息手势功能**：新增消息手势操作
- **左滑右滑操作**：支持左右滑动自定义操作
- **多种操作类型**：引用、复读、删除、撤回、收藏、转发
- **手势触发条件**：自定义手势触发条件和灵敏度

### v1.3.2

- **红包功能**：首次实现自动抢红包功能
- **自动抢红包**：支持私聊和群聊红包自动领取
- **黑白名单**：支持群聊黑白名单过滤
- **自动回复**：抢到红包后自动回复
- **通知设置**：支持多种通知方式设置

### v1.3.1

- **防止撤回功能**：新增消息防撤回功能
- **隐藏撤回提示**：隐藏"对方撤回了一条消息"提示
- **原文跳转**：点击撤回提示可跳转到原文
- **消息保存**：自动保存被撤回的消息内容

### v1.3.0

- **界面优化功能**：首次发布界面优化功能
- **界面净化**：隐藏无用界面元素
- **消息时间显示**：优化消息时间显示格式
- **触摸轨迹**：新增触摸轨迹显示功能
- **导航栏标题**：自定义导航栏标题样式

### v1.3.0

- 界面优化功能
- 界面净化功能
- 消息时间显示优化
- 触摸轨迹优化
- 导航栏标题优化

## 安全说明

本项目仅供学习交流使用，请遵守以下安全原则：

1. **合法使用**: 仅用于个人学习和研究目的
2. **数据安全**: 不收集用户隐私数据
3. **风险提示**: 使用本插件可能违反微信用户协议
4. **责任声明**: 使用本插件造成的任何问题，开发者不承担责任

## 致谢

感谢所有贡献者对项目的支持！

特别鸣谢：WechatEnhance提供的开源项目。

## 免责声明

本项目仅供学习交流使用，请勿用于非法用途。使用本项目所造成的任何问题，均与开发者无关。
