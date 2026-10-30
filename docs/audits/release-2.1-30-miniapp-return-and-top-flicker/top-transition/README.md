# 顶部业务卡片转场：证据、修复范围与边界

本目录验证了一个源码上的同步收尾缺口：顶部业务行使用直接的 `MMTableViewCell`，其原生布局完成后没有像 `NewMainFrameCell`／`FakeMainFrameCell` 那样校正既存插件卡片。如果原生布局改变了 contentView 的宽度，旧卡片几何会一直保留到后续 table／VC 布局。**这个缺口成立；尚未证明它就是用户录屏中转场观感的真机根因。**

## 录屏能证明什么

原录屏的原样解码与数值复核见 [frame-evidence](../frame-evidence/README.md)。frame0=52／53／54 相对稳定态同时发生横移和共同变暗；把文字和底板放在同一个区域拟合，平均绝对残差分别约为 **2.06／1.36／0.78**。卡内与卡下灰底仍保留亮度差。该证据支持转场横移／共同遮暗能够解释可见差异，不能把尚未达到 RGB 255 或尚未露出的圆角当作漏绘证据。

未连接设备、未运行微信、未采集修复后视频。自然生命周期顺序、真实 cell 交付次数、绘制次数、CA 提交次数、修复后是否还闪，均未测得。

## 原生静态证据

复用了已有微信 8.0.78 二进制和已有 Objective-C 元数据解码器，再用本地主机 LLVM 工具作有界反汇编；没有运行微信或调用原生方法。

- 输入：`/tmp/wechat-8.0.78-inset-analysis/WeChat`
- SHA256：`0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`
- 解码器：`docs/audits/tabbar-wechat-badge-2.1-6-2026-10-29/native/extract.py`
- 方法范围、签名、继承和 ivar 见 [native-layout-metadata.json](native-layout-metadata.json)。顶部 Header cell 直接使用 `MMTableViewCell` 的构造证据沿用 [2.1-27 原生证据](../../release-2.1-27-banner-launch-flicker/native-evidence.md)。

| 方法 | 范围／操作 | 结论 |
| --- | --- | --- |
| `MMTableViewCell.layoutSubviews` | `0x1166fd0c4–0x1166fd46c`；`0x1166fd248` 向 contentView 发送 `setWidth:`，值为 self.width；`0x1166fd278` 发送 `setX:0` | 原生布局会校正 contentView 几何；没有观察到直接清除／移除插件背景或替换 contentView 的代码 |
| `MMBaseMultiMenuTableViewCell.layoutSubviews` | `0x116756564–0x1167566bc`；读取既有 `_actualContentView`，`0x1167565c4` 设 frame，`0x1167565f8` 添加到 super.contentView，`0x11675660c` 更新复制背景 | 存在多层 content 容器的几何操作；没有建立直接业务行必经这一子类的事实 |
| `MMBaseMultiMenuTableViewCell.contentView` | `0x116756a10–0x116756a7c`；按 contextMenuEnabled 选择 `_actualContentView`／super.contentView | 返回既有容器，未建立新分配／替换的证据 |
| `NewMainFrameCell.layoutSubviews` | `0x1050fcf20–0x1050fcfd4`；设置 item frame | 既有 New/Fake 布局 hook 已有同步几何收尾 |

四份 `.asm` 与 JSON 保存在本目录。以上仅是所列方法体的有界静态结论；不能从“没有在此方法观察到”推断整个 UIKit 调用链永不重绘或改变容器。

## 最小生产改动

仅改 `Hooks/ListCornerRadiusHooks.xm`：引入 runtime 声明；在 `MMTableViewCell.layoutSubviews` 的 `%orig` 后，要求**实际类恰为 `MMTableViewCell`，且已持有 session background**，再调用既有 `CSListCornerRefreshSessionGeometry`。

精确类门槛避免给 New/Fake 子类增加一轮修复。既有 refresh 只使用已缓存的卡片形状／首尾角色，检查现有 frame／颜色／mask 后再写；不查询分组／行模型、不交付 cell、不重载、不写 contentOffset。它保留 outer table-layout depth guard：table 正在原生布局时，独立 cell 收尾暂不执行，仍由原有 table 出口统一校正。

没有改 renderer、PageContext、SessionAdapter、SessionRestore、分组卡片角色计算、密友规则或受保护的 2.1-26／27／28／29 方法。没有新增延时、透明度、动画、快照、强制布局或整表刷新。

## 固定 14 项红绿测试

命令：

```sh
bash Tests/verify-top-transition.sh \
  docs/audits/release-2.1-30-miniapp-return-and-top-flicker/top-transition/baseline
bash Tests/verify-top-transition.sh
```

完整抽取 `MMTableViewCell.layoutSubviews` hook，只将 `%orig` 换成明确的受控输入块；编译真实 PageContext、SessionAdapter、SessionRestore 和 renderer。renderer 仅改函数定义名，以便入口计数后调用真实实现。宿主 UIKit 替身使用真实 QuartzCore 路径，但没有 UIKit compositor。

