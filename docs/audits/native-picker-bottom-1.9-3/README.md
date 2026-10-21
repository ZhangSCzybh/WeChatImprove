# 1.9-3：密友选择器底部完成按钮

2026-10-21，继续使用 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 的 `main` 工作区及当前 1.9-2 源码。

## 上版遗漏与本次修复

用户截图 `IMG_7477.PNG` 显示完成按钮位于底部工具栏，导航栏右侧没有按钮。1.9-2 仅在原生 `updatePanelBtn` 执行后更新 `navigationItem.rightBarButtonItem`，测试替身也只模拟了导航栏布局，因此未覆盖截图中的实际控件。

微信 8.0.78 的原生代码表明：`updatePanelBtn` 保存内部 `m_panelBtnItem`，工具栏的 `updateWithCompleteBarButtonItem:` 从该项的 customView 取出 UIButton，存为 `completeButton`，并将触摸事件绑定到工具栏自身的 `onDone:`。工具栏随后调用 `completeHandler`；`initBottomArea` 配置的 handler 转发给选择器 `onDone:`，已有插件保存回调仍有效。

本次在插件专用好友选择器中同步内部 `m_panelBtnItem`、`m_panelBtn` 和 `m_toolView.completeButton` 的 enabled 状态。使用微信现有按钮和回调，只在原来的按钮更新入口同步状态。锁定使选择器失效时，也立即禁用底部实际控件。继续保留完成时和关闭动画后的账号、授权校验。

保存逻辑支持空数组的行为不变。没有更换底部按钮、修改布局或加入轮询，也没有对微信全局 UIButton 安装钩子。

## 核心验证

- 增加底部工具栏替身：导航栏按钮为 nil，工具栏从内部按钮项取出 custom UIButton，再由其 target/action 进入 completeHandler。
- 在 1.9-2 代码上运行新增用例，确认在 `bottom Done permits an initially empty list` 处失败，见 `regression-before.json` / `.log`。
- 修复后原生选择器 130 项检查通过，覆盖初始空名单、清空最后一个联系人、按钮替换、底部点击链路只保存一次、重新打开空名单、取消、锁定后拒绝迟到回调、账号切换、动态子类及原有导航栏和群聊选择流程。
- arm64 / arm64e 严格编译、完整 Rootless 打包、二进制一致性及 dSYM UUID 校验结果见 `validation.json`。

本轮只运行选择器核心回归和编译交付检查。现有密友设置布局、备份页标题修复和历史安装包经哈希核对保留。构建缓存与暂存位于独立临时目录，未执行 `make clean`。

- [1.9-3 Rootless 安装包](../../../packages/com.wechat.improve_1.9-3_iphoneos-arm64.deb)
- [1.9-3 双架构调试符号](../../../packages/WeChatImprove-1.9-3-dSYMs.zip)

原生方法证据为静态反汇编，回归在主机运行，尚未安装到真机。安装后重点复验截图中的底部完成按钮：不勾选直接完成、清空最后一个人后完成，以及重新进入时名单保持为空。
