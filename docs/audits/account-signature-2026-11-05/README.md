# 账号信息签名字段读取修复（2.2-13）

## 用户环境与问题

用户确认：重签 IPA 安装的微信 **8.0.78**，插件“账号信息 → 签名信息”整组显示“未读取到证书信息”。没有获取用户这份安装包的实际 `embedded.mobileprovision`，因此没有确认其文件是否存在、内容格式或所用 iOS Foundation 的实际行为。

项目 checkout 为 `/Users/zhangshichao/Documents/Workspace/WeChatImprove`，Objective-C / Logos / Theos iOS 注入插件。`Hooks/` 接入微信生命周期及私有界面，`Controllers/` 实现设置页面与业务逻辑，`Headers/` 提供公共接口及展示版本，`HeadersFile/` 保存微信私有声明。设置首页由 `CSCustomViewController` 打开 `CSAccountDetailViewController`，签名信息只读取 **当前宿主微信 app bundle** 的 `embedded.mobileprovision`。

这不是网页服务，没有本项目独立的前后端 URL、端口或服务数据库。此次没有安装、卸载、重签或重启用户微信，没有读写账号、聊天数据库、偏好或备份。所有文件读取测试均使用独立临时目录和合成数据；构建从实际 checkout 冻结副本，使用隔离的 Theos 输出。根目录既有 `Tests/` 删除和其他任务的改动保持原样，没有运行会删除历史产物的根 `make clean`。

## 定位结论

旧代码将整个 CMS 二进制描述文件按 `NSASCIIStringEncoding` 解成字符串，用 `NSScanner` 寻找 XML，再重新编码为 UTF-8。CMS 证书与签名不是纯文本，XML 中的 UTF-8 团队名也不属于 ASCII；该转换依赖了输入编码以外的行为，且会破坏中文。

必须区分已复现的缺陷与尚未确认的用户原因：本机 **Objective-C** Foundation 能解析合成的 ASCII CMS，中文 CMS 的团队名会乱码，但并未复现所有字段同时消失。最初 Swift ASCII 转换返回 nil 的探针与 Objective-C 行为不同，不能用它证明用户失败原因。二进制中的 NUL 也未导致本机旧扫描器截断。详见 [原实现复现](legacy-reproduction/README.md)。

文件从首次提交 `96d3f5d3`（2026-04-27，v1.5.3）到基线 `25081b45`（2.2-11）完全相同，任务开始时既有 2.2-12 改动也未修改该文件。因此没有源码证据把故障起点归到某个后续插件版本。宿主签名文件缺失、无法读取、内容异常及 Foundation 编码差异，旧界面都合并成同一个缺失提示。

## 实现

- 新增 `Controllers/CSProvisioningProfile.h/.m`，在 `NSData` 上定位完整 `<plist…</plist>` 字节范围，直接交给 `NSPropertyListSerialization`，保留整个字典及原有日期、数组、嵌套信息，不转换 CMS 二进制为字符串。
- 账号页调用同一个生产 helper；缺开／闭标签、损坏 XML、非字典根节点或空输入返回 nil，不人工补齐被截断的 XML。
- 签名组页脚区分描述文件不存在、读取失败与解析失败，其他两组不显示该说明。成功读取时清除旧说明。
- 描述文件类型判断先检查 `NSNumber` / `NSArray` 类型，避免异常字段直接调用不兼容的方法。
- UDID 仍取 `ProvisionedDevices` 首项，标题明确为“授权设备 UDID”。这代表描述文件授权名单中的设备，不保证是本机。
- `control`、展示版本及离线发布说明同步为 2.2-13，沿用任务开始时现有的聊天分组与滚动位置实现。

## 验证

[专项验证](validation/README.md) 共 **43 项检查全部通过，0 失败**。真实生产 helper 直接参与编译；账号页的读取、数据模型、类型判断及页脚方法从生产源码原样提取，在最小 Foundation 模型中执行。验证记录保存方法与生产源码 SHA-256，以便和构建快照核对。

| 范围 | 结果 |
| --- | --- |
| OpenSSL 生成的真实 DER CMS、ASCII／中文 UTF-8 XML | 整字典一致，团队名、ID、日期、设备名单和 Entitlements 保真 |
| 原样旧实现与新实现比较 | 旧中文团队名乱码，新实现保留原中文；不宣称复现用户整组失败 |
| 空数据、无 plist、缺闭标签、数组根节点、不平衡 XML | 返回 nil |
| XML 前后覆盖 0–255 全部字节 | 解析结果保持一致 |
| 账号页独立 bundle 文件读取与 setupData | 七项签名行内容正确，另外两组保持原结构 |
| 缺文件／内容损坏／非普通文件读取失败 | 准确的说明仅显示在签名组；再次成功后说明清空 |

复现命令：

```sh
python3 docs/audits/account-signature-2026-11-05/validation/run-validation.py
```

完整构建使用 [build-packages.py](build-packages.py)，从实际 checkout 冻结生产文件，分别构建 Rootless／Rootful 的 arm64／arm64e。脚本检查两份源码在全部架构编译、控制器引用与 helper 定义符号、包元数据、安装目录、dSYM UUID、源码一致性以及全部历史包文件哈希。结果保存在 [delivery-build/build-result.json](delivery-build/build-result.json)。

## 交付与实际边界

产物目录为 `packages/2.2-13-account-signature-final/`。重签 IPA 可使用其中与 Rootful 包内容一致的 `WeChatImprove.dylib`，按原重签工具加载插件；另提供 Rootful／Rootless `.deb`、调试符号和 `SHA256SUMS`。这些是插件产物，不是已经重签好的微信 IPA。

元数据提取不验证 CMS 内容签名、证书信任或有效性。测试样本的内容签名独立由 OpenSSL 检查；生产 helper 仅提取 XML。完整 XML 后缺少 CMS trailer 仍可提取内容；CMS 包含 binary plist 的合成样本当前不支持，未发现真实 Apple profile 使用这种格式的证据。

描述文件不存在时，无法从它恢复团队名称、创建／过期日期和授权名单，界面继续保持真实缺失值并给出原因。运行时 Team ID 或证书自身有效期不能替代这些字段。此次没有取其他安装包、插件 deb 或历史 profile 填充用户数据。

**尚未完成用户这份重签微信 8.0.78 的真机验收。** 安装含本版插件的微信后，打开“账号信息 → 签名信息”，确认团队、ID、日期与重签所用描述文件一致；若仍缺失，查看组下方的具体说明。缺文件应检查重签产物保留 `embedded.mobileprovision`；解析失败则需结合实际文件继续定位，不能仅凭本机合成数据断言用户问题已消失。
