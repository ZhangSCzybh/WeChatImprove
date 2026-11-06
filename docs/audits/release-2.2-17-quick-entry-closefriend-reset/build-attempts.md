# 两次正式构建证据

首次正式 make package 使用每方案 -j4，两方案均编译成功。警告 gate 在创建交付目录之前拦下：rootful 的同一旧 statusBarFrame 警告被按日志最后出现的编译标签归到 arm64，形成 arm64 +1 / arm64e −1；源文件 SHA 与冻结 .16 完全相同，文案和总重复次数没有变化。日志先连续打印同文件两个架构标记，再打印两条警告，归属存在歧义。初次日志和 warning-comparison 未覆盖，见 delivery-build/，定点行号见 warning-attribution-diagnosis.json。

第二次正式构建只把审计 runner 每方案内部改为 -j1，两个方案仍独立并行，日志位置在 delivery-build-final/。未改生产、旧警告基线、comparator、文案、测试或期望。两个方案均 exit0；arm64/arm64e 每方案各4条旧警告，新增0、unattributed0；17交付目录只由这次通过的快照创建。

正式快照42,522个构建输入与授权复验输入逐项相同。dylib直接取rootful deb，字节相同；两个deb都包含arm64/arm64e并实查Version2.2-17，dSYM UUID均核对。四项实际shasum校验与dpkg输出保存在artifact-verification.log。没有真机安装或验证。
