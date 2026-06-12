/// BeamTV 路由配置
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_constants.dart';
import '../extensions/context_ext.dart';
import '../../features/local_media/presentation/pages/local_media_page.dart';
import '../../features/discover/presentation/pages/discover_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) => '/local-media',
          ),
          GoRoute(
            path: '/local-media',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const LocalMediaPage(),
            ),
          ),
          GoRoute(
            path: '/discover',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const DiscoverPage(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SettingsPage(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/player/:id',
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text('播放器 - ${state.pathParameters['id']}',
              style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      backgroundColor: const Color(0xFF08090A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('页面未找到', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
            const SizedBox(height: 8),
            Text('${state.uri}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/local-media'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5E6AD2)),
              child: const Text('返回首页', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  );
}

/// 主框架外壳
class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF08090A),
      body: Column(
        children: [
          // 顶部栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF1E1F22), width: 1)),
            ),
            child: Row(
              children: [
                // 标题和版本号
                const Text('BeamTV', style: TextStyle(
                  color: Color(0xFF5E6AD2), fontSize: 20, fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                )),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E6AD2).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('v${AppConstants.version}', style: const TextStyle(
                    color: Color(0xFF5E6AD2), fontSize: 11, fontWeight: FontWeight.w500,
                  )),
                ),
                const Spacer(),
                // 中文名
                Text('光线传播', style: TextStyle(
                  color: Colors.grey[600], fontSize: 13,
                )),
              ],
            ),
          ),
          // 导航栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFF1E1F22), width: 1)),
            ),
            child: Row(
              children: [
                _TabButton(label: '本地媒体', icon: Icons.folder_outlined, path: '/local-media'),
                _TabButton(label: '发现', icon: Icons.explore_outlined, path: '/discover'),
                _TabButton(label: '设置', icon: Icons.settings_outlined, path: '/settings'),
              ],
            ),
          ),
          // 内容
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String path;
  const _TabButton({required this.label, required this.icon, required this.path});

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouterState.of(context).uri.toString().startsWith(path);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          backgroundColor: isActive ? const Color(0xFF5E6AD2).withOpacity(0.15) : Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
        onPressed: () => context.go(path),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: isActive ? const Color(0xFF5E6AD2) : Colors.grey[500]),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(
              color: isActive ? const Color(0xFF5E6AD2) : Colors.grey[500],
              fontSize: 13, fontWeight: FontWeight.w500,
            )),
          ],
        ),
      ),
    );
  }
}
