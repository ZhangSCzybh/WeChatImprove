# 2.2-17 回归准备与执行边界

本目录从 2.2-16 交付审计复制 277 个原始 Tests 文件，并与该目录保存的 git archive HEAD provenance 逐项 SHA256 对齐。没有恢复根 Tests，也没有修改旧 fixture 或断言。执行脚本的路径随新审计目录适配；实际生产源码仍读取当前工作树。

消息布局六套当前通过，共 1,048,295 项；生产 compact 无测试宏门槛通过，共 1,436 项，compact 2pt、normal 21/24pt。上述源码不属于本轮生产改动范围，run 结果及源码 provenance 已保存。

冻结 2.2-16 基线分别运行旧 rollback/migration 232 项与 quick-entry 90 项，均为零失败。这两套基线不是本轮新断言的红测试；本轮新红由实现负责人另行留档。

额外 73 脚本的 shell 及 95 个直接/动态测试源与 2.2-16 独立安全审查逐项 SHA256 一致，并重新执行 bash -n，均通过。它们使用独立 TMPDIR、Theos 三个临时目录和隔离数据源，不更改 HOME。安全通过不等于编译或行为断言通过；全量脚本及其基线失败输出必须保留。

构建脚本已准备，尚未执行。新版本包目录严格禁止覆盖；双方案构建在临时源码快照中，各自独立 _THEOS_LOCAL_DATA_DIR / THEOS_BUILD_DIR / THEOS_PACKAGE_DIR。警告基线为 2.2-16 实际交付日志，rootful/rootless × arm64/arm64e 各四条，unattributed 为零。

旧单手势断言 `avatar receives exactly one recognizer` 与已发布 2.2-16 双手势行为冲突，不会修改其断言或宣称它通过。用户对“任何一项失败不出包”的范围正在由主负责人澄清，构建保持等待。

全部观察仅来自宿主隔离夹具和实际 SDK 编译，无真机验证。
