# 原生聊天分组隔离验证

这些验证不启动或切换服务，不连接微信进程，不读写真实账号数据或数据库。可执行文件、提取后的源码和宿主替身均在系统临时目录生成，结束时删除；`NSUserDefaults` 在测试进程中替换为内存字典。

在项目根目录运行：

```sh
bash docs/audits/session-groups-native-2026-11-03/validation/run-native-behavior.sh
bash docs/audits/session-groups-native-2026-11-03/validation/run-unread-panel.sh
```

需要 macOS、Xcode Command Line Tools、Python 3。编译使用 ARC、blocks 和 `-Wall -Wextra -Werror`。未读面板同时运行正常签名和不支持 ABI 两种宿主场景。

`run-native-behavior.sh` 直接编译当前生产模型、协调器、桥接、投影、偏好和策略实现。适配器方法与转发枚举替换体从当前生产文件提取，保留其实际表达式；不可用的 UIKit、微信宿主和调度器由替身提供。

主要行为覆盖：

- 原生会话对象与顺序保持，全部源和缓存包装对象的同名身份校验，分组间切换恢复完整基线及原生几何信息。
- 完整来源的未读统计，过滤不在完整原生呈现中的隐藏记录及折叠、服务容器子项，密友隐藏先于分组和计数。
- 账号、epoch、策略、对象身份变化时关闭发布；原生字段写入中的同步回调不会读取半更新列表。
- Session 与 Forward 独立的完整源作用域、嵌套规则、异常恢复、原生惰性枚举的作用域内物化、作用域恢复通知后的再次验证。
- 发布 setter 中发生真实原生更新时，旧快照不能重新开放；最多三次自动重建仍冲突时保持关闭且不自旋，后台线程真实事件及静默账号、epoch、manager 变化均可恢复；原生 original 内的正常嵌套更新不会误报为发布冲突。
- 主列表保留原生 datasource、delegate、prefetch；不明路径或匿名业务项缺乏可靠映射时遮蔽展示。
- 80 ms 尾随与 250 ms 最大等待的调度窗口、嵌套批量变更、暂停和发布中的延后请求、同步重入请求及无脏状态时不产生额外工作；布局、reload 和 layoutIfNeeded 引入的新隐私事件保留到下一轮，并保持遮蔽和立即优先处理。

`run-unread-panel.sh` 只将基线提交 `863bfdb350fddf678c349574d99badb241d98958` 中原有未读面板 fixture 导出到临时目录，不恢复已删除的 `Tests/`。它执行当前生产桥接与联系人表面辅助函数、完整未读面板适配器及其 hook 注册。完整源包装器在此套中是可控制的边界替身，用于验证“原生 rebuild 已运行但完整源被拒绝”以及“原生 rebuild 未运行”的遮蔽和点击拒绝；包装器真实实现由 native 套验证。

记录当前源码对应的正式结果：

```sh
python3 docs/audits/session-groups-native-2026-11-03/validation/record-validation.py
```

该命令重新运行两套验证，将输出写入 `.sh.log`，并生成 `behavior-result.json`。报告包含生产文件 SHA-256，且必须满足 `source_unchanged_during_checks: true` 和所有 runner 的 `exit_code: 0`；执行期间若源码发生修改，需重新录制。`legacy-core-result.json` 与 `verify-group-*.sh.log` 是其他基础验证的记录。

这些测试验证生产算法及安全边界，宿主替身不能证明私有微信 ABI 在设备上的实际表现。最终还需使用交付构建在真实设备验收分组切换、新消息、隐藏/解锁、折叠置顶、转发候选和未读面板流程。
