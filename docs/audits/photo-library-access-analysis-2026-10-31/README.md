# 相册持续访问路径分析（仅静态分析）

**一句话结论：本次证据不支持插件导致系统「照片」App 的长时间后台耗电；当前插件不写系统相册，未发现照片库观察/资源请求/循环唤醒路径，直接照片访问入口均需用户点击；具体后台任务仍需设备日志确认。**

基线：`282f5db17938e16c0d19233d27b85782c8f67eae`。以下行号全部针对该 HEAD；46 个引用文件均与 HEAD 逐字节一致，见 [cited-source-sha256.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/cited-source-sha256.json)。本轮只有静态搜索和调用链核查，没有真机采样、运行时调用次数、Instruments 数据或系统照片访问日志。下文的“1 处”“4 处”是源码调用点数量，不是设备上的调用次数。

本轮没有修改生产代码、头文件、Hooks、Tests、脚本、control、根 README 或发布说明；没有测试、构建、打包、提交或推送。只新增本审计目录。原有 `.DS_Store`、`packages/.DS_Store` 的工作树差异、未跟踪反馈素材及上一轮审计目录均保留。

## 1. 检查范围与结论边界

编译入口 [Makefile:25](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Makefile:25) 纳入 `Controllers/*.m` 和 `Hooks/*.xm`。本次直接扫描 `Controllers/`、`Hooks/`、`Headers/`，并补扫仓库其余实现文件；`HeadersFile/` 用作原生 API 声明证据，不能当作插件实现。动态 hook（`MSHookMessageEx`、`CSCloseFriendInstallHook`、`imp_implementationWithBlock` 等）也纳入检查，没有只看 Logos `%hook`。

静态检查结果：

- 插件有 **1 处**显式 `[PHPhotoLibrary authorizationStatus]` 和 **1 处** `[PHPhotoLibrary requestAuthorization:]`，都在底栏图标页的手动选图动作中。
- 插件有 **4 处** `UIImagePickerController` 构造点，分别在底栏图标、导航标题分隔图、触点轨迹、联系人分隔图设置页；其中底栏及联系人页同一构造方法也服务于手动拍照。
- 未找到插件注册 `PHPhotoLibraryChangeObserver`、持有 `PHAsset` / `PHFetchResult`、调用 `PHImageManager` / `PHCachingImageManager`、`ALAssetsLibrary`、PhotosUI / `PHPickerViewController` 的实现。
- 未找到插件调用 `UIImageWriteToSavedPhotosAlbum`、`UISaveVideoAtPathToSavedPhotosAlbum`、`PHAssetChangeRequest`、`PHPhotoLibrary performChanges` 或 `writeImageToSavedPhotosAlbum`。
- 找到两处带 `SaveAlbum:` 参数的微信原生图片下载桥接调用，实参均为 **NO**：一处是自动 AI 聊天图片处理，一处是用户点击“添加表情”。这不是“保存到系统相册”的指令；原生方法体不在仓库中，其内部是否额外查询 Photos 仍未知。

“未发现”表示本版本可见源码中没有可接通的调用链，不等于测出了设备上 Photos 调用为零。UIKit picker、微信原生方法和其他注入模块的内部执行，不能靠仓库搜索完全排除。

## 2. 相册相关调用点清单与触发条件

风险等级描述的是本次“无人操作持续访问”的嫌疑程度，不是安全漏洞等级。

| 文件:行 | API / 行为 | 静态触发条件 | 是否人手触发 | 判断 / 风险 |
| --- | --- | --- | --- | --- |
| [CSTabBarStyleSettingsViewController.m:662](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:662) | `PHPhotoLibrary authorizationStatus` | 点击图标设置，选择普通/选中图标，再点击“从相册选择” | 是 | 低；仅查询权限状态，本身没有 fetch 照片，也不调用系统授权弹窗 |
| [同文件:665](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:665) | `PHPhotoLibrary requestAuthorization:` | 上述动作且状态为 `NotDetermined` | 是 | 低；每次进入该方法只走一次请求，无失败重试或自动重开链 |
| [同文件:707](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:707) | 创建 picker、设置 source、present | 已获授权/有限授权（:668、:673），或另一个手动“拍照”动作 | 是 | 预期选图访问；picker 内部可取缩略图，不能等同于插件反复打开 picker |
| [CSNavigationTitleSettingsViewController.m:1140](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:1140)、[:1149](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:1149) | 检查 PhotoLibrary source 可用性，创建 picker，:1151 设照片来源，:1154 present | 点击“设置分隔符号”→“选择图片” | 是 | 低；没有显式 Photos 授权请求；UIKit 可能自行处理访问授权 |
| [CSTouchTrailViewController.m:898](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:898) | 创建 picker，:900 设 PhotoLibrary，:902 present | 点击“选择轨迹图片” | 是 | 低；没有显式 Photos 授权请求 |
| [CSContactSeparatorSettingsViewController.m:292](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:292)、[:309](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:309) | 用户选相册后创建 picker 并 present | 点击选择分隔图→“从相册选择”；:286 为另一条手动相机分支 | 是 | 低；没有显式 Photos 授权请求 |
| [CSAIImagePreparer.m:205](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:205) | 原生 `StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:`，`SaveAlbum=NO` | AI 启用并接受一条聊天图片事件，本地附件缺失/不可用 | 否，消息事件驱动 | 插件确有自动图片工作，但可见实现读取聊天附件；原生内部 Photos 行为待真机核实 |
| [CSMessageImageStickerAdapter.m:154](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSMessageImageStickerAdapter.m:154) | 同一原生下载方法，`SaveAlbum=NO` | 用户点击聊天图片“添加表情”，附件未就绪 | 是 | 微信表情素材下载/上传，不是系统相册写入；原生内部未知 |

