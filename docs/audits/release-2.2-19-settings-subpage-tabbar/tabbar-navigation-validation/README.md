# 2.2-19 导航政策红绿验证

这套新增 fixture 先在未修改的 2.2-18 生产上运行，再以完全相同 fixture 和 runner 运行修复后的生产代码。第一次两个编译预检目录 `red-2.2-18`、`red-final-2.2-18` 保留编译诊断，不当作有效红点；有效红点为 `red-runtime-2.2-18`（该路径的 runtime 指主机可执行文件，**不是微信/设备 runtime**）。

| 执行 | 编译退出码 | 运行退出码 | 断言通过 | 断言失败 | 样本 |
| --- | ---: | ---: | ---: | ---: | ---: |
| 未修改 2.2-18 | 0 | 1 | 83,400 | 18,000 | 49,200 |
| 修复后 2.2-19 | 0 | 0 | 101,400 | 0 | 49,200 |

50 条路由标签（44 个源继承表格后代 + 4 个 plain editor + 密友普通/快捷两个入口别名）× 样式开关 2 × 原生导航/独立 modal 2 × 构造路径 3，共 600 个场景。每场景做两轮进入退出；每轮记录根出现、push 起始、12 个 push 中间、push 完成、pop 起始/取消/重试、12 个 pop 中间、pop 完成、插件列表、退出到主界面与四 tab 来回。样本总数 49,200；构造前后属性断言和单 bar 计数断言使总断言数为 101,400。

红点具体抓住：每个 push-middle 阶段 600 个违规，共 7,200 个中途可见违规；push-complete 另有 600 个。进入前/返回后根列表样本原本就通过，因而只比首尾会漏。全阶段失败数见 `red-green-result.json`。

完整的生产单位快照位于每次执行的 `production/`：共享基类 h/m、两份包含 4 个 plain editor 的生产 m，以及根菜单、native host、密友manager、入口hook、底栏hook/adapter和Makefile。四个 getter 的抽取全文独立留档；旧版不存在时不伪造 getter，沿用主机 double 的 SDK默认 NO。编译命令、运行命令、所有生产文件运行前后哈希、fixture哈希与源路径在各次 `provenance.json`；全部样本在 `samples.json`。

| fixture / runner | 红与绿相同的 SHA256 |
| --- | --- |
| `NavigationTests.m` | `b93313555dc4e56bd51a3b6498ee7cedf72eaef9a794a516be87ce4522c6a5a1` |
| `UIKitDouble.m` | `a0cd0ea45ba52be65df66c6780ce64a116fd3b9fa2472d0dda2ffa0f8246d0d6` |
| `UIKit/UIKit.h` | `4f70098249dc129ab96fa6caf60145b2e4188c49c9001c2d997ab2a1cdde125b` |
| `run_validation.py` | `785c92ea050af51407123d618860e308c821064185f6d665de945e297ec1e2f9` |

## 模型与真机的边界

执行的是完整生产 `CSSettingsTableViewController.m` 与从 4 个 plain editor 原样抽取的属性 getter。其他目标类仅由真实 interface 继承链生成空实现，未运行其业务、菜单回调或原生导航。宿主根页的 YES 来自离线原生 init 反汇编，主机政策模型按原生 owner 的 destination/top 属性决策建立。每个样本均标 `host-policy-model; NOT device runtime`，`MMTabBar_runtime` 均为 UNAVAILABLE。frame `[0,803,393,49]` 是明确的主机输入，不是测得的设备 frame。

主机 `hidden/alpha/superview/window` 是模型对象状态，不是同名真实MMTabBar状态；转场copy是否存在也单列，避免只看livebar属性漏掉副本。样式开关只是模型输入，本测试没有运行样式adapter，不能证明真实图标、角标、选中态或点击事件。真机8阶段证据在上级 runtime-evidence 中明确 unavailable；视觉/手势/点击仍未验证。
