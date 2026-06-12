/// 主框架组件 — 顶栏 + 导航
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/beam_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../features/local_media/presentation/providers/local_media_provider.dart';

class BeamMainScaffold extends StatelessWidget {
  final Widget child;
  final int tabIndex;
  final ValueChanged<int> onTabChanged;

  const BeamMainScaffold({
    super.key,
    required this.child,
    required this.tabIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BeamColors.background,
      body: Column(
        children: [
          // 顶栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: BeamColors.border)),
            ),
            child: Row(
              children: [
                Text('${AppConstants.appName}  v${AppConstants.version}', style: const TextStyle(
                  color: BeamColors.primary, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'monospace',
                )),
                const Spacer(),
                Text(AppConstants.appNameZh, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          // 内容
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: BeamColors.border)),
        ),
        child: BottomNavigationBar(
          backgroundColor: BeamColors.background,
          selectedItemColor: BeamColors.primary,
          unselectedItemColor: BeamColors.textTertiary,
          currentIndex: tabIndex,
          onTap: onTabChanged,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.folder_outlined, size: 20), label: '本地媒体'),
            BottomNavigationBarItem(icon: Icon(Icons.explore_outlined, size: 20), label: '发现'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined, size: 20), label: '设置'),
          ],
        ),
      ),
    );
  }
}
