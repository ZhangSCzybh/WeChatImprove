# UI：导航弹窗图片与附件布局

本子项在当前 checkout 延续既有 2.1-15 导航批量布局，未改版本、README 或其他 agent 负责的功能；未访问微信账号、真实偏好或数据库，未编译安装包或安装到设备。

## 导航头像信息与联系人分隔符设置

- `CSNavigationImageBinding` 在共享 `CSNavigationImageLoader` 上管理一个当前视图订阅；复用原有后台缩图、同账号／URL／尺寸的 in-flight 合并和有界内存缓存。绑定标识包含账号、联系人、URL、像素尺寸及目标视图，另用代次撤销迟到结果。相同有效绑定复用图片／请求，不反复显示占位。
- 信息弹窗不再单独创建 NSURLSession，也不再以原图 UIImage 解码；联系人分隔符设置不再同步读取 URL，先构造页面和占位头图，待显示后异步加载。
- 两个页面的生产回调均重验账号、联系人、URL、可见页面和当前目标；信息弹窗还核对表格当前 cell。退出页面、cell／header 离屏或被复用时取消；返回页面后重新订阅。相同 key 但身份失效时立即取消并恢复占位。清空设置头像 URL 也会恢复占位。
- 维持既有不传 URL、只提供 `contactAvatar` 的初始化调用兼容性。头像信息为 80pt、设置头图为 40pt，使用显示 scale 请求有限像素缩图。

宿主脚本实际提取并执行生产 popover/settings 绑定及生命周期方法，使用 UIKit 替身、离线 NSURLProtocol 延迟图像和生产 loader。慢响应时立即保留占位；两个相同尺寸消费者只有 **1 次**底层网络启动，**100 次**稳定重绑定新增启动 **0 次**；账号、联系人、URL、当前 cell／header、退出和复用失效均拦截结果；同 key 已加载失效清空图片、pending 失效取消底层请求；主线程缩图解码 **0 次**。

## 附件布局

- 每次原生布局开始失效一次旧快照，随后所有逐按钮回调共用不可变有效配置。相同场景／聊天标识和配置代次的回调复用快照；设置通知和 NSUserDefaultsDidChangeNotification 也明确失效。
- 构建时预计算 tag 到第一次出现的位置、隐藏 NSSet、可见序号前缀。按钮回调只做常量次查询和实时几何计算，避免重复偏好读取、indexOfObject 和前序扫描。
- 总开关或当前场景关闭时仍返回原生 frame；启用时仍调用一次 `%orig` 保留可能的原生副作用。保留原有排序关闭、未知索引、分页、宽度、列数及空排序懒初始化语义；没有修改默认设置初始化和 synchronize 的次数。

宿主脚本提取实际配置／frame 生产代码与两个 hook 方法，用独立的原布局顺序模型比较 **3 场景 × 7 排序／隐藏组合 × 4 列数 × 3 宽度 × 40 索引**。另覆盖缺失与空排序、未知场景、聊天身份变化、可变源隔离及两类真实通知失效。启用场景每次 layout 最多 **9 次**偏好读取，稳定 **1,000 次**后续 frame 回调新增读取 **0 次**；每份缺失或空排序仅 **1 次**写入和 **1 次 synchronize**；每次 frame 的原生调用副作用保持。

## 验证

| 命令 | 结果 | 日志 |
| --- | --- | --- |
| `bash Tests/verify-navigation-images.sh` | 162 checks passed | `ui-navigation-images.log` |
| `bash Tests/verify-navigation-title-batch.sh` | 15 checks passed | `ui-navigation-title-batch.log` |
| `bash Tests/verify-attachment-layout.sh` | 10,610 checks passed | `ui-attachment-layout.log` |
| 对本子项文件执行 `git diff --check` | 通过 | 无空白错误 |

共 **10,787 项**宿主检查通过。测试仅使用内存偏好替身、临时构建目录及离线 URLProtocol；没有调用真实网络或访问账号数据。完整 iOS 双架构编译与 Rootless／Rootful 构建由 root 汇总本轮所有修改后统一执行；本报告不将宿主检查表述为 iPhone 真机验收。

## 文件

生产：`Controllers/CSNavigationImageLoader.h/.m`、`Controllers/CSContactSeparatorSettingsViewController.h/.m`、`Hooks/NavigationTitleHooks.xm`、`Hooks/CSChatAttachmentLayout.xm`。

测试：`Tests/NavigationImageTests.m`、`Tests/NavigationUIKit/UIKit/UIKit.h`、`Tests/verify-navigation-images.sh`；新增 `Tests/AttachmentLayoutTests.m`、`Tests/verify-attachment-layout.sh`。

统一构建补充：首轮完整构建发现附件默认标签数组的局部名 `private` 与 Objective-C++ 关键字冲突，已仅重命名为 `privateTags`（另两项命名同步明确为 `officialTags`、`groupTags`），布局逻辑未变。重命名后附件 10,610 项再次通过。最终 Logos / Objective-C++ 双架构编译由统一构建结果确认，首轮日志保存在 `attempt-1-build-*.log`。
