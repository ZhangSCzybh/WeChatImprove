# 真实运行时阶段日志：未取得

本轮已执行 `xcrun simctl list runtimes`、`xcrun simctl list devices booted`、`xcrun devicectl list devices`。前两者为空；已配对的 iPhone 和 Apple Watch 均为 `unavailable`，不存在可访问的微信运行时。没有连接、启动、安装、重签或修改设备数据。设备标识没有抄入本报告。

因此，用户要求的 push 起始/中途/完成、pop 起始/完成、根列表出现、返回原生插件列表、退出到主界面八阶段的 MMTabBar hidden / alpha / superview / frame / window，以及当前 VC 的 hidesBottomBarWhenPushed / modal / child 状态，**真实运行时均未采集**。STATUS.json 将这些字段全部保留为 null，不用模型值或视频像素代填。

录屏只能证明画面中的底栏或转场副本可见，不能区分其对象身份，也不能读取 UIKit 属性。原生二进制定点反汇编是静态决策证据；新回归测试的阶段日志是显式主机替身。三者都不冒充设备日志。所有修复后的真机可见性、点击、动画和状态恢复均为未验证。
