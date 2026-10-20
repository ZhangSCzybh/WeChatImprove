# 1.8-22 编译与打包验收

2026-10-19，按用户“编译打包”的要求，在原 checkout `/Users/zhangshichao/Documents/Workspace/WeChatImprove` 编译并生成 Rootless 1.8-22。包含此前完成的五项性能优化及该 checkout 已有功能。同步更新 `control`、插件内版本号、内置更新说明和项目 README；保留 1.8-21 等已有安装包。

| 产物 | 大小 | SHA-256 |
| --- | ---: | --- |
| `packages/com.wechat.improve_1.8-22_iphoneos-arm64.deb` | 807,816 字节 | `78d2b100fd5ba1ac3adc2d04de432b75124de2487a6ea34890f6f802515a2225` |
| `packages/WeChatImprove-1.8-22-dSYMs.zip` | 3,432,631 字节 | `c6f5541f9b1d7ce870e51a41616542425a2cd0a9c36e68360a6d4041f2ee8cfe` |

构建使用项目现有 Theos 配置：`DEBUG=0`、`FINALPACKAGE=1`、Rootless、arm64/arm64e、最低目标 iOS 15.0。执行 `make -j4 package`，输出放入独立临时目录，没有执行 `make clean`。构建退出码为 0，仍有现有弃用 API 和链接器警告。

验收通过：

- 包标识 `com.wechat.improve`，版本 `1.8-22`，Debian 架构 `iphoneos-arm64`；包内 dylib 同时包含 arm64 和 arm64e。
- 包内、staging 和构建目录内的 dylib SHA-256 一致；包内包含新版本字符串及新增图片加载器、文本匹配函数。
- 两个架构的 dSYM UUID 分别匹配包内 dylib，符号 ZIP 内容及完整性已核对。
- 注入过滤配置与源码语义一致。Theos 将源码 OpenStep plist 转换为二进制 plist，因此使用解码后的内容比较。
- 包内没有测试和审计文件，未导出气泡扫描、合并描述的测试计数器。
- 构建前后源码清单一致；五项优化的 30 个代码、测试及构建配置文件与已通过 11 组测试的内容一致。
- 本次打包仅额外修改四个版本和说明文件。已有安装包、符号文件及其他已记录产物的哈希保持不变。

详细机器记录见 [verification.json](verification.json)，构建命令见 [build-command.json](build-command.json)，完整日志见 [build.log](build.log)，包内文件见 [package-contents.txt](package-contents.txt)。核验过程保存在 [verify-delivery.py](verify-delivery.py)。

已完成本地编译打包，未安装到手机，未切换服务、账号或数据库。前一阶段的测试结果见 [五项优化验收记录](../README.md)；这次只更新发布元数据，没有重复运行已经通过且功能源码未变化的测试。真机流畅度和耗电效果仍需实测。
