# 2.2-16：回滚无密码重置与头像五击设置入口

本次基线是当前未提交的 2.2-15 工作树，完整冻结在 `baseline-2.2-15/`；2.2-14 的准确副本使用上次审计保留的 `baseline-2.2-14/`。不使用 HEAD 重新构造基线，不提交，不执行 reset / checkout / stash / make clean，不覆盖历史安装包。项目为 Objective-C / Logos / Theos 微信插件，没有启动服务、切换端口或用户数据库。所有测试使用隔离临时数据，未访问真实微信账号或系统 Keychain。

## 回滚范围与来源

Reset.h/m、Runtime.h/m、Manager.m、Bridge.m 六文件先按真实 .15 → .14 diff 全部还原，六项回滚阶段 SHA-256 均与准确 .14 一致，见 [精确回滚 SHA 对照](rollback-validation/exact-rollback-sha256.json)。随后只叠加必要残留清理和新的设置页授权，最终 SHA 不等于 .14 的文件必须据实单列，不能把有新实现的文件报成逐字节恢复。

无密码重置的公开 API、私有状态、两个静态 intent/marker 工厂、密码框“忘记密码”、账号确认/风险确认/自动设密流程均撤回。.15 应用内说明只保留气泡紧密修复；.16 说明告知回滚与新快捷入口风险。.15 专用 reset-validation 及孤立 review-reset.md 共 60 文件已实际删除，旧断言不保留为跳过、注释或死测试；删除路径、大小和 SHA 清单见 [删除清单](rollback-validation/removed-2.2-15-credential-tests-manifest.json)。冻结历史生产源码只作为 provenance，不参与当前构建。

## 残留 Keychain 数据与兼容

.15 可能留下：

| account-scoped kind | 可能的值/状态 |
| --- | --- |
| `reset` | UTF8 `close-friends-credential-reset-v1`；可能先于 marker 写入时中断。 |
| `credential-reset` | UTF8 `close-friends-credential-setup-v1`；也可能损坏。 |
| `auth` | 旧 auth 仍在、已删除，或新 auth 已持久化但 marker 尚未删除。 |
| `biometric-domain` | 仍在或已删除。 |
| `policy`、名单 state、discovery | 原 .15 凭据重置没有清理这些数据。 |

Manager 的正常账号加载边界直接删除当前账号的 retired `credential-reset` kind，不读取或解释其值，也不再写入。Reset.resume 对 reset 槽只精确识别已废弃的 `close-friends-credential-reset-v1`，删除它后继续；不继续执行旧凭据删除，也不创建新密码。删除失败不变成 pending 或错误弹窗，后续加载幂等重试，不能声称系统拒绝删除时已经清除。

真正 `close-friends-reset-v1` 的完整重置仍严格；未知 intent、读取错误或真正整组清理失败仍阻断，绝不以兼容为由吞掉。现存 auth、生物识别、名单、选项与其他账号不被兼容过程改写。已删除的 verifier 无法凭空恢复；有 state 但无 auth 时，普通认证保持原 .14 fail closed，由新的独立设置页访问能力提供读取/编辑，不伪造密码认证。

详见 [迁移调查与红绿验证](rollback-validation/FINDINGS.md)。

## 头像五击与设置页权限

只在插件主设置页的头像安装单击识别器。每次 Ended 读取单调 uptime，相邻点击间隔超过 0.8 秒或时钟倒退就重置序列，第五次立刻触发风险确认。没有 dispatch_after 凑次数，也没有定时器轮询。

单击 recognizer 显式 require 原两秒长按 recognizer fail：短按在抬手时长按即可失败并交付单击；长按成功时单击不能成功，且原长按 Began 清五击计数。两者只在头像上共存。微信首页标题恢复手势不作改动，另有原字节哈希对照。

确认后以当前账号/epoch 的内存 visit nonce 进入设置；它与密码认证 token 分开，不能用于密码认证、显示聊天列表或整组重置。进入/离开不改 revealUntil、锁定状态或解锁计时器，不写“已通过连点”的偏好/Keychain。新 grant 不依赖缺失 auth 状态下的普通 authenticationToken；损坏 state/凭据读取失败、未知真 reset 则不能获得 grant。

访问范围为密友设置页及其现有原生名单选择器子流程。返回插件主页、关闭或替换密友页、进后台、切账号、原 owner 在 picker 显示时从栈移除均撤销，旧 token 即使复制保存也无效。正常的原生名单选择器是本次设置流程的子操作，临时显示它不算另开一次访问。回来后从插件主页再进入仍需新的五击。

普通入口与原密码验证不放宽。快捷页可显式编辑名单和保护选项；修改密码与整组重置继续要求原凭据。进入本身不改变聊天列表隐藏；用户主动修改保护选项则按其选择改变规则。读取检查外部账号 epoch 与 suspension，保存须在账号 epoch 锁内复核，覆盖原生切号已发生而主线程通知尚未送达的窗口。

## 安全告知

