// 本地媒体页面组件
library features.local_media.presentation.widgets;

import 'package:flutter/material.dart';

import '../../../../core/theme/beam_theme.dart';
import '../../../../shared/widgets/main_scaffold.dart';
import 'local_media_page.dart';

/// 媒体源卡片
class MediaSourceCard extends StatelessWidget {
  final MediaSource source;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MediaSourceCard({
    super.key,
    required this.source,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return BeamCard(
      onTap: onTap,
      onLongPress: onLongPress,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 类型图标
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getTypeColor(context).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getTypeColor(context).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Icon(
              source.type.icon,
              size: 24,
              color: _getTypeColor(context),
            ),
          ),
          const SizedBox(width: 16),

          // 信息区
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        source.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.textPrimary,
                        ),
                      ),
                    ),
                    // 状态指示
                    Row(
                      children: [
                        StatusDot(
                          color: source.isOnline ? context.successEmerald : context.errorRed,
                          size: 8,
                          pulsing: source.isOnline,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          source.isOnline ? '在线' : '离线',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: source.isOnline ? context.successEmerald : context.errorRed,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  source.configSummary,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.textQuaternary,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    BeamBadge(
                      label: '${source.itemCount} 项',
                      icon: Icons.inventory_2_rounded,
                    ),
                    const SizedBox(width: 8),
                    BeamBadge(
                      label: _formatDate(source.lastScraped),
                      icon: Icons.schedule_rounded,
                    ),
                    if (source.error != null) ...[
                      const SizedBox(width: 8),
                      BeamBadge(
                        label: '异常',
                        icon: Icons.error_outline_rounded,
                        backgroundColor: context.errorRed.withOpacity(0.15),
                        textColor: context.errorRed,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // 箭头
          Icon(
            Icons.chevron_right_rounded,
            color: context.textQuaternary,
            size: 24,
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(BuildContext context) {
    switch (source.type) {
      case MediaSourceTypeEx.smb:
      case MediaSourceTypeEx.webdav:
      case MediaSourceTypeEx.nfs:
        return context.brandViolet;
      case MediaSourceTypeEx.aliyun:
        return const Color(0xFFFF6A00);
      case MediaSourceTypeEx.quark:
        return const Color(0xFF00AEFF);
      case MediaSourceTypeEx.baidu:
        return const Color(0xFF1296DB);
      case MediaSourceTypeEx.pan115:
        return const Color(0xFFE83E3E);
      case MediaSourceTypeEx.m3u:
      case MediaSourceTypeEx.iptv:
        return context.successEmerald;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inHours < 1) return '${diff.inMinutes}分钟前';
    if (diff.inDays < 1) return '${diff.inHours}小时前';
    if (diff.inDays < 7) return '${diff.inDays}天前';
    return '${date.month}/${date.day}';
  }
}