# AI 凭据异步读取验证

生产入口为 `CSAIReadCredentialAsync`，返回独立的 `CSAICancellable` reader。注册表由锁保护，Keychain 系统调用在专用串行 worker 上执行，因此首个系统调用被阻塞时，同账号与同 revision 的后续读取仍能加入同一 flight。只合并正在执行或等候主线程交付的读取；交付时删除 flight，不保存明文结果缓存。

Coordinator 把凭据等待纳入已有 active slot、批次 phase、generation、配置和 60 秒共享期限。读取完成后重新校验；inline completion 不会覆盖后续网络任务的取消所有权。Manager 在回调主线程后再次校验 store、coordinator、账号、epoch 和完整配置。

连接测试使用单一 operation 跨越凭据读取和网络生成，整体 60 秒期限包含读取等待。取消或超时先结束本 operation，再取消其子任务；旧 phase 的成功/失败回调不会发送请求、验证旧连接或恢复已失效任务。

## 隔离行为检查

| 命令 | 结果 | 日志 |
| --- | --- | --- |
| `bash Tests/verify-ai-credentials.sh` | 30 checks；7 次 stub read；主线程 0 次系统读取 | `ai-credentials.log` |
| `bash Tests/verify-ai-coordinator.sh` | 4,496 checks passed | `ai-coordinator.log` |
| `bash Tests/verify-ai-manager.sh` | 490 checks passed | `ai-manager.log` |
| `bash Tests/verify-ai-foundation.sh` | Store 与 Client 全部通过 | `ai-foundation.log` |
| `git diff --check -- <本子任务源码与测试>` | 通过 | 本次终端结果 |

生产 coalescer 单测替换真实 `SecItemCopyMatching`，在首次底层读取阻塞期间加入第二、第三个同 slot reader，并验证仅发生一次底层读取。另测不同账号/revision 不合并、单个 reader 取消不影响其他 reader、每个 completion 主线程且至多一次、失败共享与重试、完成后再次读取不使用缓存、非法 revision 不进入 backend、后台注册/取消仍回主线程。

Coordinator/Manager 新回归覆盖延迟读取期间不发送模型请求、恢复后只发送一次、取消和同步重入、改 Key/配置、切号/epoch、定时器超时与 timer 尚未执行的 deadline 到期、旧批次/旧 phase 迟到成功不影响新任务，及正常读取后 outer token 仍能取消网络子任务。既有图像、持久化、alias claim、授权及 native 最终发送校验继续通过。

没有访问真实 Keychain、微信账号、用户消息或模型网络。Keychain 的同步系统调用开始后不能被中断；取消会立即撤销该 reader 的交付，调用返回后的明文仅临时用于交付尚有效的其他 reader。双方案/双架构最终构建由主任务统一执行，本子任务不打全包、不修改版本、不提交 Git。
