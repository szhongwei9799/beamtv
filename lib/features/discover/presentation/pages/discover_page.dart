/// 发现页面 — 实用密集风
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/beam_theme.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/models/media_models.dart';
import '../providers/discover_provider.dart';
import '../widgets/discover_sections.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 搜索栏
              Container(
                decoration: BoxDecoration(
                  color: BeamColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: BeamColors.border),
                ),
                child: TextField(
                  style: BeamTextStyles.body,
                  decoration: InputDecoration(
                    hintText: '发现精彩内容...',
                    prefixIcon: const Icon(Icons.search, color: BeamColors.textTertiary, size: 18),
                    suffixIcon: provider.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, color: BeamColors.textTertiary, size: 16),
                            onPressed: () => provider.clearSearch(),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  onChanged: (q) => provider.search(q),
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: provider.searchQuery.isNotEmpty
                    ? _SearchResultsView(provider: provider)
                    : ListView(
                        children: [
                          if (provider.recentItems.isNotEmpty)
                            _buildSection('继续观看', provider.recentItems.length, SizedBox(
                              height: 120,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.recentItems.length,
                                separatorBuilder: (_, __) => const SizedBox(width: 8),
                                itemBuilder: (_, i) => _ContinueWatchingTile(item: provider.recentItems[i]),
                              ),
                            )),
                          const SizedBox(height: 16),
                          _buildSection('热门推荐', provider.trendingItems.length, DiscoverHorizontalList(items: provider.trendingItems)),
                          const SizedBox(height: 16),
                          _buildSection('为你推荐', provider.recommendedItems.length, DiscoverHorizontalList(items: provider.recommendedItems)),
                          const SizedBox(height: 16),
                          _buildSection('最新上线', provider.newReleaseItems.length, DiscoverHorizontalList(items: provider.newReleaseItems)),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection(String title, int count, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title, style: BeamTextStyles.h2.copyWith(fontSize: 15)),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: BeamColors.surfaceElevated,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text('$count', style: BeamTextStyles.caption.copyWith(fontSize: 10)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }
}

class _ContinueWatchingTile extends StatelessWidget {
  final ContinueWatchingItem item;
  const _ContinueWatchingTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: BeamColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BeamColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: BeamColors.surfaceDim,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(child: Icon(Icons.movie_outlined, color: BeamColors.textTertiary, size: 32)),
            ),
          ),
          ClipRRect(
            child: LinearProgressIndicator(
              value: item.progress,
              backgroundColor: BeamColors.border,
              valueColor: const AlwaysStoppedAnimation(BeamColors.primary),
              minHeight: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: BeamTextStyles.bodySmall.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(item.formattedProgress, style: BeamTextStyles.caption.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultsView extends StatelessWidget {
  final DiscoverProvider provider;
  const _SearchResultsView({required this.provider});

  @override
  Widget build(BuildContext context) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator(color: BeamColors.primary));
    }
    if (provider.searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, color: BeamColors.textTertiary, size: 48),
            const SizedBox(height: 12),
            Text('未找到"${provider.searchQuery}"相关内容', style: BeamTextStyles.bodySmall),
          ],
        ),
      );
    }
    return ListView.separated(
      itemCount: provider.searchResults.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) => ListTile(
        leading: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: BeamColors.surfaceDim,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.movie_outlined, color: BeamColors.textTertiary, size: 20),
        ),
        title: Text(provider.searchResults[i].title, style: BeamTextStyles.bodySmall),
        subtitle: Text(provider.searchResults[i].subtitle ?? '', style: BeamTextStyles.caption),
        trailing: const Icon(Icons.chevron_right, color: BeamColors.textTertiary, size: 16),
      ),
    );
  }
}
