// BeamTV 路由配置 - 基于 go_router
library core.routing;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/local_media/presentation/pages/local_media_page.dart';
import '../../features/discover/presentation/pages/discover_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../shared/widgets/main_scaffold.dart';

/// 路由配置
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: false,
    routes: [
      // 主 Shell - 底部导航栏容器
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // 分支 1: 本地媒体
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.localMedia,
                name: 'local-media',
                builder: (context, state) => const LocalMediaPage(),
                routes: [
                  GoRoute(
                    path: 'source/:sourceId',
                    name: 'source-detail',
                    builder: (context, state) {
                      final sourceId = state.pathParameters['sourceId']!;
                      return SourceDetailPage(sourceId: sourceId);
                    },
                  ),
                  GoRoute(
                    path: 'add-source',
                    name: 'add-source',
                    builder: (context, state) => const AddSourcePage(),
                  ),
                ],
              ),
            ],
          ),
          // 分支 2: 发现 (原网络媒体)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.discover,
                name: 'discover',
                builder: (context, state) => const DiscoverPage(),
                routes: [
                  GoRoute(
                    path: 'search',
                    name: 'search',
                    builder: (context, state) => const SearchPage(),
                  ),
                  GoRoute(
                    path: 'detail/:contentId',
                    name: 'content-detail',
                    builder: (context, state) {
                      final contentId = state.pathParameters['contentId']!;
                      return ContentDetailPage(contentId: contentId);
                    },
                  ),
                ],
              ),
            ],
          ),
          // 分支 3: 设置
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.settings,
                name: 'settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      // 全屏播放器 - 脱离 Shell
      GoRoute(
        path: Routes.player,
        name: 'player',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return PlayerPage(
            mediaUrl: extra?['mediaUrl'] ?? '',
            title: extra?['title'] ?? '',
            subtitle: extra?['subtitle'],
            posterUrl: extra?['posterUrl'],
            mediaType: extra?['mediaType'] ?? 'movie',
          );
        },
      ),
    ],
    errorBuilder: (context, state) => _ErrorPage(error: state.error.toString()),
    redirect: (context, state) {
      // 可在此添加认证重定向逻辑
      return null;
    },
  );

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  // 导航辅助方法
  static void go(int index) {
    switch (index) {
      case 0:
        router.go(Routes.localMedia);
        break;
      case 1:
        router.go(Routes.discover);
        break;
      case 2:
        router.go(Routes.settings);
        break;
    }
  }

  static void pushPlayer({
    required String mediaUrl,
    required String title,
    String? subtitle,
    String? posterUrl,
    String mediaType = 'movie',
  }) {
    router.push(
      Routes.player,
      extra: {
        'mediaUrl': mediaUrl,
        'title': title,
        'subtitle': subtitle,
        'posterUrl': posterUrl,
        'mediaType': mediaType,
      },
    );
  }
}

/// 错误页面
class _ErrorPage extends StatelessWidget {
  final String error;

  const _ErrorPage({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: context.errorRed,
            ),
            const SizedBox(height: 16),
            Text(
              '页面未找到',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go(Routes.initial),
              child: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}

// 占位页面 - 待实现
class SourceDetailPage extends StatelessWidget {
  final String sourceId;

  const SourceDetailPage({super.key, required this.sourceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('源详情: $sourceId')),
      body: Center(child: Text('Source Detail Page - $sourceId')),
    );
  }
}

class AddSourcePage extends StatelessWidget {
  const AddSourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('添加媒体源')),
      body: const Center(child: Text('Add Source Page - 待实现')),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('搜索')),
      body: const Center(child: Text('Search Page - 待实现')),
    );
  }
}

class ContentDetailPage extends StatelessWidget {
  final String contentId;

  const ContentDetailPage({super.key, required this.contentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('详情: $contentId')),
      body: Center(child: Text('Content Detail Page - $contentId')),
    );
  }
}

class PlayerPage extends StatelessWidget {
  final String mediaUrl;
  final String title;
  final String? subtitle;
  final String? posterUrl;
  final String mediaType;

  const PlayerPage({
    super.key,
    required this.mediaUrl,
    required this.title,
    this.subtitle,
    this.posterUrl,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (posterUrl != null)
              Image.network(posterUrl!, height: 200, errorBuilder: (_, __, ___) => const Icon(Icons.movie, size: 100, color: Colors.white38)),
            const SizedBox(height: 24),
            Text(title, style: const TextStyle(fontSize: 24, color: Colors.white)),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle!, style: const TextStyle(color: Colors.white70)),
            ],
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('播放中: $mediaUrl', style: const TextStyle(color: Colors.white38, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}