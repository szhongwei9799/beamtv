/// 本地媒体页面状态管理
import 'package:flutter/material.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/constants/app_constants.dart';

class LocalMediaProvider extends ChangeNotifier {
  List<MediaSource> _sources = [];
  List<MediaItem> _mediaItems = [];
  List<ContinueWatchingItem> _continueWatching = [];
  bool _isLoading = false;
  String? _selectedSourceId;
  String _searchQuery = '';

  List<MediaSource> get sources => _sources;
  List<MediaItem> get mediaItems => _mediaItems;
  List<ContinueWatchingItem> get continueWatching => _continueWatching;
  bool get isLoading => _isLoading;
  String? get selectedSourceId => _selectedSourceId;
  String get searchQuery => _searchQuery;

  void initialize() {
    _loadMockData();
  }

  void _loadMockData() {
    _sources = [
      MediaSource(id: 'aliyun', name: '阿里云盘', type: MediaSourceType.aliyun, url: 'https://aliyundrive.com/media', itemCount: 128, isConnected: true),
      MediaSource(id: 'quark', name: '夸克网盘', type: MediaSourceType.quark, url: 'https://pan.quark.cn/s/share', itemCount: 64, isConnected: true),
      MediaSource(id: 'baidu', name: '百度网盘', type: MediaSourceType.baidu, url: 'https://pan.baidu.com/s/1share', itemCount: 0, isConnected: false),
    ];
    _mediaItems = List.generate(12, (i) => MediaItem(
      id: 'm$i', title: '媒体文件 ${i+1}',
      subtitle: 'MP4  •  1080p  •  2.3GB',
      sourceId: 'aliyun', year: 2024,
    ));
    _continueWatching = [
      ContinueWatchingItem(
        id: 'cw1', title: '流浪地球2', progress: 0.65,
        position: const Duration(minutes: 78), duration: const Duration(minutes: 173),
        sourceId: 'aliyun', lastWatched: DateTime.now(),
      ),
    ];
    notifyListeners();
  }

  void selectSource(String id) {
    _selectedSourceId = id;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  Future<void> search(String query) async {
    _searchQuery = query;
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
    _isLoading = false;
    notifyListeners();
  }

  void removeSource(String id) {
    _sources.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  void addSource(MediaSource source) {
    _sources.add(source);
    notifyListeners();
  }
}
