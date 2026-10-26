# 会话图片添加到自定义表情：原生链路核对

日期：2026-10-26。用途：为功能设计提供静态证据；本目录不是已实现功能或真机验收报告。

分析对象为此前项目调查使用的 WeChat 8.0.78.34 arm64 可执行文件，SHA-256：
`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。
本轮由 REA 再次核对文件身份，使用同一文件的 Objective-C 元数据和有明确函数边界的 LLVM 反汇编核实 29 个相关方法。没有运行微信、上传图片或修改账号数据。

证据文件：`methods.json` 保存 IMP 和实际类型编码；`selected-disassembly.txt` 保存完整的选定函数；`manifest.json` 保存目标身份、函数范围、工具信息、文件摘要和局限。反汇编中的最近导出符号名称不代表所属 Objective-C 方法，应以区段标题和 methods.json 为准。选择器注释是局部引用辅助，不是完整调用图。

## 1. 图片菜单与表情消息菜单是两条路径

- `ImageMessageCellView operationMenuItems`，IMP `0x101f78e48`：可见转发、收藏、编辑、撤回/删除、搜索等菜单构造。所核对方法中没有普通图片转自定义表情的调用。不能据此断言微信所有版本、所有图片界面都没有这种入口。
- `EmoticonMessageCellView onSaveEmoticon:`，IMP `0x10152e4f8`：这是已有表情消息的原生保存入口。
- `AddEmoticonWrap initWithMessageWrap:AndSource:`，IMP `0x101531518`：先判断消息类型 `47`；另有 `49` 且内部类型 `8` 的分支。随后读取 `m_nsEmoticonMD5`、产品 ID、设计师等表情字段。没有把普通类型 `3` 的图片数据转换为表情数据的步骤。

结论：不能把普通图片 wrap 直接交给“保存已有表情”入口，也不能把 `doFavorite` 当作“添加到表情”。普通图片必须先进入图片数据转换/上传流程。

## 2. 图片字节来自哪里

- `ImageMessageViewModel imageData`，IMP `0x101f7f768`，转调 `CMessageWrap getMsgHdOrMiddleImgData:`。
- `CMessageWrap getMsgHdOrMiddleImgData:canUseHeif:`，IMP `0x104baaad0`：在 `IsHDImg` 成立时尝试高清图；没有高清数据时转取中图。禁止使用 HEIF 时有 `convertHeifDataToJpg:` 分支。
- 这条路径与 `thumbImage`、`getCoverImage` 不同。未拿到图像字节必须处理缺图，不能悄悄把会话缩略图当作完整图片。
- 仓库头文件包含 `CMessageMgr StartDownloadImage:HD:AutoDownload:SaveAlbum:Silent:` 和 `IDownloadImageExt` 的 `OnDownloadImageOk:` / `OnDownloadImageFail:`。本轮还核对了下载入口的实际方法元数据。具体扩展注册、回调相关性及取消所有权仍需要在实现时验证，不能声称已验证自动下载的真机行为。

## 3. 原生普通图片创建表情的可复用链路

`EmoticonCustomCreateLogic startImageUploadTask:`（`0x101454fa8`）保存上传任务、设置 delegate，然后调用 `startUpload`。

静态图片路径：

1. `EmoticonCreateImageUploadTask startStaticImageUpload`，`0x10145e1c0`。
2. `handleStaticImg:withAddingItem:`，`0x10145ea20`。
3. `EmoticonUtil getStaticImgData:` / `getStaticImgData:isFuzzyAlphaCheck:`，`0x1015b2ab4` / `0x1015b2acc`。
4. 将生成的字节放入 adding item，再进入 `EmoticonCreateUploadTask handleAddingItem:`，`0x10145bc84`。

静态转换函数包含等比例尺寸计算、缩放、带 alpha 判断的数据编码，以及原生配置的大小/宽度限制；不应在插件里硬编码另一套固定尺寸和容量规则。

GIF 路径：`startGifImageUpload`（`0x10145e540`）将 `gifData` 放入 adding item 的 `imgDatas`，再进入同一 `handleAddingItem:`。因此 GIF 原始字节应与静态 UIImage 路径分开。此结论不意味着聊天里被微信提前转成静态图片的内容还能恢复动画。

统一添加阶段：

1. `realDoAddImg:index:`（`0x10145c460`）计算内容 MD5，检查是否已存在，调用原生表情文件保存方法，构造 `AddEmoticonWrap` 与 `EmoticonUploadInfoObj`，保存上传临时数据。
2. `handleAddingItem:` 调用 `EmoticonCustomManageAddLogic startAddEmoticonWithWraps:`。该阶段设置 `disableAutoShowSucToast=YES`，因此插件接入上传任务后需要处理完成反馈，不能假设一定有原生成功提示。
3. `startAddEmoticonWithWraps:NeedCheckTotalCountLimit:`（`0x10146ec94`）处理并发添加、MD5、容量、重复、数据类型、资源校验与保存，再调用原生 `addBackupEmoticonToServer:totalAddCount:`。

`EmoticonCreateUploadTask` 通过 `delegate`、`getPresetAddingItem`、`handleAddingItemAndShouldContinueUploading:`、`addlogicDelegate` 与上层协作。接入必须保持这些对象到操作结束，并在提交前再次校验原消息与账号。

## 4. 完成、待上传与列表更新

- 成功入口：`onAddBackupEmoticonOK:addEmoticonWrap:`，`0x1014743dc`。
- 待上传入口：`onAddBackupEmoticonPendingUpload:`，`0x101474008`。
- 失败入口：`onAddBackupEmoticonFailed:reason:remoteErrMsg:`，`0x1014749f0`。
- 成功回调既有 `AddEmoticonFinishedWithWrap:IsSuccessed:`，又有受原生分支影响的 `AddEmoticonFinishedWithWraps:sessionID:`。适配器应覆盖实际启用的回调形式；接口返回 YES 只能说明接受/启动，不能直接报告最终成功。
- `EmoticonBoardView OnUpdateEmoticonListFor:`（`0x101405528`）转到 `updateCustomOrCameraEmoticonWithType:`（`0x10140ac50`），后者取原生 page wrap 并更新 section。
- `onAddBackupEmoticonOK:addEmoticonWrap:` 在表情面板另有切换分类位置的处理。插件应交给原生列表更新机制，不手工写表情数据库、插一条假 UI 记录或清空列表重建。

## 5. 头文件与当前样本存在真实差异

| 接口 | 仓库头文件 | 当前二进制元数据 |
| --- | --- | --- |
| `AddEmoticonWrap initWithMessageWrap:AndSource:` | source 为 long long | source 为 int，编码 `@28@0:8@16i24` |
| 添加数量检查重载 | `startAddEmoticonWithWrap:NeedCheckTotalCountLimit:` | 当前类使用复数 `startAddEmoticonWithWraps:NeedCheckTotalCountLimit:` |
| 上传单项内部方法 | `realDoAddImg:` | `realDoAddImg:index:`，且返回对象 |
| 上传任务继承关系 | class dump 显示 NSObject | 图片任务实际继承 EmoticonCreateUploadTask，后者继承 EmoticonCustomCreateInternalTask |

因此头文件只能用于发现候选接口。实际接入应复用项目的签名检查工具，校验 selector、返回值和参数宽度；新版本不符合已验证契约时显示兼容性提示，不能猜测调用。

## 6. 项目接入边界与待验证事项

- `Hooks/RepeatHooks.xm` 已接管图片消息 `operationMenuItems`；`CSMessageActionMenuAdapter` 已支持原生 MMMenuItem 构造、独立 menuType、原生去重前插入与消息身份绑定。
- `CSMessageActionContext` 已包含账号、epoch、会话和稳定消息身份；`CSMessageActionCoordinator` 已提供账号切换与原消息复核。新增动作应复用这些边界。
- `CSMessageMediaProvider` 当前主要提供语音和 app data，不能宣称已有可直接复用的图片下载实现。
- 设置沿用 `CSMessageActionPreferences`，备份登记在 `CSBackupRegistry`。插件只需保存开关，最终表情资源由微信原生机制持有。
- 真机尚需验证：普通图片无需打开编辑器即可添加；下载完成后与原消息正确关联；GIF/透明图/HEIF 表现；原生单双项回调；离线待上传；新增表情面板即时更新；关闭开关、切账号和消息复用时不会继续提交。

本轮只有静态分析和设计证据，没有运行功能回归、修改生产代码或生成安装包。
