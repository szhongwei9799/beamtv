// 发现页面组件
library features.discover.presentation.widgets;

import 'package:flutter/material.dart';

import '../../../../core/theme/beam_theme.dart';
import '../../../../shared/widgets/main_scaffold.dart';

/// 精选轮播
class FeaturedCarousel extends StatelessWidget {
  final List<FeaturedItem> items;

  const FeaturedCarousel({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '精选推荐',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) => _FeaturedCard(item: items[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final FeaturedItem item;

  const _FeaturedCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: item.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // 背景图
                item.backdropUrl != null
                    ? Image.network(
                        item.backdropUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _PlaceholderBackground(),
                      )
                    : _PlaceholderBackground(),
                // 渐变遮罩
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.9),
                      ],
                      stops: const [0.0, 0.6, 1.0],
                    ),
                  ),
                ),
                // 内容
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (item.badge != null)
                        BeamBadge(
                          label: item.badge!,
                          backgroundColor: context.brandIndigo,
                          textColor: Colors.white,
                        ),
                      const SizedBox(height: 12),
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      if (item.subtitle != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          item.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          FilledButton.icon(
                            onPressed: item.onPlay,
                            icon: const Icon(Icons.play_arrow_rounded, size: 18),
                            label: const Text('播放'),
                            style: FilledButton.styleFrom(
                              backgroundColor: context.brandViolet,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton.icon(
                            onPressed: item.onInfo,
                            icon: const Icon(Icons.info_outline_rounded, size: 18),
                            label: const Text('详情'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(color: Colors.white.withOpacity(0.5)),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.bgSurface,
            context.bgSecondary,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.movie_rounded,
          color: context.textQuaternary,
          size: 48,
        ),
      ),
    );
  }
}

/// 继续观看区
class ContinueWatchingSection extends StatelessWidget {
  final List<ContinueWatchingItem> items;

  const ContinueWatchingSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Text(
                '继续观看',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.textPrimary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, // TODO: 查看全部
                child: Text(
                  '全部',
                  style: TextStyle(color: context.textTertiary, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _ContinueWatchingCard(item: items[index]),
          ),
        ),
      ],
    );
  }
}

class _ContinueWatchingCard extends StatelessWidget {
  final ContinueWatchingItem item;

  const _ContinueWatchingCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final progress = item.progress.clamp(0.0, 1.0);

    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: item.posterUrl != null
                      ? Image.network(
                          item.posterUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: context.bgSurface,
                            child: Icon(Icons.movie_rounded, color: context.textQuaternary),
                          ),
                        )
                      : Container(
                          color: context.bgSurface,
                          child: Icon(Icons.movie_rounded, color: context.textQuaternary),
                        ),
                ),
              ),
              if (progress > 0)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 3,
                    backgroundColor: Colors.black54,
                    valueColor: AlwaysStoppedAnimation(context.brandViolet),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                ),
              if (item.mediaType == 'episode')
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'E${item.episodeNumber}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.textPrimary,
            ),
          ),
          if (item.subtitle != null)
            Text(
              item.subtitle!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.textQuaternary,
                fontSize: 11,
              ),
            ),
        ],
      ),
    );
  }
}

/// 热门榜单
class HotRankingsSection extends StatelessWidget {
  final List<HotRanking> rankings;

  const HotRankingsSection({super.key, required this.rankings});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            '热门榜单',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.textPrimary,
            ),
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: rankings.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _RankingCard(ranking: rankings[index], rank: index + 1),
          ),
        ),
      ],
    );
  }
}

class _RankingCard extends StatelessWidget {
  final HotRanking ranking;
  final int rank;

  const _RankingCard({required this.ranking, required this.rank});

  @override
  Widget build(BuildContext context) {
    final isTop3 = rank <= 3;

    return SizedBox(
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ranking.posterUrl != null
                      ? Image.network(
                          ranking.posterUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: context.bgSurface,
                            child: Icon(Icons.trending_up_rounded, color: context.textQuaternary),
                          ),
                        )
                      : Container(
                          color: context.bgSurface,
                          child: Icon(Icons.trending_up_rounded, color: context.textQuaternary),
                        ),
                ),
              ),
              // 排名标签
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isTop3 ? Colors.amber : context.bgSecondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'No.$rank',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isTop3 ? Colors.black : context.textPrimary,
                      fontFamily: 'JetBrainsMono',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            ranking.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.textPrimary,
            ),
          ),
          if (ranking.score != null)
            Text(
              ranking.score!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.textTertiary,
                fontSize: 11,
                fontFamily: 'JetBrainsMono',
              ),
            ),
        ],
      ),
    );
  }
}

