# 2.0-14：补齐图片添加到表情的原生成功提示

日期：2026-10-26。范围仅为图片添加到表情的完成反馈；沿用 2.0-13 的插件提示全程关闭、设置入口调整及定时任务备份接入。

## 根因与静态证据

微信 `EmoticonCreateUploadTask handleAddingItem:` 在实际提交前执行 `setDisableAutoShowSucToast:YES`。`EmoticonCustomManageAddLogic onAddBackupEmoticonOK:addEmoticonWrap:` 只有在自动提示未被关闭时才调用 `showSavedTips`。2.0-13 插件完成回调只调用 `finish`，没有接上原生成功提示，所以原生加载提示能够出现，成功后却没有结果提示。

这是对 WeChat 8.0.78.34 arm64 的静态调用顺序确认，目标 SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。没有启动微信、上传图片或使用真实账号执行测试。

证据位置：

- [已有完整反汇编](../../evidence/image-to-emoticon-native-2026-10-26/selected-disassembly.txt)：`0x10145c190–0x10145c198` 设置关闭成功提示，`0x10145c20c` 提交；`0x1014744d8–0x1014744f4` 为自动成功提示判断与调用。
- 同一文件的 `addEmoticonLogic` getter，`0x10145cef0`：逻辑对象已存在时直接返回。`addlogicDelegate` 只在首次创建时调用，因此无法靠这个回调在后续上传时重新打开提示。上传前设置开关也会被上面的写入覆盖。
- [本次方法元数据](native/methods.json)、[本次反汇编](native/selected-disassembly.txt)：`showSavedTips` 是 `v16@0:8`，`disableAutoShowSucToast` 是 `B16@0:8`；`0x101471870–0x1014719fc` 按原生样式处理，并使用原生语言键 `Emoticon_Added_To_Board`。
- 原生 `EmoticonCustomCreateLogic AddEmoticonFinishedWithWrap:IsSuccessed:` 在 `0x10145585c` 检查成功标志，随后走原生 `WeToast` 与语言服务。这印证了上传任务的消费者需要负责成功结果展示。
- `AddEmoticonFinishedWithWraps:sessionID:` 的参数并非成功数组。原生逻辑传入 `m_emoticonComplete` 字典，成功和失败都可能触发此回调；原生消费者在 `0x101455df0–0x101455e48` 按 key 获取结果，再检查 `uploadSuccess`。插件不能按“非空”判定成功。

`native/extract.py` 复用项目只读 Mach-O 解析定义，以 `LC_FUNCTION_STARTS` 限定反汇编边界。`native/ivars.json` 记录结果字典的类型和偏移。注释仅用于解析邻近的地址引用，不代表全函数数据流证明；运行时仍需真机验收。`EmoticonCustomAddResult` 的独立实现方法表为空，结果 getter 的使用由原生消费者反汇编佐证；插件在运行时验证具体方法 ABI，不依赖硬编码类布局。

## 修改

生产行为仅修改 `Controllers/CSMessageImageStickerAdapter.m`：

1. 单项成功或批量字典中全部 `uploadSuccess` 为真时，在主线程调用 `completeWithSuccess:`。
2. 操作必须已经提交且账号、开关和消息上下文仍有效；确认微信关闭自动成功提示，并验证原生方法签名后，调用该操作自己的 `showSavedTips`。
3. 在委托尚未清理时显示，让原生仍可获取页面；随后执行原有清理。`completing` / `finished` 阻止重入和重复回调。
4. 原生自动提示未关闭时不补弹。失败、待上传、超限、空结果、格式未知、签名不匹配及取消后都不补成功提示。没有新增全局 hook、插件 toast 或硬编码成功文案。

版本、更新说明和功能文档同步为 2.0-14。备份与定时任务生产代码保持原样。

## 核心回归

只运行一条相关脚本，使用隔离偏好域、临时图片文件和原生替身：

```sh
CS_TEST_IMAGE_STICKER_FEEDBACK=1 bash Tests/verify-message-actions-execution.sh
```

- [失败复现](red.log)：保留旧生产实现，模拟原生上传阶段关闭自动提示，断言 `savedTips == 1` 失败。该失败是测试实际运行的断言失败。
- [修复后结果](green.log)：254 项检查通过，原有聚焦集合为 190 项。
- 覆盖异步/同步成功、正确的批量结果字典、部分或全部失败、空/未知结果、原生自动提示去重、回调重入、后台线程回调、取消/账号/开关边界、错误 ABI、下载收尾、原生菜单与既有共享反馈。
- 不运行全量、备份或定时任务脚本；未向真实会话发送消息，未上传图片。

## 编译与交付

使用既有隔离 Theos 缓存，顺序执行 rootful / rootless 增量编译；不执行 `make clean`。两份 deb 均含 arm64、arm64e，最低 iOS 编译目标为 15.0。编译有项目既有的 `UILocalNotification`、`statusBarFrame` 弃用和 `multiply_defined` 链接参数警告。

- [Rootful](../../../packages/com.wechat.improve_2.0-14_iphoneos-arm.deb)
- [Rootless](../../../packages/com.wechat.improve_2.0-14_iphoneos-arm64.deb)
- [调试符号](../../../packages/com.wechat.improve_2.0-14_symbols.zip)
- [包元数据及 SHA-256](packages.json)、[源码摘要](source-sha256.json)、[验证结果](validation.json)

`verify-packages.py` 校验版本、架构、安装前缀、修复方法与原生 selector、dSYM UUID、首个存储初始化器、测试替身不入包、旧插件提示未恢复，并校验已有 2.0-13 包和本轮范围外的工作区文件。`preserved-tree.json` 覆盖修改前 47,068 个范围外文件；精简清单另保留 1,675 个源码/构建/安装包文件，既有 `.theos` 不改写。

## 真机验收

1. 在原签名 IPA 安装流程中替换为 2.0-14，并确认插件版本；保持“表情功能 → 图片添加到表情”开启。
2. 对会话中一张尚未添加、已加载完整的图片长按“添加到表情”。应先出现微信原生“正在添加”，成功后出现一次原生“已添加表情”，并可在自定义表情栏找到图片；全程无额外插件黑色提示。
3. 连续点击和再次添加已存在的图片，原生重复判断及提示保持原样，不叠加插件提示。再检查一张需要先下载的图片。
4. 断网/图片过期/表情容量满时不应误报“已添加表情”；微信自身失败提示继续保留。未完成时关闭开关、取消操作或切账号，不应出现迟到的成功提示。

本轮没有连接真机，不能将替身测试或静态分析当成真实上传及 UI 验收。若仍只有“正在添加”，请记录微信完整版本、已加载图片还是需要下载的图片、表情栏最终是否出现该图片，以及发生时是否切后台或离开会话，以区分未成功与成功提示路径差异。
