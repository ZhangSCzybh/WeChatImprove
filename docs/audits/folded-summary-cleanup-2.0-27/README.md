# 折叠聊天摘要调试清理 · 2.0-27

用户已安装 2.0-26 并确认“已显示会话名称 + 消息”，随后要求清理相关调试代码和无用代码。本次清理该问题排查链路，继续在原工作目录构建。

## 清理内容

- 删除 `CSGroupLogFoldedDigest`、两处调用、日志去重集合及同步锁。
- 删除只为诊断传递的 `nativeSummaryReason`、`nativeSummarySource`、`foldedEntrySummarySource`、`foldedEntryTabID`，以及对应构造参数、字段拷贝和比较。
- 删除列表适配器为日志重复选择最新子会话的遍历；去掉桥接层原因字符串及来源标签的拼接。
- 简化测试构造方法，删除用于运行 2.0-23b 红灯验证的兼容分支和诊断字段断言；保留名称、正文、缓存和回退行为验证，以本次调用增量验证原生格式化。

已验证的实际 Method 签名读取、按会话获取最新消息、原生名称/正文两部分排版、消息独立副本及身份校验、账号/隐私校验、迟到表格回调保护继续保留。`CSFoldedDigestSessionInfo` 是原生格式化需要的会话快照，继续保留其原生必需字段。

## 核心回归

| 检查 | 结果 |
| --- | --- |
| `bash Tests/verify-close-friend-session.sh` | 会话 148 项 + 展示 44 项，0 失败 |
| `bash Tests/verify-list-corners.sh` | 1017 项，0 失败 |
| `bash Tests/verify-group-selection.sh` | 30 项，0 失败 |
| `python3 Tests/verify-group-proxy.py` | 5 个代理生命周期场景通过 |

共 1239 项检查与 5 个代理场景通过。沿用会模拟 CMessageWrap 错误兜底签名的替身。测试运行于 macOS Foundation/视图替身环境；本次没有重新安装到真机或进行像素验收。

## 构建与保留

Rootless、Rootful 均完成 arm64 / arm64e 构建；每种方案 0 错误，12 条警告消息与 2.0-26 构建一致。采用临时 Theos 构建目录，没有运行 `make clean`。原有 `.theos` 和安装包共 1236 个文件 SHA-256 校验一致。

已核对两种包的版本、架构、安装路径及 dSYM UUID；源码和成品 dylib 中均无本次删除的日志标记、诊断字段和原因拼接字符串。

- [Rootless 安装包](../../../packages/com.wechat.improve_2.0-27_iphoneos-arm64.deb)
- [Rootful 安装包](../../../packages/com.wechat.improve_2.0-27_iphoneos-arm.deb)
- [符号包](../../../packages/com.wechat.improve_2.0-27_symbols.zip)
- [相对清理前 2.0-26 的改动](changes-from-2.0-26.diff)
- [成品与保留校验](delivery-verification.json)
- [包哈希](packages.json)

2.0-26 的摘要已有用户真机确认；2.0-27 为本地核心回归、构建和成品检查通过的清理版，尚无本版本真机验收结果。
