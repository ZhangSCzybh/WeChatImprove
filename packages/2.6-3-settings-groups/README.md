# 2.6-3 设置首页分组调整

发布日期：2026-11-14。

将“信息时间”和“后台模糊”从“功能增强”移至“界面定制”。“界面定制”组末尾依次为：

**聊天分组 → 信息时间 → 后台模糊**

两个入口继续进入原设置页面，使用原有图标、配置键和偏好域。此次调整不涉及配置迁移。包版本、插件显示版本、内置版本说明和仓库当前版本说明均更新为 `2.6-3`。

## 安装包与附件

用户当前为 **Rootless** 环境，使用下面的 Rootless 安装包。

| 产物 | 说明 |
| --- | --- |
| [Rootless 安装包](com.wechat.improve_2.6-3_iphoneos-arm64.deb) | Debian 架构 `iphoneos-arm64`，动态库安装到 `/var/jb/Library/MobileSubstrate/DynamicLibraries/` |
| [Rootful 安装包](com.wechat.improve_2.6-3_iphoneos-arm.deb) | Debian 架构 `iphoneos-arm`，动态库安装到 `/Library/MobileSubstrate/DynamicLibraries/` |
| [重签用动态库](WeChatImprove.dylib) | 从本版 Rootful 安装包提取，与包内动态库 SHA-256 一致 |
| [调试符号](symbols.zip) | 包含 Rootless、Rootful 各自的 arm64 / arm64e dSYM，共四份，按方案与架构分目录 |
| [SHA-256 清单](SHA256SUMS) | 上述两个安装包、动态库和符号压缩包的校验值 |

两种安装包均包含 `arm64`、`arm64e`，最低编译目标 iOS 15.0，使用本机 Xcode 的 iPhoneOS 27.2 SDK 构建。

## 构建与验证

两种方案分别在 `.theos/release-2.6-3/rootless/`、`.theos/release-2.6-3/rootful/` 中完成全量构建。未运行 `make clean`，也未覆盖已有构建目录。构建命令如下，在仓库根目录运行：

```bash
make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootless \
  PACKAGE_VERSION=2.6-3 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-3/rootless" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-3-settings-groups"

make package -j4 THEOS=/Users/zhangshichao/theos SCHEME=rootful \
  PACKAGE_VERSION=2.6-3 \
  _THEOS_LOCAL_DATA_DIR="$PWD/.theos/release-2.6-3/rootful" \
  THEOS_PACKAGE_DIR="$PWD/packages/2.6-3-settings-groups"
```

已完成以下核验：

- `git diff --check` 通过；两个设置入口各出现一次，归属和顺序正确，点击仍进入原设置页。
- Rootless / Rootful 全量编译、链接、签名与打包成功；本次修改的 `CSCustomViewController.m`、`CSReleaseNotesViewController.m` 没有编译警告。构建保留项目已有的弃用 API 和 `-multiply_defined` 链接选项警告。
- 两包的包名、版本 `2.6-3`、Debian 架构及安装目录正确；包内动态库均含 arm64 / arm64e，两个架构的最低系统版本均为 iOS 15.0。
- 包内仅包含插件动态库与注入 plist；plist 转换为二进制后，解析内容与源码一致。Rootless 两个架构的 `/var/jb` RPATH 已核验。
- 四份 dSYM 的 UUID 与对应包内动态库一致；`symbols.zip` CRC 核验通过。
- 构建输入 SHA-256 前后一致；构建前已有的 17 份安装包目录文件和 11 份已有构建文件，其 SHA-256、大小及修改时间均保持一致。
- 已生成并复核四份产物的 SHA-256 清单。

本机构建日志和产物核验数据位于 `.theos/release-2.6-3/`。

本版尚未安装到手机，设置页面显示和点击操作仍待原设备验收。
