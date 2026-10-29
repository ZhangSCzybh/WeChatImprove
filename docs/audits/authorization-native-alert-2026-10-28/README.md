# 公众号授权原生弹窗修复（2026-10-28）

基于当前工作区 2.1-5 源码完成局部修复。沿用现有关注校验，不实施此前讨论的授权系统重构。

## 行为

- 第三方插件管理、“我”、微信设置三个入口使用同一个 `CSAuthorizationManager` 系统 `UIAlertControllerStyleAlert`，标题、文案与“关注公众号 / 取消”按钮一致。
- 删除设置页自定义授权遮罩、渐变卡片、关注与重检按钮及专用方法。
- 第三方入口取消时，按实际原生宿主返回：push 进入只 pop 一页；插件是模态导航根页时只 dismiss 插件导航；直接模态进入时只 dismiss 插件宿主。不会关闭底层微信或第三方管理导航容器。
- “我”和微信设置入口在尚未打开插件时取消，只关闭授权弹窗并保留原页面。
- 原生 alert 完成关闭后再处理公众号跳转和取消返回。重复 appearance、取消转场不会重复请求授权；缓存控制器重新使用时可以再次检查。
- 校验成功恢复设置交互后再检查使用声明；未授权期间不允许通过长按发现密友入口。
- AI、定时发送运行模块没有修改，取关后的现有执行检查保留。使用声明与隐私保护不在本次重写范围内。

## 验证

| 检查 | 结果 |
| --- | --- |
| `bash Tests/verify-authorization-prompt.sh` | 92 项通过 |
| `bash Tests/verify-authorization-read.sh` | 67 项通过 |
| `bash Tests/verify-plugin-framework.sh` | 插件入口 21、启动集成 25 项通过 |
| `bash Tests/verify-close-friend-entry.sh` | 状态 45、长按 26 项通过 |
| `bash Tests/verify-scheduled-task-manager.sh` | 204 项通过 |
| `bash Tests/verify-ai-manager.sh` | 333 项通过 |
| 两个生产修改文件 iOS arm64 语法检查 | 通过 |
| Rootless、Rootful 完整编译打包 | 均退出码 0 |

测试使用主机 UIKit/微信服务替身及隔离存储，没有操作真实微信账号与数据。真机弹窗外观、公众号跳转和返回动画尚待安装验收。

## 构建与产物

版本保持 2.1-5。新产物位于 `packages/2.1-5-auth-native-alert/`，保留原 `packages/2.1-5/` 及其他历史包。每个方案均包含 arm64、arm64e。

- Rootless：`com.wechat.improve_2.1-5_iphoneos-arm64.deb`，库安装在 `/var/jb/Library/MobileSubstrate/DynamicLibraries/`。
- Rootful：`com.wechat.improve_2.1-5_iphoneos-arm.deb`，库安装在 `/Library/MobileSubstrate/DynamicLibraries/`。
- `com.wechat.improve_2.1-5_symbols.zip` 包含两个方案、两个架构的 dSYM，全部 UUID 与相应包内动态库匹配，ZIP 完整性通过。
- `SHA256SUMS` 包含两份安装包和符号包校验值。

构建使用独立 `_THEOS_LOCAL_DATA_DIR`、`THEOS_BUILD_DIR`，没有运行 clean。构建前后 364 个编译输入文件哈希一致；原有 `.theos` 和 packages 中 1246 个文件哈希全部保持不变。包内已验证新弹窗请求状态和返回方法标记，旧授权遮罩标记不存在。

每个方案有 6 条来自原有密友通知、红包状态栏与链接器参数的警告，本次修改的两个模块无编译警告。

构建日志见 `build-rootless.log`、`build-rootful.log`；元数据、架构、UUID、文件校验及保留结果见 `verification.json`。
