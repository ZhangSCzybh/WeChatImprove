# 最窄档数字角标的原生越界与插件增量

日期：2026-10-29。任务边界：只读分析用户已确认的第 4 节方案中剩余的 `.6` 档部分越界，未修改生产代码、正式 Tests 或旧审计。沿用微信 8.0.78 / build 8.0.78.34 静态目标，SHA-256 为 `0b3cd1e2ed1da493a6fe12c9ef6e9b9421c95bcac63417c677f309536f7c1c8e`。

## 1. 明确结论

**此前实验中 `.6` 档宽数字与 99+ 的部分右越界，在默认原生图标宽度为 28 的输入下已经存在于“同样窄 item”的原生布局中；修正 autoresizing 基线后，插件的图标平移不会新增这部分右越界。应保留这种原生观感，不应把 `CGRectContainsRect(item.bounds,badge.frame)` 无条件写成绿色标准，更不能改字号、尺寸、内容或裁剪开关来消除它。**

旧实验 JSON 的按宽度/阶段计数也与此一致：[experimental-results.json](../tabbar-badge-2026-10-28/probe/experimental-results.json) 的全部2,080次部分越界都在`.6`档，其余四档均为0；首次开启/100次普通Update的初始超过99输入各80次，value100与string99+的更新/100次item布局/100次bar布局各320次，合计`80×2+320×6=2,080`。红点、1、12各阶段的部分越界为0。该实验原生图标默认28、font.lineHeight=12、badge代表宽30；这些输入满足上述“不新增右越界”的推导。不能把这个计数外推为真实设备99+宽度或裁剪表现。

这一结论限于已核对的默认原生图标几何和此前实验输入。原生 `item.customSize`、动态字体的实际尺寸都不能硬编码为 28；当实际原生图标比最终样式图标更窄，或文字较高导致最终图标更靠上时，统一平移可能新增某一侧越界。这些情况需要只调位置的约束，并以**同一窄 item、同一原生 badge 对象、相同实际 size 的同步原生 frame**为参照。真实 `clipsToBounds` 的值不参与判定。

下述规则不要求改动原生已经存在的越界：插件的最终 frame 在任一侧造成的越界，不得大于同步原生 frame 在该侧的越界。只限制插件新增的部分。

## 2. 原生证据及适用边界

复用旧审计中的证据文件，不修改它们：

- [原生证据索引](../tabbar-badge-2026-10-28/native/README.md)
- [layoutBadgeView](../tabbar-badge-2026-10-28/native/MMTabBarItemView--layoutBadgeView.asm)：方法地址 `0x104728b94`。数字或非空 badgeString：`y=4`，`x=getBadgeViewRightMarginPortrait`；纯红点：`y=imageView.y`，`right=imageView.right`。
- [getBadgeViewRightMarginPortrait](../tabbar-badge-2026-10-28/native/MMTabBarItemView--getBadgeViewRightMarginPortrait.asm)：方法地址 `0x104728d64`，返回 `item.width/2+3`。
- [layoutIcon](../tabbar-badge-2026-10-28/native/MMTabBarItemView--layoutIcon.asm)：方法地址 `0x10472884c`。有 `item.customSize` 时按其 CGSize 布局；没有时按 `UIFont.dynamicLength(28)` 决定宽高。水平居中，默认 top=8；customSize 路径可使用 bottom 对齐。
- [MMBadgeView.setFrame](../tabbar-badge-2026-10-28/native/MMBadgeView--setFrame_.asm)：方法地址 `0x11671553c`。origin 对齐到屏幕像素，size 向上像素对齐。`FRINTI` 按当前浮点舍入模式执行；通常的 nearest-even 与 C `round` 的半数远离零在半像素 tie 上不同。最终结论必须读取真实 getter，不能把替身某一种舍入策略当成运行观测。
- [MMBadgeView.innerSetBadgeShape](../tabbar-badge-2026-10-28/native/MMBadgeView--innerSetBadgeShape.asm)：方法地址 `0x116714ae4`。数字宽度来自原生 badgeLabel 的测量宽度、高度和 inset；`99+` 字宽不是一个可安全硬编码的常量。

这里的 `dynamicLength(28)=28` 是旧 host 探针的默认字号输入，**不是所有设备、动态字号、微信设置下的恒等式**。正式实现应继续调用原生 `layoutIcon/layoutBadgeView` 并读回 frame，而不是复制上述常量作为产品定位公式。数字用例中的宽 16/24/30 是明确标记的几何代表输入；真实宽度只能读取原生 badge 的实际 frame。

## 3. 同窄 item 原生与 style 的比较

比较对象必须都处于**当前样式 item.bounds**：

