# 1.7-24 首次进入会话列表背景高度修复

基于 `91c906b5 / 1.7-23`，在用户已合并的原项目 main 上修复；完整旧包和 .theos 本地改动保留，不使用旧对象增量打包。

## 问题与证据

IMG_7407.PNG 显示首次进入时会话卡片白底高度小于行内容高度，头像和消息下方露灰。源码确认：会话背景只在 cellForRow/willDisplay 阶段按当时 contentView.bounds 绘制，NewMainFrameCell/FakeMainFrameCell 原生 layout 后无卡片尺寸修复。早期内容高度与后续行高不一致时，旧背景与旧 mask 路径会留下灰带。

复用上一轮 native-layout.json 中 NewMainFrameCell.layoutSubviews 静态证据（0x1050fcf20）：先执行父类布局，再使用当时的 width/height 设置 item frame。HeadersFile/FakeMainFrameCell.h 也声明 layoutSubviews。没有本轮手机运行视图树，截图对应实际中间尺寸仍属推断；主机用 44→64 高度变化复现这条确定存在的失效路径。

## 修复

在 NewMainFrameCell 和 FakeMainFrameCell 的 layoutSubviews 中各执行一次原实现，然后仅对实际主会话表修复已有卡片。

CSListCornerRefreshSessionGeometry 读取当前真实 contentView 的宽高和设置边距，通过渲染器已有 corners 状态更新背景及遮罩，沿用此前显示回调确定的首/中/末/单行角色。不会保存 indexPath、查询 indexPath/行数、计算分组投影或触发 reloadData/layoutIfNeeded/异步补偿。已有背景尚未建立时退出，绝不猜测行角色。

原生替换真实内容容器时，将同一插件背景转移到当前容器并清除旧关联；避免两份背景或旧容器随后移除新背景。内容侧滑坐标、原生头像/消息/时间 frame 不改。尺寸无效和圆角关闭时跳过；对象重入保护覆盖 contentView 访问。普通页面与会话显示回调复用原有底色准备逻辑，语义不变。

八个高度回调逐段不变；四页适配器、配置和纯高度策略与 1.7-23 相同；174 个受保护文件与 1.7-17 一致。此前通讯录、发现和我页面修复均保留。

## 验证与限制

- 初始失败用例：865 项、36 失败；完成修复与边界补充后：868 项、0 失败。
- 新覆盖真实/占位 Cell 原布局之后的 44→64 高度变化、首/中/末/单行角色、mask 重置、重复布局复用路径、宽高变化、侧滑、真实内容替换、关闭态、搜索排除、无已有背景、跨 native/display 索引作用域、零尺寸和重入。
- 相关分组表头46、交互124、视口72、搜索36项，共278项、0失败。
- 主机替身不代表手机真实 UIKit 光栅化、Hook 时序或冷启动已验收。

使用全新 Theos 输出目录构建 Rootless Release arm64 + arm64e。版本、源码提交、包哈希、符号检查见 build-validation.json；已有构建产物/旧包保护与最终交付见 delivery-validation.json。没有向手机安装，也未推送本轮提交到远程。

实机重点：彻底结束微信后首次进入主会话列表，白底应覆盖头像与消息所在完整行高；再次冷启动、滚动返回、分组切换及侧滑仍正常。此前图片对应的其他页面修复也应继续保留。
