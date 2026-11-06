# 2.2-16 既有回归与产物核验

全部回归使用新审计目录内的隔离副本；277 个原始 Tests 文件保持原字节，没有恢复根 Tests，没有修改旧断言。主机测试使用隔离状态、UIKit／微信边界夹具和实际生产模块；没有安装到真机。

| 范围 | 本次结果 | 证据 |
| --- | --- | --- |
| merge / bubble / 联合布局 / message time / gesture / attachment | 6 套通过，1,048,295 checks；联合布局覆盖 2,880 seam combinations | `legacy-result.json`、`legacy-summary.log` |
| 无测试宏的生产 compact 门槛联合测试 | .78 / .80 / .80.34 / 未知 .81 共 1,436 checks，0 failures；紧密 2pt，normal 21/24pt | `compact-result.json`、`../prior-compact/green-result.json` |
| 2.2-14 设置页顶部回归 | 当前 5,114 lifecycle checks；arm64/arm64e SDK 编译、头文件继承与路由检查通过；原有 4 项负对照仍按预期失败 | `../prior-settings/result.json` |
| 2.2-14 新底栏回归 | 几何、新旧原生模型、wrapper/selection/badge/hit-target/restoration 通过；点击效果 39 checks；arm64/arm64e SDK 编译通过 | `../prior-tabbar/validation-result.json`、`native.log` |
| 2.2-14 搜索密码和首页长按标题回归 | 当前 search 108 + 109 + 108、recovery 32，共 357 checks 通过；原 HEAD 负对照仍失败 | `../prior-privacy/results.json` |
| 2.2-14 Merge 版本门槛回归 | 三个版本各 17,566 native checks，policy 235,148 checks 通过；旧门槛负对照按预期拒绝 .80 | `../prior-merge/result.json` |
| 旧 close-friend 21 套原脚本 | **16 套通过，5 套编译失败**；已输出明确数字的通过断言合计 1,395，另有 contacts / discovery / social 行为与双架构编译通过，原脚本没有输出其检查总数，不推算 | `security-result.json`、`security-summary.log` |
| 最终 Runtime 源码定版后复跑 | Runtime 109、scheduling 9、biometric 99，共 217 checks 通过；全部 close-friend 实际 iOS SDK arm64/arm64e 对象再次编译通过 | `security-final-result.json` |

旧 21 套中的 5 项编译失败没有算成通过：

| 原脚本 | 本次失败 | 冻结 2.2-15 对照 | 分类 |
| --- | --- | --- | --- |
| alerts | 7 个编译错误 | 相同 7 个错误文案及重复次数 | 既有夹具缺少原生 session adapter 声明 |
| recovery | 7 个编译错误 | 相同 7 个错误文案及重复次数 | 既有夹具缺少 .14 recoveryTarget/window/navigationItem 等声明 |
| session | 到编译器 20 错误上限 | 相同错误多重集及相同上限 | 既有夹具缺少原生 session coordinator 声明 |
| unread-panel | 3 个编译错误 | 相同 3 个错误文案及重复次数 | 既有夹具缺少原生 session coordinator 声明 |
| entry | 新 tap 类型与字段未被旧夹具声明，编译器到 20 错误上限；state 子测试仍 45 checks 通过 | 冻结 .15 原脚本通过 state 45 + gesture 26 | 新功能增加第二个手势，旧夹具同时缺声明且包含旧行为不变量 |

冻结基线复跑明细在 `security-baseline-diagnosis.json`；原始失败日志和对应基线日志均保留。上述 4 项既有夹具未为本任务扩展，相关普通搜索／首页标题回归由现代 .14 privacy 夹具执行通过。

为 entry 单独增加了声明／链接兼容层，原断言和原 fixture 文件不变，实际生产手势方法及 Runtime 模块参与编译。UIKit 夹具仍真实记录长按和 tap 两个 recognizer，没有过滤 tap。编译成功后，**原断言真实失败于 `avatar receives exactly one recognizer`**：旧要求一个，本次明确要求两个共存。原程序遇该失败即停止，因此不能声称其后 25 项旧 gesture 断言已执行通过。该预期红见 `entry-compatibility/run.log`、`result.json`、`fixture-additions.diff`。五连击与长按共存、账号／页面／后台生命周期采用本次独立 quick-entry 测试覆盖，不能把它记作这套旧断言全绿。

双方案隔离构建成功，每方案均包含 arm64 / arm64e。警告按架构、源文件、完整文案和重复次数与 2.2-15 比较，新增数为 0。直接交付 dylib 与 rootful deb 内动态库字节一致，全部对象、selector、dSYM UUID 和两 deb 的 Version 已实查。literal `shasum` / `dpkg-deb` 输出在 `../artifact-verification.log`；构建证据在 `../delivery-build/`。

本报告没有声称真机已验证手势、UIKit 转场或最终气泡间距。
