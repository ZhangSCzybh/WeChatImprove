# 2.1-31 构建准备

构建脚本使用新建临时目录，不改变现有 `.theos`；不执行 `make clean`。双方案 rootful/rootless 均包含 arm64/arm64e。交付目录 `packages/2.1-31-service-tab-and-scroll/` 必须不存在或为空，拒绝覆盖已有包。

两方案先输出至临时构建目录的 packages/，仅在编译、警告、输入一致性和历史产物保护全部通过后，以独占创建方式写入新交付目录。失败的构建不会在交付目录留下单方案包。

构建前核对六个受保护定义、冻结的 1329 个 packages／.theos 文件以及 92 个历史包目录文件，全部逐字节硬核对，不设例外；构建前后全部生产输入 SHA256 必须相同。每方案警告必须与 2.1-30 的规范化多重集合完全相同（6 条）。已有用户 `.DS_Store` 改动保留、不还原、不提交；其任务开始哈希与构建前相同，未发生任务期间漂移，详见 `external-metadata-observed-before-build.json` 的核对更正。

验证包含双包元数据、前缀、完整 payload、每 slice 平台／部署目标／依赖、4 份 dSYM UUID、ZIP 字节和 SHA256SUMS。验证不代表真机安装或触摸／中间帧回归。

执行命令：

```sh
python3 -B docs/audits/release-2.1-31-service-tab-and-scroll/verify-source-guards.py
python3 -B docs/audits/release-2.1-31-service-tab-and-scroll/build-packages.py
python3 -B docs/audits/release-2.1-31-service-tab-and-scroll/verify-packages.py
```
