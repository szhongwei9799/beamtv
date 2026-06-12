/// 设置页面 — 实用密集风
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/beam_theme.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/models/media_models.dart';
import '../../../../core/constants/app_constants.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_sections.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 应用信息
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: BeamColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: BeamColors.border),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48, height: 48,
                      decoration: BoxDecoration(
                        color: BeamColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.live_tv, color: BeamColors.primary, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppConstants.appName}  v${AppConstants.version}', style: BeamTextStyles.bodySmall),
                        const SizedBox(height: 2),
                        Text('光线传播 · 智能电视媒体中心', style: BeamTextStyles.caption),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 设置列表
              Expanded(
                child: ListView(
                  children: [
                    _buildSection('播放', [
                      _buildSettingItem(
                        context, '默认视频质量',
                        settings.defaultVideoQuality.label,
                        () => _showQualityPicker(context, settings),
                      ),
                      _buildSettingItem(
                        context, '默认音频质量',
                        settings.defaultAudioQuality.label,
                        () => _showAudioQualityPicker(context, settings),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    _buildSection('界面', [
                      _buildSettingItem(
                        context, '主题模式',
                        _themeModeLabel(settings.mode),
                        () => _showThemePicker(context, settings),
                      ),
                      _buildSettingItem(
                        context, '语言',
                        settings.getLanguageLabel(settings.languageCode),
                        () => _showLanguagePicker(context, settings),
                      ),
                      _buildSettingItem(
                        context, '字体缩放',
                        '${(settings.fontScale * 100).round()}%',
                        () => _showFontScaleSlider(context, settings),
                      ),
                    ]),
                    const SizedBox(height: 12),
                    _buildSection('关于', [
                      _buildSettingItem(context, '版本号', AppConstants.version, null),
                      _buildSettingItem(context, '开源许可', '', () {}),
                      _buildSettingItem(context, '检查更新', '', () {}),
                    ]),
                    const SizedBox(height: 24),
                    Center(
                      child: Text('BeamTV · 光线传播', style: BeamTextStyles.caption.copyWith(fontSize: 10)),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _themeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system: return '跟随系统';
      case ThemeMode.dark: return '深色';
      case ThemeMode.light: return '浅色';
    }
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(title.toUpperCase(), style: BeamTextStyles.caption.copyWith(
            color: BeamColors.primary, letterSpacing: 1.2, fontSize: 10,
          )),
        ),
        Container(
          decoration: BoxDecoration(
            color: BeamColors.surfaceElevated,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: BeamColors.border),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildSettingItem(BuildContext context, String label, String value, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(label, style: BeamTextStyles.bodySmall.copyWith(fontSize: 13)),
            const Spacer(),
            Text(value, style: BeamTextStyles.caption.copyWith(color: BeamColors.textSecondary, fontSize: 11)),
            if (onTap != null) ...[
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, color: BeamColors.textTertiary, size: 14),
            ],
          ],
        ),
      ),
    );
  }

  void _showThemePicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BeamColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values.map((mode) {
          return ListTile(
            title: Text(_themeModeLabel(mode), style: BeamTextStyles.bodySmall),
            trailing: settings.mode == mode
                ? const Icon(Icons.check, color: BeamColors.primary, size: 18)
                : null,
            onTap: () {
              settings.setMode(mode);
              context.pop();
            },
          );
        }).toList(),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BeamColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: settings.getLanguageOptions().map((code) {
          return ListTile(
            title: Text(settings.getLanguageLabel(code), style: BeamTextStyles.bodySmall),
            trailing: settings.languageCode == code
                ? const Icon(Icons.check, color: BeamColors.primary, size: 18)
                : null,
            onTap: () {
              settings.setLanguageCode(code);
              context.pop();
            },
          );
        }).toList(),
      ),
    );
  }

  void _showQualityPicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BeamColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: VideoQuality.values.map((q) {
          return ListTile(
            title: Text('${q.label} (${q.resolution})', style: BeamTextStyles.bodySmall),
            trailing: settings.defaultVideoQuality == q
                ? const Icon(Icons.check, color: BeamColors.primary, size: 18)
                : null,
            onTap: () {
              // TODO: save quality
              context.pop();
            },
          );
        }).toList(),
      ),
    );
  }

  void _showAudioQualityPicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BeamColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: AudioQuality.values.map((q) {
          return ListTile(
            title: Text('${q.label} (${q.bitrate})', style: BeamTextStyles.bodySmall),
            trailing: settings.defaultAudioQuality == q
                ? const Icon(Icons.check, color: BeamColors.primary, size: 18)
                : null,
            onTap: () {
              // TODO: save quality
              context.pop();
            },
          );
        }).toList(),
      ),
    );
  }

  void _showFontScaleSlider(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      backgroundColor: BeamColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('字体缩放', style: BeamTextStyles.h2.copyWith(fontSize: 16)),
            const SizedBox(height: 16),
            StatefulBuilder(
              builder: (context, setState) {
                double val = settings.fontScale;
                return Column(
                  children: [
                    Slider(
                      value: val,
                      min: 0.7,
                      max: 1.5,
                      divisions: 8,
                      activeColor: BeamColors.primary,
                      inactiveColor: BeamColors.border,
                      label: '${(val * 100).round()}%',
                      onChanged: (v) => setState(() => val = v),
                      onChangeEnd: (v) => settings.setFontScale(v),
                    ),
                    Text('${(val * 100).round()}%', style: BeamTextStyles.bodySmall),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
