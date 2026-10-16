# Bubble / Revoke Implementation Plan

**Goal:** 恢复气泡样式，修复私聊和重进页面的原文点击，提供最终定位标记。
**Architecture:** Core Graphics 模板与配置纯层；真实 Cell 负责背景应用；持久链接解析与会话校验独立于合并；导航请求负责生命周期与标记。
**Tech Stack:** Objective-C / Logos / Theos / macOS Foundation/CoreGraphics tests.
**Spec:** docs/superpowers/specs/2026-10-16-bubble-revoke-design.md（用户已批准实施）。

直接顺序执行；不创建其他工作区、不改设备或数据库；保留全部旧包和当前未提交工作。

- [x] 提取中立 CSChatNativeBridge，供现有合并及新适配器复用。
- [x] CSBubbleStylePolicy + CSBubbleStyleAdapter：配置、模板、绑定、复用恢复、可见刷新，替换旧 BubbleInfo 绘制 Hook；测试配置及实际像素。
- [x] CSRevokeReference：href/正文/pattern 一致性、私聊/群聊关系、结构化事件解析；测试丢失 pattern 与序列化重建。
- [x] CSMessageNavigation：绑定真实聊天，旧新页面无共享请求，截止任务、事务完成后定位与标记；测试拒绝/重试/旧页面销毁。
- [x] RevokeHooks：独立保护/提示结果、去重、链接入口；HideChatTimeHooks 只隐藏目标提示且可恢复。
- [x] 更新新增测试，执行现有回归和 arm64/arm64e Rootless 1.6-3 构建，检查包内版本与旧包校验。
- [x] 写交付记录，明确真实微信运行与图像/性能验收未完成。

本地实施完成；设备运行、持久化与性能验收待用户原环境验证。实际结果见 docs/bubble-revoke-1.6-3.md 与对应 validation.txt。
