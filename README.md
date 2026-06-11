# BeamTV (光线传播)

> 智能电视/大屏端流媒体聚合播放平台
> Version 1.2.0 | Flutter 3.24 | Dart 3.5

## ✨ 核心特性

| 功能 | 说明 |
|------|------|
| **多源聚合播放** | 支持主流视频平台（腾讯、爱奇艺、优酷、芒果、B站等）统一检索与播放 |
| **本地媒体库** | SMB/WebDAV/NFS/阿里云盘/夸克/百度/115 网盘挂载，自动刮削海报元数据 |
| **智能推荐** | 协同过滤 + 内容向量双路推荐，跨设备同步观看进度/收藏/播放列表 |
| **画质增强** | HDR10+/Dolby Vision 直通、AI 超分 (FSRCNN/RealESRGAN)、帧率插值 |
| **字幕系统** | 内嵌/外挂自动匹配、双语对照、时间轴微调、在线字幕搜索 |
| **直播聚合** | 央视/卫视/地方台/体育/新闻 2000+ 直播源，EPG/时移/录制 |
| **家庭云** | 基于 WebDAV 的家庭共享媒体库，多用户权限隔离 |

## 📱 支持平台

| 平台 | 最低版本 | 推荐版本 | 备注 |
|------|----------|----------|------|
| **Android TV** | Android 9 (API 28) | Android 12+ | Leanback / Google TV Launcher |
| **tvOS** | tvOS 15.0 | tvOS 17+ | 原生 SwiftUI，支持 Focus Engine |
| **Linux TV** | Ubuntu 20.04+ / Debian 11+ | Ubuntu 22.04+ | Wayland/X11 双支持 |
| **Windows** | Windows 10 1903+ | Windows 11 | 支持 HDR/WCG |
| **macOS** | macOS 12+ | macOS 14+ | Apple Silicon 原生 |

## 🏗 技术架构

```
BeamTV/
├── lib/
│   ├── main.dart                    # 应用入口
│   ├── core/
│   │   ├── theme/beam_theme.dart    # Linear 风格深色主题系统
│   │   ├── routing/app_router.dart  # go_router 路由配置
│   │   └── constants/app_constants.dart
│   ├── features/
│   │   ├── local_media/             # 本地媒体 - "我的库"
│   │   ├── discover/                # 发现 - "找内容" (原网络媒体)
│   │   └── settings/                # 设置
│   └── shared/widgets/              # 通用组件
├── android/                         # Android TV 配置
├── .github/workflows/               # CI/CD
└── pubspec.yaml
```

**核心技术栈：**
- **UI**: Flutter 3.24 + Dart 3.5 (Impeller/Skia/Vulkan)
- **架构**: Provider 状态管理 + go_router 声明式路由
- **解码**: FFmpeg 6.1 + libplacebo + dav1d/rav1e (AV1/H.265/VP9/H.264 硬解)
- **音频**: DTS-HD MA / Dolby TrueHD 位流直通 / PCM 多声道
- **网络**: HTTP/HTTPS/WebSocket/SRT/RIST/HLS/DASH/RTMP/MMS
- **存储**: SQLite + LevelDB + SQLCipher

## 🎨 设计语言

参考 **Linear** 设计系统：
- **深色模式原生**: `#08090A` 营销黑 / `#0F1011` 面板 / `#191A1B` 表面
- **半透明白边框**: `rgba(255,255,255,0.05~0.08)` 代替实线
- **品牌强调色**: Indigo `#5E6AD2` / Violet `#7170FF` (仅用于 CTA 与交互)
- **字体**: Inter Variable (cv01+ss03) + JetBrains Mono
- **三权重系统**: 400 阅读 / 510 强调 / 590 标题
- **负字间距**: Display 级别 -1.584px ~ -1.056px

## 🚀 快速开始

### 环境要求
- Flutter SDK 3.24+
- Dart SDK 3.5+
- Android SDK 34 (API 34)
- JDK 17

### 本地构建

```bash
# 克隆仓库
git clone https://github.com/your-username/beamtv.git
cd beamtv

# 安装依赖
flutter pub get

# 生成代码 (freezed, json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# 调试运行 (连接 Android TV 设备/模拟器)
flutter run

# 构建 Debug APK
flutter build apk --debug --split-per-abi

# 构建 Release APK (需配置签名)
flutter build apk --release --split-per-abi
```

### CI/CD 自动构本

推送到 `main` 分支或创建 `v*` 标签会自动触发 GitHub Actions 构建：

- **Debug APK**: 每次推送自动构建，保留 30 天
- **Release APK**: 打标签时自动构建并发布到 Releases，保留 90 天

**下载最新 Debug APK**: [GitHub Actions Artifacts](../../actions/workflows/build-android.yml)

## 📦 APK 下载

| 类型 | 架构 | 下载链接 |
|------|------|----------|
| Debug | arm64-v8a | `beamtv-debug-apk/app-arm64-v8a-debug.apk` |
| Debug | armeabi-v7a | `beamtv-debug-apk/app-armeabi-v7a-debug.apk` |
| Debug | x86_64 | `beamtv-debug-apk/app-x86_64-debug.apk` |

> **注意**: Debug APK 仅用于测试，生产环境请使用 Release 版本。

## ⚙️ 配置说明

### 首次启动
1. 进入 **本地媒体** → 点击右上角 `+` 添加媒体源
2. 支持类型：SMB / WebDAV / NFS / 阿里云盘 / 夸克网盘 / 百度网盘 / 115网盘 / M3U / IPTV
3. 添加后自动刮削海报、元数据、演职员信息

### 跨设备同步
1. 设置 → 账户与同步 → 开启跨设备同步
2. 登录相同账户即可同步：观看进度、收藏、播放列表、媒体源配置

### 画质/音频偏好
设置 → 播放设置：
- 画质：自动 / 4K优先 / 1080p优先 / 720p优先 / 省流模式
- 音频：自动 / 无损优先 / 高质量 / 标准
- HDR/Dolby Vision：开启后自动匹配显示能力
- AI超分：FSRCNN 实时超分 (需设备支持)

## 🛠 开发指南

### 项目结构规范
- **Feature-first**: 按业务领域组织 (`features/local_media`, `features/discover`)
- **Layered**: presentation / domain / data 分层
- **Provider**: 状态管理使用 `ChangeNotifierProvider`
- **Router**: 所有路由集中在 `core/routing/app_router.dart`

### 代码风格
```bash
# 格式化
dart format .

# 静态分析
flutter analyze

# 运行测试
flutter test
```

### 添加新页面
1. 在对应 feature 下创建 `presentation/pages/xxx_page.dart`
2. 在 `AppRouter` 中注册路由
3. 如需底部导航，在 `MainScaffold` 添加 `StatefulShellBranch`

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE)

## 🤝 贡献

欢迎提交 Issue 和 PR！

1. Fork 本仓库
2. 创建特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交更改 (`git commit -m 'Add amazing feature'`)
4. 推送分支 (`git push origin feature/amazing-feature`)
5. 创建 Pull Request

## 📞 联系

- GitHub Issues: [问题反馈](../../issues)
- 邮箱: beamtv@example.com

---

**BeamTV** - 让好的内容流动 🌊