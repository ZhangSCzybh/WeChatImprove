# 六处定义保护：修改前核对

基线 `58e0b0dfc611e14aa2d2f8e07c0f2ffb80a7ec6a`。定义起始到闭合大括号的原字节；不做空白、注释、换行或token归一化。六处快照均与 Git 基线和工作区一致，初始核对时生产文件差异为0。

| 版本／定义 | 字节数 | SHA256 |
| --- | --- | --- |
| 2.1-26 + (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller { | 1692 | `24e6cc06ede2f289ca83486198b56b0f1a929cd7bd7c6f8cf0a13a67a58241cf` |
| 2.1-27 - (void)refresh { | 12778 | `8e631a48ce5b9d3560484af0917ad6093e89993cce0e89f1b09dabf6793cf140` |
| 2.1-27 - (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous | 1835 | `ec8054e434786a5981548586cb72035a82fe3892ec7ffe6356e94372fa1484d7` |
| 2.1-28 - (void)performVisibleLayout:(void (^)(void))layout { | 2339 | `857e35c052dec406ff55fdafd34c61eed1a237f6ca5c85842a75002d9cb11a8e` |
| 2.1-29 static NSSet<NSString *> *CSGroupActiveSessionEventUserNames(id oldValue, id newValue) { | 637 | `7ccbd5145d809106721c7dda8bb35afc3938859cdcdc39c370f7299d70ce1d65` |
| 2.1-29 - (void)onActiveUsrNameChange:(id)oldName curUsrName:(id)newName { | 471 | `a3f7ba59223d7890216350e70f9a3c27676baa8259135ab57af2d27d7d5c84ee` |

验证命令：`python3 -B docs/audits/release-2.1-31-service-tab-and-scroll/verify-source-guards.py`。修改前原始结果保存在 `source-guard-initial-check.json`，构建前及最终验证将再次核对。
