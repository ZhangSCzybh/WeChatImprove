# 2.2-20 核心回归

本轮在当前生产工作树执行了82个未豁免原脚本和10套现代测试，共92个任务，全部退出0。10套中已包括37,152断言的header返回布局测试，不重复计数。底栏导航政策测试随后独立执行101,400断言，失败0。

`../CORE-REGRESSIONS.json`保存分项数字；`result.json`保存92个任务的命令、退出码、日志与临时隔离目录；`navigation.log`保存导航测试计数；`execution.json`保存临时执行树、命令、输入保护结果和输出清单。主机测试不能证明真机手势、转场、像素观感或Keychain行为。

原始100脚本仍为82通过、18失败。本轮没有重新运行这18个已知豁免脚本，也没有增加豁免。原始gate和WAIVER由发布审计单独保留，不能把本轮92任务通过写成100脚本全绿。

## 输入与生成物

`input-provenance.json`逐项保存325份既有fixture/runner的来源SHA。其中277份原始Tests来自恢复后的主树，与2.2-19保存的测试字节一致；其余现代测试及支持输入原字节保存于`inputs/`。没有修改测试断言、fixture或旧runner。新`run-core.py`只负责临时目录、生产根路径、2.2-20输出标签、执行和证据回收。

所有测试在`execution.json`所列项目外临时目录编译。二进制、临时测试应用和完整几何样本保留在该临时树，没有进入本审计。审计保留日志、JSON、输入哈希和必要的源码抽取证据。

## 复跑

在项目根目录执行，使用新的输出目录保护本轮结果：

```sh
python3 docs/audits/release-2.2-20-cleanup/release-core-revalidation/run-core.py --output /tmp/wechat-2220-replay-new/core
```

原privacy runner把`git show HEAD`用作历史负对照。本轮执行时HEAD仍为`a227b1677255fe0e2dc727dcc2e6f62386fc3afd`。提交后复跑时，新orchestrator仅为测试子进程创建项目外的私有Git元数据视图，HEAD固定到保存的历史commit，objects通过只读查询现有对象库；主工作树、HEAD、index、refs和用户Git配置均不变。生产代码仍从显式项目路径读取并在测试前后核对哈希，不会替换为历史生产代码。

`replay-orchestration-verification.json`验证此私有视图读取的五份负对照源码与显式历史commit逐字相同。旧runner与断言的字节保持不变；负对照版本也保持不变。若后续有意修改原Tests，需要单独更新测试来源流程；当前入口会因原字节保护拒绝执行。

本轮原结果不覆盖，后续复跑应在所选新输出目录检查`result.json`、`execution.json`和日志。
