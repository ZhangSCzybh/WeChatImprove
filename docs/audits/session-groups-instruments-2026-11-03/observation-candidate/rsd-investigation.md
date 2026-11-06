# Frida RSD 发现失败：只读调查

本调查发生在 root 完成无注入的四场景 Instruments 基线之后。root 的一次无脚本附加能力检查返回 `NotSupportedError: unable to detect RSD port`，原始结果见上一层 `runtime-attach-capability.json`。本调查没有再次附加或注入设备，没有安装软件、启动服务/隧道或重启 `remoted`。

**结论：现有环境可确认 Xcode 的设备隧道工作正常，但未找到可直接向 Frida 17.8.2 的现有 USB 连接指定 RSD 端口的公开参数。不能通过 `-H`/`add_remote_device` 把 RSD 端口当作 Frida 服务端口使用。**

## 已确认的现有工具和状态

- 本机 Frida `17.8.2`、frida-tools `14.6.1`；Python 环境在 `/opt/homebrew/Caskroom/miniconda/base/`。
- Xcode `devicectl device info details` 只读查询成功，目标 UDID `00008120-001064E10E70201E` 的隧道地址为 `fdeb:9d36:10b5::1`、状态 `connected`、传输 `tcp`。
- 系统已有 `/usr/libexec/remotectl`，不在 PATH。`list` 与 `show -t coredevice-device ...` 成功，显示目标设备 `connected`、接口 `utun6`。`get-property ... RSDPort` 返回退出码 66，`No such property "RSDPort"`。
- `remotectl dumpstate` 显示设备和服务信息，未给出可明确标为 RSD 的端口。没有调用它的 `relay`、`reset`、`alias`、`synctime` 或 `identity` 写操作。
- 普通用户 `lsof -nP -iTCP` 可见 CoreDevice、Instruments 与 xctrace 到同一设备地址的既有业务服务连接，例如 Instruments 到 60496。它未显示 `/usr/libexec/remoted` 的对应连接，未能从输出确定 RSD 端口。不能把某个业务端口猜为 RSD。
- 系统 `remoted` 进程存在，归属 root。当前信息不足以判断 Frida 失败是连接列表可见性、系统 TCP 结构兼容、进程路径匹配还是其他发现步骤；没有据此宣称是权限问题或服务未运行。
- `pymobiledevice3`、`pytun-pmd3` 未安装。已有 `tidevice` CLI 因缺 `pkg_resources` 在导入阶段失败；没有为此修改 Python 环境。

## Frida 同版本源码证据

读取的是官方 `17.8.2` 标签源码：

- [device-monitor-macos.vala，RSD 发现流程](https://github.com/frida/frida-core/blob/17.8.2/src/fruity/device-monitor-macos.vala#L358)
- [socket-host-session.vala，远程 Frida 服务连接](https://github.com/frida/frida-core/blob/17.8.2/src/socket/socket-host-session.vala#L94)

macOS 的 `locate_discovery_service` 在第 358–409 行：遍历 `XNU.query_active_tcp_connections()`；只保留 IPv6 且 `foreign_address` 等于隧道设备地址的连接；调用 `proc_pidpath(effective_pid)` 后要求路径严格等于 `/usr/libexec/remoted`；取该连接的 `foreign_port`，建立 RemoteXPC DiscoveryService；失败后报 `Unable to detect RSD port`。该流程尝试 0、50、250 ms 三个间隔。

该 macOS 文件没有读取 `Environment.get_variable` / `getenv`，未发现 `RSD_PORT` / `rsd-port` 外部覆盖参数。现有 Python `Device.attach` 参数为 pid/realm/persist_timeout，`DeviceManager.add_remote_device` 的可选项为 certificate/origin/token/keepalive_interval；没有 RSD 端口入口。`add_remote_device` 进入 socket 后端，连接对象是 Frida 服务协议，不能用苹果 RemoteXPC 服务发现端口替代。

## 可行范围与停止点

在不新增服务、不换工具、不改环境的约束下，可以继续使用已经成功的 Xcode Instruments 采样，保留未注入基线及精确调用计数不可用的边界。RSD 观察器不应为了填满报告而被标记为可用或已执行。

若未来单独处理 Frida 兼容，需要恢复它自身的 RSD 发现能力，或使用明确支持手动 RSD 地址的客户端/版本，或已有且可达的 Frida server。上述条件均没有在本调查中得到验证；没有建立或启动这些环境，也没有将它们当成本次可交付路径。
