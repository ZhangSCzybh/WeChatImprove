# 语音气泡播放进度：cell 接入审查与实现

最终范围仅为**语音进度拖动**。微信 8.0.80 已有原生倍速按钮，用户已明确要求保持该功能，由一个独立进度开关控制新交互。本报告中最初提出的细轨道、圆点和额外速度开关已被最终需求替代。

最新交互采用气泡自身长度表示内容时间：在原生语音背景内部放置半透明同色填充，保留原生播放动画、总时长、倍速和续播按钮；在正在播放的气泡上横向拖动预览，松手只提交一次原生 seek。无独立 slider、轨道或小圆点，不改消息行高、字幕尺寸或原生 view frame。

## 实现边界

本子任务只实现 `Controllers/CSVoicePlaybackOverlay.h/.m`、独立主机 UI 测试和本报告。控制器、开关、生命周期、hook 与发布由主任务负责。未启动微信或服务，未改数据库、账号、媒体文件或原生播放器；没有访问共享 REA session。

- `CSVoicePlaybackRefreshCell(id)`：由现有消息 cell 生命周期在最终几何处理后调用。只接受真实 `VoiceMessageCellView`、`VoiceMessageViewModel`、type 34 消息及已附加的 window。
- `CSVoicePlaybackDetachCell(id)`：绑定、复用、离屏或 window 移除时清除本任务拥有的填充、recognizer、预览及拖动 token，不停止原生音频。
- `CSVoicePlaybackOwnsTouch(id, CGPoint)`：只为有效当前播放快照、当前绑定、气泡 body 内且避开原生按钮/导航边缘的点返回 YES，供消息左右滑快捷动作的 admission guard 使用；该函数本身不开始或定位播放。

状态以关联对象归属于 cell，并由全局 weak registry 保存。仅观察播放状态与设置变化，刷新已经登记的 voice cell；不遍历整个页面或历史消息，不为每个 cell 启动 timer。未播放的 cell 也保留轻量状态，使开关打开后可以刷新正在播放的气泡。主控制器提供单个 150ms 活动播放时钟。

## 几何与视觉

`getContentView` 是手势 host，`getBgImageView` 是被动填充的父 view。填充不参与 UIKit hit test，既不接管原生点击也不占用 native gesture delegate。原生图标、时长和按钮仍在背景上方。

先读取 `CSBubbleStyleVisibleInsets`；若当前背景尚无可用已解码信息，回退到 `CSBubbleStyleModelInsets` 的缓存模板。现有 body padding 算法按重复直边识别 body，排除窄箭头和透明外围。两者均不可用时隐藏新 UI，避免根据不可靠背景尺寸把颜色画到气泡外。背景 transform、容器关系、`voiceNodeHeight` 的 double ABI、body 与 host bounds 都经过检查。

填充 frame 比真实 body 内缩 1pt，并使用内部圆角 clip。填充长度按 `currentTime / duration` 计算，拖动期间改为预览位置；低透明度颜色来自现有 `m_secLabel.textColor`，主题回退使用 UIKit 动态颜色。填充本身只有一个子 view；没有轨道、thumb 或新增常驻时间标签。当前/总时间仅在拖动时以非交互 badge 显示于当前 window，结束/取消立刻移除，避免遮挡小气泡的原生文字或纳入紧密气泡测量。

没有改变 model.contentViewSize、voiceNodeHeight、背景模板、原生图片、glyph transform、字幕 frame、原生 hidden 状态或任何行缓存。由于被动填充嵌入既有背景，紧密气泡检查的 cell/content 两层不会新增越界 child。

## 交互与身份

一个 `UIPanGestureRecognizer` 安装在已验证的 content host；只有初始点位于当前播放 body、非原生 UIControl 且取得有效快照时才 admission。明确的横向意图（水平量超过垂直量 1.35 倍）才 begin，竖向或模糊斜向移动交给原有滚动。未识别前不延迟 touches，识别横拖后取消原生点击，避免松手触发播放点击。

导航返回 recognizer 与 `UIScreenEdgePanGestureRecognizer` 拥有 failure 优先；存在 navigation pop 时，两侧各 24pt 的起始触摸区域保留给导航。拖动从其他位置开始后，手指仍可移动到气泡两端并 clamp 到 0/总时长。原生速率、续播、转文字按钮 frame 及实际 UIControl 祖先触摸都排除在进度拖动外。

