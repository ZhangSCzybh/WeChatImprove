# 2.2-20 docs 本机归档索引

归档目录：`/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/2.2-20-cleanup-2026-11-06`。本索引记录166项根摘要；256,490个逐文件SHA256明细保存在项目外，不放回docs。

保持相对路径移动 **166项、256,490文件、2,130,403,146字节**；全部逐文件SHA256复核一致。原始证据保存在归档中；历史README、WAIVER、REGRESSION-GATE、红绿日志、provenance和测试断言没有修改。

- 原始计划：[docs-cleanup-plan.json](docs-cleanup-plan.json)，SHA256 `e89072697cfeada3bbeb229f21bd923c048f2a94140f41231b5e1f854cfa77cc`。
- 逐文件明细：`/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/2.2-20-cleanup-2026-11-06/FILE-SHA256.jsonl`，SHA256 `439388266c36c67c802a4a7f272595c7deb901ffaf23e5b8d720fd3bda51525f`。
- 归档根清单：`/Users/zhangshichao/Documents/Workspace/WeChatImprove-local-archive/2.2-20-cleanup-2026-11-06/ROOTS-MANIFEST.json`，SHA256 `12b2ceaaf50e09ff49c8c95ef95de8f2468b528d429337ca2215803aac872f30`。
- 执行记录：[docs-cleanup-result.json](docs-cleanup-result.json)。

## 恢复方法

1. 先读取外部 `ROOTS-MANIFEST.json` 与 `FILE-SHA256.jsonl`，核对上列SHA256。
2. 选择下表一个原相对路径；归档位置为「归档目录 / 原相对路径」。
3. 确认项目原路径不存在，再将该目录或文件按原路径复制回来；不要覆盖现有文件。
4. 按逐文件明细对恢复文件计算SHA256。
5. 旧报告链接的trace、XML、baseline头文件可按此恢复；仓库保留摘要、日志、方法、源样本和结果。

两个历史 `remaining-regressions/baseline-fixture/HeadersFile` 链接本体未修改；由于目标baseline HeadersFile已归档，链接暂时不可用。重跑对应历史baseline工作区前须恢复目标目录。本轮release20使用主树HeadersFile，不受影响。

## docs 体积核对

- 全docs开始快照：267,227文件 / 2,578,845,361字节。
- 全docs归档后、写本索引前：11,087文件 / 469,507,019字节。
- 排除并发release20审计目录：267,154 → 10,667文件；2,571,791,755 → 441,390,603字节。
- 差额已逐项对账：归档256,490文件/2,130,403,146字节；父任务并发新增docs/README.md共1,707字节；两个旧目录链接因目标归档，被os.walk从目录归到文件，计数增加2、字节增加287。链接没有改写。
- 上述统计口径调整后，文件数与字节差额精确一致；执行记录保留原始数字。

## 归档根清单

树SHA256算法：按原相对路径排序，将每条 `path\0type\0bytes\0sha256\n` 送入SHA256；当前256,490条均为普通文件，哈希内容字节。