### 2.1 四个 picker 的完整手动入口

1. **底栏图标**：[didSelectRow:1086](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:1086) → :1097 执行 `item.actionBlock` → :197–225 注册的四个图标动作 → [showIconSelectionAlertForType:578](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:578) → :610–621 普通/选中图标的 alert action → [showImagePicker:637](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:637) → :642–645 “从相册选择”的 action → `pickImageFromLibrary:661` → :662 / :665 / :668 / :673 → picker :707。`dispatch_async` :667 是本次用户请求授权完成后回主线程展示，不是循环任务。拒绝时 :715–720 只展示插件自己的“权限不足”提示，不重试、不自动跳系统设置。
2. **导航标题**：[didSelectRow:1007](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:1007) → :1035–1038 的“设置分隔符号” → [showSeparatorOptions:1049](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:1049) → :1113–1114 用户点击“选择图片” → `openImagePicker:1139` → :1149 构造 / :1154 present。
3. **触点轨迹**：[didSelectRow:601](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:601) → :637–638 “选择轨迹图片” → [showImagePicker:897](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:897) → :898–902 构造 / present。
4. **联系人分隔图**：[didSelectRow:387](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:387) → :392–394 执行 actionBlock → [:190–191 注册的动作](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:190) → `showImagePicker:278` → :289–292 “从相册选择” → `presentImagePickerWithSource:308` → :309–313 构造 / present。

对这些方法名做了全生产目录反向引用搜索，没有发现定时器、通知、KVO、CFNotification、后台任务、页面生命周期或布局回调调用它们。四页 picker 的取消回调仅 dismiss，不会重新弹出。相关原始匹配见 `04-settings-entry-callers.json`、`05-settings-event-sources.json`；上下文正文见 `source-excerpts.txt`。

### 2.2 选完后的保存与页面打开时的读取

选图后保存的是 UIImage 的 PNG 副本与插件自己的路径/偏好，不保存 `PHAsset`、相册标识或 picker 对象供后台反复取图。

| 设置项 | 保存位置与证据 | 打开页面时的自动行为 | 是否重读系统照片库 |
| --- | --- | --- | --- |
| 底栏图标 | [目录:780](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:780) 为 `Library/Preferences/WeChatImprove/`；:997 PNG，:1015 原子写文件，:1021 保存路径，:1028 发样式通知 | [viewDidLoad:77](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:77) → load/setup，:186–190 加载图标，[:832–840](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:832) `imageWithContentsOfFile:` | 否，读本地副本 |
| 导航标题分隔图 | [saveSeparatorImage:1393](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:1393) → `Library/Preferences/WeChatImprove/separator_image.png`，:1422 写入，:1425 保存路径 | [:181–185](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:181) 读本地文件；`viewWillAppear:100` 会 setup/reload，`viewDidLayoutSubviews:114` 只做一次 reload；都不执行选图动作 | 否，行重载不触发 picker |
| 触点轨迹 | [processAndSaveImage:937](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:937) → :945 `saveImageToDocuments:`；实际 [:967–991](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:967) 为 `Library/Preferences/WeChatImprove/touch_trail.png`，:949 保存路径，:1003 发图片变更通知 | [:1136–1153](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:1136) 恢复插件固定路径，[:449–452](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:449) 读文件作为预览 | 否；方法名中的 Documents 不代表照片库 |
| 联系人分隔图 | [saveSeparatorImage:334](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:334) → `Library/Preferences/WeChatImprove/separator_<contactId>.png`，:352 写 PNG；[CSContactSeparatorManager.m:96](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorManager.m:96) 保存配置字典 | [:105–109](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:105)、[:124–128](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:124) 读已有本地图片；另会自动加载联系人头像，见下节 | 否，图片预览来自本地副本 |

## 3. 自动链与间接放大核查

### 3.1 AI 图片：自动处理的是聊天附件，原生下载器内部仍需设备证据

完整可证链：

`CMessageMgr -AsyncOnAddMsg:MsgWrap:` 的 [AIReplyHooks.xm:19](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/AIReplyHooks.xm:19)（original 一次后检查入口资格）→ [CSAIReplyManager receiveNativeSession:wrap:epoch:564](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIReplyManager.m:564) → [CSAIMessageAdapter EventFromWrap:29](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIMessageAdapter.m:29) → [CSAIReplyCoordinator receiveEvent:286](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIReplyCoordinator.m:286) / `startBatch:483` → [:495 prepareImageForEvent:](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIReplyCoordinator.m:495) → [CSAIImagePreparer.m:272](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:272)。触发源是聊天消息，不是照片库变化。

