# 2.9-2 朋友圈链接与小程序卡片修复

基于 `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 当前完整工作区构建，包含本次朋友圈修复。插件内显示版本与安装包版本统一为 **2.9-2**。

## 本次更新

- **H5 链接卡片**：没有媒体和有效封面的链接使用紧凑卡片，展示链接图标、来源或域名及主标题，不再把完整长链接和编码参数拼入封面文字。卡片测量与展示同步调整；有正常封面的链接继续显示图片，无法创建封面视图时使用最多两行文字回退。
- **小程序名称与分享标题换位**：原粗体标题位置显示小程序名称，图标右侧或大封面下方的信息行显示分享页面标题。分享标题缺失时保留原发布文案。
- **实际小程序名称**：优先使用当前微信账号本地缓存中的名称，其次使用分享数据中的有效名称；过滤固定占位“小程序名称”，没有有效名称时显示“小程序”。查找结果仅在当前列表更新期间复用，账号切换或后续更新时重新读取。

原始朋友圈对象、媒体与完整跳转链接保留，点击继续交给微信原生入口处理。完整包同时包含此前已有的聊天分组、底栏、设置页和其他功能。

## 构建产物

| 文件 | 内容 |
| --- | --- |
| `com.wechat.improve_2.9-2_iphoneos-arm64.deb` | Rootless，安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| `com.wechat.improve_2.9-2_iphoneos-arm.deb` | Rootful，安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| `WeChatImprove.dylib` | 重签用动态库，与 Rootful 包内载荷一致；包含 arm64 / arm64e |
| `symbols.zip` | 两方案、两架构的四份 dSYM |
| `SHA256SUMS` | 全部归档文件的 SHA-256 校验清单，自身除外 |

两种安装包均包含 arm64 / arm64e，最低编译目标为 iOS 15.0。包名中的 `iphoneos-arm64` / `iphoneos-arm` 表示打包方案，应按设备现有注入环境选择。

## 本轮验证

| 验证 | 结果 | 日志 |
| --- | --- | --- |
| 朋友圈模型 | 262 条断言通过 | `regressions/moments-model.log` |
| 名称读取与当前账号隔离 | 84 项检查通过 | `regressions/moments-names.log` |
| 分享卡片与原生打开适配 | 103 项检查通过 | `regressions/moments-share.log` |
| 卡片几何与配置 | 73,467 项几何检查、113 项配置检查通过，arm64 / arm64e iOS 对象编译成功 | `regressions/moments-card.log` |

两个方案均成功编译打包；构建命令、时间与退出码见 `build-commands.json` 和各方案构建日志。`source-manifest.json` 记录 516 份构建输入，构建前后校验一致；本次朋友圈修改已包含在这两个包中。包版本、安装路径、双架构、四份符号 UUID 和独立动态库一致性核验结果见 `build-validation.json`。

构建使用当前 checkout 和各方案独立的临时构建目录。既有共享构建文件与历史包共 2,757 个受保护文件在构建后校验一致；未执行清理或安装，未启动或切换服务，未接触微信数据库及账号数据。

**实际真机显示、小程序名称缓存命中及点击打开效果尚未验证，需在原设备、原账号和原注入环境复验。**
