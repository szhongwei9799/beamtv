/// 本地媒体页面 — 实用密集风
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/beam_theme.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/models/media_models.dart';
import '../providers/local_media_provider.dart';
import '../widgets/media_source_card.dart';
import '../widgets/media_grid.dart';

class LocalMediaPage extends StatelessWidget {
  const LocalMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalMediaProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 搜索栏
              _SearchBar(
                onChanged: (q) => provider.search(q),
                onClear: () => provider.clearSearch(),
              ),
              const SizedBox(height: 16),

              // 媒体源列表
              if (provider.sources.isNotEmpty) ...[
                _SectionHeader(
                  title: '媒体源',
                  action: '管理',
                  onAction: () {},
                  count: provider.sources.length,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 88,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.sources.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) => MediaSourceCard(
                      source: provider.sources[i],
                      isSelected: provider.sources[i].id == provider.selectedSourceId,
                      onTap: () => provider.selectSource(provider.sources[i].id),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 续播列表
              if (provider.continueWatching.isNotEmpty) ...[
                _SectionHeader(
                  title: '继续观看',
                  count: provider.continueWatching.length,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.continueWatching.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, i) => _ContinueWatchingCard(
                      item: provider.continueWatching[i],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // 媒体文件列表
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionHeader(
                      title: provider.selectedSourceId == null ? '全部文件' : provider.sources
                          .where((s) => s.id == provider.selectedSourceId)
                          .map((s) => s.name)
                          .firstOrNull ?? '全部文件',
                      action: '排序',
                      count: provider.mediaItems.length,
                    ),
                    const SizedBox(height: 8),
                    Expanded(child: MediaGridView(
                      items: provider.mediaItems,
                      isLoading: provider.isLoading,
                      onItemTap: (item) => context.pushNamed('player', arguments: {'id': item.id}),
                    )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  const _SearchBar({required this.onChanged, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BeamColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BeamColors.border),
      ),
      child: TextField(
        style: BeamTextStyles.body,
        decoration: InputDecoration(
          hintText: '搜索媒体文件...',
          prefixIcon: const Icon(Icons.search, color: BeamColors.textTertiary, size: 18),
          suffixIcon: IconButton(
            icon: const Icon(Icons.close, color: BeamColors.textTertiary, size: 16),
            onPressed: onClear,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;
  final int? count;
  const _SectionHeader({required this.title, this.action, this.onAction, this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: BeamTextStyles.h2.copyWith(fontSize: 15)),
        if (count != null) ...[
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
        const Spacer(),
        if (action != null)
          TextButton(
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), minimumSize: Size.zero),
            onPressed: onAction,
            child: Text(action!, style: BeamTextStyles.caption.copyWith(color: BeamColors.primary, fontSize: 11)),
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
          // 缩略图区域
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: BeamColors.surfaceDim,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Icon(Icons.movie_outlined, color: BeamColors.textTertiary, size: 32),
              ),
            ),
          ),
          // 进度条
          ClipRRect(
            borderRadius: BorderRadius.zero,
            child: LinearProgressIndicator(
              value: item.progress,
              backgroundColor: BeamColors.border,
              valueColor: const AlwaysStoppedAnimation(BeamColors.primary),
              minHeight: 3,
            ),
          ),
          // 信息
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: BeamTextStyles.bodySmall.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(item.formattedProgress, style: BeamTextStyles.caption.copyWith(fontSize: 10)),
                    const Spacer(),
                    Text('${item.position.inMinutes}min', style: BeamTextStyles.caption.copyWith(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
