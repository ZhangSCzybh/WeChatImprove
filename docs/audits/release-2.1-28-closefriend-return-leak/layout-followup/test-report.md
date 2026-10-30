布局补充测试使用独立的 `GroupReturnLayoutTests.m`，保留原 37 项隐私回归及其历史日志、哈希。

同一最终测试版本的控制结果：

| 控制源码 | 检查 | 通过 | 失败 | 日志 |
|---|---:|---:|---:|---|
| 未修改的 2.1-27 `e9d4601c` | 861 | 251 | 610 | layout-27-red.log |
| 首次交付的 2.1-28 `af84d15d` | 861 | 691 | 170 | layout-initial28-red.log |
| 当前同步恢复布局补丁 | 861 | 861 | 0 | layout-fixed28-green.log |
| 37 项隐私回归，27 控制 | 37 | 25 | 12 | privacy-27-red.log |
| 37 项隐私回归，当前补丁 | 37 | 37 | 0 | privacy-fixed28-green.log |

27 的失败同时覆盖未过滤身份、错误 section 行数、逐行 y/height、原生装饰回调中的首末行圆角角色和完整布局返回后的 offset。初版 28 已保护隐私，但首次完整布局仍停在原生临时 offset -25，而生产 viewport helper 得到的稳定值为 360；同 revision 下离页插入/移除 Group、移动置顶行也先用了旧投影。修复后，首轮及随后每个完整布局结果都与过滤后的稳定结果逐项相等。

模型为真实选中的 Group 分组及三个原生 section：业务行、置顶、普通。模型包含密友、密群、普通私聊、服务号/公众号容器和普通群；分组归属由生产 NativeBridge/Projection 决定。额外覆盖所选 Group 下置顶 section 被过滤为空，确保空 section 数量与行几何也一致。解锁时受保护群可见，普通私聊仍不属于 Group；原有语义不变。

两种装饰 hook 顺序的结果一致：

| 分支 | originalLayout 实际计算次数 | 完整 table hook 返回次数 | 表格 mutation |
|---|---:|---:|---|
| 稳定锁定返回 | 1 | 1 | 0 |
| 所选分组有空 section | 1 | 1 | 0 |
| 解锁返回 | 1 | 1 | 0 |
| 同一 native owner 范围内同步重入 | 2 | 2 | 0 |
| 离页 relock | 2 | 2 | 1 次已有结构 publication |
| blocked 阶段 | 2 | 2 | 1 次安全空结构 publication |
| 随后 ready 阶段（单独计数） | 2 | 2 | 1 次过滤结构 publication |
| 同 revision 离页插入/移除群并移动置顶 | 2 | 2 | 1 次已有结构 publication |

这些计算次数来自实际执行的 originalLayout 替身，不是计时帧数或 UIKit 提交事务数。两个同步计算均在可见布局 guard 内完成，所有完整返回结果的 section、行 y/height、首末角色和 offset 均一致。稳定锁定返回显式设置 dirty=YES 模拟实际离页失效，但集合未变；新增同步 gate 仍只计算一次 originalLayout，且没有整表或局部 reload。真实结构发生变化时沿用既有 publication 方法。

边界：真实执行 Native index scope、可见布局 hook/guard、NativeBridge、Group/隐私投影、按 section 计数和高度调用映射、身份解析、`CSGroupCardPosition`、隐私 shield，以及 `presentationScrollHeight`、`restoreScrollHeight`、`saveAnchor` 等 viewport helpers。UIKit 几何替身使用固定 section 间距和 native fixture 行高，稳定参照也通过相同的生产投影、行高映射及圆角方法计算，没有把期望角色硬编码为首末索引。真实圆角装饰 table hook 与真实 restore-depth wrapper 按两种顺序组合；后续 paint repair 为只计数的替身，不查询行或重算圆角。refresh 的 admission/chrome 为替身，调用生产 projection/publication 接缝。没有在真机测量帧提交，也没有以 host 结果声称真机已复录零错位帧。

37 项旧 fixture 仅补充 `presentationScrollHeight=nil`、`restoreScrollHeight` 空实现以兼容新 guard；其断言未改，场景继续专注没有 retained viewport 的身份交付。真实 viewport 与原生临时 inset/offset 的组合由新增 861 项布局套件负责。最终同版本输入和源码 SHA256 见 `test-inputs.json`。
