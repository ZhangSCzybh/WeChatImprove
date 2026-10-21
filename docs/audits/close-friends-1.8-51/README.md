# 密友快捷操作优化 · 1.8-51

基于 1.8-50（`73deb4cd`），将首页顶部导航栏长按解锁从 1.2 秒缩短为 1 秒，并提高“摇动立即锁定”的灵敏度。设置说明、README 和内置更新记录同步更新。

## 实现

- 原先仅依赖 UIKit 的 `motionEnded`。现在新增独立 CoreMotion 轻摇检测，同时在 UIKit `motionBegan` 即可锁定，保留 `motionEnded` 兜底。
- 轻摇检测使用去除重力的加速度，40 Hz 采样；两个幅度至少 0.65 g、间隔 0.06–0.45 秒、方向点积不大于 −0.35 的相反冲量触发一次。单次碰撞、小幅抖动、同方向动作以及异常采样不会触发。
- 仅在微信前台、有效账号已开启密友且临时解锁、开启“摇动立即锁定”时采样。默认开关仍为关闭；关闭选项、锁定、退到后台时停止采样。
- 检测运行在专用串行队列，仅把一次锁定请求异步提交给主线程。账号 epoch、检测代次和当前状态阻止过期回调；系统开始/结束事件与传感器回调共用状态检查，避免重复导航。

## 验证

- `bash Tests/verify-close-friend-shake.sh`：18 项通过。编译实际监测实现、实际管理器检查方法和系统摇动回调；CoreMotion 硬件输入与 UIKit 导航由主机 fixture 替代。覆盖轻摇、噪声/单次撞击、取消、重新解锁、跨账号、硬件不可用、传感器错误、主线程交付与原生回调去重。
- `bash Tests/verify-close-friend-runtime.sh`：89 项运行状态检查及 5 项超时调度检查通过。测试仅使用临时 fixture 数据。
- Rootless 双架构构建：`make package -j4 SCHEME=rootless PACKAGE_VERSION=1.8-51`。包元数据、arm64 / arm64e、最低 iOS 15.0、CoreMotion 链接、dSYM UUID、build/stage/包内一致性，以及旧安装包保全由 `verify-delivery.py` 核验，结果见 `validation.json`。
- 本轮没有运行未改动的朋友圈、个人资料及其他功能专项。生产改动范围见 `scope.json`；朋友圈实现保留 1.8-48，个人资料入口保留 1.8-50。

开发与构建继续在 `/Users/zhangshichao/.codex/worktrees/close-friends-148/WeChatImprove` 的 `codex/close-friends-148` 分支进行。新包复制到原项目的 `packages/com.wechat.improve_1.8-51_iphoneos-arm64.deb`，原项目 main 源码及已有安装包保留。

## 真机复验

安装后彻底退出并重开微信，确认插件版本为 1.8-51。在首页顶部导航栏长按约 1 秒，确认直接临时解锁；开启“摇动立即锁定”，解锁后轻摇一次往返，确认重新隐藏密友并返回安全页面。轻拿、慢转手机时不应误锁，关闭选项后摇动不应触发本功能。

已完成主机构建与逻辑回归，未安装到真机。具体握持动作下的灵敏度和误触率仍需真机确认；主机模拟采样不能代表真实传感器手感。
