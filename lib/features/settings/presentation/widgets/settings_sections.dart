/// 设置区块组件
import 'package:flutter/material.dart';
import '../../../../core/theme/beam_theme.dart';

class SettingsSection extends StatelessWidget {
  final List<Widget> children;
  const SettingsSection({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BeamColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: BeamColors.border),
      ),
      child: Column(children: children),
    );
  }
}
