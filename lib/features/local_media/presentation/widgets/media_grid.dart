// 媒体网格组件
library features.local_media.presentation.widgets;

import 'package:flutter/material.dart';

import '../../../../core/theme/beam_theme.dart';
import '../../../../shared/widgets/main_scaffold.dart';

/// 媒体网格 - 用于展示电影/剧集海报墙
class MediaGrid extends StatelessWidget {
  final List<MediaItem> items;
  final int crossAxisCount;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;

  const MediaGrid({
    super.key,
    required this.items,
    this.crossAxisCount = 4,
    this.childAspectRatio = 0.7,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _MediaGridCard(item: items[index]),
      ),
    );
  }
}

class _MediaGridCard extends StatelessWidget {
  final MediaItem item;

  const _MediaGridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 海报
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
                          errorBuilder: (_, __, ___) => _PlaceholderPoster(item.mediaType),
                        )
                      : _PlaceholderPoster(item.mediaType),
                ),
              ),
              // 进度条
              if (item.progress != null && item.progress! > 0)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    value: item.progress!.clamp(0.0, 1.0),
                    minHeight: 3,
                    backgroundColor: Colors.black54,
                    valueColor: AlwaysStoppedAnimation(context.brandViolet),
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                ),
              // 徽标
              if (item.badge != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: BeamBadge(
                    label: item.badge!,
                    backgroundColor: context.brandIndigo,
                    textColor: Colors.white,
                  ),
                ),
              // 播放图标覆盖（悬停/聚焦时显示）
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: item.onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Opacity(
                          opacity: 0,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: context.brandViolet,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // 标题
        Text(
          item.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: context.textPrimary,
          ),
        ),
        // 副标题
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

class _PlaceholderPoster extends StatelessWidget {
  final String mediaType;

  const _PlaceholderPoster(this.mediaType);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.bgSurface,
      child: Center(
        child: Icon(
          mediaType == 'series' ? Icons.tv_rounded : Icons.movie_rounded,
          color: context.textQuaternary,
          size: 32,
        ),
      ),
    );
  }
}

// 网格项数据模型
class MediaItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? posterUrl;
  final String mediaType; // 'movie' | 'series'
  final double? progress; // 0.0 - 1.0
  final String? badge; // 'New', '4K', 'HDR' 等
  final VoidCallback? onTap;

  const MediaItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.posterUrl,
    required this.mediaType,
    this.progress,
    this.badge,
    this.onTap,
  });
}