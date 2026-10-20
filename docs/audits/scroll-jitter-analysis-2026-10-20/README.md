# 历史消息滚动后间距收缩分析

日期：2026-10-20。范围：用户提供的录屏、当前工作区合并模块、定向宿主复现。此次仅新增分析材料，没有修改产品代码、版本号或安装包。

## 录屏证据

输入为 `../inbound/scroll-jitter-demo.mp4`，ffprobe 确认 592×1280、30 fps、79 帧、2.633333 秒。分析解码全部 79 帧，时间采用视频帧的 `best_effort_timestamp_time`。

第 57 帧（1.866667 秒）到第 58 帧（1.900000 秒），顶部同一组三条气泡的首条上沿和下沿保持在 y=193、239，而两道接缝分别由约 4、8 像素变成 2、2 像素。下方另一组两条气泡的接缝也由约 8 像素变成 2 像素。局部间距在一帧之间改变，不能由整屏统一滚动解释。

见 `gap-before-after.png` 和 `gaps.csv`。像素边界通过 x=90..99 的粉色背景检测：至少 6 个像素满足 R>180、B>90、R−G>45、B−G>10；连续区段超过 10 像素才计入气泡。压缩、抗锯齿会产生约 1 像素误差。录屏像素不能直接等同于 iOS pt。视频没有滚动代理或布局调用日志，不能仅凭帧时间断言具体触发了哪个微信回调。

## 当前源码确认的路径

- `Controllers/CSMessageMergeAdapter.m:385`：首次行高查询依据受限原生几何预设或实测几何决定 `appliedDelta`，没有同时保存并提交 `originDelta`。
- `Controllers/CSMessageMergeAdapter.m:511`：Render 采样真实边界后清除 `measurementDecided`。即使没有请求表格刷新，下一次原生行高查询仍会得到新的较小高度。
- `Controllers/CSMessageMergeAdapter.m:521`：渲染直接使用本次实测的 `actual.originDelta`，它可能不属于表格当前行高所依据的那份布局方案。
- `Controllers/CSMessageMergeAdapter.m:258`、`:419`：全局布局 epoch 或原生缓存重置会清掉已有决策/位移，随后恢复时可能再次改变几何。
- `Controllers/CSMessageMergeAdapter.m:543`、`Hooks/MessageMergeHooks.xm:31`、`:38`：主动刷新在拖动、减速期间延后，停止后重试。有 `needsLayout` 时会触发表格高度更新；没有待办时并不会无条件刷新。
- `Controllers/CSMessageMergeAdapter.m:575`：`performWithoutAnimation` 只关闭动画，无法消除高度变化造成的位置跳变。首条锚点补偿可以抵消整屏位移，不能保证每道内部接缝不变。

录屏表现与这些路径一致，但缺少真机调用日志，尚不能唯一确定第 58 帧由哪条路径触发。

## 定向复现

`ScrollJitterProbe.m` 复用项目的 UIKit 替身与消息模型，直接编译当前生产适配器，仅运行两项特征复现，不执行原有完整测试入口：

1. 保持原生行高 61pt、正文高 44pt、透明边距上下各 3pt 等输入不变，初次测量行高为 46pt，Render 后再次测量变成 40pt。主动表格更新次数仍为 0。首轮预设位移为 −7pt，而渲染已采用实测 −10pt。
2. 对同一消息触发布局 epoch 失效并重新绑定，已有位移由 −10pt 变成 0；拖动期间没有表格更新，停止后出现 1 次更新。

输出见 `probe.log`。这些是当前问题的特征检查，通过表示复现了不稳定行为，不表示问题已经修复。UIKit 替身不执行真实表格重测、屏幕绘制或减速回调，不能证明真机帧率或精确回调时序。

原有 `Tests/MessageMergeAdapterTests.m:385` 的滚动测试使用预设与实测一致的几何，主要断言更新次数与滚动偏移。`:780` 附近的透明边距测试还明确接受 46pt→40pt，因此现有测试通过不能排除该类间距抖动。

可在项目根目录复现（产物写入临时目录，不触碰用户偏好或安装包）：

```sh
probe_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-scroll-jitter-probe.XXXXXX")"
xcrun --sdk macosx clang -DCS_MERGE_TESTING=1 -fobjc-arc -fblocks \
  -Wall -Wextra -Werror -Wno-unused-parameter \
  -framework Foundation -framework CoreGraphics -framework CoreFoundation \
  -ITests/MessageUIKit -IControllers \
  Tests/MessageUIKit/MessageUIKit.m Tests/MessageUIKit/DisplayLink.m \
  Controllers/CSMessageMergePolicy.m Controllers/CSMessageMergeAdapter.m \
  Controllers/CSRevokeReference.m Controllers/CSChatNativeBridge.m \
  Controllers/CSMessageNavigation.m Controllers/CSMessageTimeLayout.m \
  docs/audits/scroll-jitter-analysis-2026-10-20/ScrollJitterProbe.m \
  -o "$probe_dir/probe"
"$probe_dir/probe"
```

## 建议方案

1. 将高度、内容位移及其布局签名作为同一份已提交结果，测量和渲染都使用它。渲染采样不得单独覆盖当前位移或让普通的后续高度查询隐式改用更紧的结果。
2. 同一消息、相同正文尺寸/宽度/原生高度/显示比例/邻接关系/配置/昵称与辅助内容状态下，保留结果。历史缓存通知标记待验证，不直接清零已显示内容的位移。涉及气泡可见边距时也须纳入验证。
3. 停止滚动只处理有明确原因的布局变化；较小的实测边界本身不能成为当前可见消息再次收紧的理由。仅跳过停止回调不充分，因为原生高度查询仍能走到同一问题。
4. 真正的内容增长、翻译展开、宽度变化、消息删除等仍需重新计算。未知/不可靠几何采用稳定的保守布局，同一输入下安全回退不能反复进入压缩。首次精确收紧应在可靠的首次测量阶段完成。

这一轮建议聚焦稳定性，保留当前紧密布局的目标；44pt 头像等初次几何标定应作为独立问题验证，避免直接整体恢复曾回退的 1.8-24。仅冻结当前结果不能保证所有版本/类型都立即达到最小间距，首次测量精度仍是后续需要分别完善的能力。

## 核心验收

- 拖动→减速→停止，多次重测的行高、内容位移和相邻接缝保持一致，覆盖预设与实测不相同的情况。
- 相同几何下的历史 epoch、原生缓存重置、复用和重新绑定，不产生临时位移归零或额外收紧。
- 私聊/群聊、收发方向、首中末条、两种头像位置、普通与连续圆角背景，以及透明边距差异。
- 删除邻居、正文增长、翻译展开等真实变化能正确重排，内容不裁切，安全回退不反复震荡。
- 真机重复本次滚动操作，跟踪同一组消息接缝的相邻帧变化。仅允许录屏栅格化误差；宿主测试不能替代这一步。

当前源码与输入视频摘要记录于 `source-sha256.json`，用于区别后续代码变化。
