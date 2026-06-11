// 本地媒体 Provider - 状态管理
library features.local_media.presentation.providers;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_media_page.dart';

class LocalMediaProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  List<MediaSource> _sources = [];
  List<ContinueWatchingItem> _continueWatching = [];
  List<MediaItem> _recentlyAdded = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<MediaSource> get sources => _sources;
  List<ContinueWatchingItem> get continueWatching => _continueWatching;
  List<MediaItem> get recentlyAdded => _recentlyAdded;

  Future<void> initialize() async {
    _setLoading(true);
    _error = null;

    try {
      await _loadFromStorage();
      _generateMockData(); // 临时模拟数据
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refresh() async {
    await initialize();
  }

  Future<void> refreshSource(String sourceId) async {
    final index = _sources.indexWhere((s) => s.id == sourceId);
    if (index != -1) {
      _sources[index] = _sources[index].copyWith(lastScraped: DateTime.now());
      notifyListeners();
      await _saveToStorage();
    }
  }

  Future<void> addSource(MediaSource source) async {
    _sources.add(source);
    notifyListeners();
    await _saveToStorage();
  }

  Future<void> deleteSource(String sourceId) async {
    _sources.removeWhere((s) => s.id == sourceId);
    notifyListeners();
    await _saveToStorage();
  }

  Future<void> updateWatchProgress(ContinueWatchingItem item) async {
    final index = _continueWatching.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _continueWatching[index] = item;
    } else {
      _continueWatching.insert(0, item);
    }
    // 保持最多 20 条
    if (_continueWatching.length > 20) {
      _continueWatching = _continueWatching.take(20).toList();
    }
    notifyListeners();
    await _saveToStorage();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO: 从本地存储恢复数据
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    // TODO: 持久化数据
  }

  // 临时模拟数据 - 正式版从存储/网络获取
  void _generateMockData() {
    _sources = [
      MediaSource(
        id: 'src_1',
        name: 'NAS 电影库',
        type: MediaSourceTypeEx.smb,
        configSummary: 'smb://192.168.1.100/Movies',
        itemCount: 1247,
        lastScraped: DateTime.now().subtract(const Duration(hours: 2)),
        isOnline: true,
      ),
      MediaSource(
        id: 'src_2',
        name: '夸克网盘 - 4K 资源',
        type: MediaSourceTypeEx.quark,
        configSummary: '已授权 • 2.3 TB 可用',
        itemCount: 342,
        lastScraped: DateTime.now().subtract(const Duration(days: 1)),
        isOnline: true,
      ),
      MediaSource(
        id: 'src_3',
        name: '阿里云盘 - 资源分享',
        type: MediaSourceTypeEx.aliyun,
        configSummary: '已授权 • 1.1 TB 可用',
        itemCount: 568,
        lastScraped: DateTime.now().subtract(const Duration(hours: 6)),
        isOnline: true,
      ),
      MediaSource(
        id: 'src_4',
        name: 'IPTV 直播源',
        type: MediaSourceTypeEx.iptv,
        configSummary: 'https://example.com/live.m3u',
        itemCount: 240,
        lastScraped: DateTime.now().subtract(const Duration(minutes: 30)),
        isOnline: true,
      ),
    ];

    _continueWatching = [
      ContinueWatchingItem(
        id: 'cw_1',
        title: '流浪地球 2',
        subtitle: '4K HDR • DTS-HD MA 7.1',
        posterUrl: 'https://picsum.photos/seed/wandering2/300/450',
        progress: 0.67,
        mediaType: 'movie',
      ),
      ContinueWatchingItem(
        id: 'cw_2',
        title: '三体',
        subtitle: 'S01E12 • 1080p',
        posterUrl: 'https://picsum.photos/seed/3body/300/450',
        progress: 0.45,
        mediaType: 'series',
        episodeNumber: 12,
        seasonNumber: 1,
      ),
      ContinueWatchingItem(
        id: 'cw_3',
        title: '奥本海默',
        posterUrl: 'https://picsum.photos/seed/oppenheimer/300/450',
        progress: 0.23,
        mediaType: 'movie',
      ),
    ];

    _recentlyAdded = [
      MediaItem(
        id: 'ra_1',
        title: '沙丘 2',
        subtitle: '4K DV • 2024',
        posterUrl: 'https://picsum.photos/seed/dune2/300/450',
        mediaType: 'movie',
        badge: 'New',
      ),
      MediaItem(
        id: 'ra_2',
        title: '权力的游戏',
        subtitle: '全 8 季 • 4K HDR',
        posterUrl: 'https://picsum.photos/seed/got/300/450',
        mediaType: 'series',
      ),
      MediaItem(
        id: 'ra_3',
        title: '星际穿越',
        subtitle: 'IMAX 4K • 2014',
        posterUrl: 'https://picsum.photos/seed/interstellar/300/450',
        mediaType: 'movie',
      ),
      MediaItem(
        id: 'ra_4',
        title: '黑镜',
        subtitle: 'S06 更新中',
        posterUrl: 'https://picsum.photos/seed/blackmirror/300/450',
        mediaType: 'series',
        badge: 'Updating',
      ),
      MediaItem(
        id: 'ra_5',
        title: '银翼杀手 2049',
        subtitle: '4K HDR • 2017',
        posterUrl: 'https://picsum.photos/seed/blade2049/300/450',
        mediaType: 'movie',
      ),
      MediaItem(
        id: 'ra_6',
        title: '西部世界',
        subtitle: '全 4 季 • 4K',
        posterUrl: 'https://picsum.photos/seed/westworld/300/450',
        mediaType: 'series',
      ),
    ];
  }
}

// 为 MediaSource 添加 copyWith (简化版)
extension MediaSourceCopyWith on MediaSource {
  MediaSource copyWith({
    String? id,
    String? name,
    MediaSourceTypeEx? type,
    String? configSummary,
    int? itemCount,
    DateTime? lastScraped,
    bool? isOnline,
    String? error,
  }) {
    return MediaSource(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      configSummary: configSummary ?? this.configSummary,
      itemCount: itemCount ?? this.itemCount,
      lastScraped: lastScraped ?? this.lastScraped,
      isOnline: isOnline ?? this.isOnline,
      error: error ?? this.error,
    );
  }
}

// 临时导入 MediaItem
import 'media_grid.dart';