`EventFromWrap` [:33–40](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIMessageAdapter.m:33) 先检查消息类型、图片开关、当前账号和会话是否启用；:74 将 type=3 的原始 `CMessageWrap` 放入 `imageSource`。路径由 [CSAIImagePaths:53](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:53) 调用 `CMessageWrap` 的 `getJpgPathOfMsgHdOrMiddleImg:`、`getPathOfRawMiddleImage:`、`getJpgPathOfMsgMiddleImg:` 得到，声明可对照 [CMessageWrap.h:197](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/CMessageWrap.h:197)、[:208](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/CMessageWrap.h:208)、[:211](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/CMessageWrap.h:211)。插件不从 PHAsset 标识查询路径。

[CSAIReadImage:65](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:65) 用 `open(O_RDONLY|O_NOFOLLOW|O_NONBLOCK)` / `fstat` / `read` 读取普通文件；[:144](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:144) 开始用 ImageIO 缩放编码；工作在 [:263](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:263) 创建的 `com.wechat.improve.ai-image` 队列，[:378](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:378) 执行读取。读的是聊天附件语义的本地路径，非 Photos API；真机实际返回路径没有采集，原生 getter 方法体也不在仓库中。

本地文件不可用时 [:400](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:400) → `startDownload:336` → `CSAIImageNativeDownload startEvent:191` → [:205](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:205) 的实参依次为 `imageSource, NO, NO, NO, YES`。原生 [CMessageMgr.h:149](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/CMessageMgr.h:149) 声明确认第四个业务参数是 `SaveAlbum`，这里明确为 NO。[:203](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:203) 注册的是消息图片下载完成扩展 `IDownloadImageExt`，不是 `PHPhotoLibraryChangeObserver`；:214 取消注册。

没有发现该链反复扫照片库：[:338–339](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:338) `requestedDownload` 限制每项操作只发起一次下载；:341–343 的一次性 dispatch_source 超时只结束当前操作；[:353](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:353) 下载完成后重读聊天文件。协调器 [:313–319](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIReplyCoordinator.m:313) 有消息身份保留/去重检查。多条新聊天图片仍可造成多次文件读取和网络下载，这与无人操作枚举相册是两类行为。

**不能排除的间接边界：**微信 `StartDownloadImage:...` 虽收到 `SaveAlbum=NO`，仍可能在其不可见实现内做权限状态检查。静态源码无法证明它绝不触及 Photos，也无法证明它正在触及 Photos。若设备调用栈从该桥进入 PhotoKit，应进一步定位这条间接链，不能用 NO 实参直接否认设备证据。

### 3.2 定时器、通知、KVO、前后台与布局

| 驱动源 | 文件:行与调用链 | 本次结论 |
| --- | --- | --- |
| AI 后台消息同步定时器 | [CSAIBackgroundSync.m:4](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIBackgroundSync.m:4) 为 45 秒间隔；:45–70 安排一次性 timer 并续约 → [CSAIReplyManager requestBackgroundSync:354](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIReplyManager.m:354) → :373 `NewSyncService BackGroundFetchToSync` | 自动链存在，但同步的是消息；:331–352 限制后台、保活有效、AI/连接/群配置有效等条件。可能带来新聊天图片处理，不直接枚举 Photos |
| AI 生命周期/策略通知 | [CSAIReplyManager.m:120](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIReplyManager.m:120) → `changed:125` → `refresh:161`；:184 初始化 preparer | preparer [init:261](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:261) 只装配队列/闭包；初始化本身不读图片、不请求照片权限 |
| 原生同步观察 | [CSAINativeSyncObserver.m:141](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAINativeSyncObserver.m:141) 安装 NewSyncService 的 `creatPBNewSyncEvent:`、`MessageReturn:Event:`、`HandleSyncResp:handleResult:` hook；:206 上报同步完成 | 消息同步观察，不是照片库观察；当前安装还有 :145 的微信版本守卫 |
| AI 批处理唤醒 | [CSAIReplyCoordinator.m:508](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIReplyCoordinator.m:508) 根据现有 active/staged/pending 工作安排 timer → `processPending` | 服务已有消息任务，不会独立生成相册任务 |
| 触点设置页的录屏状态通知 | [CSTouchTrailViewController.m:108](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:108) → :125–142 调整触点显示状态 | 不调用选图或照片授权 |
| 触点运行时的设置/前台通知 | [TouchTrailHooks.xm:677](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/TouchTrailHooks.xm:677) defaults/图片变更/录屏/前后台 → `CSReloadTouchTrails`；:503–512 输入变化才更新图片缓存 → [:441–444](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/TouchTrailHooks.xm:441) `imageWithContentsOfFile:` | 可能自动重读插件 PNG；[:426–430](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/TouchTrailHooks.xm:426) 固定目录是 Preferences/WeChatImprove。没有 Photos API |
| 全局触摸事件 hook | [TouchTrailHooks.xm:526](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/TouchTrailHooks.xm:526) `%orig` 一次 → :535 使用 `cachedTrailImage` | 每次 touch 不打开 picker，也不每次读照片库 |
| 四个设置页的生命周期 / table reload | `05-settings-event-sources.json` 列出对应回调；导航页 [viewWillAppear:100](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:100)、[viewDidLayoutSubviews:114](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:114) 代表性链为 load/setup/reload | 没有通向 picker/授权的自动调用；生成 actionBlock 与执行用户动作不同 |
| 联系人头像自动预览 | [CSContactSeparatorSettingsViewController.m:33](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:33) / :62 → `loadContactAvatar:39` → :49 `CSNavigationImageBinding`；头像地址来自 [NavigationTitleHooks.xm:1442](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/NavigationTitleHooks.xm:1442) 的 `contact.m_nsHeadImgUrl` | 这条会自动加载图片，但不是系统相册。loader [:145–146](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationImageLoader.m:145) 只接受 HTTP(S) 或有效普通文件 URL，:155 读文件，:179 NSURLSession；不处理 `ph://` / `assets-library://` |
| KVO / CFNotification / CADisplayLink / 后台任务到 picker 或授权 | 对直接入口反向搜索，并核查四页的 observer、生命周期和 reload 上下文 | 未发现可接通的链；这不表示插件完全没有其他用途的 KVO/定时器，只表示没有连接到本次相册入口 |

