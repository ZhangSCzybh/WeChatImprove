# 仍与 2.0-18 基线存在差异的文件清单

**当前源码、测试、版本定义和当前说明文件：0 项差异。** 以下内容按用户要求保留，不作为待撤回代码：

| 类别 | 文件数 | 处理 |
| --- | ---: | --- |
| 历史审计 | 55 | 2.0-19 / 2.0-20 的调查与构建证据完整保留。 |
| 历史成品包 | 6 | 保留已有 2.0-19 / 2.0-20 deb 和 symbols；没有新打包，没有覆盖 2.0-18。 |
| 用户反馈素材 | 2 | 图片和需求原文保留。 |
| 本次回退核对记录 | 38 | 保留 SHA256、还原副本、编译与测试日志。 |

逐文件路径、基线 SHA256、当前 SHA256 见 [remaining-differences.json](remaining-differences.json)。该清单记录核对时点；后续写入的本次报告本身也属于新增回退证据。

## 非审计文件明细

- `docs/feedbacks/2026-10-27-revert-scope-supplement.txt`：added（preserved-user-feedback）。
- `docs/feedbacks/2026-10-27-revert-to-2.0-18-request.txt`：added（preserved-user-feedback）。
- `packages/com.wechat.improve_2.0-19_iphoneos-arm.deb`：added（preserved-packages）。
- `packages/com.wechat.improve_2.0-19_iphoneos-arm64.deb`：added（preserved-packages）。
- `packages/com.wechat.improve_2.0-19_symbols.zip`：added（preserved-packages）。
- `packages/com.wechat.improve_2.0-20_iphoneos-arm.deb`：added（preserved-packages）。
- `packages/com.wechat.improve_2.0-20_iphoneos-arm64.deb`：added（preserved-packages）。
- `packages/com.wechat.improve_2.0-20_symbols.zip`：added（preserved-packages）。

工作区已有 packages 共 42 个文件全部未变，既有 .theos 共 1173 个文件全部未变。

本次仅 `make all SCHEME=rootful`，验证 arm64 / arm64e；未执行 package、stage、clean，不生成 deb。
