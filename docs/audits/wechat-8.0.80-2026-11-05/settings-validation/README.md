# 插件设置页首帧与安全区独立复核

复核对象是完整生产 `Controllers/CSSettingsTableViewController.{h,m}`，以及所有插件设置表页的继承关系。测试没有恢复根 `Tests`，没有访问微信运行进程、手机、账号、数据库或持久设置。

## 复核结论

基类在初始化时设置 `edgesForExtendedLayout=UIRectEdgeNone`、禁止旧式自动滚动 inset，并关闭大标题；在首次加载表格时禁止 UIKit 自动 inset、清理临时 top inset。布局和安全区回调只增减底部安全区贡献，保留键盘/编辑器的额外 bottom inset，不重置后续滚动位置。

独立复核发现并修正一个首次加载边界：新表已经带有临时 `adjustedContentInset.top`、且 `contentOffset.y` 恰好为其负值时，只清 inset 会保留顶部空白。修改先捕获原 inset 和 offset；仅在初次加载原先贴顶、清理后 offset 仍为负时设 `y=0`，保留 x。已经滚动的位置、UIKit 同步做出的正向纠正、后续返回与负向回弹都保留。

`baseline-CSSettingsTableViewController.m` 保存该边界修正之前的基类。它在宿主可执行回归中失败于 `provisional.tableView.contentOffset.y==0`；生产修正通过同一场景。

## 路由范围

扫描 `Controllers/*.[hm]` 的 Objective-C 类声明，并递归核验继承：

- 38 个类直接继承 `CSSettingsTableViewController`，共 44 个设置表页后代，包括 AI 设置的选项、预设、历史和会话页。
- `CSCustomViewController.m` 中 33 个具体 CS 类分配目标均继承设置基类。密友入口通过 manager 进入的 `CSCloseFriendSettingsViewController` 同样覆盖。
- 备份预览、备份修复、定时任务编辑等嵌套表页已覆盖。
- 唯一保留直接 `UITableViewController` 父类的业务页是 `WEContactSelectViewController` 联系人选择器；本次有意保留其既有行为。
- 非表格编辑页继续使用自身的 `safeAreaLayoutGuide` 布局。

完整类名和源文件映射见 `route-coverage.json`；迁移头文件合集为 `MigratedHeaders.m`。

## 验证

运行：

```sh
python3 docs/audits/wechat-8.0.80-2026-11-05/settings-validation/run-validation.py
```

1. 使用实际 iPhoneOS 27.2 SDK，将生产基类编译为 iOS 15 最低版本的 arm64、arm64e 目标文件，启用 `-Wall -Wextra -Werror`，仅关闭 UIKit 旧 API 的弃用警告。两架构通过。
2. 使用实际 iOS UIKit 头文件编译迁移头文件合集，核验继承与类型。通过。
3. 使用实际生产基类全文，在宿主 Foundation + UIKit double 上执行 5,114 项生命周期检查。覆盖初始化时策略、初次加载、临时 inset、已滚动与负向回弹、返回不归零、横向 inset/offset 保留、键盘/编辑器额外 bottom、安全区反复变化不累积、super 生命周期和非插件表页隔离。通过。
4. 以三个仅在临时文件中修改的故障版本检查测试敏感度：重新扩展到导航栏下、丢弃 bottom 额外贡献、返回布局时归零 offset。三者均触发相应断言。

所有返回码、命令、输出、生产源码 SHA-256 及测试期间不变校验见 `result.json`。本目录的执行验证是宿主 UIKit double，不是 UIKit 原生导航动画或用户微信真机验收；实际 SDK 编译也不等于运行验收。