### 3.3 名称含 Album 的 hook：处理朋友圈，不是设备相册

这里确有插件自动刷新原生界面的链，不能简单写成“插件没有相册 hook”：

- [CloseFriendProfileHooks.xm:51](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/CloseFriendProfileHooks.xm:51) 钩住联系人助手 `onSocialInfoHandle` / `showAlbumList`。[:20](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/CloseFriendProfileHooks.xm:20) 的 `Navigate0` 只在原生已经调用时判断是否阻止，放行时 original 一次，不主动点击或打开相册。
- [CSCloseFriendAlbumAdapter.m:77](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendAlbumAdapter.m:77) 开始钩住 `WCListViewController reloadStyle`、`setM_contact:`、`viewWillAppear:` 及 `WCListView updateRowsData` / `shouldReloadData:starredDataItems:jumpState:prePage:` / footer。其模型是 [WCListViewController.h:12](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/WCListViewController.h:12) 的 `m_arrPhotoDatas`、`CContact`、:28 `WCMomentsPageContext`，以及 [WCListBaseCellView.h:11](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/WCListBaseCellView.h:11) 的 `WCCellGroup/WCDataItem`，指向朋友圈个人相册。
- 自动通知链为 [CSCloseFriendSocialAdapter.m:25](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendSocialAdapter.m:25) `CSCloseFriendPolicyDidChangeNotification` → `CSCFRefreshSurface` → [AlbumRefresh:36](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendAlbumAdapter.m:36)。:39 仅在页面已加载、已有状态且 hidden 确实变化时 :42 调 `reloadStyle`，稳定 hidden 不因相同通知反复重建。:17–24 临时替换的是页面已有朋友圈数组，不是 PHFetchResult。
- 另一条策略通知 [CSCloseFriendPrivacyAdapter.m:59](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendPrivacyAdapter.m:59) → `RefreshPrivacyOwner:37`；:40 同 hidden 状态直接 return，首次未记录状态或状态变化时才在 :47–49 调原生 `initView` / `layoutSubviews` / `updateAccessibility` 等，刷新朋友圈隐私图标/缩略图 UI。
- [AlbumTerminator:27](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendAlbumAdapter.m:27) 只处理尾部显示状态；实际正文没有调用控制器 `refreshFooter` 发起下一页请求。不能仅凭它的注释推断所有被调用原生方法的内部行为。

**放大判断：**插件在隐私状态切换时可能额外重建朋友圈 UI，原生图片加载/解码是否因而重复，主机静态分析不能计数；但没有连接到设备 PhotoKit 的证据，也没发现稳定状态下自驱动 fetch 环。若用户所说“相册”其实是联系人朋友圈相册，需要按这条链另外采原生网络/图片调用；不能把朋友圈照片加载记成系统照片库访问。

### 3.4 聊天附件“照片”按钮与“添加表情”

[CSChatAttachmentLayout.xm:33](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/CSChatAttachmentLayout.xm:33) 的 tag 18000 确为附件“照片”按钮，但 [:291–307](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/CSChatAttachmentLayout.xm:291) 的 `SelectAttachmentView layoutSubviews` / frame getter 只刷新配置与计算位置，original 各执行一次，没有发送按钮 action、构造原生 picker、fetch 相册或自行解码缩略图。:349 监听的是布局设置。按钮被用户正常点击后，仍会由微信原生打开照片页；这不构成插件自动触发的证据。

聊天图片手动“添加表情”的链：[CSMessageActionMenuAdapter.m:27](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSMessageActionMenuAdapter.m:27) → :22–23 的 `invoke` → [CSMessageActionCoordinator.m:237](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSMessageActionCoordinator.m:237) → [CSMessageImageStickerAdapter.m:60](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSMessageImageStickerAdapter.m:60) → [CSMessageMediaProvider.m:45](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSMessageMediaProvider.m:45) 读取聊天附件；需要时 :154 下载（`SaveAlbum=NO`），[:37–49](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSMessageImageStickerAdapter.m:37) / :136 用 `EmoticonCreateImageUploadTask` 上传到微信表情。:69 的延时只用于操作清理，不轮询相册。创建菜单项或布局菜单本身不会执行“添加表情”。

## 4. 已排除项与依据

以下“排除”均限定为本版本插件可见实现，不扩展到原生二进制或其他插件。