/// 直播频道
class LiveChannelsSection extends StatelessWidget {
  final List<LiveChannel> channels;

  const LiveChannelsSection({super.key, required this.channels});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.5),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '正在直播',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.textPrimary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, // TODO: 电视指南
                child: Text(
                  '节目单',
                  style: TextStyle(color: context.textTertiary, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: channels.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => _LiveChannelCard(channel: channels[index]),
          ),
        ),
      ],
    );
  }
}

class _LiveChannelCard extends StatelessWidget {
  final LiveChannel channel;

  const _LiveChannelCard({required this.channel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: channel.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                channel.logoUrl != null
                    ? Image.network(
                        channel.logoUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _PlaceholderChannel(),
                      )
                    : _PlaceholderChannel(),
                // 渐变
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // 信息
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'LIVE',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (channel.isFavorite)
                            Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        channel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      if (channel.currentProgram != null)
                        Text(
                          channel.currentProgram!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlaceholderChannel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.bgSurface,
      child: Center(
        child: Icon(Icons.live_tv_rounded, color: context.textQuaternary, size: 32),
      ),
    );
  }
}

/// 分类网格
class CategoryGridSection extends StatelessWidget {
  final List<ContentCategory> categories;

  const CategoryGridSection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            '分类浏览',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: context.textPrimary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) => _CategoryCard(category: categories[index]),
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final ContentCategory category;

  const _CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: category.onTap,
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.bgSurface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.borderSubtle, width: 0.5),
                ),
                child: Center(
                  child: Icon(
                    category.icon,
                    size: 32,
                    color: context.brandViolet,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: context.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 为你推荐
class RecommendationsSection extends StatelessWidget {
  final List<MediaItem> items;

  const RecommendationsSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Text(
                '为你推荐',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: context.textPrimary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {}, // TODO: 查看全部
                child: Text(
                  '全部',
                  style: TextStyle(color: context.textTertiary, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) => _RecommendationCard(item: items[index]),
          ),
        ),
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  final MediaItem item;

  const _RecommendationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 2 / 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: item.posterUrl != null
                      ? Image.network(
                          item.posterUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: context.bgSurface,
                            child: Icon(Icons.movie_rounded, color: context.textQuaternary),
                          ),
                        )
                      : Container(
                          color: context.bgSurface,
                          child: Icon(Icons.movie_rounded, color: context.textQuaternary),
                        ),
                ),
              ),
              if (item.badge != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: BeamBadge(
                    label: item.badge!,
                    backgroundColor: context.errorRed,
                    textColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: context.textPrimary,
          ),
        ),
        if (item.subtitle != null)
          Text(
            item.subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.textQuaternary,
              fontSize: 11,
            ),
          ),
      ],
    );
  }
}

// 数据模型
class FeaturedItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? backdropUrl;
  final String? badge;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;
  final VoidCallback? onInfo;

  const FeaturedItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.backdropUrl,
    this.badge,
    this.onTap,
    this.onPlay,
    this.onInfo,
  });
}

class HotRanking {
  final String id;
  final String title;
  final String? posterUrl;
  final String? score;
  final VoidCallback? onTap;

  const HotRanking({
    required this.id,
    required this.title,
    this.posterUrl,
    this.score,
    this.onTap,
  });
}

class LiveChannel {
  final String id;
  final String name;
  final String? logoUrl;
  final String? currentProgram;
  final bool isFavorite;
  final VoidCallback? onTap;

  const LiveChannel({
    required this.id,
    required this.name,
    this.logoUrl,
    this.currentProgram,
    this.isFavorite = false,
    this.onTap,
  });
}

class ContentCategory {
  final String id;
  final String name;
  final IconData icon;
  final VoidCallback? onTap;

  const ContentCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.onTap,
  });
}

// 复用 local_media 的模型
import 'local_media_page.dart' hide MediaSource;
import 'media_grid.dart' hide MediaItem;