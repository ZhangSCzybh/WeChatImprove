# 列表圆角第一阶段实施计划

**Goal:** 在 1.7-17 功能基础上抽取配置与无表格依赖的 section 高度规则，保留原生布局、分组代理和绘制行为。

**Architecture:** 配置模块只依赖 Foundation/CoreGraphics，集中现有键名、默认值和读取语义；高度模块仅接受值参数。原有 Hook 调用顺序、Cell 样式入口、分组首末行查询以及圆角渲染器保持原样。此阶段不引入配置缓存或行数缓存。

**Tech Stack:** Objective-C / Logos / Theos / macOS Foundation 回归 / arm64 和 arm64e iOS 编译。

**Spec:** `docs/audits/list-corners-native-2026-10-17/README.md`。用户已授权进行下一步，本任务在原 checkout 顺序执行，构建输出放独立临时目录；不替换用户已回退的安装包。

## 约束

- 不修改聊天分组、搜索表头、滚动偏移、代理、手势、原生内容布局和渲染器。
- 保留原来的键、数值范围、六套颜色及 RGBA 全零回退语义；历史非法值在设置显示和实际渲染中的不同回退规则也暂时保留。
- 配置读取无写入、通知或 UI 副作用；高度计算无 UITableView、block、delegate 或数据源参数。
- 保留全部八个高度回调中的一次 `%orig`，包括关闭功能时。
- 不改版本，不部署，不覆盖已有 1.7-17 包。隔离构建只用于验证，不是用户交付环境。

## 任务 1：配置兼容抽取

文件：新建 `Controllers/CSListCornerConfiguration.h/.m`；修改圆角 Hook 和设置控制器；新建 `Tests/ListCornerConfigurationTests.m`。

- [ ] 集中现有 30 个配置键和五个数值默认值，使用旧字符串；通过 NSUserDefaults 参数注入使测试不访问真实偏好。
- [ ] 实现五项数值读取、设置显示兼容读取及六项 RGBA 读取，接口返回 CGFloat 或值结构，不返回视图。
- [ ] 设置页的写入、校验、通知、重置和重启流程不变，只替换读取与常量来源。
- [ ] 用内存 defaults 替身验证缺省、合法边界、小数、零、负数、显式零间距、浅深色、全零及部分 RGBA，确认读操作不写配置。

## 任务 2：高度计算隔离

文件：新建 `Controllers/CSListCornerSectionPolicy.h/.m`；修改八个高度 Hook；新建 `Tests/ListCornerSectionTests.m` 和提取脚本。

- [ ] `CSListCornerSectionHeaderHeight(page, enabled, originalHeight, section, pinnedGap, normalGap)` 保留四页既有算法；`CSListCornerSectionFooterHeight(page, enabled, originalHeight)` 保留 0 / 0.01 页脚规则。
- [ ] 高度 Hook 在 `%orig` 后调用纯值规则；其他方法体逐个与变更前快照校验一致，配置辅助函数除外。
- [ ] 提取实际生产高度 Hook，把 `%orig` 替换为计数宿主方法；用禁止查询/刷新的表格替身测试启动期计算。
- [ ] 与 1.7-17 高度方法的冻结样本比较，覆盖开关、section、原始高度和两个间距的组合；在真实 CSGroupIndexScope 两种作用域下重复，验证不修改作用域。

## 任务 3：验证与交付

- [ ] 执行 `bash Tests/verify-list-corner-foundation.sh`。
- [ ] 执行现有 group-header、group-search、group-interactions、group-business、group-selection、group-viewport、my-page-clean 回归。
- [ ] 在临时 `_THEOS_LOCAL_DATA_DIR` 中从当前 checkout 执行完整 arm64/arm64e 构建，不运行 make clean、不安装、不覆盖 packages。
- [ ] 核验保护文件哈希、Hook 方法集合/未改方法体、共享库架构与未定义符号；记录实际结果及实机限制。

验收边界：主机回归和 iOS 编译可以证明本阶段值计算与接入兼容，不能证明微信真实 UIKit 渲染或手机启动已通过。四页布局迁移与缓存优化属于后续阶段。
