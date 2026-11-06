# 重置后重新设置密码：独立路径验证

冻结的未修改 2.2-16 原路径验证：**50 checks / 0 failures**。同一套测试在重置完成后的现有 Runtime，以及重新构造 Runtime 的加载路径，各执行 25 项检查。

随后在保留原 50 项断言的基础上新增快捷 Runtime 重置终态整链：同一最终 fixture 在冻结 2.2-16 跑红 **51 checks / 1 failure**（新增快捷 API 缺失，原 50 项全通过）；当前实现跑绿 **105 checks / 0 failures**。新增的同进程及重建 Runtime 两条分支先从已锁定保护状态取得 settings nonce，用真实 `prepareResetWithSettingsToken:error:` 与原 `resetWithToken:error:` 完成重置，再执行同一条原长按、发现、普通初始设密、锁解锁路径。

本测试先通过真实 Runtime 的普通密码 proof 和 `resetWithToken:` 完成真实 `CSCloseFriendReset` 全量清理；并非以手写空状态替代重置。随后执行从生产源逐字抽取的 `CSCustomViewController` 长按安装/touch/Began 处理和 `CSCloseFriendManager` 的 discovery、普通设置导航、authenticate、passwordPrompt 方法。EntryState、Reset、Runtime、Store、Crypto、Policy 全部直接编译生产 `.m` 文件。

断言覆盖：密文文件、policy/auth/bio/reset、发现记录均已删除；保护关闭且未 blocked；不存在旧 verifier 时原 2 秒长按可以发现“捉迷藏呀”；原普通入口显示“设置密友密码”并要求两次新密码；不进入生物识别；实际 `passwordPrompt` 写入新 verifier 并导航设置；新状态可正常 lock；旧密码不能解锁、新密码可以解锁。结论为原设置新密码路径可用，无需放开快捷页“修改密码”。

存储全部在 `TemporaryDirectory` 下及内存 secure 字典中；NSUserDefaults 使用独立随机测试 suite 的内存覆盖，不使用用户真实 Keychain 或配置。UIKit 对象为声明级 UI doubles，用于执行实际回调和观察分支，因此结果不证明真机手势识别时长、UI 转场或强杀 durability。

复跑：

```sh
python3 docs/audits/release-2.2-17-quick-entry-closefriend-reset/new-password-validation/run-validation.py docs/audits/release-2.2-17-quick-entry-closefriend-reset/baseline-2.2-16 baseline-2.2-16
python3 docs/audits/release-2.2-17-quick-entry-closefriend-reset/new-password-validation/run-validation.py . green
```

每轮保留生产源码 SHA256、测试/runner SHA256、编译命令、抽取的实际方法、编译和运行日志。初始基线成功日志在 `baseline-2.2-16/run.log`；最终同 fixture 红在 `red-quick-reset/run.log`，初次绿在 `green/run.log`，生产冻结后最终绿在 `green-release/run.log`，仍为 105/0。本套覆盖快捷 Runtime 重置后原有设密链；实际快捷页两级确认、取消、UI 令牌失效与中断恢复由另一套专用测试验证。