| 核查项 | 结果与依据 |
| --- | --- |
| 插件自己注册照片库 change observer / 长期持有资源结果 | `01-production-photos-apis.json` 中仅四页 picker 及底栏授权命中；未找到 `photoLibraryDidChange:` / `registerChangeObserver:` / PHAsset / PHFetchResult 的插件实现或存储 |
| PhotoKit 资源 fetch、缩略图缓存/解码 | 未发现 `PHImageManager`、`PHCachingImageManager`、PHAsset fetch、ALAssetsLibrary、PhotosUI/PHPicker 使用；ImageIO/UIImage 的本地文件解码不属于照片库资源请求 |
| 钩住原生设备照片库数据源或缓存类 | `02-native-photo-targets-in-plugin.json` 对 `MMAlbumDataProviderForPHAssetFramework`、`MMPHAssetCacheObj`、`MMPHAssetChangeInfo`、`MMUIImagePickerController`、`MMAssetForPHAssetFramework`、`MJPHAssetsAnalyzer`、`PHPhotoLibraryChangeObserver` 等为零命中；相关声明只在 HeadersFile |
| 间接调用原生相册取资源 selector | `03-native-photo-selectors-in-plugin.json` 未命中 `fetchAssets`、`AllMMAlbums`、`tryLoadPHAsset`、`fetchThumbImage`、`requestWechatAuthAndLoadAlbum` 等；仅命中上述两处下载桥及其能力检查 |
| 动态安装到上述 Photos 类 | `09-dynamic-hook-installers.json` 追查动态安装入口；[CSCloseFriendBridge.m:58](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendBridge.m:58) 按明确类名+selector 安装，不是通配 Photos 类。没有发现隐式安装到上述原生相册类的目标 |
| 把设置图片或 AI 图片写入系统相册 | `08-photo-save-and-fetch-global.json` 与 `03-native-photo-selectors-in-plugin.json`：无保存 API；两处 SaveAlbum 明确 NO；设置图片落插件 Preferences 目录 |
| 页面打开 / 回到前台时自动读照片权限 | 唯一 Photos 状态查询的反向链为手动选图；四页生命周期与前台通知没有调用它。`UIImagePickerController isSourceTypeAvailable` 也只在手动动作中 |
| 名称含 authorization 的自定义入口 | [CSAuthorizationManager.m:73](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAuthorizationManager.m:73) 是插件公众号授权，:82–92 为“关注公众号”提示和跳转，不是 Photos 授权。底栏 :689/:692 是相机 AVFoundation 权限，不是照片库权限 |
| 全局 UIKit hook 自动打开照片页 | [SessionGroupHooks.xm:217](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/SessionGroupHooks.xm:217) table 的 adapter 为空时走原生；[:453](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/SessionGroupHooks.xm:453) cell reuse/layout 处理会话 cover。触摸链见 3.2；没有通向 picker/PhotoKit 的调用。不能据此保证所有 UIKit 副作用为零 |
| 朋友圈上传 hook 主动读系统照片 | [WCUploadTaskHook.xm:24](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Hooks/WCUploadTaskHook.xm:24) 只处理 `appInfo` 的应用标识/显示后缀，不取上传资源、不查询相册 |
| 名称误判 | SF Symbol 的 `photo.fill`、备份目录的 assets、PNG/JPEG 文件读取、朋友圈 `m_arrPhotoDatas` 均不能仅凭名称归为 PhotoKit 访问 |

没有发现“定时器/通知/布局 → 相册 fetch → 再通知 → 再 fetch”的可证自激链，也没有可供归因的主线程阻塞或重复照片解码实测。本轮不把普通图片处理耗电推定为照片库持续访问。

## 5. 系统「照片」App 后台耗电：补充证据与归因

### 5.1 实际证据与五项判定

本轮用户补充及对应的 [补充反馈](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/feedbacks/2026-10-31-photo-library-access-analysis-addendum.txt) 已明确：不是权限弹窗/隐私提示，而是 iOS「设置 → 电池」中系统「照片」App 的详情。反馈记载今日耗电占比 20%，比过去七天多 15%，屏幕活跃 1 分钟、累计后台 2 小时 17 分钟，趋势自 10/24 抬升。这里引用的是反馈文本；本轮没有独立读取截图或设备电池数据库。补充文件的来源路径与哈希见 [supplemental-evidence-provenance.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/supplemental-evidence-provenance.json)。

**这组数字证明的是用户观察到系统「照片」的后台耗电记录，不能换算为微信/插件调用相册的次数，也不能单凭时长判定一定是人脸/OCR/索引任务。**同样，不能只按电池 App 标签推断跨进程守护进程的全部能耗归属。

