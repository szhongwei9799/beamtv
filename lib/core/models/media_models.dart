import 'package:flutter/material.dart';

/// 媒体源
class MediaSource {
  final String id;
  final String name;
  final MediaSourceType type;
  final String url;
  final bool isAvailable;
  final bool isConnected;
  final int itemCount;
  final String? username;
  final String? password;
  final IconData? icon;

  const MediaSource({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    this.isAvailable = true,
    this.isConnected = true,
    this.itemCount = 0,
    this.username,
    this.password,
    this.icon,
  });

  MediaSource copyWith({
    String? id,
    String? name,
    MediaSourceType? type,
    String? url,
    bool? isAvailable,
    bool? isConnected,
    int? itemCount,
    String? username,
    String? password,
    IconData? icon,
  }) {
    return MediaSource(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      isAvailable: isAvailable ?? this.isAvailable,
      isConnected: isConnected ?? this.isConnected,
      itemCount: itemCount ?? this.itemCount,
      username: username ?? this.username,
      password: password ?? this.password,
      icon: icon ?? this.icon,
    );
  }
}

/// 续播条目
class ContinueWatchingItem {
  final String id;
  final String title;
  final String? posterUrl;
  final double progress;
  final Duration position;
  final Duration duration;
  final String sourceId;
  final DateTime lastWatched;

  const ContinueWatchingItem({
    required this.id,
    required this.title,
    this.posterUrl,
    required this.progress,
    required this.position,
    required this.duration,
    required this.sourceId,
    required this.lastWatched,
  });

  String get formattedProgress {
    final pct = (progress * 100).toInt();
    return '$pct%';
  }
}

/// 媒体条目
class MediaItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? posterUrl;
  final String? backdropUrl;
  final Duration? duration;
  final int? year;
  final double? rating;
  final List<String>? genres;
  final String sourceId;
  final bool isFavorite;
  final MediaItemType itemType;

  const MediaItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.posterUrl,
    this.backdropUrl,
    this.duration,
    this.year,
    this.rating,
    this.genres,
    required this.sourceId,
    this.isFavorite = false,
    this.itemType = MediaItemType.video,
  });

  MediaItem copyWith({bool? isFavorite}) {
    return MediaItem(
      id: id,
      title: title,
      subtitle: subtitle,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      duration: duration,
      year: year,
      rating: rating,
      genres: genres,
      sourceId: sourceId,
      isFavorite: isFavorite ?? this.isFavorite,
      itemType: itemType,
    );
  }
}

/// 媒体条目类型
enum MediaItemType {
  video,
  series,
  movie,
  audio,
  live,
  unknown,
}

class MediaSourceTypeEx {
  static const MediaSourceTypeEx emby = MediaSourceTypeEx._('emby', 'Emby');
  static const MediaSourceTypeEx jellyfin = MediaSourceTypeEx._('jellyfin', 'Jellyfin');
  static const MediaSourceTypeEx plex = MediaSourceTypeEx._('plex', 'Plex');
  static const MediaSourceTypeEx local = MediaSourceTypeEx._('local', '本地存储');

  final String value;
  final String displayName;
  const MediaSourceTypeEx._(this.value, this.displayName);

  static List<MediaSourceTypeEx> get values => [emby, jellyfin, plex, local];
}

enum MediaSourceType {
  smb,
  webdav,
  nfs,
  aliyun,
  quark,
  baidu,
  pan115,
  m3u,
  iptv,
}
