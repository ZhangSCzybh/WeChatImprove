# AI 自动回复清理与性能优化（2026-10-28）

用户反馈 `2.1-2` 和 `2.1-3` 都有发热，前台使用时更明显，后台只有轻微额外发热。本轮在原项目 `main` 上清理 AI 高频路径的无效工作，保留当前 `2.1-3` 版本及已有列表前台恢复等改动。没有访问设备、运行 Instruments 或采集温度、电池数据，因此下述确定的是源码工作量及主机替身结果，不能量化实际温降或排除其他功能、模型请求、屏幕和网络因素。

## 已落实的清理与优化

| 路径 | 优化前可确认的开销 | 本轮修改 |
| --- | --- | --- |
| AI 调用的授权检查 | 每次先清缓存，删除两个偏好键并 `synchronize`、打印日志；实时检查后再写两个键并 `synchronize`。缓存从未被用于返回授权结果 | 移除无效缓存字段、读写方法、无调用的清缓存 API 及该检查路径日志，保留每次实时检查和原有异常回退；旧偏好数据不主动删除 |
| 消息认领与历史保存 | 保存整份 plist 后，再整份编码／解码构造不可变状态，连未修改配置也替换成新对象，后续资格比较可能深遍历配置 | 只冻结外部传入的配置／历史记录；内部共享不可变配置、账本及历史分支，每次持久提交只编码一次，运行态更新保持配置对象身份 |
| 去重账本 | 每次认领都排序全部记录，即使没有超过 5,000 条上限 | 仅超过上限时排序淘汰；仍清理七天前身份，并在网络调用前持久认领 |
| 未开启 AI 的消息 | 总开关开着时，所有会话先读取 wrap、处理正文／@ 元数据，之后才在 coordinator 拒绝未启用会话 | 已知非空 session 未开启 AI 时在解析前返回；空／非字符串 session 保留原有 wrap 推导路径 |
| 群消息解析 | 每条群消息重新编译相同正则、建立相同分隔字符集；无 @ 列表的 msgsource 也启动 XML parser | 缓存不可变正则与字符集；正文无 @ 时跳过替换，msgsource 不含 `atuserlist` 时跳过 XML 解析 |
| 后台资格 | 配置无效或没有免 @ 群时也可能先调用实时授权与账号服务 | 先筛配置及候选群，再访问原生服务；保留账号 epoch、授权、音频和调用前重新检查 |

`Controllers/CSAI*` 和 `Hooks/AIReplyHooks.xm` 没有常驻逐消息 `NSLog/printf` 或调试轮询。本次清掉的是它们反复调用到的授权无效缓存及日志；没有为了“清理”删除实际使用的计时器、运行记录、测试时钟入口、原生 ABI 防御或账号保护。

## 保留的行为和成本

每条获准消息仍在请求模型前完成去重记录的文件 `fsync`、原子 `rename` 和目录 `fsync`；失败仍停止回复，保留提交不确定状态下的凭据引用保护。未改备份格式、记录上限、历史回复规则、@所有人排除、本人／非文本过滤、合并、并发、超时、手动回复并行及隐藏群正常回复。

后台音频保活和约 30 秒一次的原生全账号同步仍有固有能耗；后台同步只在后台音频实际有效且有合格免 @ 群时运行，前台停止。没有调长同步周期、减少必要的最终检查或关闭后台回复。原生同步的网络与数据库工作量、真实模型请求频率、消息量以及各模块的实际能耗占比需要设备测量。设置通知与详情页重建、队列重排和 NSURLSession 复用可继续分析，但本轮没有为了推测收益修改这些较敏感路径。

## 验证及交付

测试与采样仅使用临时目录和替身服务，不读写真实微信配置、Keychain 或数据库，不调用真实模型或发送微信消息。

### 操作计数与主机采样

基线固定为提交 `a445c24adee5653ce64f20fdbec3052b894a2067`。两版使用相同 schema-1 合成数据，省略基线不支持的 `allowUnmentioned` 字段；分别编译生产存储源码，用转发计数器调用真实系统接口。以下计数在小、大两种夹具中一致，范围是单次成功的消息认领或历史追加，不包含预置、加载及回读。

| 每次持久操作 | 基线 | 优化后 |
| --- | ---: | ---: |
| 整份状态 plist 编码 | 2 | 1 |
| 整份状态 plist 解码 | 1 | 0 |
| 文件 `fsync` | 1 | 1 |
| 目录 `fsync` | 1 | 1 |
| 未修改 configuration 对象身份 | 改变 | 保持 |

历史追加仍对外部传入的单条记录执行一次不可变深复制；零 plist 解码不代表零复制。两版都经过原生产路径的真实文件写入、原子替换及同步，且回读确认落盘值和 `0600` 权限。

大夹具包含 1,000 个会话、50 个预设、4,000 条去重身份和 200 条历史记录，共 178,546 字节。每版串行执行三轮，每轮 20 个认领／历史追加对，排除预热，记录数保持在 5,000 条淘汰阈值以下。按每次持久操作计算的主机中位数如下：

