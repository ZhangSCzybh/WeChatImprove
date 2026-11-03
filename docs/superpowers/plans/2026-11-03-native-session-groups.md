# Native Session Groups Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** 将主聊天列表改为原生数组分组，保留密友与完整源消费者，修正刷新收敛。

**Architecture:** 共享规则生成原对象结果，协调器管理完整基线与原生发布；主列表使用原生坐标，折叠子页保留投影。完整源消费者通过按 surface 隐私过滤的同步 scope 取数，元数据和动作继续验证身份版本。

**Tech Stack:** Theos、Objective-C/Logos、Foundation、UIKit、macOS clang 行为夹具。

**Spec:** `docs/superpowers/specs/2026-11-03-native-session-groups-design.md`

## Global Constraints

- 当前交付 checkout：`/Users/zhangshichao/Documents/Workspace/WeChatImprove`，起点 `863bfdb350fddf678c349574d99badb241d98958`，配置版本 `2.2-6`。
- 保留当前账号配置、密友凭据、工作区既有删除项及历史包。测试夹具只在隔离目录恢复，构建使用冻结生产源码与独立输出。
- `MMNewSessionMgr.m_arrSession` 与聊天数据库只读。
- 本轮不启动、安装或重启设备微信，不访问实际微信数据库。

## Task 1: 原生模型与完整基线

**Files:** Create `Controllers/CSGroupNativeModel.{h,m}`, `Controllers/CSGroupNativeSessionCoordinator.{h,m}`.

**Interfaces:** 保持历史冻结源的 `CSGroupNativeModelResult`、`refreshFromPreferences`、`performNativeRebuildForManager:original:`、`performNativeMutationForManager:original:` 契约；新增：

```objc
- (BOOL)performWithCompleteSourceForSurface:(CSCloseFriendSurface)surface
                                  original:(void (^)(void))original;
```

- [x] 对照历史 SHA-256 并审查完整基线、原实例、置顶、账号/epoch、setter 失败及重入。
- [x] 移植组件；完整候选 scope 只支持 Session/Forward，返回 BOOL 决定是否信任产物，finally 恢复当前组。
- [x] 当前生产实现通过模型与协调器行为回归。

## Task 2: 原生主列表集成

**Files:** Modify `Controllers/CSGroupListAdapter.{h,m}`, `Controllers/CSGroupNativeBridge.{h,m}`, `Hooks/SessionGroupHooks.xm`; create `Hooks/NativeSessionGroupHooks.xm`.

**Interfaces:** 消费 Task 1 模型/协调器；保留 Adapter 的现有外部接口与折叠页代理。

- [x] 主列表退出代理与双坐标事务；读取原生对象元数据时固定并复核 model/revision/epoch/policy。
- [x] 完整源统计供标签与全局角标；Forward 枚举在完整候选 scope 中物化，返回独立枚举器。
- [x] 行操作、首帧遮罩、业务行和折叠摘要通过行为回归。

## Task 3: 完整未读面板与持久刷新调度

**Files:** Modify `Controllers/CSCloseFriendUnreadPanelAdapter.m`, `Hooks/CloseFriendUnreadPanelHooks.xm`, `Controllers/CSGroupListAdapter.m` 的调度方法。

**Interfaces:** 面板根据 `performWithCompleteSourceForSurface:original:` 返回值决定是否撤罩；新增内部 `consumeRefreshRequest` 在实际发布前清理本次 pending。

- [x] 未读面板重建使用 Session 完整候选，失败不能仅凭 selector 存在就发布。
- [x] 持久 coalesced/urgent、80ms latest / 250ms burst cap；schedule 不置 dirty；真实 1→0 才唤醒。
- [x] 行为回归覆盖 publishing 中重入、urgent 抢占、空调度和多余 end。

## Task 4: 隔离验证、构建与交付

**Files:** Create `docs/audits/session-groups-native-2026-11-03/validation/`、审计说明与结果；更新项目 README 的实现状态。

- [x] 在新 validation 目录保留可复跑的本次测试；旧 Tests 从 Git 只导出到临时夹具，不恢复用户删除项。
- [x] 独立复核生产改动，修复实质问题后重跑受影响测试。
- [x] 冻结当前生产输入，分别构建 rootless/rootful，记录输入/产物哈希并验证双架构。
- [x] 核实工作区既有删除项与历史包保留；交付当前代码、验证证据及真机验收限制。
