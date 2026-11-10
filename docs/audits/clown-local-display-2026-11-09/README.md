# 2.3-5 小丑功能：实现与验证

本轮在既有 Objective-C / Logos / Theos 插件中实现“小丑功能”，设置入口紧接“表情功能”，沿用公共设置页与导航布局。总开关和文字、时间、图片、转账金额四个子开关首次全部关闭。

文字、图片与转账长按菜单分别提供“修改文字”“修改图片”“修改金额”；系统时间标签使用独立长按入口。系统相册选择一张图片，时间按 `yyyy-MM-dd HH:mm` 严格解析，金额使用正数、1–9 位整数及最多两位小数。

## 显示与数据边界

`CSClownSession` 仅在当前聊天控制器关联的内存中保存覆盖值。`CSClownPresentation` 使用独立覆盖视图和行高投影；真实 cell 的 viewModel、源消息 wrap、正文与时间、图片数据及支付字段保持原值。不调用发送、上传、收款或消息持久化接口。仅五个开关登记到配置备份。

聊天退出或账号边界失效会清空覆盖、恢复源视图与交互状态；重新进入时重算 UITableView 的原生高度缓存。总开关关闭清空整页，子项关闭清空相应类别。插件自己的编辑弹窗与相册不结束会话；相册结果逐次核对账号、页面、消息与请求身份，同一消息的新选择取代旧选择，不影响其他消息。取消新相册不取消此前已选择、仍在加载的图片。

## 自动验证

新增相关检查共 **933 项通过**：

| 范围 | 检查数 |
| --- | ---: |
| 开关、快照与备份 | 249 |
| 原生菜单构造、去重及过期请求 | 302 |
| 内存会话、消息身份与退出 | 120 |
| 图片几何、日期与金额规则 | 111 |
| 真实 UIKit 的生产显示逻辑 | 151 |

生产显示测试直接编译未修改的 `CSClownPresentation.m`，使用 Mac Catalyst 的真实 UILabel、UIImageView、UIAlertController 与 UITableView；微信私有对象、模态呈现及相册服务边界使用替身。测试覆盖实际编辑确认、覆盖树复用、原数据不变、拆分长文本、表格高度缓存、时间文字边缘命中、转账金额与千分位、并行相册请求、取消、迟到结果及后台账号边界。使用 UUID 独立偏好域，不访问用户相册。

原消息动作、消息手势、信息时间、消息合并／气泡组合与备份登记回归通过。计数见 [verification-summary.json](verification-summary.json)，生产 UIKit 运行日志见 [presentation-tests.log](presentation-tests.log)。新增及修改的 Objective-C / Logos 源码均通过真实 iPhoneOS SDK 编译。

## 安装包

最终源码由 [build.py](build.py) 复制到独立临时构建快照，分别使用独立 Theos 构建数据目录生成 Rootless 和 Rootful 产物，没有执行 `make clean`。脚本核对构建前后源码清单、历史安装包 SHA-256、包元数据、arm64 / arm64e 架构、PhotosUI 链接、关键导出符号和各架构 dSYM UUID。

产物位于 [packages/2.3-5-clown-local-display](../../../packages/2.3-5-clown-local-display/)：

- [Rootless deb](../../../packages/2.3-5-clown-local-display/com.wechat.improve_2.3-5_iphoneos-arm64.deb)
- [Rootful deb](../../../packages/2.3-5-clown-local-display/com.wechat.improve_2.3-5_iphoneos-arm.deb)
- [重签用 dylib](../../../packages/2.3-5-clown-local-display/WeChatImprove.dylib)
- [调试符号](../../../packages/2.3-5-clown-local-display/com.wechat.improve_2.3-5_symbols.zip)
- [SHA-256 清单](../../../packages/2.3-5-clown-local-display/SHA256SUMS)

具体命令、最终源码清单和产物哈希见 [build-result.json](build-result.json)、[production-inputs.json](production-inputs.json) 及两种方案的构建日志。

## 验证限制与用户环境

本轮保留原 checkout、既有产物和配置，没有启动或切换服务，没有访问、迁移或替换微信数据库。插件运行目标仍是用户原来的 iOS 微信，不存在新的 Web URL 或端口。

安装包尚未安装到用户手机。微信 8.0.78／8.0.80 内的私有视图层级、菜单回调、图片比例、气泡／紧密布局组合及其他插件兼容性仍需原设备验收。真实 Mac Catalyst UIKit 测试和成功编译打包均不能代替 iPhone 微信真机验证。