1. 深度保护内同步执行原生 layoutIcon、layoutBadgeView。
2. 捕获原生图标 frame `I` 和原生 badge frame `N`，均为 getter 返回值。
3. 按已有图标尺寸语义取得最终样式图标 frame `J`。
4. 插件原本计划的纯平移候选为 `T.origin = N.origin + (J.maxX−I.maxX, J.minY−I.minY)`；badge size 不变。

不能拿旧的完整宽度 item 下的 badge 位置作这一比较；item 缩窄本身是已授权的样式行为，用户要求比较的是原生在**同样窄 item**里的观感。

先忽略像素对齐，仅为理解水平差值。设当前窄 item 宽 `w`，原生图标宽 `n`，最终图标宽 `a`。两图均居中：

```text
原生图标右边 = w/2 + n/2
样式图标右边 = w/2 + a/2
数字原生 x    = w/2 + 3
样式平移 dx   = (a−n)/2
样式数字 x    = w/2 + 3 + (a−n)/2
```

默认 `n=28` 时，现有 adapter 的方形系统/导入图标目标宽 `a≤28`，所以 `dx≤0`。像素取整是单调的，且原生 `N.origin.x` 已经对齐；最终样式数字不会比同宽原生数字更向右。宽数字产生的右越界因此不会增加。是否仍部分越界取决于原生 badge 的真实宽度。

以此前实验的 390pt bar、`.6` 档为例，四项 item 宽 `w=58.5`；代表性数字 badge 宽 30、@3x：

| 阶段/图标尺寸 | 数字 badge.x（实际像素对齐后） | 右边 | 超过 item 右边的幅度 |
| --- | ---: | ---: | ---: |
| 同窄 item 原生数字位置 | 32⅓ | 62⅓ | 3⅚ |
| 最终图标宽 28，dx=0 | 32⅓ | 62⅓ | 3⅚ |
| 最终图标宽 20，dx=−4 | 28⅓ | 58⅓ | 0 |

所以“仍有部分越出”本身不能判为插件错误；该表的 30pt 只是代表输入，不是声称真机 99+ 恰好宽 30pt。原生 position 与 style position 均应该由实际 getter 计算其越界幅度。

两个不能省略的边界例子：

- **较窄的原生 customSize**：若原生图标实际宽 16，而最终导入方形图标仍按原来语义宽 28，则 `dx=+6`。上述例子数字 x 会从 32⅓ 到 38⅓，右越界由 3⅚ 增到 9⅚；新增的 6pt 来自插件，应只调整位置限制它，不修改导入图标的 28pt 语义。
- **较高文字/动态字体**：数字原生 y=4，但最终图标的 top 可能小于原生图标 top−4，例如现有最小高度44、文字高度20、图标高20、gap3 时，最终 top=.5；若原生 top=8，则候选数字 y=−3.5（取整前）。这是插件新增的上越界，应只修 y；不能因为默认字号没有出现就忽略。

## 4. 最小位置约束及像素边界

令 `B` 为当前 item.bounds，`N` 为同步原生 badge 的实际 frame，`W/H` 为真实 badge size。定义四侧原生越界：

```text
leftN   = max(0, B.minX − N.minX)
rightN  = max(0, N.maxX − B.maxX)
topN    = max(0, B.minY − N.minY)
bottomN = max(0, N.maxY − B.maxY)
```

只允许候选 origin 落入以下区间，保持 size 不变：

```text
x ∈ [ B.minX−leftN,  B.maxX+rightN−W ]
y ∈ [ B.minY−topN,   B.maxY+bottomN−H ]
```

每个区间一定包含原生实际 origin，因此即使 badge 比 item 更宽/高，也不会出现“必须改 size 才有解”的情况。对候选 origin 做最近点夹取即可；原生已有越界的上限保留，原本全部在内的原生 badge 不允许新增越界。这个规则不读取、不猜测 `item.clipsToBounds` 或祖先裁剪状态。

像素处理必须在约束里完成，不能先夹到非像素边界、再让 MMBadgeView 取整时额外推出一像素。设原生 frame setter 使用的屏幕 scale 为 `S`，对每个区间 `[lo, hi]` 先取可行像素格点区间：

```text
loPixel = ceil(lo*S)/S
hiPixel = floor(hi*S)/S
```

在这个格点范围内选最接近目标的格点，或先按像素量化候选再夹取。允许的浮点容差只用于处理数值误差，例如 `1e−6 / S` pt；不能容忍完整一像素越界。原生 origin 本来就是本 setter 的固定点，应总能提供可行格点；极小浮点误差可用原生实际 origin 兜底验证，不能移动到不可行格点。

写回后仍需读实际 badge.frame，按真实 origin 相对 `N.origin` 记录 actual offset，用于现有 restore。若运行 getter 的取整或 size 与预期不同，应以实际四侧越界验证，并沿某个必要轴回到原生 origin，而不是叠加新偏移或改 size。该检查只负责当前同步 apply，不引入延时、轮询、额外内容更新或缓存。

