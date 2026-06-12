/// 发现页面状态管理
import 'package:flutter/material.dart';
import '../../../../core/models/media_models.dart';

class DiscoverProvider extends ChangeNotifier {
  List<ContinueWatchingItem> _recentItems = [];
  List<MediaItem> _trendingItems = [];
  List<MediaItem> _recommendedItems = [];
  List<MediaItem> _newReleaseItems = [];
  List<MediaItem> _searchResults = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<ContinueWatchingItem> get recentItems => _recentItems;
  List<MediaItem> get trendingItems => _trendingItems;
  List<MediaItem> get recommendedItems => _recommendedItems;
  List<MediaItem> get newReleaseItems => _newReleaseItems;
  List<MediaItem> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  void initialize() {
    _loadMockData();
  }

  void _loadMockData() {
    _recentItems = [
      ContinueWatchingItem(
        id: 'cw1', title: '流浪地球2', progress: 0.65,
        position: Duration(minutes: 78), duration: Duration(minutes: 173),
        sourceId: 'aliyun', lastWatched: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      ContinueWatchingItem(
        id: 'cw2', title: '三体', progress: 0.3,
        position: Duration(minutes: 45), duration: Duration(minutes: 150),
        sourceId: 'quark', lastWatched: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ];

    _trendingItems = List.generate(6, (i) => MediaItem(
      id: 't$i', title: '热门推荐 ${i+1}',
      subtitle: '2024 年度大片', sourceId: 'aliyun',
      year: 2024, rating: 4.5 + (i * 0.1),
    ));

    _recommendedItems = List.generate(8, (i) => MediaItem(
      id: 'r$i', title: '为你推荐 ${i+1}',
      subtitle: '根据你的观看历史', sourceId: 'quark',
      year: 2024, rating: 4.0,
    ));

    _newReleaseItems = List.generate(4, (i) => MediaItem(
      id: 'n$i', title: '最新上线 ${i+1}',
      subtitle: '本周新片', sourceId: 'baidu',
      year: 2024, rating: 4.2,
    ));

    notifyListeners();
  }

  Future<void> search(String query) async {
    _searchQuery = query;
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _searchResults = _trendingItems
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    _isLoading = false;
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    notifyListeners();
  }
}
