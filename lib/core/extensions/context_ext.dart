import 'package:flutter/material.dart';

/// BuildContext 扩展 - 提供便捷的导航和颜色访问
extension ContextExtensions on BuildContext {
  /// 导航
  void pushNamed(String route, {Object? arguments}) =>
      Navigator.of(this).pushNamed(route, arguments: arguments);

  void pop<T>([T? result]) => Navigator.of(this).pop<T>(result);

  /// 主题颜色快捷访问
  Color get errorRed => Theme.of(this).colorScheme.error;
  Color get textTertiary => Theme.of(this).textTheme.bodySmall?.color ?? Colors.grey;
  Color get borderLineTint => Theme.of(this).dividerColor;
  Color get surfaceDim => Theme.of(this).colorScheme.surface;
  Color get surfaceBright => Theme.of(this).colorScheme.surface;
  Color get onSurfaceContainer => Theme.of(this).colorScheme.onSurface;
}

/// 主题模式
enum ThemeModeExt {
  light('跟随系统'),
  dark('深色'),
  lightManual('浅色');

  final String label;
  const ThemeModeExt(this.label);
}

/// 视频质量
enum VideoQuality {
  sd('标清', '480p'),
  hd('高清', '720p'),
  fhd('超清', '1080p'),
  qhd('2K', '1440p'),
  uhd('4K', '2160p'),
  auto('自动', 'Auto');

  final String label;
  final String resolution;
  const VideoQuality(this.label, this.resolution);
}

/// 音频质量
enum AudioQuality {
  low('低', '64kbps'),
  medium('中', '128kbps'),
  high('高', '320kbps'),
  lossless('无损', 'FLAC'),
  auto('自动', 'Auto');

  final String label;
  final String bitrate;
  const AudioQuality(this.label, this.bitrate);
}
