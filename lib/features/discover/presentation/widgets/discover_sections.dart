/// 发现页面区块组件
import 'package:flutter/material.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/theme/beam_theme.dart';

class DiscoverHorizontalList extends StatelessWidget {
  final List<MediaItem> items;
  const DiscoverHorizontalList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (_, i) => _MediaCard(item: items[i]),
      ),
    );
  }
}

class _MediaCard extends StatelessWidget {
  final MediaItem item;
  const _MediaCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: BeamColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BeamColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 封面
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: BeamColors.surfaceDim,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Center(
                child: Icon(Icons.movie_outlined, color: BeamColors.textTertiary, size: 24),
              ),
            ),
          ),
          // 标题
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              item.title,
              style: BeamTextStyles.bodySmall.copyWith(fontSize: 11),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // 评分
          if (item.rating != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  const Icon(Icons.star, size: 10, color: Color(0xFFFBBF24)),
                  const SizedBox(width: 2),
                  Text('${item.rating!.toStringAsFixed(1)}', style: BeamTextStyles.caption.copyWith(fontSize: 9)),
                ],
              ),
            ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