| 主机耗时 | 基线 | 优化后 |
| --- | ---: | ---: |
| user CPU | 5.3054 ms | 2.1947 ms |
| system CPU | 0.2120 ms | 0.1786 ms |
| wall | 5.5669 ms | 2.4310 ms |

上述结果包含仍保留的校验、编码及磁盘写入，只证明此 macOS 合成场景的工作量减少；主机负载、缓存状态和固定运行顺序均会影响时间，不能换算为 iPhone 温降或省电比例。授权成功路径另经静态对比和 67 项替身检查确认：实时原生查询仍为一次，`synchronize` 从两次降为零，无条件清缓存日志从一次降为零。

完整环境、原始计数、时间、源码及采样程序哈希见 [store-operation-counts.json](store-operation-counts.json)；复跑入口为 [store-operation-sample.py](store-operation-sample.py)，计数程序为 [StoreOperationSample.m](StoreOperationSample.m)，所用源码保存在 [source-snapshots](source-snapshots/)。

### 核心回归

| 命令 | 结果与重点 |
| --- | --- |
| `bash Tests/verify-authorization-read.sh` | 67 项通过；实时授权变化及异常回退保持，读取路径不访问偏好、不打印日志 |
| `bash Tests/verify-ai-foundation.sh` | StoreTests／AIClientTests 通过；可变输入隔离、不可变分支共享、5,000 条淘汰及七天过期、重复消息和写入失败保护 |
| `bash Tests/verify-ai-manager.sh` | 313 项通过；新增 1,000 条未启用会话消息在读取 wrap 身份前返回，覆盖空／非字符串 session 回退及完整回复链路 |
| `bash Tests/verify-ai-native.sh` | 82 项通过；复用解析规则及无 @ 列表路径，保留私聊、群聊 @／免 @、@所有人及详情开关行为 |
| `bash Tests/verify-ai-coordinator.sh` | 通过；开关、合并／并发、持久去重、账号切换与迟到回包规则 |
| `bash Tests/verify-ai-background-sync.sh` | 41 项通过；约 30 秒调度、前后台切换、音频资格及停止规则 |
| `bash Tests/verify-ai-backup.sh` | 54 项通过；备份／恢复、旧格式及事务保护 |

有明确计数的脚本合计 **557 项**，另有 foundation 和 coordinator 专项；全部通过。最终源码回归结果见 [test-results.json](test-results.json)，保留了 [manager](test-manager.log)、[coordinator](test-coordinator.log) 和 [后台同步](test-background-sync.log) 日志。`git diff --check` 通过。

### 安装包与完整性

版本保持工作目录现有的 **2.1-3**。本次包放在独立 `packages/2.1-3-ai-performance/`，请按设备环境选择此目录的新文件。

| 文件 | SHA-256 |
| --- | --- |
| [Rootless 安装包](../../../packages/2.1-3-ai-performance/com.wechat.improve_2.1-3_iphoneos-arm64.deb) | `4ae4bea8d0b550afb7992d4e93111e1123970c5c7087e84ff29843cfd7025cfe` |
| [Rootful 安装包](../../../packages/2.1-3-ai-performance/com.wechat.improve_2.1-3_iphoneos-arm.deb) | `284b259112c53d9e13482afb3886c2f72aeda1438308cdb0afb3d01eb26eead8` |
| [调试符号](../../../packages/2.1-3-ai-performance/com.wechat.improve_2.1-3_symbols.zip) | `502db9b0609af9762ebd911c83deb3959d2fd1b620b076d9d5b671a56a04de87` |

Rootless 和 Rootful 使用独立临时构建目录完成完整打包，均包含 `arm64 arm64e`，安装路径分别为 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` 和 `/Library/MobileSubstrate/DynamicLibraries/`。两个构建均无错误，保留 12 条既有警告，无新增警告。已核对版本、免 @／后台同步相关二进制标识、移除授权缓存标识、四份 dSYM UUID 以及符号 ZIP CRC。

构建前后 1,234 个既有 `.theos`／安装包文件哈希一致，编译输入期间未变化，没有清理或覆盖旧包。证据见 [build-environment.json](build-environment.json)、[source-sha256.json](source-sha256.json)、[protected-artifacts-before.json](protected-artifacts-before.json)、[packages.json](packages.json) 与 [delivery-verification.json](delivery-verification.json)；构建输出见 [Rootless 日志](build-rootless.log) 和 [Rootful 日志](build-rootful.log)。

### 真机待验

尚未安装到设备。安装后应在相同屏幕亮度、网络和消息量条件下对比前台发热；同时检查私聊、群聊 @、免 @ 以及免打扰群后台普通消息回复，确认重复消息不重复回复、关闭开关停止、切换账号不串回复。后台音频和原生同步的实际能耗、锁屏后消息到达及系统挂起仍需真机验证。
