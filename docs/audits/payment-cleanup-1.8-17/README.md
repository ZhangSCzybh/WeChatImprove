# 1.8-17 支付模块清理

用户已确认 1.8-16 功能正常。本轮以实际交付源码为基线，整理转账及共用支付模块，保持生产行为。

## 清理内容

- CSFinish 的 stop 参数在全部生产和测试调用中恒为 YES；移除参数与不使用的分支，任务结束时仍清理原生逻辑。
- CSSend 的 BOOL 返回值在全部调用中均未使用；改为 void，保留发送前检查、原生 AddMsg 提交和异常保护。
- nextWakeAt:serial: 的 serial 参数在方法中未使用；改为 nextWakeAt:，唤醒时间计算保持原样。真正控制串行/并行的 nextAt:serial: 保持不变。
- CSPaymentErrorsOK 的 requireReturnCode 参数仅旧测试传 YES，生产一直传 NO；移除生产不使用的分支。缺省 retcode 仍按原生产语义处理，显式异常/非零错误码仍拒绝。同步调整原测试以验证实际生产语义。

## 调试代码检查

检查 CSPayment*、ReceiveTransferHooks、RedEnvelopHooks 及收款/红包设置代码，未发现 NSLog、os_log、printf/fprintf、DEBUG 分支或临时诊断开关。异常捕获和账号/交易/金额/状态校验属于运行保护，保留。测试中的断言与输出用于本地回归，Tests 和 docs/audits 均不在 Makefile 的插件源码列表中，保留以支持后续回归和追溯。

## 范围与验证

生产代码改动仅 CSPaymentAutomation.m、CSPaymentCore.h/.m，另同步原核心测试、版本及说明。转账和红包 Hook、设置、账本实现、语音及分组文件与 1.8-16 基线一致。

仅运行 Tests/verify-payment-core.sh，覆盖转账确认及最终状态、私聊/群聊回复、通知目标、记录落盘、重复回包、他人交易排除、开关/账号/超时、手动领取观察及共用支付逻辑的红包核心场景。结果见 core-tests.log。

构建使用独立 Theos 目录，未运行 make clean。版本为 1.8-17，Rootless，arm64/arm64e，iOS 15.0 编译目标。交付包、dSYM、源码保护及旧产物哈希核验见 verification.json。保留实际 1.8-16 源码快照 before-source.zip 和 baseline.json，不使用当前 Git HEAD 覆盖用户工作目录。

本轮没有访问真实微信数据、发起转账、发送消息或安装到设备。原设置、历史账本格式和数据保持原状。清理收益是减少遗留分支及维护负担，不宣称明显降低 CPU 或发热。
