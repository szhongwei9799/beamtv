// BeamTV 核心常量定义
library core.constants;

/// 应用基础信息
class AppConstants {
  static const String appName = 'BeamTV';
  static const String appNameZh = '光线传播';
  static const String version = '1.2.0';
  static const int buildNumber = 12;
  static const String packageName = 'com.beamtv.app';

  /// 支持的最小 Android API 级别
  static const int minSdkVersion = 28; // Android 9
  static const int targetSdkVersion = 34; // Android 14
}

/// 存储键名
class StorageKeys {
  static const String themeMode = 'theme_mode';
  static const String languageCode = 'language_code';
  static const String lastSelectedTab = 'last_selected_tab';
  static const String mediaSources = 'media_sources';
  static const String watchHistory = 'watch_history';
  static const String favorites = 'favorites';
  static const String playbackSettings = 'playback_settings';
}

/// 路由路径
class Routes {
  static const String initial = '/';
  static const String localMedia = '/local-media';
  static const String discover = '/discover';
  static const String settings = '/settings';
  static const String player = '/player';
  static const String sourceDetail = '/source-detail';
  static const String addSource = '/add-source';
  static const String search = '/search';
}

/// 默认配置
class Defaults {
  static const int gridCrossAxisCount = 3;
  static const double gridChildAspectRatio = 0.7;
  static const int pageSize = 20;
  static const Duration debounceDuration = Duration(milliseconds: 300);
  static const Duration animationDuration = Duration(milliseconds: 200);
}

enum VideoCodec {
  av1('AV1'),
  h265('H.265/HEVC'),
  h264('H.264/AVC'),
  vp9('VP9'),
  unknown('未知');

  const VideoCodec(this.label);
  final String label;
}

/// 音频编码格式
enum AudioCodec {
  dtsHdMa('DTS-HD MA'),
  dolbyTrueHd('Dolby TrueHD'),
  dts('DTS'),
  dolbyDigitalPlus('Dolby Digital+'),
  aac('AAC'),
  opus('Opus'),
  flac('FLAC'),
  pcm('PCM'),
  unknown('未知');

  const AudioCodec(this.label);
  final String label;
}

/// HDR 格式
enum HdrFormat {
  hdr10('HDR10'),
  hdr10Plus('HDR10+'),
  dolbyVision('Dolby Vision'),
  hlg('HLG'),
  sdr('SDR');

  const HdrFormat(this.label);
  final String label;
}