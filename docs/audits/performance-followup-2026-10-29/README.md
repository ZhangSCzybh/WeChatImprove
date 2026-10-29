# 第二轮性能优化验证（2026-10-29）

本轮按已确认的 5 项热点，以及定时任务同步写盘、赞赏页展示监测两项进行改造。源码版本仍为 2.1-13；现有 `packages/2.1-13-performance` 是上一轮发布构建，本轮未重新打包或提交。

## 实现与保留边界

| 优化 | 最终行为与保护 |
| --- | --- |
| 折叠会话摘要 | 先读取排序元数据，按相同分组、去重和隐私规则选择候选，只格式化最终可见候选。每次刷新重新读取原生正文和名称；继续校验消息身份、账号 epoch 与隐私 revision。冷会话缺少排序时间时，仍可能读取其自己的末条消息，以保证排序准确。 |
| 消息手势 | 关闭时不创建适配器和 pan，不捕获消息上下文或更新气泡几何。共享观察者负责重新开启后的可见 cell；离屏 cell 在入窗后创建。关闭会取消拖动并恢复 transform，公共时间与合并生命周期继续运行。 |
| 列表圆角 | 同一次原生表格布局中的子 cell 几何修复合并到最外层表格布局结束。最终重新读取实际容器、颜色、遮罩和几何，并在几何修复后刷新折叠入口保护。独立 cell 布局、前台恢复、空列表背景与间隙恢复继续立即处理。 |
| AI 消息入口 | 用原子标量快照在原生回调之后、投递主队列之前排除未开启或未就绪状态。仅被 @ 才回复的群聊，普通未 @ 文字在正文与身份解析前返回；图片暂存、后续 @ 组合、local/server 别名与去重保留。原生 wrap 仍只在主线程读取。 |
| 字体与缩放 | getter 原子读取完整数值快照；Defaults 读取移至初始化和设置/恢复/激活通知。保留范围、默认值和原生 fallback。 |
| 定时任务持久化 | 串行后台队列处理文件读取、序列化、原子替换以及文件和目录 fsync；主线程读取不可变快照。claim 耐久成功后才校验并发送，finish 耐久后再释放当前执行状态。编辑、关闭、切号、过期和原生查询重入均可撤销待发资格；未知结果继续不自动重发。备份 preview/prepare 等待已接受的写入，并保留 revision 校验。 |
| 赞赏页监测 | 打开阶段保留 0.2 秒检查和 12 秒打开期限；展示后改为 2 秒兜底，正常返回由宿主生命周期和原生 End 回调处理。失活/后台停止展示检查，保留原生支付路线；激活时先确认实际页面，再判断打开超时。 |

## 核心回归

仅运行受影响的核心脚本。以下均通过；宿主模拟及合成文件测试不代表真机耗电或渲染测量。

| 脚本 | 检查结果 |
| --- | ---: |
| `Tests/verify-close-friend-session.sh` | 会话 148，展示 44 |
| `Tests/verify-group-selection.sh` | 30 |
| `Tests/verify-group-badges.sh` | 136 |
| `Tests/verify-list-corners.sh` | 1631 |
| `Tests/verify-message-gesture.sh` | 369 |
| `Tests/verify-message-time.sh` | 142 |
| `Tests/verify-layout-preferences.sh` | 10013，含热路径重复读取及并发发布断言 |
| `Tests/verify-ai-manager.sh` | 389 |
| `Tests/verify-ai-native.sh` | 86 |
| `Tests/verify-native-reward.sh` | 路线 54，展示 89 |
| `Tests/verify-scheduled-tasks.sh` | 102 |
| `Tests/verify-scheduled-task-manager.sh` | 2023，含阻塞 fsync 时的主线程响应断言 |
| `Tests/verify-scheduled-task-backup.sh` | 307 |
| `Tests/verify-close-friend-automation.sh` | 187 |
| `Tests/verify-ai-backup.sh` | 96，覆盖备份 facade 提取边界 |

新增关键回归验证最终候选的原生格式化次数、所有候选隐藏时零格式化、嵌套 table/cell 布局结束后的遮罩和保护恢复、手势拖动中关闭与重新开启、AI 关闭时消息零投递、图片组合与别名、支付页后台恢复、定时任务耐久后发送与末端重入，以及 pending write 对备份预览和恢复准备的影响。

## 完整构建

`make -j4 all SCHEME=rootless` 在全新临时构建目录执行，完成 arm64 与 arm64e 编译、链接和签名。`lipo -archs` 确认两种架构。没有执行 clean、package、安装或服务操作。

- [构建结果](build-result.json)：退出码 0，构建期间源码 SHA-256 未变；1292 个已有构建和安装包文件的内容全部保留。
- [完整构建日志](build.log)：已有弃用 API 与链接选项提示，未出现编译错误。
- [构建输入 SHA-256](source-sha256.json)：记录本轮编译的源码状态。

测试使用独立临时数据、专用偏好 suite 或内存替身，没有访问用户真实账号、消息数据库或设备。实际耗电、温度和帧率收益仍需在相同设备与使用场景下测量。
