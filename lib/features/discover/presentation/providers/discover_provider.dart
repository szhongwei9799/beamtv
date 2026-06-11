// 发现页面 Provider
library features.discover.presentation.providers;

import 'package:flutter/foundation.dart';

import '../widgets/discover_sections.dart';
import 'discover_page.dart';

class DiscoverProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  List<FeaturedItem> _featured = [];
  List<ContinueWatchingItem> _continueWatching = [];
  List<HotRanking> _hotRankings = [];
  List<LiveChannel> _liveChannels = [];
  List<ContentCategory> _categories = [];
  List<MediaItem> _recommendations = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<FeaturedItem> get featured => _featured;
  List<ContinueWatchingItem> get continueWatching => _continueWatching;
  List<HotRanking> get hotRankings => _hotRankings;
  List<LiveChannel> get liveChannels => _liveChannels;
  List<ContentCategory> get categories => _categories;
  List<MediaItem> get recommendations => _recommendations;

  Future<void> initialize() async {
    _setLoading(true);
    _error = null;

    try {
      await Future.delayed(const Duration(milliseconds: 500)); // 模拟网络请求
      _generateMockData();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refresh() async {
    await initialize();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _generateMockData() {
    _featured = [
      FeaturedItem(
        id: 'feat_1',
        title: '流浪地球 2',
        subtitle: '2023 • 科幻/冒险 • 4K HDR',
        backdropUrl: 'https://picsum.photos/seed/wandering2_bg/1280/720',
        badge: '独家 4K',
        onTap: () {},
        onPlay: () {},
        onInfo: () {},
      ),
      FeaturedItem(
        id: 'feat_2',
        title: '三体',
        subtitle: 'S01 全 30 集 • 科幻 • 1080p',
        backdropUrl: 'https://picsum.photos/seed/3body_bg/1280/720',
        badge: '热播中',
        onTap: () {},
        onPlay: () {},
        onInfo: () {},
      ),
      FeaturedItem(
        id: 'feat_3',
        title: '奥本海默',
        subtitle: '2023 • 传记/历史 • IMAX 4K',
        backdropUrl: 'https://picsum.photos/seed/oppenheimer_bg/1280/720',
        onTap: () {},
        onPlay: () {},
        onInfo: () {},
      ),
    ];

    _continueWatching = [
      ContinueWatchingItem(
        id: 'dcw_1',
        title: '流浪地球 2',
        subtitle: '4K HDR • 已看到 1:42:30',
        posterUrl: 'https://picsum.photos/seed/wandering2/300/450',
        progress: 0.67,
        mediaType: 'movie',
      ),
      ContinueWatchingItem(
        id: 'dcw_2',
        title: '三体',
        subtitle: 'S01E15 • 1080p',
        posterUrl: 'https://picsum.photos/seed/3body/300/450',
        progress: 0.45,
        mediaType: 'series',
        episodeNumber: 15,
        seasonNumber: 1,
      ),
    ];

    _hotRankings = [
      HotRanking(
        id: 'hr_1',
        title: '繁花',
        posterUrl: 'https://picsum.photos/seed/blossoms/300/450',
        score: '9.2',
      ),
      HotRanking(
        id: 'hr_2',
        title: '狂飙',
        posterUrl: 'https://picsum.photos/seed/killwind/300/450',
        score: '9.0',
      ),
      HotRanking(
        id: 'hr_3',
        title: '漫长的季节',
        posterUrl: 'https://picsum.photos/seed/longseason/300/450',
        score: '9.3',
      ),
      HotRanking(
        id: 'hr_4',
        title: '似火流年',
        posterUrl: 'https://picsum.photos/seed/fireyears/300/450',
        score: '8.7',
      ),
      HotRanking(
        id: 'hr_5',
        title: '警察荣誉',
        posterUrl: 'https://picsum.photos/seed/policehonor/300/450',
        score: '8.5',
      ),
    ];

    _liveChannels = [
      LiveChannel(
        id: 'live_1',
        name: 'CCTV-1 综合',
        logoUrl: 'https://picsum.photos/seed/cctv1/320/180',
        currentProgram: '新闻联播',
        isFavorite: true,
      ),
      LiveChannel(
        id: 'live_2',
        name: 'CCTV-5 体育',
        logoUrl: 'https://picsum.photos/seed/cctv5/320/180',
        currentProgram: 'NBA 常规赛',
      ),
      LiveChannel(
        id: 'live_3',
        name: '湖南卫视',
        logoUrl: 'https://picsum.photos/seed/hunan/320/180',
        currentProgram: '歌手 2024',
      ),
      LiveChannel(
        id: 'live_4',
        name: '东方卫视',
        logoUrl: 'https://picsum.photos/seed/dfg/320/180',
        currentProgram: '极限挑战',
      ),
      LiveChannel(
        id: 'live_5',
        name: '浙江卫视',
        logoUrl: 'https://picsum.photos/seed/zhejiang/320/180',
        currentProgram: '奔跑吧',
      ),
      LiveChannel(
        id: 'live_6',
        name: '北京卫视',
        logoUrl: 'https://picsum.photos/seed/beijing/320/180',
        currentProgram: '环球跨年冰雪盛典',
      ),
    ];

    _categories = [
      ContentCategory(id: 'cat_1', name: '电影', icon: Icons.movie_rounded),
      ContentCategory(id: 'cat_2', name: '剧集', icon: Icons.tv_rounded),
      ContentCategory(id: 'cat_3', name: '综艺', icon: Icons.theater_comedy_rounded),
      ContentCategory(id: 'cat_4', name: '动漫', icon: Icons.animation_rounded),
      ContentCategory(id: 'cat_5', name: '纪录片', icon: Icons.document_scanner_rounded),
      ContentCategory(id: 'cat_6', name: '少儿', icon: Icons.child_friendly_rounded),
      ContentCategory(id: 'cat_7', name: '音乐', icon: Icons.music_note_rounded),
      ContentCategory(id: 'cat_8', name: '直播', icon: Icons.live_tv_rounded),
    ];

    _recommendations = [
      MediaItem(
        id: 'rec_1',
        title: '沙丘 2',
        subtitle: '4K DV • 2024',
        posterUrl: 'https://picsum.photos/seed/dune2/300/450',
        mediaType: 'movie',
        badge: 'New',
      ),
      MediaItem(
        id: 'rec_2',
        title: '权力的游戏',
        subtitle: '全 8 季 • 4K HDR',
        posterUrl: 'https://picsum.photos/seed/got/300/450',
        mediaType: 'series',
      ),
      MediaItem(
        id: 'rec_3',
        title: '星际穿越',
        subtitle: 'IMAX 4K • 2014',
        posterUrl: 'https://picsum.photos/seed/interstellar/300/450',
        mediaType: 'movie',
      ),
      MediaItem(
        id: 'rec_4',
        title: '黑镜',
        subtitle: 'S06 更新中',
        posterUrl: 'https://picsum.photos/seed/blackmirror/300/450',
        mediaType: 'series',
        badge: 'Updating',
      ),
      MediaItem(
        id: 'rec_5',
        title: '银翼杀手 2049',
        subtitle: '4K HDR • 2017',
        posterUrl: 'https://picsum.photos/seed/blade2049/300/450',
        mediaType: 'movie',
      ),
      MediaItem(
        id: 'rec_6',
        title: '西部世界',
        subtitle: '全 4 季 • 4K',
        posterUrl: 'https://picsum.photos/seed/westworld/300/450',
        mediaType: 'series',
      ),
      MediaItem(
        id: 'rec_7',
        title: '攻壳机动队',
        subtitle: '4K 修复版 • 1995',
        posterUrl: 'https://picsum.photos/seed/gits/300/450',
        mediaType: 'movie',
      ),
      MediaItem(
        id: 'rec_8',
        title: '爱死机',
        subtitle: '全 3 季 • 4K HDR',
        posterUrl: 'https://picsum.photos/seed/ldr/300/450',
        mediaType: 'series',
      ),
    ];
  }
}