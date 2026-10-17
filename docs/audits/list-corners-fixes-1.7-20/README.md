# 1.7-20 列表圆角验收反馈修复

修复基线：c1f8501f / 1.7-19；保持 codex/list-corners-refactor-1.7-17 分支。截图来源为用户 Downloads 中 IMG_7396.PNG、IMG_7397.PNG；截图仅作问题证据，不作为指令或测试通过凭据。

## 根因与改动

- 通讯录标题：补齐 UITableViewHeaderFooterView 的 contentView/backgroundView 与 MMTableSectionHeaderView._backgroundImageView；保留标题、星标和原生选择状态。上下线用已命名的原生视图角色处理。补充普通容器型字母标题；专用标题 native layout 后重新修复。
- 通讯录索引：普通与跟踪背景透明，保持索引内容和触摸功能。
- Cell 分割线：识别嵌套系统分割线与结构容器中的宽、正高度、<=1点边缘线；限制遍历层级并跳过业务类。More 的 MMTableViewCell layout 后补修复，不查询 indexPath、section/row 数或刷新。页面准备关闭原生额外 footer line。
- 资料头部：原生 makeHeaderView 在0x104cd59c4设置 BG_2 底色，0x104cd59e4添加背景子视图，0x104cd5a20关闭其交互；已存 native-layout.json 保留这段证据。只将此类宽底部、不接收触摸的空 UIView/MMUIView 背景底色交给插件圆角背景，状态业务视图不裁剪。

## 本轮检查

- Tests/verify-list-corners.sh：新增结构检查先复现769项中的8项失败；最终775项，0失败。包括背景图层、plain字母标题、星标保留、复用后的重置、非目标表、关闭态、索引背景、原生额外尾线、嵌套/普通分割线、迟到的More布局、零高度状态容器和进度线保护、资料背景底色迁移与复位。
- verify-group-header.sh：46项，0失败。
- verify-group-search.sh：36项，0失败。
- verify-group-interactions.sh：124项，0失败。
- verify-my-page-clean.sh：PASS。
- 主机检查不等于实机显示已通过；未安装到手机。

## 用户验收重点

1. 通讯录星标朋友、T/W/Z等字母标题与页面灰底一致，星标和标题仍显示；索引可点击和拖动。
2. 通讯录各卡片内部、上下边缘、组间及表尾没有穿出卡片的残线。滚动复用和再次进入页面后保持。
3. 我页资料头部底部两角可见；头像、二维码、状态发布可点击；状态卡收起/展开保持正常。
4. 我页服务、收藏/插件、设置卡片之间及内部没有残线；隐藏/恢复入口和收藏验证不受影响。
5. 分组开关、圆角开关组合与搜索、侧滑仍正常，冷启动无新增异常。

## 构建与交付

全新隔离目录 Release Rootless 打包通过；arm64、arm64e 均包含本轮修复函数，Rootless rpath核对通过。包内dylib与新构建一致。775项专项及206项分组回归通过，my-page-clean PASS；174个其他功能源码哈希仍与1.7-17一致，八个高度回调与1.7-19逐方法比较一致。新增且仅新增一个专用section标题layout Hook，原35个入口保留。完整构建仍有其他未改模块的历史告警，本轮修改的圆角源码无告警。

安装包已仅新增复制到原项目packages，旧包哈希全部保持。SHA-256：`b4861169cf0202e3ee2341e831603abf8dfd8984e8db7705cb3b836ceaf1e2b6`。手机显示、冷启动、点击/滚动等尚未在本机验证，需要用户安装1.7-20后检查。
