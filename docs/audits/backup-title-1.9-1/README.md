# 1.9-1：修复进入备份配置时标题上移

2026-10-21，按用户要求从 `1.9-1` 开始版本编号。继续使用 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` checkout，保留工作区中的 1.8-60 密友设置布局修改和既有安装包。

## 定位与修复

检查用户提供的 `ScreenRecording_10-21-2026 16-26-40_1.MP4`（约 2.35 秒），可见进入备份配置后标题、返回按钮和列表内容发生向上收起。录屏原件未修改，文件哈希及抽帧信息见 `validation.json`。

`viewWillAppear:` 会调用 `reload`。原 `setWorking:` 在读取前设置 `navigationItem.prompt`，异步读取完成后将其设回 nil。该提示占用导航栏的额外高度，因此导航转场过程中会先扩展、再收起，标题和列表随之移动。

本次仅调整备份页的加载状态展示：在 `viewDidLoad` 一次性建立右上角 32×32pt 容器，内置系统活动指示器。`setWorking:` 只启动或停止转圈，不修改导航栏 prompt、不增删导航项，也不调整标题、表格 inset 或滚动位置。停止转圈时隐藏指示器，保留容器尺寸。继续保留忙碌标记、操作期间禁止列表交互，以及“正在处理，请稍候…”的辅助功能说明。

同一方法用于读取、创建、导入、导出及备份管理操作，这些操作的加载提示也不再改变导航栏高度。全部业务回调从 `reload` 起逐字节保持一致；修复配置子页面、备份管理器、存储、恢复事务和密友实现均保持原文件内容。

## 验证与交付

| 检查 | 结果 |
| --- | --- |
| 备份引擎既有回归 | 25 项通过 |
| 恢复事务与回滚既有回归 | 89 项通过 |
| 备份设置页 arm64 / arm64e 严格编译 | 通过，`-Wall -Wextra -Werror`，无诊断 |
| 原有数据回调与文件保留检查 | 本轮仅变更备份页及 4 个版本/说明文件 |

测试使用临时目录及 UUID 独立偏好域。没有为导航栏样式新增模拟 UIKit 高度的测试；主机回归不等于真机转场验收。完整构建、包版本、双架构、二进制、注入过滤和调试符号的核对结果统一记录在 [validation.json](validation.json)，构建日志见 [build.log](build.log)。

- [1.9-1 Rootless 安装包](../../../packages/com.wechat.improve_1.9-1_iphoneos-arm64.deb)
- [arm64 / arm64e 调试符号](../../../packages/WeChatImprove-1.9-1-dSYMs.zip)

包版本、插件内显示版本和内置更新说明同步为 `1.9-1`。构建使用当前 checkout 源码，缓存、暂存和初始包输出放在独立临时目录；最终新产物复制到当前项目 `packages/`。未执行 `make clean`、切换 checkout、覆盖历史安装包、提交或推送。

本项目在 iPhone 的微信进程中运行，没有本地前后端 URL 或端口。备份继续由微信容器的 `Library/Application Support/WeChatImprove/BackupV2/` 读取，旧 `Library/Backup/` 保持原只读兼容方式。本轮未访问设备容器或修改用户数据。

本机没有可用 iOS Simulator runtime，且本轮未安装到手机。安装后需复验：从设置首页进入备份配置、返回后再次进入、创建备份完成后刷新，以及从恢复预览返回时，标题和列表顶部保持稳定，右上角加载指示器正常停止。
