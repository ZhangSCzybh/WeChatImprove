# 已还原文件清单

21 个文件均已与 2.0-18 的完整基线内容逐字节比对，SHA256 全部一致。完整源码清单另核验 555 / 555 项，未增加或缺失源码/测试文件。

| 文件 | SHA256（基线与还原后一致） | 结果 |
| --- | --- | --- |
| `Controllers/CSCloseFriendSessionPresentation.m` | `9172fd4fbded0be84095e76a6376f42d409c8fb81c0e36836af8e22d9abb1be8` | 一致 |
| `Controllers/CSGroupListAdapter.h` | `caf5597cade74bea28a85d69003e7aabf96f3a6a1a214c2d18c8090078e7717e` | 一致 |
| `Controllers/CSGroupListAdapter.m` | `c5a721ecf52e624b1aa51f52f5a03d131356bf26f004d78b02fb67656cd0e72d` | 一致 |
| `Controllers/CSListCornerPageContext.h` | `3aebc011193267d26e904ed758c557de3489550b626da550e008fac2278cabf5` | 一致 |
| `Controllers/CSListCornerPageContext.m` | `b9b9ed6af090dfcf64908f65136ea787c801c175ea0a8a4131b485cdf61da48f` | 一致 |
| `Controllers/CSListCornerSessionAdapter.h` | `c6ef611543693449e2e0432ef2e807963c92c8764020a3e7c1b9dce0da64427f` | 一致 |
| `Controllers/CSListCornerSessionAdapter.m` | `23f08171456bd16b50a6a33aee2542332e11b44c3312bbfe8df2d7b6456d9000` | 一致 |
| `Controllers/CSReleaseNotesViewController.m` | `416dc6b946a74e1ecb66cf9d527eb70d3479cf5d2c91c96e86ef0f33a7e7f236` | 一致 |
| `Headers/CSUserInfoHelper.h` | `b08184bf5b5d71f6982c5e14d8f6803422633858f593ea0194b6eb05eaec2b2f` | 一致 |
| `Hooks/ListCornerRadiusHooks.xm` | `a221726f7ceb03014ded3b70bf2d8f4cd5edfe0240d9d871b299d63721633fd1` | 一致 |
| `Hooks/SessionGroupHooks.xm` | `b56c592908053179b6e40af145c57f35c7923d39a7ee51cc1ff0874be4763b4c` | 一致 |
| `README.md` | `bbc0d40e984704db4cd729daf5adaa33c5f4ecf21997a3d87b9600431ccaaa87` | 一致 |
| `Tests/CloseFriendSessionPresentationTests.m` | `392740c164a06cef0698c48439ff008e867d6aead217accc4643b7aeb71907e0` | 一致 |
| `Tests/ListCornerSemanticsTests.m` | `94d45bf95099b9906da838f640ed6979c17ebfff4a0537383e98e56859b9db51` | 一致 |
| `Tests/ListCornerUIKit/ListCornerUIKit.m` | `fb091a5b0fbfca00670a161f34bd34796e36256f9ed76dacd27fe7ba12ffdaa5` | 一致 |
| `Tests/ListCornerUIKit/UIKit/UIKit.h` | `d50bf8031e62e506e93a1c9f5b73667133aabc70dc3f2c8e31611e37fc3da4b4` | 一致 |
| `Tests/extract-list-corners.py` | `8fbdc076334d980aafa1d2361a8a2facb680ad4ef3db27f199f7e3a12a398922` | 一致 |
| `Tests/verify-close-friend-session.sh` | `b388c4e52590b880ea7be6837f153706e1507a3cf28348e339ae973d35d08b6f` | 一致 |
| `Tests/verify-list-corners.sh` | `102976251a148f86ef210f1e0000ac1fcf37e588536760c17bbebea8703923f1` | 一致 |
| `control` | `67389be0ca314b37f9d9a2b9397214f9ae35408750e5d08297e996a7dde96635` | 一致 |
| `docs/session-groups.md` | `c0e7269f7a957723c099338f808a1516b1e548e3255706d96e381f7c226679dc` | 一致 |

## 2.0-18 之后新增的测试文件

以下两份文件已移出当前 Tests，原文保存在本次审计目录，没有删除历史审计：

- `Tests/FoldedEntryVisualTests.h` → `docs/audits/rollback-to-2.0-18-2026-10-27/execution/post-2.0-18-tests/Tests/FoldedEntryVisualTests.h`；SHA256 `014d4ec109d9b6749ae49343494336612664cd7451b348dfce832ac1bcd4d0e1`。
- `Tests/FoldedCardIntegrationTests.h` → `docs/audits/rollback-to-2.0-18-2026-10-27/execution/post-2.0-18-tests/Tests/FoldedCardIntegrationTests.h`；SHA256 `1d97b32ba783872d5d458280bce8c5e7acf6f0d7fd168cb6cd2938239e801449`。

还原来源与缺失原文恢复过程见 [candidate-verification.json](candidate-verification.json)。优先使用 2.0-19 before 原件；其他来源必须先满足 2.0-18 的历史 SHA256。所有恢复前文件另保存于 source-before-rollback.zip。
