# 微信 8.0.80 防撤回链接命中 API 定点核验

这是 `reverse-engineer-anything` 技能下的离线定点核验：复用已解包且身份明确的用户指定 8.0.80.34 主程序，读取 Objective-C 元数据，并用本地 `llvm-objdump` 输出三个方法的窄范围反汇编。未执行主程序、连接设备或进行运行时采样。未重复开启此前超时的全量 REA 分析。

目标：`/var/folders/vh/8wytdb4s29342gz7592zc9kr0000gn/T/rea-extracted-cf6cb9d6-f0a6-4248-ba40-f3933418ac8d/Payload/WeChat.app/WeChat`；545074336 字节；SHA256 `1d626426df97058a8a87c661532b2801cd27b7d9fcc12e27609c751f5877b7ed`。此值本轮重新计算，与此前新 IPA 的目标身份一致。

## 已观察的 ABI 与继承关系

| 对象或方法 | 元数据观察 | 使用含义 |
| --- | --- | --- |
| `RichTextView` | `RichTextView → MMCPLabel → MMUILabel → UILabel`；末项是 UIKit 的 `UIView` 后代 | 它是实际视图，可使用 UIKit 手势和坐标转换；不是仅供排版的非视图对象。前三段继承关系来自本轮元数据，`UILabel → UIView` 为 UIKit 公共类型关系。 |
| `SystemMessageCellView -getRichTextView` | `@16@0:8`；IMP `0x105e705d8` | 零参数对象 getter；反汇编直接取 `m_richTextView`（偏移 48），不是新建或拷贝视图。 |
| `RichTextView -arrStyles` | `@16@0:8`；IMP `0x1058a3fc0` | 可通过现有受检对象 getter 取得当前样式数组。 |
| `RichTextView +targetLinkStyleFromStyles:withPoint:` | `@40@0:8@16{CGPoint=dd}24`；IMP `0x1058a0040` | **类方法**；调用约定为 `id (*)(id, SEL, id, CGPoint)`，点使用 RichTextView 自身坐标。返回样式对象，未命中返回 `nil`；不直接返回 URL 字符串。 |
| `RichTextView -getPreviewLinkForLocation:inView:` | `@40@0:8{CGPoint=dd}16@32`；IMP `0x1058a0be0` | **实例方法**；调用约定为 `id (*)(id, SEL, CGPoint, id)`。根据 `inView` 转换坐标，有额外原生触摸状态限制。 |
| `LinkStyle -nsUrl` | `@16@0:8`；IMP `0x1022c0e6c` | 从命中样式取 URL 字符串后，仍须交给插件的拥有判断与引用解析。 |

原始小型记录为 `native-hit-test-metadata.json`；命令、地址边界、退出码为 `native-hit-test-commands.json`。所有命令退出码为 0。所选方法 ABI 还与前轮同版本元数据一致。

## 命中与 preview 返回值的区别

`+targetLinkStyleFromStyles:withPoint:` 的主方法是 `0x1058a0040..0x1058a0140`；后续到 `0x1058a0398` 是它的枚举 block，均包含在 `RichTextView-targetLinkStyleFromStyles_withPoint-annotated.asm` 中。它枚举可选样式，处理 `eventRespondStyle` 或 `LinkStyle`，按当前 frame 与触点选候选，最后用 `expandHitAreaForRect:` 的结果作几何命中确认；失败分支返回 `nil`。候选结果需要再读取 `nsUrl`。这避免把提示整行或周围空白视作蓝字链接。

`-getPreviewLinkForLocation:inView:` 在 `0x1058a0c18..0x1058a0c40` 根据 view 参数转换点，随后存在三道限制：

1. `0x1058a0c44..0x1058a0c54` 调 `bTouchBeginOnLink`；假时立即走 `nil` 分支。
2. `0x1058a0c58..0x1058a0c7c` 取自身 `_arrStyles`（偏移 56），调用上述类方法选择样式。
3. `0x1058a0c8c..0x1058a0cb0` 要求样式 `eDataDectorType == 2` 且 `jumpType == 0`，通过才在 `0x1058a0ce8..0x1058a0d00` 返回其 `nsUrl`，否则返回 `nil`。

因此，独立 tap 入口可采用“当前 rich view 的 `arrStyles` + rich view 内触点 → 原生类方法命中 → 读 `nsUrl` → 插件拥有判断和现有导航校验”。`getPreviewLinkForLocation:inView:` 依赖原生 `bTouchBeginOnLink`，不适合作为该入口唯一的命中依据。两种 API 的参数次序不同，不应混用。

## 证据与边界

三个方法均保存原始 `.asm` 与 `-annotated.asm`；注释只增加已解码的 selector-ref 名称，保留全部原指令地址与字节。`native-hit-test-metadata.json` 另存 selector-ref 地址、解码结果、相关 ivar 偏移及解析脚本 SHA256。

这里证明所选命中 API 在指定主程序中的类型合同与静态控制流。它不证明用户录屏中的触摸实际到达这些入口、不证明已安装插件的 runtime IMP、也不构成微信真机已修复的证据。原有点击失败的真实运行时断点仍未知；新增 tap 入口属于针对该可失效点击链的修复设计，需要用其实际生产实现做核心回归，并保留账户、会话及原消息身份校验。