开始拖动保存 binding、model、源 CMessageWrap、控制器 generation 及总时长。每次预览和最后提交前均重新验证 window、当前 model/wrap 和活动快照。changed 只改变 UI；ended 清除拖动状态后提交一次 seek，防止同步状态通知重入导致重复提交。cancel/failed、消息切换、generation 变化、关闭开关、复用或 window detach 均丢弃请求。VoiceOver 对当前有效进度提供 ±5 秒的 adjustable 操作，同样经新鲜快照和 generation 验证。

UI 只消费规范化秒数，不自行估算播放时钟或写入速率。控制器负责账号、当前原生播放消息和 session generation。源消息不按 indexPath 或 localID 单独绑定，drag token 也不能跨 cell 重用。

## 当前 8.0.80 的证据

证据由并行 native-playback 审计保存，本 UI 任务只读取落盘结果。旧 HeadersFile 把两类父类写为 NSObject，且缺少新速率按钮，不能据此重建原生 cell。

| 接入点 | 当前 ABI / 地址 | 作用 |
| --- | --- | --- |
| `VoiceMessageCellView : CommonMessageCellView` | [ui-voice-metadata.json](native-playback/ui-voice-metadata.json) | 真实继承关系 |
| Cell `initWithViewModel:` | `@24@0:8@16`，`0x106571ad0` | 第一次绑定 |
| Cell `layoutContentView` | `v16@0:8`，`0x106571e5c` | 原生布局后的最终几何 |
| Cell `prepareForReuse` | `v16@0:8`，`0x106573424` | 复用清理 |
| Cell `onBeginPlayingMsg:autoPlayEnabled:` | `v28@0:8@16B24`，`0x106586078` | 首参为 CMessageWrap，原生后刷新 |
| Cell `onEndPlayingMsg:autoPlayEnabled:` | 同上，`0x1065864d4` | 不能把任意回调当作本 cell 活动身份 |
| VM `voiceNodeHeight` | `d16@0:8`，`0x106589714` | 限制 body 高度 |
| VM `voiceNodeWidth` | `d16@0:8`，`0x1065894d0` | 原生宽度，仅供审查 |
| VM `isPlaying` | `B16@0:8`，`0x10658a078` | 派生状态带 ivar 兜底，不作为唯一活动身份 |
| VM `timerEvent` | `v16@0:8`，`0x10658c998` | 原生 0.3 秒 timer，不由插件接管 |

`m_playingImageView` 实际是 VoicePlayingView，不能假定 UIImageView。`m_playRateButton` 已经由原生无条件建立，其实际显示还受时长、最小化、收发及首次播放影响；本实现既不复制也不强制显示。已知按钮通过名字解析对象 ivar，并检查对象类型，不使用固定偏移。

原生 begin 回调在 `IsSameMsg:` 过滤前会更新部分 UI，故 hook 到 begin 不等于本 cell 活动。controller 应以 `MsgPlayingFacade.currentPlayingMsg` 与真实 messageWrap 匹配。已确认门面 `currentPlayTime` 返回 int32 毫秒、`seekToTime:` 接受 uint32 毫秒；总时长来自 `m_uiVoiceTime`。VM.voiceTimeLength 计算气泡宽度，不能用作媒体时长。具体 codec 定位粒度见 [native-playback/README.md](native-playback/README.md)。

## 验证与真机验收

真实 iPhoneOS SDK arm64 与 arm64e 的 ARC、`-Wall -Wextra -Werror` 语法检查均已通过。独立 invocation-recording UI 回归 `Tests/verify-voice-playback-overlay.sh` 的 **71 checks 通过**，覆盖结束单次提交、同步通知重入、取消/失败、stale generation、停止、重绑、window detach、设置开关通知、原生按钮及导航边缘、上下边界 clamp 和原生 frame/hidden 保持；本任务 7 个源/测试/报告文件的空白检查通过。测试使用独立 UIKit doubles，不修改原有共享测试框架或用户运行环境。主任务还需要完成控制器、生命周期及发布集成验证。

真机应覆盖私聊/群聊、收发方向、最短与最长语音、连续播放切换、同消息多个页面、默认/自定义/紧密气泡、浅深色、大字体、两类转文字进行中/展开/折叠、隐藏语音提示及原生速率/续播按钮。交互需验证原生点击和长按、竖滚、导航边缘返回、横向消息快捷动作、拖动中离屏/重用/关闭开关。静态和主机回归无法替代实际听感、codec 粒度、缓冲延迟或真实图像边缘观感。