| 补充问题 | 判定 | 代码依据与边界 |
| --- | --- | --- |
| 1. 插件是否写相册 | **就本基线可见实现，插件不写系统相册** | 全局写库 API 搜索无命中；[底栏:1015](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTabBarStyleSettingsViewController.m:1015)、[导航:1422](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSNavigationTitleSettingsViewController.m:1422)、[触点:991](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSTouchTrailViewController.m:991)、[联系人:352](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSContactSeparatorSettingsViewController.m:352) 写入的是插件 PNG。[AI:205](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:205) / [表情:154](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSMessageImageStickerAdapter.m:154) 的 SaveAlbum 均为 NO。原生方法体不可见 |
| 2. 是否观察相册 / 持有 PHAsset / 反复请求资源 | **插件没有发现这类注册、持有或请求** | 完整否定证据见 `01` / `02` / `03` 搜索；[CSAIImagePreparer.m:203](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAIImagePreparer.m:203) 的注册对象为 IDownloadImageExt，非 Photos observer，:214 对应注销。没有因此持续唤起 photolibraryd 的可证链 |
| 3. 是否直接写照片目录 / 照片 App 容器 | **未发现** | `14-photo-filesystem-targets.json` 中 DCIM、`/var/mobile/Media`、MediaLibrary、照片 bundle/container 目标无实质命中；PhotoData 的 4 行匹配全是 [CSCloseFriendAlbumAdapter.m:18](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendAlbumAdapter.m:18) 等处的朋友圈 `m_arrPhotoDatas` ivar。真实写入目标见第 2.2 节；未发现照片 App 容器定位或系统照片共享组路径 |
| 4. 相册 / 朋友圈 hook 是否放大 Photos 请求 | **未发现可证放大链；原生方法内部待确认** | 插件没有钩住设备相册 provider/asset cache；[AlbumRefresh:39–42](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendAlbumAdapter.m:39)、[RefreshPrivacyOwner:40–49](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCloseFriendPrivacyAdapter.m:40) 可重建朋友圈 UI：前者要求已有状态且 hidden 变化，后者首次未记录或 hidden 变化时重建；处理的是 WCMomentsPageContext/WCDataItem。手动 picker、原生下载桥可能进入系统照片服务；没有调用栈不能归因本次后台时长，也不能保证间接工作必然全记在微信名下 |
| 5. 是否有挂起后又拉起的循环唤醒 | **可证循环唤醒链：无** | [WeChatImprove.plist:2](/Users/zhangshichao/Documents/Workspace/WeChatImprove/WeChatImprove.plist:2) 的 filter 列出 `Bundles=com.tencent.xin` 与 `Executables=ZYBH`，没有列系统「照片」/MobileSlideShow 或 photolibraryd/mediaanalysisd/photoanalysisd。[:143](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAuthorizationManager.m:143)、[:159](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSAuthorizationManager.m:159) 的 URL 是 weixin；[CSCustomViewController.m:254](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSCustomViewController.m:254) 是 Telegram HTTPS；[CSLayoutSettingsViewController.m:292](/Users/zhangshichao/Documents/Workspace/WeChatImprove/Controllers/CSLayoutSettingsViewController.m:292) 等 Darwin 通知是插件设置名，没有 Photos 唤起目标。实际设备加载列表未采集，不能凭 filter 证明现场只加载这些目标 |

对不存在的 API/注册点以可复跑的完整搜索结果作否定证据，不编造“无调用”的源码行号；上表代码链接标出实际写入、容易混淆的注册及 UI 刷新位置。

据此结论是 **「本次证据不支持插件导致」**，不是“已经证明系统照片 App 没有问题”。非插件方向应优先核实：照片/视频的大批导入或设备恢复后媒体分析、人脸/场景/OCR/回忆等后台处理、iCloud 照片同步、iOS 升级后重建索引。这些是与长时间后台工作相容的候选，当前没有进程栈，不能选其中一个写成已确认根因。

### 5.2 微信原生照片能力，供需要时抓栈识别

HeadersFile 显示微信自身具备设备相册观察、资源缓存与截图观察业务：

| 原生类 / 声明位置 | 可证明的能力 | 不能据此证明的事项 |
| --- | --- | --- |
| [MMAlbumDataProviderForPHAssetFramework.h:13](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MMAlbumDataProviderForPHAssetFramework.h:13)、:18 | album/changeInfo、相册列表入口 | 当前设备是否调用、频率多高 |
| [MMPHAssetCacheObj.h:39](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MMPHAssetCacheObj.h:39)、:41、:43 | 异步缩略图、`tryLoadPHAsset`、`fetchThumbImage` | 是否重复 fetch / decode、是否阻塞主线程 |
| [MMAssetForPHAssetFramework.h:38](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MMAssetForPHAssetFramework.h:38)、:51–59 | PHAsset 持有与 requestImage / image manager | 是否由插件触发 |
| [MJPHAssetsAnalyzer.h:23](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MJPHAssetsAnalyzer.h:23) | 视频、图片、元数据分析接口 | 是否自动常驻运行 |
| [MMUIImagePickerController.h:10](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MMUIImagePickerController.h:10) | UIImagePickerController 子类 | 插件四页用的是 UIKit picker，没有引用该原生子类 |
| [SystemImagePickViewController.h:109](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/SystemImagePickViewController.h:109)、:114–119 | `photoLibraryDidChange:`、`backgroundUpdateAlbums:`、注册观察、授权加载 | 是否脱离照片页仍反复执行 |
| [MMAlbumDropPickerController.h:60](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MMAlbumDropPickerController.h:60)、:73–75 | 后台更新、观察与 loadAllAlbums/readAlbums | 是否当前现象的源头 |
| [MMAlbumChangeObserver.h:18](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/MMAlbumChangeObserver.h:18)、:21–24 | 照片变化、注册/取消、服务初始化 | 当前是否注册、调用频次 |
| [WAScreenshotMgr.h:14](/Users/zhangshichao/Documents/Workspace/WeChatImprove/HeadersFile/WAScreenshotMgr.h:14)、:40–47 | 持有 PHFetchResult、截图事件、`photoLibraryDidChange:`、截图 fetch 初始化及 observer 开关 | 用户是否触发截图业务、是否与提示同步、是否存在异常循环 |

