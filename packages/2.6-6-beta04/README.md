# 2.6-6-beta04 朋友圈未读与互动修复

发布日期：2026-11-16。基于 `2.6-6-beta03` 的当前工作区和发布冻结源码修复，累积保留 beta03 的后台开销优化。当前用户环境为 **Rootless**，主安装包如下。

| 产物 | 内容 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-6-beta04_iphoneos-arm64.deb) | `iphoneos-arm64`；安装至 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-6-beta04_iphoneos-arm.deb) | `iphoneos-arm`；安装至 `/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 与本版 Rootful 包内动态库逐字节一致 |
| [调试符号](symbols.zip) | 两方案各含 arm64 / arm64e dSYM，共四份 |
| [SHA256 校验清单](SHA256SUMS) | 两个 deb、独立动态库与符号附件的校验值 |

两个安装包均含 **arm64 + arm64e，最低 iOS 15.0**。Debian 包版本、插件显示版本和内置更新说明均为 `2.6-6-beta04`。

## 修复内容

- **普通朋友圈消息正常已读**：将标记已读与清空、删除限制拆开。密友锁定且隐藏互动生效时，沿用原生消息页首项 localID 的读进度，只对该进度之前的可见未读调用微信原生精确批量已读。包含未加载的较旧普通消息；隐藏密友及关联密友消息保留未读，晚于页面读进度的新消息保留未读。
- **以真实读状态驱动提示**：向 `WCFacade.markMessageListRead:` 传递原生 `WCSNSMessage` 对象数组。写入前重新核对实际未读集合、账号 epoch、策略 revision 和消息身份；复用微信原生数据库计数、保存和通知链，不根据候选数伪造清零，也不额外重复发通知。解锁或关闭隐藏互动时保留原生已读路径。
- **统一未读展示**：同次展示共用可见未读快照；按原生 localID 降序选择首条可见消息和头像，限量查询在完整过滤后截断。发现页继续保留原生相关/共同好友分区；消息状态、账号或策略变化使缓存失效，包括同一次刷新内的策略变化。
- **隔离后台查询与界面缓存**：底层原生后台数据查询保持完整；隐藏状态下，后台调用的三个朋友圈界面提示 getter 返回安全的空值，不访问主线程展示缓存；非隐藏状态按原生返回。
- **明确删除认证**：锁定时在清空消息和评论删除入口请求认证；不保存或重放隐藏状态下捕获的删除动作、菜单或索引。解锁后重新发起操作，沿用原生删除流程，避免猜测投影索引造成错删。
- **恢复尾部行点击**：允许有效的原生加载更多行选择，并核对原始数组数量与逐项对象身份；同长度替换、重排或扩容后的旧坐标被拒绝。
- **补齐回归缺口**：新增整份生产互动适配器的 Hook 注册及行为回归；修复聊天未读面板测试缺失的完整来源协调器依赖，保持严格编译警告要求。

## 原生接口依据

已对本地微信 `8.0.80`、build `8.0.80.34` 静态核实：消息页 `viewDidAppear:` 调用 `markMessageAllRead`，页面原始首项为读进度锚点；原生全量已读还可能触发扩大范围的一致性回退，因此隐藏状态不放开该路径。

精确批量接口接收消息对象数组，经 manager 提取 ID 后写数据库，再读取真实未读数、保存并通知 facade。完整未读按 `m_localId DESC` 排序，`getLastUnReadMessage` 实际为 `LIMIT 1` 的首项。静态证据、方法地址、宿主身份和局部反汇编见 `.theos/release-2.6-6-beta04/native-contract/README.md`，该证据没有将宿主二进制加入安装包。

## 聚焦核心验证

| 验证 | 实际结果 |
| --- | --- |
| `bash Tests/verify-close-friend-interactions.sh` | **46 项通过**；整份生产适配器和真实 Hook 注册，覆盖精确已读、隐藏保留、localID 截止、新消息、写入失败、账号/策略、提示、缓存、认证及尾部行 |
| 同一互动回归读取 beta03 冻结源码 | 可编译，随后在普通消息未变已读的行为断言处按预期失败；证明捕获本次主故障 |
| `bash Tests/verify-close-friend-social.sh` | 通过；保留既有社交、缓存、归档、页面展示及新评论删除 Hook 回归 |
| `bash Tests/verify-close-friend-discovery.sh` | 通过；发现页计数、提醒分区和真实源记录保留 |
| `bash Tests/verify-close-friend-unread-panel.sh` | **90 项通过，0 失败；ABI 7 项通过，0 失败** |
| 未读面板 `--native-control` | 按预期退出 1；关闭 Hook 后 4 条核心安全断言失败，证明能检出缺失过滤和错误行选择 |
| `bash Tests/verify-close-friend-ios.sh --social` | arm64 / arm64e 社交源对象严格编译通过 |
| `bash Tests/verify-close-friend-ios.sh --unread-panel` | arm64 / arm64e adapter、hook 严格编译通过 |
| Rootless / Rootful 全量构建 | 两方案编译、链接、ldid 签名和打包成功；两方案双架构的互动适配器、评论适配器及更新说明确认重新编译 |

本轮聚焦朋友圈、密友互动和受影响的回归基础设施，没有重复运行未改动的后台与 AI 全量回归，也没有将 beta03 的历史测试数计入本轮实际执行数。

## 构建与产物核验

从当前工作区冻结 **42,936 个输入文件**到 `.theos/release-2.6-6-beta04/source/`，SHA256 核对后，以该同一快照和两个全新独立缓存构建。相对 beta03 冻结源码，变更仅涉及两个社交生产适配器、核心回归、版本和发布说明，共 14 个文件；后台与 AI 源码保持 beta03 内容。

Rootless 用时约 **17.2 秒**，Rootful 约 **16.6 秒**。完整核验通过真实 Debian 元数据、载荷及安装路径、注入 plist、arm64 / arm64e slices、最低系统版本、逐架构 SHA1/SHA256 CodeDirectory 页面及特殊槽哈希、四份 dSYM UUID、符号 ZIP CRC 和内容哈希、独立 dylib 一致性及全部附件 SHA256。

构建后 **42,936 个冻结输入 SHA256 不变**；已保全的 **21,081 个历史发布和构建文件**保持 SHA256、大小与修改时间不变，包括全部 53 个历史 packages 文件。两方案各保留 8 条既有工程警告，完整日志保存在本次独立构建目录中。未执行 `make clean`、安装、设备重启或 Git 提交。

复现构建命令：

```bash
make -C "$PWD/.theos/release-2.6-6-beta04/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootless PACKAGE_VERSION=2.6-6-beta04 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta04/rootless" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta04"

make -C "$PWD/.theos/release-2.6-6-beta04/source" package -j4 \
  THEOS=/Users/zhangshichao/theos SCHEME=rootful PACKAGE_VERSION=2.6-6-beta04 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-6-beta04/rootful" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-6-beta04"
```

实际命令、退出码及耗时见 `build-results.json`，最终核心检查见 `core-tests.json`，冻结来源见 `source-freeze.json`，产物核验见 `validation.json`，源码差异见 `beta04-changes.patch`；这些文件均位于 `.theos/release-2.6-6-beta04/`。

## 真机验收

本包尚未安装到手机，主机验证与静态接口核实不能代替手机验收。未连接、启动或修改用户的微信进程、账号和数据库。

在原 Rootless 环境重点检查：锁定时普通未读一次阅读后消失；混合消息中密友仍保留未读并在解锁后显示；阅读期间新消息不误清；返回发现页和底栏提示同步；清空及评论删除明确请求认证，解锁后新操作有效；加载更多正常。实际数据库持久性及设备交互仍待该环境确认。
