/// 媒体文件网格视图
import 'package:flutter/material.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/theme/beam_theme.dart';

class MediaGridView extends StatelessWidget {
  final List<MediaItem> items;
  final bool isLoading;
  final void Function(MediaItem)? onItemTap;

  const MediaGridView({
    super.key,
    required this.items,
    this.isLoading = false,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: BeamColors.primary));
    }

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.folder_off_outlined, color: BeamColors.textTertiary, size: 48),
            const SizedBox(height: 12),
            Text('暂无媒体文件', style: BeamTextStyles.bodySmall),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) => _MediaItemCard(
        item: items[i],
        onTap: () => onItemTap?.call(items[i]),
      ),
    );
  }
}

class _MediaItemCard extends StatelessWidget {
  final MediaItem item;
  final VoidCallback onTap;

  const _MediaItemCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: BeamColors.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: BeamColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 缩略图
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: BeamTextStyles.bodySmall.copyWith(fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  if (item.subtitle != null)
                    Text(item.subtitle!, style: BeamTextStyles.caption.copyWith(fontSize: 10), maxLines: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
