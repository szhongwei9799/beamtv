/// 媒体源卡片组件
import 'package:flutter/material.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/theme/beam_theme.dart';

class MediaSourceCard extends StatelessWidget {
  final MediaSource source;
  final bool isSelected;
  final VoidCallback onTap;

  const MediaSourceCard({
    super.key,
    required this.source,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? BeamColors.primary.withOpacity(0.1) : BeamColors.surfaceElevated,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? BeamColors.primary : BeamColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: source.isConnected
                    ? BeamColors.primary.withOpacity(0.15)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                source.isConnected ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
                color: source.isConnected ? BeamColors.primary : Colors.grey,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(source.name, style: BeamTextStyles.bodySmall.copyWith(
                    color: isSelected ? BeamColors.primary : BeamColors.textPrimary,
                    fontSize: 12,
                  ), maxLines: 1),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text('${source.itemCount}个', style: BeamTextStyles.caption.copyWith(fontSize: 10)),
                      const SizedBox(width: 4),
                      Container(
                        width: 4, height: 4,
                        decoration: BoxDecoration(
                          color: source.isConnected ? BeamColors.success : Colors.grey,
                          shape: BoxShape.circle,
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
    );
  }
}