| 原相对路径 | 文件数 | 字节数 | 树SHA256 |
| --- | ---: | ---: | --- |
| `docs/.DS_Store` | 1 | 6,148 | `7659c02006caa154be6f42d67befdb399f3320bce3694c916f4f75b71b40c4fe` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/__pycache__` | 1 | 25,057 | `55a9b0f4774b82c823a77cd256bc9d3e1bfe6cfa4192d8dc621a74f222452aeb` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/baseline-2.2-14/Controllers/.DS_Store` | 1 | 6,148 | `f7c7d1b5307ac55c44dd01fc6fa79fcee23c45a0aeeb451614b8c586587c0887` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/baseline-2.2-14/HeadersFile` | 42,142 | 53,227,892 | `eb2c86a8c7e9fa1cc3178153b1032f58f089618d59dd7c7b74a0b0a09b7d81ac` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/baseline-git-status.z` | 1 | 539,952 | `2dbe18f8262e7dc9ace1198ef763f7df7db377386f35c358ea1aca368b062a80` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/final-git-status.z` | 1 | 10,998,191 | `5681dfb85fd08912353c393195537d06880f4e661478cf149ee95b45d145796c` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/baseline/recovery` | 1 | 104,040 | `3cdc5e42277b15e31cb1779e89718ab8ecf2ca741fbfaafaca5216cfde7f87d3` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/baseline/search-8.0.80` | 1 | 244,688 | `eac0c6438bd2d7c5bc66600824639741a7aeebb16c8604bc772123d5306b8284` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/baseline/search-8.0.80-voice` | 1 | 244,640 | `3df0e400b996ad3ed65be8d170e1027a342a806e1f0f5a1e3738b419ed4cda9d` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/baseline/search-legacy` | 1 | 244,640 | `2879479b5523b4b5d140d5acd5b75a59fc4eccf48a80b3624305fa1657fe846a` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/current/recovery` | 1 | 104,344 | `5258d0356fb0c453721489282397e13bc49bffda5fff550031f6dd684c8b225e` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/current/search-8.0.80` | 1 | 245,184 | `877869260538f5c2e052dfb7416bfb8359715c291972b5971aa6ab5837ee1c9d` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/current/search-8.0.80-voice` | 1 | 245,152 | `94383ecc8608c53136b1d36ef8ad5f22016c3eff5252f2995c47093b7b3a167c` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/prior-privacy/build/current/search-legacy` | 1 | 245,136 | `674e690f5800c25ef2996762dff379b95c90a3c33ac76fbc7981d084157ae256` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/regression/fixture-project/Tests/.DS_Store` | 1 | 8,196 | `dbd7d6e3eb30ddfa5eb26e6123e8b4e7b1cd19c151ecbc0e2af0f8e3f495b624` |
| `docs/audits/release-2.2-15-8080-compact-and-closefriend-reset/regression/fixture-project/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `897e761ad32a45f8cce0f9984749e023006047d18ca8015848d4be32fbfa88b4` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/__pycache__` | 2 | 49,695 | `66d60361c4140d5ebbed199500db728a5bc8b9f0ef33c1d1989f18935493e387` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/baseline-2.2-15/Controllers/.DS_Store` | 1 | 6,148 | `77879c4c8317f73ef9e55f52c1236d1be359dbd98dab4c15353ab11a920bae81` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/baseline-2.2-15/HeadersFile` | 42,142 | 53,227,892 | `5868141792da0d538a37b7d60c207e78eaad85a00ab23e66d544dc101345b1fc` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/baseline-git-status.z` | 1 | 16,501,595 | `77f7f5d8fc112b0deece861b806d38d626af8d59c464c9565105b3a3c8a1e595` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/final-git-status.z` | 1 | 16,634,007 | `7cbe57ab2d5609b04c12c16faf90fd0610cfb057d87196a45cb8fbd3451d443b` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/baseline/recovery` | 1 | 104,040 | `751d2c5cb28cb86f0f85e20d2879cac45dc5c04831be555335dfaf108b4cb8b5` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/baseline/search-8.0.80` | 1 | 244,688 | `26fba030fa1dd632f45db07337480ba1463638c53375c97fbf8b38c0c7962eb8` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/baseline/search-8.0.80-voice` | 1 | 244,640 | `ccc1b99fa30f3fbcccbd0ab4d3dafa147b3e9cfc6747540120163f3e8e200e7b` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/baseline/search-legacy` | 1 | 244,640 | `fec77048889d7aa35e41b9654797b2afcf69876e720dc760c1ceb4624ded5c21` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/current/recovery` | 1 | 104,344 | `c7f95d28a2ef47859cf81b723f990d8a968ef8d124cdf22246ff8eb77d4f167a` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/current/search-8.0.80` | 1 | 245,184 | `c40e64121fe025b813d790bc2d14d53ff69ef0e3633e313a297ef1b5177c339b` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/current/search-8.0.80-voice` | 1 | 245,152 | `3cae42b21e08c88f9af462296f41f1967a3a54682fe06376fb69d2a204fed48f` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/prior-privacy/build/current/search-legacy` | 1 | 245,136 | `95c9ace0e99dd2e934afbf7da7cc97b0272fd12b45a612651089a76968dfb8ac` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/regression/__pycache__` | 2 | 12,582 | `4693f2f6cef34105b2fc3d42fd70089f64e531bcf7e7d62b4949f02d62ec630f` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/regression/fixture-project/Tests/.DS_Store` | 1 | 8,196 | `c730f849f842a2103e07d502e1d439d6eaa8fc0eee91dd31b8d732b8f9da1cdb` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/regression/fixture-project/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `ad7dfc18b684bf7d2756713b9391ffc5e845aee4a42f40021d883247c369812a` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/remaining-regressions/__pycache__` | 1 | 11,455 | `4a3482f55400a02182cba25bb8cd9ec52a6f77925e7e1a0fe4fd72d73c4148e4` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/remaining-regressions/baseline-fixture/Tests/.DS_Store` | 1 | 8,196 | `d9056c6cb6934f53a83fc9a13994d0d43ddab72b5e1d47bf4171205daf470309` |
| `docs/audits/release-2.2-16-revert-closefriend-reset-and-quick-entry/remaining-regressions/baseline-fixture/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `ff69cc90c5c4e9da0df6583b021e4ef7be16a6dbc8fc894e00992bb4c691fcd9` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/__pycache__` | 1 | 27,593 | `2a84860651319e1f4feb33ffa76f7f32c04b90e43c8d50396002dafc408cb780` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/baseline-2.2-16/Controllers/.DS_Store` | 1 | 6,148 | `54ac4f4a6a3a470b2097ce7a57ff285b191120156937821bf5482c02094168ba` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/baseline-2.2-16/HeadersFile` | 42,142 | 53,227,892 | `a781d6559f1f456c05b558910fd8874ec15f871b1fc4a6cc683d40ff834efebc` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/baseline-git-status.z` | 1 | 540,653 | `24394d837cb8c332b69e06a31891c272fd3641cf6be90b3f0159ca1bc808d5d5` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/final-git-status.z` | 1 | 21,940,957 | `fbc7dd88b5ea12418299e87f1cbab9b821a1770362a86b08a754b292560582f4` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/pre-package-scope/final-git-status.z` | 1 | 21,850,550 | `64667d38837338651289be3968b96e50ec59f3485d2b7d37a0cfcee11be5a251` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/baseline/recovery` | 1 | 104,040 | `30389278a1af0cd2dc2620947992c644d327406a170157430fd5c27b6fffc2e3` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/baseline/search-8.0.80` | 1 | 244,688 | `b9e550913e5531c901e56b25df08db4543640cb53ac3d6ba087b6cebd9cc1433` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/baseline/search-8.0.80-voice` | 1 | 244,640 | `6d359b8d40f6f12a223fbcb7cbe3c9094b9bd8f555565ae0add7ab6dd9537eb5` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/baseline/search-legacy` | 1 | 244,640 | `7a795f26b01d6e7e9351326ff848d89a1e649814742ad84b7d265012a543443a` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/current/recovery` | 1 | 104,344 | `18aaaabb53d974aeda5587fac20e63984bc22da7878dbd32323c9b845551cfd4` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/current/search-8.0.80` | 1 | 245,184 | `a2d691505a23cfc81ec7db77a6457f40eae142c6544e71b030daa670b0a79b3f` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/current/search-8.0.80-voice` | 1 | 245,152 | `e551e204089f039946b3e0e1ceb27842feaa60476438c4a30662f19c0ba6d4a0` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/prior-privacy/build/current/search-legacy` | 1 | 245,136 | `f1b5450beb0ea7d307fca2a59e44dc2c5c2389715c0b2f5fe0147b4030d8fea8` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/regression/alerts-compatibility/fixture/Tests/.DS_Store` | 1 | 8,196 | `02466b92c4a3ce15c2103fdd48219c3e001e5581adef9f02b4258ee9996557d6` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/regression/alerts-compatibility/fixture/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `4f1b0f62d9fa5dc2986d6d83c0e76461934f17eda4a5d87bbb247e759db86d8d` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/regression/fixture-project/Tests/.DS_Store` | 1 | 8,196 | `78c1ed6515743391df4176f7bfe7bef2df8c77cc9d4f94f34e92b05391006b5c` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/regression/fixture-project/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `0771d90282ccc49b40751c29223897f83933ad90802d70ffc1dde65d9920fee3` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/fixture-project/Tests/.DS_Store` | 1 | 8,196 | `3292d9779464ec0285824a9a7aff9334c2bb812fbd400ba4a250601fadb14eaf` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/fixture-project/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `edfd92e69c6262f8b19c1cb937ca25751105a422d49e1b25cf5982806b2bcafd` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/baseline/recovery` | 1 | 104,040 | `863526f756630f2eb0d4766d1b1b4419e7a2128cf331c3cc1fbeef7161f2ae66` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/baseline/search-8.0.80` | 1 | 244,688 | `db5be1438c0dfa9893ab35e2f87961ebd7405071f8fc754664b7c92b549b6ae1` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/baseline/search-8.0.80-voice` | 1 | 244,640 | `6bca7431181d59d429b518a7bc936601fafb8d560506faaedcb21f1401513b82` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/baseline/search-legacy` | 1 | 244,640 | `babbb003755f6a92f14a3192923ccd624096f0deadab4d2783ee2fd45095c9ad` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/current/recovery` | 1 | 104,344 | `baff8830dbd094827c7f181f7d3fdd847c4464c6f49caf422fbea663797098b7` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/current/search-8.0.80` | 1 | 245,184 | `cff6c4e7d23e2016c6efc3b9d9d573763bcbc1d5334360ef6af6650ab48542c0` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/current/search-8.0.80-voice` | 1 | 245,152 | `254cead0271e39e2a30e34d246284b2e167bcad8ca8e4249bc3cd101a68adc2b` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/release-authorized-revalidation/prior-privacy/build/current/search-legacy` | 1 | 245,136 | `4645f7f6068b0192c8eec876b3802ff53d05133ebdd39e91c6f2e20d258312f1` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/remaining-regressions/baseline-fixture/Tests/.DS_Store` | 1 | 8,196 | `24d2614cadfe8c52c031a85cf89ffdbbeec642968e0f214794dbecb3389524f9` |
| `docs/audits/release-2.2-17-quick-entry-closefriend-reset/remaining-regressions/baseline-fixture/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `9fb0f5d1d10f83ddd59a32f6b697882603dc66c172db4c63bef5b12c67dc4f4c` |
| `docs/audits/release-2.2-18-settings-return-header-gap/__pycache__` | 1 | 27,529 | `6298739f8bad9335d7c7a7d2494e886c85168accf01325896b507a84c812cafe` |
| `docs/audits/release-2.2-18-settings-return-header-gap/baseline-2.2-17/Controllers/.DS_Store` | 1 | 6,148 | `d0288fab426958974f25c205c67ffd961f1e7ef2388177e32868b2ea003a774a` |
| `docs/audits/release-2.2-18-settings-return-header-gap/baseline-2.2-17/HeadersFile` | 42,142 | 53,227,892 | `dda253b21100a16caf7f102c0f512644165d0015059f4139c327746436369e15` |
| `docs/audits/release-2.2-18-settings-return-header-gap/baseline-git-status.z` | 1 | 26,849,115 | `8015c02c1b47921ab0a05ecb9e667224a1619409e60bae9316383424b0e29134` |
| `docs/audits/release-2.2-18-settings-return-header-gap/final-git-status.z` | 1 | 26,940,215 | `560c372cf18d58a8703e044931fc14f6f8898f2e8b456b358f78568b1f8c013d` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/__pycache__` | 1 | 12,618 | `fcfd111d0ea3b3195551058ad05981e9af9f3f9eab08086f46853c333d840b58` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/fixture-project/Tests/.DS_Store` | 1 | 8,196 | `b54e70891062caf88440adba699117a195ff171747bcd380bf9b9eb6502a45e4` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/fixture-project/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `87efa58da8d9ecba1825ce031ed30814ef5de1c7f3564c2c4576f1925ceb129e` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/baseline/recovery` | 1 | 104,040 | `dd4b195b83b45fc7f2e861f6854d092088445375996a9040cf9e2f226c2ee424` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/baseline/search-8.0.80` | 1 | 244,688 | `1212f27150ed21f0f659917ae6e7595942ef1e33d69178bc81d0074f80922d25` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/baseline/search-8.0.80-voice` | 1 | 244,640 | `b3f8b6a6573a0aad29f01e95d3bbc76ae0cba9fa57e96e6e9ea9ac39b4e07096` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/baseline/search-legacy` | 1 | 244,640 | `a5a383b166f3783816182b35459581ec8811d4d4fd2572f37ec42a6dfe257ee2` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/current/recovery` | 1 | 104,344 | `8542462c3d6ff5347a7b9352f15657cf11c16397569b574a3e169c2a7300b740` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/current/search-8.0.80` | 1 | 245,184 | `bbe2e03ad74b3fac78c3ec1b5feea1270af7b5f00071e55770ac4af120b6f951` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/current/search-8.0.80-voice` | 1 | 245,152 | `b7d2185626280b89742a26a5e8d9e86c6dc3cf0dbc70c9304c1b86b5bc16e26f` |
| `docs/audits/release-2.2-18-settings-return-header-gap/release-core-revalidation/prior-privacy/build/current/search-legacy` | 1 | 245,136 | `3cf13eee0bf41f718f7325c5397248e151f106685b3f09ab21ea877cd1b82d2e` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/baseline-2.2-18/Controllers/.DS_Store` | 1 | 6,148 | `349b196bfd222d1b6e7e9cb0ef323d6f96cc086badc011359c6f17410e34187f` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/baseline-2.2-18/HeadersFile` | 42,142 | 53,227,892 | `e8a3c2dfb6200e93762999f33192e23716a40c91d292ac92905de6441fc293e9` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/baseline-git-status.z` | 1 | 31,721,800 | `04e838706bae273e2f177a4e178069100668b67288956c35a62f8db4f6653b6f` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/final-git-status.z` | 1 | 31,836,901 | `5bf075c9aa402d13b41cdbee4e4f64b82372bc633ae888ad2c519802d95db84e` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/fixture-project/Tests/.DS_Store` | 1 | 8,196 | `eb67a5f0832fc01b0fe1f29e5c7641cce47f69f5ae63edb15ebf7fbbe2b86e44` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/fixture-project/Tests/MessageUIKit/.DS_Store` | 1 | 6,148 | `58dccb9533e4d5a5ca226a0dc0c38f2ba94d0315755198ca6feea7b57627a077` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/baseline/recovery` | 1 | 104,040 | `1bc68743081de22d24acfc6025d426a8922c5d73e411f3ced6360e8eaab83e06` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/baseline/search-8.0.80` | 1 | 244,688 | `d73365c9b184a4d3c511fe0881fc616599a0d3250801df39a49d6782efa2bff6` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/baseline/search-8.0.80-voice` | 1 | 244,640 | `cdba34786676f632c3ccedc1700be1308b0df2566449a5bd39878911fe89cbf9` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/baseline/search-legacy` | 1 | 244,640 | `1ed8c05f139ef5efb054f2fb19cc5c59d0e5a7024f89e1a82f7f1e201b50a84c` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/current/recovery` | 1 | 104,344 | `509c9f24c73180d9fba0967b2a778469816638fe19f291453c6ef5c86a4d9f91` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/current/search-8.0.80` | 1 | 245,184 | `263be61409e8cb8494a4d574aab716890052e51b69eae2df992caffc51a06c56` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/current/search-8.0.80-voice` | 1 | 245,152 | `5fb6f9a57ef01f129b328d118b92c285e8e46a938c554a8d89db990688f4d743` |
| `docs/audits/release-2.2-19-settings-subpage-tabbar/release-core-revalidation/prior-privacy/build/current/search-legacy` | 1 | 245,136 | `1f6b33973bdffd5b82b1addacea7413377a2ed07c02de85f163c1322afd8ce2a` |
| `docs/audits/session-groups-cpu-2026-11-03/__pycache__` | 2 | 22,894 | `86abdc0cd1b01afa5d4ccbf95e063ba75f6f04f11702d380f0d5ee866fc15198` |
| `docs/audits/session-groups-cpu-2026-11-03/baseline-2.2-7/Controllers/.DS_Store` | 1 | 6,148 | `8beeeb8068c86e37cb5e004cf4ae820a2f0e686403996291a4870fe24f1f3de1` |
| `docs/audits/session-groups-efficiency-2026-11-03/__pycache__` | 2 | 29,095 | `b22afe05d8e4b2652be353fc047530b6ae42eb991a575a3039bff9b34c5a3f5c` |
| `docs/audits/session-groups-efficiency-2026-11-03/initial-git-status.z` | 1 | 524,478 | `74d087bc9392e6c95a1a4d2a297ddf30564d9edd52422062a171b866da56e18b` |
| `docs/audits/session-groups-efficiency-2026-11-03/observation-validation/__pycache__` | 1 | 4,448 | `f161e4a2495686be7f05f73b37bccbe7e457618385d48a63f73b2ad994ee829f` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/final-git-status.z` | 1 | 524,478 | `cf17abb6a773d797c7624a54d713e4db6f461d703dba979839b1bd0dcc19b2ba` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/idle-confirmed/export` | 11 | 83,280,997 | `0b6e268f174c33d4566fdf99d227db18c355697efbe4ed221f92b26283532368` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/idle-confirmed/raw.trace` | 203 | 46,284,988 | `c0fcf7163e9eafe2e51c9d32ccceb6897668c4b80c2c383305e6fae531d88d77` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/idle/export` | 11 | 84,890,778 | `ba5988b88aac76715a883623e6b74720d60f4f02bdcc2110e51e69fe88a2a8cd` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/idle/raw.trace` | 208 | 68,404,014 | `caf940ed9d479b99130e15c5c0f9f8ce5771c963bf255cf96575ce3637eb9e0f` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/initial-git-status.z` | 1 | 523,122 | `994fd8f409a53fb8b491b0aedf98bf8d08917092767855f0bbd7b10d8bdd10f4` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/messages/export` | 11 | 115,965,150 | `21a0c685919cc7fa3fd4f2d328d9a0a73ff95103fac720b5d1795cf34c73eeb5` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/messages/raw.trace` | 203 | 64,226,236 | `12628e4878381b3fe5b6f6626872519a2e66d97d9aa6efee53dc14366de3b87c` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/review/__pycache__` | 1 | 28,789 | `e8acbfb8076072094b7a0a42cc141265eb6c7aa0119af0af798f68e6ff71930b` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/scroll/export` | 11 | 175,753,182 | `df1286c292ca361c259c00a17fe3de2c3d9d34fafa269278a6343b74d8f3c4b2` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/scroll/raw.trace` | 211 | 83,392,599 | `8c078d0f5af4ecca264fbc412a809a6a8ffdf51e6fbe01caf2b8ff2cda3dbad5` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/signposts/xcode-signpost-schemas.xml` | 1 | 3,205 | `67e0f88c712ef377b1e285647ff4a35303f4d841b18e7677e80a2c07245aec94` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/smoke-system/export` | 11 | 83,039,964 | `9e9fe10fea8c082fb1801d5cb7bab5c879f8eb7d08acc20bf3e5b7abeb98b451` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/smoke-system/raw.trace` | 198 | 39,708,020 | `b8021aa98f1c26c63a1aa461319940df27c7cb857ad5561c5c0680167f477c30` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/smoke/export` | 11 | 9,930,570 | `6448cbe9140dac4f9050c0999c1427a00479c6a106d93d843dc81015a3b8afb6` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/smoke/raw.trace` | 188 | 35,206,142 | `f34e5a0acfd1dd44df3ee7291009477c7ea65a0c4227725ddc708b6145134457` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/switch/export` | 11 | 156,635,597 | `e8b3515f53e3a07af5649969ecd5b30e20a75af23aa023797071384bc92e78ca` |
| `docs/audits/session-groups-instruments-2.2-9-2026-11-03/switch/raw.trace` | 198 | 69,605,016 | `267cfdb0e6d3120ed4c407b2f249204a3b28f8520fee8e1c4f6655171f133d61` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-commits.xml` | 1 | 3,289 | `eb487509ee807e000ce6b068962cffd5be9f33a0b93e3c7efe0d9072f6da1df5` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-cpu.xml` | 1 | 17,686 | `5f0ac49d110f959cb6851e30cb03daf9cabbe560f034ad362db3080e8122e448` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-fps.xml` | 1 | 2,769 | `206f64c0e1a5b3e8df6bef31f8c041012b59a91c2496792a52475524629565c7` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-frames.xml` | 1 | 206,518 | `578ce4179632d68ca1d5084963610a7f719ecf532db0af31766eaa811cefd00e` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-hitches.xml` | 1 | 1,010 | `9328a40a6ca077749edc488da8a43e9df9ad3fb99c3d97ea8c5ba5e8903e9f24` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-libraries.xml` | 1 | 1,361 | `c5929eff1ea3260ffd0d9fb8b2a486a8cddd6349e8994e86e413952c99c698ed` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-samples.xml` | 1 | 264,900 | `06a36b94cbf97f26f86f7510d55dc24b48f5ac29f2d86c0d10b5e554206e554c` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke-toc.xml` | 1 | 19,417 | `df682b22d7d1a8c90073ef80af2ab65752248a15f3ad8d4464420134f8ca90c7` |
| `docs/audits/session-groups-instruments-2026-11-03/capability-smoke.trace` | 562 | 132,755,812 | `204f24cd5e2a6e44d0862e13cb94cbf94682428fdf8db13a88d47e5005e73393` |
| `docs/audits/session-groups-instruments-2026-11-03/cpu-frames-capability-smoke.trace` | 164 | 10,290,298 | `45139ea2fbe8c64ae9ee5856dbee0220354cdbae6c3d9f2d053c73292dc74f20` |
| `docs/audits/session-groups-instruments-2026-11-03/idle/export` | 9 | 18,739,803 | `890da5765d628ad673fa893e9f901a90678b9263b91036184087128c20d97199` |
| `docs/audits/session-groups-instruments-2026-11-03/idle/raw.trace` | 164 | 47,225,279 | `7be9e27e7ed8d161aba030e14aefe1becd42d0e1cd2db24434b1fa8f0921286b` |
| `docs/audits/session-groups-instruments-2026-11-03/messages/export` | 9 | 3,039,731 | `b39a34a597778e1e281691d74e687ece767caf0c2b5643fbe5d1e6b72fbce89f` |
| `docs/audits/session-groups-instruments-2026-11-03/messages/raw.trace` | 163 | 48,890,773 | `0334c758d1ddafba0e72b64cf95e82c18205dbd93ed6bf693577891efae56738` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-commits.xml` | 1 | 2,798 | `76e7f10c64d6d687a48f4539fc653bfb926d74e5e2f6c7dcaa0547b16cb58a18` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-cpu.xml` | 1 | 1,668,720 | `8d6826dbe3d91e793bde802be841e0f888db56ff1f1eb79c9cd83f179a5d12e1` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-fps.xml` | 1 | 2,609 | `a1f19e0dcd674236ed6afa24ce318a441ea65e4e862266d6a199ef9fd5fee61c` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-libraries.xml` | 1 | 1,361 | `e13dd65bb5d1fa2010d758b80259466fdea712a3c97bb53cbadbd12195daf18a` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-lifetime.xml` | 1 | 406,736 | `859171f5f8fff8a66a1d666b45e2171c044ee15915ae7fe7015292a8f25ee038` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-sysmon-process.xml` | 1 | 2,489,475 | `cb8c850e76c68ad311772ad1b0a04dfce206ee06e8b1dd4620e8150a67a38604` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-thermal.xml` | 1 | 1,473 | `657ddb810d632aabbbcee70dc3c8f2b632ba65ba5b83cf7fcf710b3c44b55a96` |
| `docs/audits/session-groups-instruments-2026-11-03/offline-smoke/cpu-frames-capability-smoke-toc.xml` | 1 | 5,624 | `b79c7dcca17c04ecaadb99cec4c5c57ed7e95ddad826e9d334d6aebcf371dbae` |
| `docs/audits/session-groups-instruments-2026-11-03/scroll/export` | 9 | 5,655,357 | `97c82a4395e05e6494532c865251ec7f047e2f3cd96b9ec144378f9c62a60d6a` |
| `docs/audits/session-groups-instruments-2026-11-03/scroll/raw.trace` | 164 | 64,558,236 | `f341ea7c5e9a7f416f6010c0a67828b30e658503b04e88f90c06dd8f58d31dd3` |
| `docs/audits/session-groups-instruments-2026-11-03/switch-system/export` | 9 | 22,103,068 | `80ffa046eb62aa523dd1d9e6af119d1f440610464305c8d42d8d4d8b706fa9a5` |
| `docs/audits/session-groups-instruments-2026-11-03/switch-system/raw.trace` | 165 | 49,772,562 | `43dbbda7af15528c01bfc0018ddf971eb8280796acfd5b8a5fdf3c8b9d118c1b` |
| `docs/audits/session-groups-instruments-2026-11-03/system-cpu-capability-smoke.trace` | 90 | 10,173,726 | `9e2b737a414264d982e7a08858349d181ade6402b3d34f1e542533be146df196` |
| `docs/audits/session-groups-instruments-2026-11-03/targeted-compatible-smoke.trace` | 341 | 28,157,066 | `e9ae0c255033c2687a1566a66bdf9cec412f0f961723496646bf4ef84bec540d` |
| `docs/audits/session-groups-instruments-2026-11-03/targeted-cpu-frames-smoke-toc.xml` | 1 | 5,657 | `77b8049350eff9f70df618ab349b938bb016d0afc334652c4a314ed480142292` |
| `docs/audits/session-groups-instruments-2026-11-03/targeted-cpu-frames-smoke.trace` | 163 | 25,954,828 | `04dfd0aaf62668c79d0392dac154960092c41c38967d0771ef15177800f7fb4b` |
| `docs/audits/session-groups-interaction-2026-11-03/initial-git-status.z` | 1 | 523,110 | `7d861b4aefdb21e901f08757765c6654a585db7399e09e1071bc8731804d02b3` |
| `docs/audits/session-groups-quick-top-2026-11-05/baseline-2.2-11/HeadersFile` | 42,142 | 53,227,892 | `f04f2f2776f3143d599336579f6e933764fbd995bf4b3a53194094d00cff72de` |
| `docs/audits/session-groups-quick-top-2026-11-05/initial-status.z` | 1 | 536,790 | `8891e4ac80a87fd6e61eed8c90c79dc4eb7c881cc246462cfaa6b52a83de2a62` |
| `docs/audits/session-groups-scroll-position-2026-11-03/__pycache__` | 4 | 35,784 | `305c83c0240ca1b5058296807ac74e4ac0f2f1f6737c20adacccfb3fd3f5743a` |
| `docs/audits/session-groups-scroll-position-2026-11-03/baseline-2.2-10/Controllers/.DS_Store` | 1 | 6,148 | `12236ec0c2b15e42a4960c1c9313b1ceaf53ff81dfafa249f406661beae2945c` |
| `docs/audits/session-groups-scroll-position-2026-11-03/initial-git-status.z` | 1 | 523,165 | `baf47c49a224d9acebc39bc4a32d7d51c15f759ccb4149c8bd1ff333706ec959` |
| `docs/audits/session-groups-scroll-position-2026-11-03/sdk-validation/__pycache__` | 1 | 4,175 | `067ca99c5af072305431df2e04302c11041aa76c3f4a6e44e3f3cf80ce00c08b` |
| `docs/audits/wechat-8.0.80-2026-11-05/__pycache__` | 1 | 19,358 | `6b55af9b94cca1d38f4967791200cc27e64192dc419a1c73e3bd015011ca4705` |
| `docs/audits/wechat-8.0.80-2026-11-05/initial-git-status.z` | 1 | 537,365 | `6cd7424bb38ad29f09737c73a13cee2f0c202ed262275b5f7c7bf8601624086b` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/__pycache__` | 1 | 10,830 | `6f653abb972362710cf92b81038213dea574ddfefe89cd9aa2caab1a0123ec88` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/baseline/recovery` | 1 | 104,040 | `c9d58d162ea5fae2a57d95ed109721a3f1844546f600128054d4bda3f2b0019e` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/baseline/search-8.0.80` | 1 | 244,688 | `6719df3d7053db78dd554a2b21e6f82eff91ef824e8af877a7d98520e53f6dce` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/baseline/search-8.0.80-voice` | 1 | 244,640 | `32bdeff99ba11eb0fad6ad1f781c454f79308aa132dc9dd2fab21b8e2d97c27e` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/baseline/search-legacy` | 1 | 244,640 | `8547187baa92ad8dae39d706004bbbc7866f3e2d5bdde020bcb62c381d3546d0` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/current/recovery` | 1 | 104,344 | `6c21fd4e7f908e50d9e1906fc40ed1312c0addff52b15a8bb3d65b4d06947135` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/current/search-8.0.80` | 1 | 245,184 | `5eddd19a99d82138b643f87e6a21ea1fc6d9eccd9915f9cb1c878a6e8f85e295` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/current/search-8.0.80-voice` | 1 | 245,152 | `e9808f1a3c040dbc9a7f85a483600a4e3413ed5f6b8f20d12b2572b5888112e9` |
| `docs/audits/wechat-8.0.80-2026-11-05/privacy-validation/build/current/search-legacy` | 1 | 245,136 | `0ea1b5524e884bec6ac09b40d2ef18469423acbb9b54b4a9fdd263bb71c064ba` |

## 补充的编译缓存检查

按文件魔数再次扫描，另将 58 个散落在 red/green、ui-validation 等目录中的主机编译可执行文件移入同一外部归档的 additional-compiled-caches/。共 14572136 字节，移动前后逐 SHA256 一致。源码、断言、夹具、日志、provenance 和样本保留；具体清单见 additional-cache-cleanup.json。
