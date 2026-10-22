# 1.9-9：隐藏范围图标，删除按钮保持原位

用户明确要求隐藏朋友圈范围图标后，删除按钮仍处于隐藏前的位置。1.9-8 删除了布局模型中的范围元素，虽然避免按钮落到左边缘，但也收缩了范围图标原有占位，仍会移动删除按钮；本版修正这一行为。

## 实现

保留微信原生 `_privacyBtn` 的创建、实际尺寸、布局元素及换行计算。隐藏时仅设置按钮隐藏、禁用交互并从无障碍读取中排除，保留布局占位。原生同步布局前恢复按钮原始显示状态，布局结束后重新隐藏，既不改变测量输入，也不会在本次布局返回渲染前显示图标。原有范围按钮动作拦截继续生效。

移除 1.9-8 的 `WCActionAreaVM` 范围元素抑制及线程局部状态，也不再抑制详情 `canShowPirvacyButton`。隐藏前的可见性、交互和无障碍状态保存在按钮上，关闭隐藏时按原值恢复。对公开动态仍遵循原生条件，不额外创建按钮。实际朋友圈权限及删除操作没有改动。

本次只改动 `CSCloseFriendPrivacyAdapter.m`、对应回归和发布资料。上一版迁入“账号保护”的 7 个设置继续保留。

## 核心验证

- [主机回归](privacy-regression.log)：38 项通过。直接比较隐藏前后删除按钮的 x/y 坐标及布局高度，覆盖宽布局、窄布局换行、时间宽度变化、反复布局、页头重建、新开详情、开关恢复、点击/无障碍屏蔽及既有列表图标行为。
- [1.9-8 对照](previous-version-regression.log)：同一测试明确失败于“隐藏后保持删除按钮原坐标”，证明新增检查能识别上版行为偏差。
- [iOS 严格编译](ios-compile.log)：改动适配器在 arm64 / arm64e 下以 `-Wall -Wextra -Werror` 编译通过。
- [完整 Rootless 构建](build.log)：成功。保留项目原有弃用 API 和链接器警告。本次未重复与改动无关的全量回归。

## 交付

- [1.9-9 Rootless 安装包](../../../packages/com.wechat.improve_1.9-9_iphoneos-arm64.deb)
- [匹配包内双架构 UUID 的调试符号](../../../packages/WeChatImprove-1.9-9-dSYMs.zip)
- [构建源码、原文件保留及包内信息核验](package-verification.json)

2026-10-22 在原 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 构建，构建缓存和暂存目录隔离。旧安装包、备份功能文件及设置分组源文件均经哈希核验保留；未切换 checkout、运行 `make clean`、修改设备配置或重启微信。本项目无 Web 服务 URL 或前后端端口，密友数据仍沿用微信原容器中的 `Library/Application Support/WeChatImprove/CloseFriends/`。

当前未连接手机，未完成真机视觉验收。安装后完全退出并重新打开微信，在同一条带范围限制的朋友圈详情切换图标隐藏，核对范围图标消失但删除按钮位置不动；原图标位置保留空白占位。
