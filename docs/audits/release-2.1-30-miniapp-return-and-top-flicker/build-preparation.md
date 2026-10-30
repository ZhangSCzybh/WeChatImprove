# 2.1-30 构建准备

本目录脚本已准备，尚未执行构建。不得在版本、最终生产修复和要求的红绿证据就绪前执行。

```sh
python3 -B docs/audits/release-2.1-30-miniapp-return-and-top-flicker/verify-source-guards.py
python3 -B docs/audits/release-2.1-30-miniapp-return-and-top-flicker/build-packages.py
python3 -B docs/audits/release-2.1-30-miniapp-return-and-top-flicker/verify-packages.py
```

构建为 rootful/rootless 各创建独立临时目录，arm64/arm64e，保持现有 .theos 与全部历史 packages 原字节；不执行 make clean。交付目录 packages/2.1-30-miniapp-return-and-top-flicker/ 必须不存在或为空，脚本拒绝覆盖已有产物。

构建前强制检查四组共六处完整保护定义及任务开始时1325个 packages／.theos 文件；构建前后输入 hash 必须一致。每方案警告须与2.1-29完整规范化多重集合相同（6条），不只比较数量。

包验证检查双包版本、前缀、完整 payload、arm64/arm64e、每slice平台/部署版本/依赖、4份dSYM UUID及归档字节，生成符号ZIP与SHA256SUMS；已有交付文件只接受相同字节，不替换为不同字节。设备安装、运行与帧计数均不由脚本执行或证明。
