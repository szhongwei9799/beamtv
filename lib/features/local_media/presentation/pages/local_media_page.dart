// 本地媒体页面 - "我的库"：已挂载源、刮削完成、观看进度同步、文件管理
library features.local_media.presentation.pages;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/beam_theme.dart';
import '../../../../shared/widgets/main_scaffold.dart';
import '../widgets/media_source_card.dart';
import '../widgets/media_grid.dart';
import '../providers/local_media_provider.dart';

class LocalMediaPage extends StatelessWidget {
  const LocalMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocalMediaProvider()..initialize(),
      child: const _LocalMediaView(),
    );
  }
}

class _LocalMediaView extends StatelessWidget {
  const _LocalMediaView();

  @override
  Widget build(BuildContext context) {
    return BeamPageScaffold(
      title: '本地媒体',
      actions: [
        IconButton(
          tooltip: '添加媒体源',
          icon: const Icon(Icons.add_rounded, size: 24),
          onPressed: () => context.pushNamed('add-source'),
        ),
        const SizedBox(width: 8),
      ],
      body: Consumer<LocalMediaProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingState(message: '加载媒体源...');
          }

          if (provider.error != null) {
            return ErrorState(
              message: provider.error!,
              onRetry: provider.initialize,
            );
          }

          final sources = provider.sources;

          if (sources.isEmpty) {
            return EmptyState(
              icon: Icons.folder_open_rounded,
              title: '暂无媒体源',
              subtitle: '点击右上角「+」添加 SMB、WebDAV、网盘或直播源',
              action: FilledButton.icon(
                onPressed: () => context.pushNamed('add-source'),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('添加媒体源'),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: provider.refresh,
            child: CustomScrollView(
              slivers: [
                // 来源列表区
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Text(
                          '媒体源 (${sources.length})',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '长按管理',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: context.textQuaternary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList.separated(
                  itemCount: sources.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final source = sources[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: MediaSourceCard(
                        source: source,
                        onTap: () => context.pushNamed(
                          'source-detail',
                          pathParameters: {'sourceId': source.id},
                        ),
                        onLongPress: () => _showSourceActions(context, source, provider),
                      ),
                    );
                  },
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // 继续观看区
                if (provider.continueWatching.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Row(
                        children: [
                          Text(
                            '继续观看',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: provider.continueWatching.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = provider.continueWatching[index];
                          return _ContinueWatchingCard(item: item);
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                ],

                // 最近添加区
                if (provider.recentlyAdded.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(
                        '最近添加',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MediaGrid(items: provider.recentlyAdded),
                  ),
                ],

                const SliverToBoxAdapter(child: SizedBox(height: 48)),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSourceActions(BuildContext context, MediaSource source, LocalMediaProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _SourceActionSheet(source: source, provider: provider),
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
                      style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w500),
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

class _SourceActionSheet extends StatelessWidget {
  final MediaSource source;
  final LocalMediaProvider provider;

  const _SourceActionSheet({required this.source, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        border: Border.all(color: context.borderStandard, width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: context.textQuaternary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ListTile(
            leading: Icon(source.type.icon, color: context.textSecondary),
            title: Text(source.name, style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(source.type.displayName, style: Theme.of(context).textTheme.bodySmall),
          ),
          const Divider(height: 1),
          _ActionTile(
            icon: Icons.refresh_rounded,
            label: '刷新刮削',
            onTap: () {
              context.pop();
              provider.refreshSource(source.id);
            },
          ),
          _ActionTile(
            icon: Icons.edit_rounded,
            label: '编辑源',
            onTap: () {
              context.pop();
              // TODO: 编辑源
            },
          ),
          _ActionTile(
            icon: Icons.delete_outline_rounded,
            label: '删除源',
            isDestructive: true,
            onTap: () {
              context.pop();
              _confirmDelete(context, source, provider);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, MediaSource source, LocalMediaProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除媒体源'),
        content: Text('确定要删除「${source.name}」吗？此操作不可撤销。'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('取消')),
          FilledButton(
            onPressed: () {
              context.pop();
              provider.deleteSource(source.id);
            },
            style: FilledButton.styleFrom(backgroundColor: context.errorRed),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? context.errorRed : context.textSecondary),
      title: Text(
        label,
        style: TextStyle(color: isDestructive ? context.errorRed : context.textPrimary),
      ),
      onTap: onTap,
    );
  }
}

// 数据模型 - 从 domain 层迁移至此以简化
enum MediaSourceTypeEx {
  smb(Icons.lan_rounded, 'SMB/CIFS'),
  webdav(Icons.cloud_sync_rounded, 'WebDAV'),
  nfs(Icons.storage_rounded, 'NFS'),
  aliyun(Icons.cloud_rounded, '阿里云盘'),
  quark(Icons.cloud_queue_rounded, '夸克网盘'),
  baidu(Icons.cloud_download_rounded, '百度网盘'),
  pan115(Icons.cloud_upload_rounded, '115网盘'),
  m3u(Icons.tv_rounded, 'M3U 直播源'),
  iptv(Icons.live_tv_rounded, 'IPTV');

  const MediaSourceTypeEx(this.icon, this.displayName);
  final IconData icon;
  final String displayName;
}

class MediaSource {
  final String id;
  final String name;
  final MediaSourceTypeEx type;
  final String configSummary; // 脱敏后的配置摘要
  final int itemCount;
  final DateTime lastScraped;
  final bool isOnline;
  final String? error;

  const MediaSource({
    required this.id,
    required this.name,
    required this.type,
    required this.configSummary,
    this.itemCount = 0,
    required this.lastScraped,
    this.isOnline = true,
    this.error,
  });
}

class ContinueWatchingItem {
  final String id;
  final String title;
  final String? subtitle;
  final String? posterUrl;
  final double progress; // 0.0 - 1.0
  final String mediaType; // 'movie' | 'series'
  final int? episodeNumber;
  final int? seasonNumber;

  const ContinueWatchingItem({
    required this.id,
    required this.title,
    this.subtitle,
    this.posterUrl,
    required this.progress,
    required this.mediaType,
    this.episodeNumber,
    this.seasonNumber,
  });
}