插件没有引用或 hook 表中这些设备相册类。尤其 `WAScreenshotMgr` 是值得在“小程序/截图相关场景”中观察的原生候选，**仅为取证候选，不是根因结论**。

目前只能给出“未发现插件直接路径或可证明的 hook 放大路径”，不能写“确定是微信原生 bug”或“确定与插件无关”。若真机栈只有原生照片类，仍需结合插件开启/停用的同环境对照，才能区分原生正常业务、原生异常、间接 hook 副作用和其他注入模块。用户主动打开的 UIKit picker 在展示期间可能取多张缩略图，这也不同于反复申请权限或反复弹 picker。

## 6. 待确认事项与最小真机取证方案

本轮没有能定因的真机数据。下一步先取证，不建议为猜测修改代码。

### 6.1 针对「照片」后台耗电先核对系统任务

实际来源已由补充反馈确定为电池页，不再把“反复权限弹窗”当作本次已知现象。仍需设备/iOS/微信版本、实际安装插件版本、Photos 授权状态，以及以下时间关系：10/24 前后是否升级 iOS、恢复/迁移设备、大批导入照片/视频、开启或恢复 iCloud 照片同步，是否有大量新截图/视频。

在照片 App 中查看图库/个人资料入口的同步状态（具体入口依 iOS 版本而异），是否提示同步中/暂停/待处理；观察人物、搜索、回忆是否仍在补齐。系统没有保证所有版本都展示统一“后台分析进度”，不能因找不到进度条就认定没有分析任务。对齐电池页所选日期/小时，避免把不同时间窗口的耗电百分比直接比较。

优先观察 photolibraryd / mediaanalysisd / photoanalysisd / cloudphotod 的活动和调用栈，区分同步、分析与客户端资源请求。不能仅因它们运行就认定插件触发，也不能从“照片后台 2 小时 17 分钟”反推出连续满负载了同样时长。

### 6.2 若仍怀疑微信触发，再做不改代码的四个观察窗口

保持同一账号、数据、安装版本和授权状态，不清空数据库、不重置照片权限。分别记录时间：

1. 聊天列表前台静置，期间不打开图片设置、不主动选图；记录是否有新 AI 图片消息。
2. 只进入上述图片设置页，不点击选择图片；若此时就出现反复照片服务请求，静态手动入口解释不了，需要抓栈。
3. 手动打开一次 picker，保持展示，再取消；区分展示中的资源请求和取消后仍持续请求。
4. 若问题只在收到 AI 图片或小程序/截图后出现，单独记录该事件窗口；不要把不同业务同时混在一段采样里。

如果仍无法区分，在用户同意的前提下做同账号/同数据/同操作的插件启用与停用注入对照；或先只关闭 AI 图片处理作窄范围对照。不能静默切换账户/环境，也不把关闭开关后的短时耗电下降直接当成因果证明；系统已有分析/同步任务可能继续运行，应对齐同一电池时段和进程任务。

### 6.3 系统日志与最小调用栈

优先用 Mac“控制台”选择连接的 **iPhone 设备**，记录电池高峰窗口的 photolibraryd / mediaanalysisd / photoanalysisd / cloudphotod 活动；若存在微信关联，再补 photo / Photos / TCC 日志，必要时收设备 sysdiagnose。普通 Mac 终端直接跑 `log stream` 采到的是 Mac 日志，不能冒充 iPhone 证据。

若设备环境自身有 `log` 命令，可在**设备 shell**尝试下面的探索性筛选（先核实实际进程名）：

```sh
log stream --style compact --info --predicate 'process == "photolibraryd" OR process == "mediaanalysisd" OR process == "photoanalysisd" OR process == "cloudphotod" OR process == "MobileSlideShow"'
```

这是后续建议，本轮未执行。子系统名称、日志可见性和脱敏因系统版本而异；没有日志不能证明没有访问。日志太宽时先用复现时间缩窗，再按实际发现的 subsystem 缩小筛选。

若进程日志显示系统分析/同步任务持续工作，先按其任务栈归类；若发现微信客户端资源请求与高峰同步、但没有调用来源，下一步用工作树外的运行时取证工具记录时间戳、线程、调用栈和非内容参数，不改本仓库、不记录照片内容：

- `PHPhotoLibrary` 的 authorizationStatus / access-level 版本、requestAuthorization / access-level 版本、registerChangeObserver / unregisterChangeObserver。
- PHAsset / PHAssetCollection 的 fetch 入口、PHImageManager 的 requestImage/requestImageData、PHPhotoLibrary changes 写入入口。
- 四个设置页的 picker present/dismiss，以及实际 present 的控制器类型。
- `CMessageMgr StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:` 的调用栈和 `SaveAlbum` 值。

判读规则：插件设置页 action → picker 是可解释的手动路径；插件 AI 下载桥 → 原生 → Photos 是应继续调查的间接链；原生 `WAScreenshotMgr` / album provider → Photos 而无插件帧，是原生候选，需要 A/B 对照；其他注入模块出现在栈中，应单独归因。采集时间必须与电池页所选时段及具体操作对齐，不能只看某个类在进程中存在。

