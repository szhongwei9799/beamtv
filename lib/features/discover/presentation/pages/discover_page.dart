// 发现页面 - "找内容"：多平台聚合搜索、热榜、推荐、直播 EPG、继续观看
library features.discover.presentation.pages;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/beam_theme.dart';
import '../../../../shared/widgets/main_scaffold.dart';
import '../widgets/discover_sections.dart'
import '../providers/discover_provider.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiscoverProvider()..initialize(),
      child: const _DiscoverView(),
    );
  }
}

class _DiscoverView extends StatelessWidget {
  const _DiscoverView();

  @override
  Widget build(BuildContext context) {
    return BeamPageScaffold(
      title: '发现',
      actions: [
        IconButton(
          tooltip: '搜索',
          icon: const Icon(Icons.search_rounded, size: 24),
          onPressed: () => context.pushNamed('search'),
        ),
        const SizedBox(width: 8),
      ],
      body: Consumer<DiscoverProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingState(message: '加载推荐内容...');
          }

          if (provider.error != null) {
            return ErrorState(
              message: provider.error!,
              onRetry: provider.initialize,
            );
          }

          return RefreshIndicator(
            onRefresh: provider.refresh,
            child: CustomScrollView(
              slivers: [
                // 搜索栏入口
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: _SearchBarEntry(onTap: () => context.pushNamed('search')),
                  ),
                ),

                // 热门推荐轮播
                if (provider.featured.isNotEmpty)
                  SliverToBoxAdapter(
                    child: FeaturedCarousel(items: provider.featured),
                  ),

                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                // 继续观看 (跨设备同步)
                if (provider.continueWatching.isNotEmpty)
                  ContinueWatchingSection(items: provider.continueWatching),

                // 热门榜单
                if (provider.hotRankings.isNotEmpty)
                  HotRankingsSection(rankings: provider.hotRankings),

                // 直播频道
                if (provider.liveChannels.isNotEmpty)
                  LiveChannelsSection(channels: provider.liveChannels),

                // 分类入口
                CategoryGridSection(categories: provider.categories),

                // 为你推荐
                if (provider.recommendations.isNotEmpty)
                  RecommendationsSection(items: provider.recommendations),

                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SearchBarEntry extends StatelessWidget {
  final VoidCallback onTap;

  const _SearchBarEntry({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: context.bgSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: context.borderStandard, width: 0.5),
          ),
          child: Row(
            children: [
              Icon(Icons.search_rounded, color: context.textQuaternary, size: 22),
              const SizedBox(width: 12),
              Text(
                '搜索电影、剧集、演员、导演...',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: context.textTertiary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: context.brandIndigo.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mic_rounded, size: 14, color: context.brandViolet),
                    const SizedBox(width: 4),
                    Text(
                      '语音',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: context.brandViolet,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}