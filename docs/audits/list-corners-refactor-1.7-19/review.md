# 列表圆角独立审查记录

## Task 1 初审

审查范围：`9c699587..52e888b9`。独立只读审查结论：Needs fixes；无 Critical，2 项 Important。

1. `CSListCornerMoreAdapter` 把零高度状态内容与普通分割线合并隐藏，存在收起后展开仍不可见的风险。应只对既有精确 UIView 分割线保留隐藏规则，状态内容可见性由原生管理，并覆盖零高度到展开的转换。
2. `CSListCornerPrepareTable` 的统一 enabled 退出改变了会话页关闭圆角时原有 appearance 背景与滚动条行为。按本轮兼容合同恢复 session appearance 的基线行为，关闭态 Cell 装饰仍必须零表格查询。

既有非圆角 Hook 编译警告与过时 linker 选项警告已记录，属于未改动源码的历史问题；本轮不为清理警告扩展修改范围。实机显示与启动待用户验收。

## Task 1 修复复审

`52e888b9..de6e8273`：两项均 ADDRESSED，无新增 Critical/Important。零高度/收起后展开及原生隐藏状态保留有生产适配器断言；关闭态会话准备有三项外观+零查询断言。新增14项检查先复现10项失败，修复后专项756项全部通过。Task 1规格与质量审查通过。

## Task 2 发布审查

审查 `de6e8273..b66a9dee`：规格与质量 Approved。直接核对 deb 元数据、payload、双架构符号、依赖/rpath及197个构建输入；无 Critical/Important。已有其他模块构建警告如实保留。

## 整分支最终审查

独立审查 `2aa7bcb8..b66a9dee`：Approved for device-acceptance delivery，无 Critical/Important，无需要扩大交付范围的 Minor。核对高度纯计算调用链、分组无效路径隔离、原生实际内容容器/侧滑坐标、配置兼容、两项修复和生产逻辑测试；复核197个构建输入哈希全部匹配。

实际包 SHA-256：`ce9a6d8ff8feed4e01f64c87bc1505d2745c006d3bb419816343edc61585e03b`。最终复制后再次校验一致，记录见 delivery-validation.json。分支保留且未合并；手机安装与验收由用户执行。