这条入口完全不验证身份。任何能操作已解锁手机的人均可五击头像、确认后查看和修改当前账号的名单与保护选项；因此独立密码不再构成名单/选项的访问边界。五击位置隐蔽不能作为缓解措施。确认框、设置页页脚、应用内发布说明和主 README 都明示风险；确认只用于知情与防误触，不能阻止有意访问。普通密码校验/整组重置门禁仍在，但不能据此声称名单安全性未削弱。

## 已完成的验证

回滚迁移新增断言先在 frozen .15 跑红：232 项、39 失败；相同 fixture 转绿为 232 项、0 失败，测试与 runner 哈希完全相同。最终 Runtime 冻结后再次执行 `rollback-validation/green-release/`，仍为 232 项、0 失败，provenance 对应最终源 SHA。覆盖旧 intent 先于 marker、auth/bio 各中断状态、非阻塞 cleanup 重试、真 reset 严格语义、无残留正常密码门禁、另一个账号完整 key 集和字节不变。

头像快捷入口相同 fixture：冻结 .15 为 40 检查、12 失败；当前为 90 检查、0 失败。检查总数差异来自旧版缺少入口/API 后受依赖的后续分支无法执行，fixture 字节相同；没有把红、绿数字硬凑成同一总数，详见 [快捷入口验证](quick-entry-validation/FINDINGS.md)。最终源经 [独立只读复核](review-quick-entry.md)。

既有消息布局 1,048,295 项通过（含 2,880 seam 组合 / 744,926 联合断言）；真实生产版本门槛 compact 1,436 项通过，.78/.80/.80.34 与未知 .81 均保留原断言。compact 2pt、normal 21/24pt 来自受控主机几何，不是手机测量。原 277 个回归 fixture 字节保持，不还原到根 Tests；上一轮 fixture 复制到本次目录执行以免覆盖旧证据。

## 按原样回滚范围交付的入口限制

若已装 .15、auth 确实缺失，同时原配置 `hidePluginEntry=YES`，完全恢复 .14 Bridge 后内建插件入口会在打开根页前被隐藏，头像不可达。单独清 marker 并不能解决这个 UI 路径。本次按用户明确要求保持 Bridge 逐字节 .14；没有在未获答复时擅自加入扩大根入口可见性的例外。因此，本版保证退休 marker/intent 本身不阻塞加载，但不能保证这个“已丢失 auth + 隐藏插件入口”的组合可从原内建 UI 进入。已删除的 verifier 不会被重建；这个入口限制没有解决，不能把已创建根页的主机测试当成内建入口可达的证明。

真机手势、UIKit 转场、iOS Keychain 实际行为、聊天间距和其他注入插件组合均 **未验证**。

## 逐文件回滚对照

六文件在回滚阶段均逐字节等于 .14。最终 Reset.h、Bridge.m 仍等于 .14；Reset.m、Manager.m 因必需的残留兼容不同；Runtime.h/m 因新增独立页面权限不同。完整 .15/.14/.16 SHA256 与增删行数见 [最终 SHA 与行数](rollback-final-sha256-and-lines.json)。应用内发布说明保留 .15 紧密气泡条目，并新增 .16 说明，因此不能要求它等于 .14。

## 构建和交付

[构建记录](delivery-build/build-result.json) 保存两种 scheme 的完整命令、三个独立临时 Theos 路径、冻结源码 SHA、实际编译对象与最终 dylib 的验证。rootless / rootful 都实际完成 make package，均包含 arm64 / arm64e。独立重签 dylib 直接提取 rootful deb 内的文件，SHA256 `280d50c2cfc93f12194803c1d5f7f6b620143a139ece8f9f5fdd61ba7e09e08f`，未再次修改二进制。四组 scheme/架构的 dSYM UUID 与对应薄 dylib 匹配。

[警告多重集比较](delivery-build/warning-comparison.json) 使用 .15 实际 delivery-build 日志，保留 source、architecture、完整诊断及次数，只去行列和 ANSI。每种 scheme 的既有 warning 为 8（每架构 4），当前同为 8，新增 **0**，未归因警告为 0。

[实际产物验证日志](artifact-verification.log)：

```text
$ shasum -a 256 -c SHA256SUMS
WeChatImprove.dylib: OK
com.wechat.improve_2.2-16_iphoneos-arm.deb: OK
com.wechat.improve_2.2-16_iphoneos-arm64.deb: OK
com.wechat.improve_2.2-16_symbols.zip: OK
```

两 deb 均通过 dpkg-deb 实查：Version `2.2-16`，Architecture 分别为 `iphoneos-arm` / `iphoneos-arm64`。没有安装到手机，也没有修改 IPA 原文件。

## 既有测试的实际边界

.14 四项回归脚本均通过：设置生命周期 5,114 项，搜索 legacy / 8.0.80 / voice 三变体及首页长按恢复通过，底栏 arm64 / arm64e 编译与几何通过，Merge 三版本与生产门槛通过。详见 [四项回归原输出](regression/prior-result.json)。不能把用例中的预期 negative/baseline 红输出错报为当前失败。

