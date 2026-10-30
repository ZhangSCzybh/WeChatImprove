# 受保护完整定义的原始字节

任何本轮生产修改前，已从 `73e8e78ad5bbc87cb2b73bcf64ed8e0e9ac13f8e` 冻结当前完整定义字节。下表四组共六处定义，均与该提交逐字节一致；不做空白、注释或 token 归一化。

| 完整定义 | 来源 | 字节 | SHA-256 |
| --- | --- | ---: | --- |
| `+ (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller` | 2.1-26 | 1692 | `24e6cc06ede2f289ca83486198b56b0f1a929cd7bd7c6f8cf0a13a67a58241cf` |
| `- (void)refresh` | 2.1-27 | 12778 | `8e631a48ce5b9d3560484af0917ad6093e89993cce0e89f1b09dabf6793cf140` |
| `- (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous` | 2.1-27 | 1835 | `ec8054e434786a5981548586cb72035a82fe3892ec7ffe6356e94372fa1484d7` |
| `- (void)performVisibleLayout:(void (^)(void))layout` | 2.1-28 | 2339 | `857e35c052dec406ff55fdafd34c61eed1a237f6ca5c85842a75002d9cb11a8e` |
| `static NSSet<NSString *> *CSGroupActiveSessionEventUserNames(id oldValue, id newValue)` | 2.1-29 | 637 | `7ccbd5145d809106721c7dda8bb35afc3938859cdcdc39c370f7299d70ce1d65` |
| `- (void)onActiveUsrNameChange:(id)oldName curUsrName:(id)newName` | 2.1-29 | 471 | `a3f7ba59223d7890216350e70f9a3c27676baa8259135ab57af2d27d7d5c84ee` |

生产输入 42513 份，现有 packages 文件 88 份，packages／.theos 共 1325 份均已保存原始 SHA-256。警告基线为 2.1-29，每方案 6 条，后续须完整多重集合一致。

本阶段只冻结文件和准备审计，不代表已修复、已构建或真机验证。没有运行／安装／附加微信或修改用户环境与数据。