## 7. 未验证项、证据文件与环境保护

### 7.1 未验证项

- 未采集真机 PHPhotoLibrary/PHAsset 调用次数、线程、调用栈或权限弹窗次数；没有证据证明持续访问实际来自哪个模块。
- 已按补充文本明确证据为系统「照片」电池页；没有独立读取原截图、电池数据库或系统任务日志，未确认 2 小时 17 分钟由分析、同步还是其他后台工作组成。
- 未验证 UIKit picker 的系统内部访问/授权展示细节；不能把四处构造点数量当作运行时 present 次数。
- 未验证微信原生下载器、聊天路径 getter、朋友圈 reload/initView、截图观察服务的内部行为；class dump 是声明，不含实现。
- 未采集真实附件路径、照片访问能耗、重复解码耗时，未证明任何主线程阻塞或通知风暴。
- 未验证其他 tweak 或当前实际安装二进制是否与仓库基线一致。
- 没有运行测试、构建或打包；本轮没有修复，也没有“已修好”的结论。

### 7.2 可复核证据

搜索 JSON 保存了完整 argv、退出码、stdout、stderr。`rg` 退出码 1 表示无匹配，非采集失败；全仓补扫显式传入 `.`。可在同一 HEAD 逐条重跑。检索结果是静态匹配，不是运行时测量。

| 文件 | 内容 |
| --- | --- |
| [provenance.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/provenance.json) | 基线完整 SHA、目录、开始时 git 状态、原有变更、保护文件数量 |
| [01-production-photos-apis.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/01-production-photos-apis.json) | 直接 Photos/相册 API 与 picker；41 行匹配包含声明、delegate 与调用，不等于 41 次访问 |
| [02-native-photo-targets-in-plugin.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/02-native-photo-targets-in-plugin.json) | 指定原生设备相册类在插件代码中零匹配 |
| [03-native-photo-selectors-in-plugin.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/03-native-photo-selectors-in-plugin.json) | 原生 fetch/观察/下载 selector，4 行均为两个下载调用与能力检查 |
| [04-settings-entry-callers.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/04-settings-entry-callers.json) / [05-settings-event-sources.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/05-settings-event-sources.json) | 手动入口的反向引用与四页生命周期、通知、定时等事件来源 |
| [06-authorization-generic.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/06-authorization-generic.json) | Photos / camera / 插件公众号授权的区分 |
| [07-native-declaration-files.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/07-native-declaration-files.json) | 相关原生 class dump 文件清单 |
| [08-photo-save-and-fetch-global.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/08-photo-save-and-fetch-global.json) | 排除 docs/Tests/原生头文件/历史产物后补扫，实现层仅 Photos 的两个手动权限调用 |
| [09-dynamic-hook-installers.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/09-dynamic-hook-installers.json) | 非 Logos 动态 hook 安装入口 |
| [10-ai-event-sources.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/10-ai-event-sources.json) / [11-social-album-hooks.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/11-social-album-hooks.json) / [12-settings-local-images.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/12-settings-local-images.json) | AI 驱动源、朋友圈 hook、设置本地图像保存/读取 |
| [13-broad-photo-terminology.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/13-broad-photo-terminology.json) | 补扫 photo/album/相册/照片等宽关键词，区分图片路径、图标和朋友圈名称 |
| [14-photo-filesystem-targets.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/14-photo-filesystem-targets.json) / [15-photo-launch-ipc.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/15-photo-launch-ipc.json) / [16-additional-launch-container-apis.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/16-additional-launch-container-apis.json) | 照片目录、进程唤起、URL/IPC、容器定位与注入 filter 的补查 |
| [supplemental-evidence-provenance.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/supplemental-evidence-provenance.json) | 分析期间新增的电池页补充反馈来源与哈希 |
| [source-excerpts.txt](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/source-excerpts.txt) | 带原文件路径和行号的调用链上下文 |
| [cited-source-sha256.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/cited-source-sha256.json) | 46 个引用文件的 HEAD/工作树 SHA256，全部相同 |
| [workspace-before-sha256.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/workspace-before-sha256.json) / [preservation-check.json](/Users/zhangshichao/Documents/Workspace/WeChatImprove/docs/audits/photo-library-access-analysis-2026-10-31/preservation-check.json) | 审计目录之外的前置逐文件哈希与结束保护核对 |

结束保护核对通过：HEAD 保持不变，生产代码/Tests/构建输入对 HEAD 的 diff 为 0 字节；原有 50,635 个文件零删除、零内容修改，其中 packages 的 108 个文件与主树 `.theos` 的 1,237 个文件哈希全部一致。保护核对区分原有文件与并行新增反馈。第一次结束检查发现目录外新增 `docs/feedbacks/2026-10-31-photo-library-access-analysis-addendum.txt`，因此原先“目录外零新增”的检查如实报失败，记录保留于 `preservation-check-initial.json`；本轮没有工具向该文件写入，读取并纳入本报告后原样保留。最终 `preservation-check.json` 记录这一项并行新增及原有文件保护结果，不将它算作本轮代码修改。已有 `.DS_Store` 差异只与开始时对比，不声称其与 HEAD 相同。