在默认原生28宽图标和此前探针字号下，这个约束通常无需改变原本候选；`.6` 档的原生99+部分右越界可自然保留。较窄 customSize/较高文字等输入只在某轴新增越界时触发，保持最小位置改动。

## 5. 正式回归 oracle 建议

正式用例应通过独立的 frame 比较检查行为，避免逐行重写生产夹取公式：

1. 在同一 bounds 下单独执行替身原生布局，保留同一 badge 指针、值对应的原生 size、hidden/alpha 和原生 frame，作为“同窄 item”的基准。不是以原始完整宽 item 作为比较基准。
2. 执行真实 adapter 后断言非零有限 frame、badge 同一性、size/hidden/alpha 不变；独立计算四侧 overflow，逐侧要求 `styledOverflow ≤ nativeOverflow + 1e−6/S`。**不要求原生已有部分越界的 frame 一定完全包含于 item。**
3. 使用 nativeWidth=28 的默认基线验证 `.6` 宽99+示例保持同样或更小右越界；包含系统/导入图标、保留/隐藏文字和五档宽度。
4. 添加窄 customSize（例如16宽、实际 size仅作测试输入）、动态放大 nativeWidth、较高文字等边界；候选增加一侧越界时，只允许必要的位置修正，不能缩角标/改内容/改最终图标尺寸。
5. 在 @2x/@3x、非整点 item 宽度和半像素附近分别执行；加入会把非像素上界四舍五入到界外的候选，以 `overflow` 实际值检查，不能给“允许1px”宽容度。可用 `nearbyint` 模拟默认 nearest-even，并用另一种舍入的 setter 变体检验结果不依赖 tie 的猜测。
6. 普通 Update、多次 native item layout、完整 bar layout、内容由红点变数字/99+、开关样式后都检查以上不增量越界不变量；restore 则比较当前原生几何，不恢复旧size，也不复用旧数字宽度。

这些 oracle 能区分“允许的原生部分越界”和“插件新增错误”，不会靠盲目把所有frame塞进item来做绿。真实裁剪链、像素可见性和实际动态字体字宽仍需真机验收，不能把 host oracle 通过说成已看见真机99+。

## 6. 正式落地顺序建议：保留正常 frame 的原生取整

推荐 **先原生取整，再只修新增越界的必要轴**：

1. 按原方案写入候选 target frame，直接读取原生 MMBadgeView getter。
2. 用实际 getter 和同窄 item 的原生 frame 比较四侧 overflow；没有新增越界就结束。这条正常路径保留微信自身的像素舍入、自然观感和原方案结果。
3. 只有某轴确实新增越界时，才将该轴的**实际 origin**夹到第 4 节可行像素格点区间；另一轴保持实际 getter 原值。仍保留原生实际 size。
4. 如需修正，最多增加一次纯位置 frame 写入；之后再次读取 getter，记录最终实际 offset。第二次写入前选择的是可行格点，本 setter 对该坐标应为固定点；如实际值仍不满足上限，只在必要轴使用同步原生 origin 作为有证据的保底，不叠加偏移、不循环尝试。

| 方式 | 正常未新增越界 | 需要约束时 | 取舍 |
| --- | --- | --- | --- |
| 先实际 getter、仅异常轴 clamp | 不主动量化，不改变正常原生结果；一趟原有 badge 写入 | 至多增加一趟纯位置写入；精确匹配实际 setter 结果 | 推荐，正常观感扰动最小 |
| 预先向内格点量化再 clamp | 若连正常候选也预量化，必须复制原生 tie/scale 语义，半像素 tie 可差一像素 | 可以一趟写入，但仍应读实际 getter 验证 | 可证明安全，但对正常 frame 更容易施加不必要的插件舍入 |

容差是数值误差上限，不是可见性宽容度：例如 `1e−6/S` pt 只用于避免二进制浮点尾差触发修正；它比一物理像素小一百万倍。对非像素 item 右边界应先 `floor(upper*S)`，不能把刚刚 round 到界外的一像素当成“差不多”。原生已有3⅚pt右越界在修正前后仍允许3⅚pt，不能因检查更严格而变成强制全部收进item。

对区间约束进行了独立纯数值核对：@2x/@3x、item宽44/48/56.25/58.5/62.1/64.5/97.5、高44/52/80、badge代表宽8/16/24/30/80及高8/16、native图标宽16/28/42、文字高度12/20、保留/隐藏文字、数字/纯点。nearest-even 与 half-away 两种 getter 取整模型各 **10,080** 组，每种有1,724组触发位置约束，约束后新增任一侧 overflow 的组数均为0。该核对只验证数学规则，不编译生产 adapter，不计入正式 Tests 或真机通过数；真实 native 的动态字体字宽仍未测量。