冻结的基线来自未修改的 `73e8e78a`（2.1-29），六份输入及哈希见 [baseline/manifest.json](baseline/manifest.json)。正式红测在生产 hook 修改前完成；红／绿采用完全相同的三份测试文件哈希，分别记录在 [red result](red-2.1-29-result.json) 与 [green result](green-2.1-30-result.json)。正式结果为 **14 项／3 失败 → 14 项／0 失败**。旧测试文件的逐字副本带 `-red-14.txt` 后缀。

| 输入 | 原生事实与受控条件 | 旧 hook 出口 | 修复 hook 出口 |
| --- | --- | --- | --- |
| content 容器替换 | 纯受控防御输入；未在实际 MM 原生方法确认 | 卡片留在脱离的旧容器 | 同一张卡片已挂到当前 contentView |
| 卡片颜色／mask 清除 | 纯受控防御输入；未在实际 MM 原生方法确认 | 卡片透明、无 mask | 既有颜色和 mask 已恢复 |
| 原生 content width／x 操作 | `setWidth:self.width`／`setX:0` 已静态确认；输入 `x=-40,width=450` 和其设备出现频率是受控／未知 | content width 已为 390，卡片／mask 仍为 412 | 卡片／mask 同步变为 352，offset 仍为 y=120 |

三个场景均只调用一次受控原生 cell layout。旧代码在这个出口 renderer apply／refresh 为 0／0，到受控后续 table 布局出口才为 1／1；修复代码在 cell 出口已为 1／1，后续 table 出口为 2／2。这里的“2”是两次既存几何核对入口，不能称为两次内容重建、cell 交付或屏幕提交。

每个 fixture 初始 decoration 调用一次；受控 return 中没有调用 cell delivery。host 的 reloadData／模型查询计数均为 0；宽度场景卡片 setFrame 由 0 变为 1；paint-reset 场景一笔清除＋一笔恢复；container 场景复用同一对象。完整相对 synthetic begin／end 的计数在两份 `.log`。**fixture 未观测 reloadRows、真实 drawRect、真实 cell 交付和 CA commit；不能把其实际次数填为 0。** 两个设备绘制字段在日志中为 null。

早期两场景 10／2、加入 exact-class fixture 前 14／3、以及漏掉 table tracking 的无效 fixture 启动日志都单独保留。无效 fixture 日志不计入正式红绿结果。

## 独立兼容检查

`bash Tests/verify-top-transition-compatibility.sh [source_root]` 是另一份补充套件，未更改上述三份测试的哈希。它在 frozen 29 与修复 30 上均为 **11 项／0 失败**，所以它是兼容覆盖，不是本次缺陷的红测。

三个输入覆盖正常 content width／x、MM 子类、outer table-layout scope。正常输入没有卡片 frame／background 写入或 display invalidation，保留卡片／mask／path、滚动 y=120；host reloadData／模型查询为 0，原生 layout 一次。子类没有从 base hook 增加 refresh，outer table 内独立刷新为 0、table 出口保留既有一次刷新。详见 `compatibility-2.1-29*`／`compatibility-2.1-30*`。

## 可选设备观察器（尚未在设备运行）

[runtime-top-transition-observer.js](runtime-top-transition-observer.js) 从既有 2.1-29 只读探针扩展：记录列表生命周期、聊天出现、导航 pop 边界、发布与局部／全表重载、业务 cell delivery、MM／MMBase／New／Fake 布局、自然 renderer／geometry C 函数调用、已确认业务卡片及其 layer 的 frame／background／mask／drawRect／display 边界。

脚本不自动 attach、不触发 banner getter／策略／刷新／布局、不写参数或返回值、不改设置／数据库、不输出昵称／消息。脚本加载后仅安装观察 hooks；须显式调用 `topTransition30.start('chat-return')` 开始有限采集，再正常进入聊天并返回，最后调用 `topTransition30.stop()`。**必须在进入聊天前启动**，覆盖完整前后边界；不能在异常已经发生后补采并把缺失事件当零。

具体使用时在已授权的 Frida 会话中手动加载脚本，不在本次任务中执行设备连接。`start` 会在主线程扫描一次现有 adapter 并读取现有 banner ivar，用 banner 的祖先 cell 确定业务 cell；卡片身份只从真实自然发生的生产 renderer `argument0` 识别，不猜测“第一个 subview”。若进入返回窗口之前没有自然 renderer 调用，card baseline 是 unknown，不能宣称卡片身份稳定或没有重建。

Objective-C 方法先验签名；C 符号只在 `WeChatImprove` 模块唯一匹配，并仅依据源码声明核对首指针参数 ABI。符号不可用、Frida bridge／API 不支持、签名不匹配或未覆盖的入口均记录为 unknown／unavailable。C ABI、桥接对象／结构解码和 hooks 未经真机验证；本地仅通过 Node 语法检查及嵌套 CGColor pointer encoding parser 检查，结果见 `observer-validation.json`。

同一个底层 IMP 可以因继承／super 调用／多种观察角色产生重叠 hook 边界，不能相加当作实际绘制次数。导航 pop 返回／didAppear／drawRect／CALayer.display 均不是 compositor 完成证明。探针不观测 CA 提交；无 drawRect 调用也不等于没有 layer 绘制。start 前、停止后、异常 unwind、动态后续 swizzle、未覆盖 override 等均可能漏事件。观察本身存在计时开销，不能保证复现原始的 0.2 秒时长。
