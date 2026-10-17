# “我”页面隐藏作品 · 1.7-0

在 **插件设置 → 界面净化 → 我的页面设置** 新增 **隐藏作品选项**，默认关闭。开启后返回“我”页面隐藏“作品”；关闭后返回该页时调用微信原生 `reloadMoreView` 重建列表，恢复入口。

使用独立配置键 `com.wechat.tweak.hide_works_enabled`，与原有“隐藏视频号与公众号选项”分别控制。仅处理 `MoreViewController` 的列表入口，不修改作品内容、账号或微信数据库。

作品识别优先读取 `cellConfig.leftConfig` 的原始 `_title`，精确匹配“作品”，避免菜单文字定制后漏匹配，或把其他改名为“作品”的菜单误隐藏。无法取得该字段时回退到标题 getter；未知结构保留原行。当前仅适配中文原始标题，尚未验证其他语言和不同微信版本的入口结构。

## 验证

- `bash Tests/verify-my-page-clean.sh` 通过。测试从生产 Hook 中提取过滤与生命周期代码，在 macOS Foundation 下使用列表替身执行，覆盖默认关闭、开启隐藏、关闭恢复及顺序、重复进入、原生重建、多开关组合、文字定制和未知 cell。
- 测试使用独立随机 NSUserDefaults suite，完成后删除，不接触微信真实配置或数据库。
- `make package SCHEME=rootless PACKAGE_VERSION=1.7-0` 成功，包含 `arm64`、`arm64e`。
- 已核对 deb 元数据：`com.wechat.improve`、`1.7-0`、`iphoneos-arm64`，动态库位于 `/var/jb/Library/MobileSubstrate/DynamicLibraries/`。
- 未安装到手机；实机页面结构、显示布局及与其他插件组合的效果尚待验收。Rootful、Roothide 本轮未构建。

## 产物

`packages/com.wechat.improve_1.7-0_iphoneos-arm64.deb`

SHA-256：`718ef788a4d04bfbfaf9cecc61ded808365d823360c5ccc2fdc3baf045f769f6`

安装并重新打开微信后，依次验证：默认仍显示“作品”；开启后“作品”消失且收藏、插件保持正常；关闭后返回“我”页面恢复原位置；与其他隐藏选项组合时分别生效。