密友原 21 套脚本全部执行，16 套通过，5 套编译失败。alerts / recovery / session / unread-panel 四套在冻结 .15 上具有相同诊断多重集，是原 fixture 与既有源不匹配；不把它们计作通过，也不为了适配无关模块改旧断言。entry 原 fixture 缺新增 tap 声明；在新审计仅加声明/链接兼容并保留全部断言后，真实触发原“头像恰好一个 recognizer”断言失败。新增要求实际为两个手势，此差异明确留红，不隐藏 tap、不篡改旧断言。新的 90 项合同检查验证两个手势的依赖及分支，不能把它说成旧21套全绿。另在最终 Runtime 定版后复跑原 Runtime/Scheduling/Biometric 109+9+99项与双架构 iOS 源编译，全部通过。

原始运行见 [密友回归](regression/security-result.json)，冻结 .15 对照见 [既有编译失败诊断](regression/security-baseline-diagnosis.json)，头像旧断言差异见 [兼容执行记录](regression/entry-compatibility-summary.log)。

## 安装后的真机验收步骤（尚未执行）

1. 普通“捉迷藏呀”入口恢复原密码流程，密码框没有“忘记密码”入口。已授权的原临时解锁期限仍按原规则，不因新页面入口改动。
2. 插件主设置页头像前四次短按不进入；相邻不超过 0.8 秒的第五次弹出无密码风险确认，确认后进入当前账号设置。中途停 2 秒，应从之后重新数五次。
3. 原头像长按 2 秒仍执行发现入口/原设置密码行为；长按后再开始短按，需要重新完成五次，不应把长按计为点击。
4. 在原先微信列表保持隐藏的前提下只进入/退出快捷页，不修改保护选项，聊天列表的密友仍应隐藏；回到插件主页再进入须新五击。进入后台、换账号后旧页不得继续显示或写入旧账号名单。
5. .15 已留下 retired marker 且 auth 仍有效的账号应正常加载，无 pending/错误提示。auth 已丢失但根插件页仍可达时，用五击查看保留名单；auth 已丢失且整插件入口已隐藏的组合按上述限制处理，不能把密码凭空恢复。
6. 连续同发送者文本在“紧密”仍应有明显接缝；主机断言为 2pt，normal 为 21/24pt。手机真实点数、不同字体/缩放与特殊消息布局尚未测量，不把主机几何称为真机结果。

## 原 100 个脚本的全量补齐

在已跑原 6 套布局与 21 套密友脚本之外，其余 73 套已逐项检查 shell 及 95 个引用测试源，全部可在独立 TMPDIR、独立 Theos 输出变量下安全执行；没有安全跳过，没有修改 HOME，也没有改脚本和断言。实际 60 套通过、13 套失败；13 套全部在冻结 .15 上用相同脚本复现相同退出码与诊断，其中 11 为夹具接口/抽取方法体编译失配，2 为提取器 ValueError / AssertionError，新增失败为 0。

因此，原目录 **100 个 verify 脚本全部实跑：82 通过、18 失败**。失败中 17 套为冻结 .15 已存在的相同诊断，1 套为新增头像手势与旧“恰好一个 recognizer”断言的明确有意差异。这里保留失败，不能称全量回归全绿；现代 .14 四项、compact 与本次 232/90 新合同测试分别按其真实结果记录。详见 [余 73 套运行与基线对照](remaining-regressions/SUMMARY.md)。

## 最终范围和环境保护

全量测试结束后实际再执行 `verify-final-scope.py --final`：**PASS**。相对冻结 .15 为 **13 文件，+204 / −195 行**；189/189 个历史包文件（包含 .DS_Store）、1,237/1,237 个主树 .theos 文件、314/314 个复制先前夹具（其中原 Tests 277/277、compact 7/7）均路径集合与 SHA 一致。准确 .14/.15/.16 SHA 和逐文件行数见 [最终核对表](final-scope.md) 与 [完整 JSON](final-scope-result.json)。

实际构建的 42,522 个输入又与最终工作树逐项 SHA 对照，无差异；build/current tree SHA 均为 `e68e4524ced144e2bd3a84b824eee980854c941a91816f94ef022093cf882a97`，见 [包内源码对应证明](delivery-inputs-match-final.json)。未因测试或报告变化留下未进入 dylib 的生产修改。

旧 .15 专用测试与孤立 review 报告的 60 文件删除与 manifest 精确一致；旧 .15 README 仅更新撤回说明和失效链接，前后 SHA 留档。初次范围检查因 review-reset 尚未列入删除允许名单而失败的原记录保留在 initial-failed-*，随后仅按用户本轮清理范围明确列出该路径，没有重置 before 基线或忽略其它文件。

Git HEAD 仍为 `a227b1677255fe0e2dc727dcc2e6f62386fc3afd`，全部工作未提交。没有 reset / checkout / stash / make clean，没有覆盖历史包，没有访问或迁移用户微信数据库。最终交付不包含对“auth 已丢失且整插件入口隐藏”组合的入口显示例外；该限制保留在主 README 和本报告，未声称已解决。
