// 设置页面
library features.settings.presentation.pages;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/beam_theme.dart';
import '../../../../shared/widgets/main_scaffold.dart';
import '../providers/settings_provider.dart';
import '../widgets/settings_sections.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider()..initialize(),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, provider, _) {
        return BeamPageScaffold(
          title: '设置',
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 账户与同步
              SettingsSection(
                title: '账户与同步',
                children: [
                  SettingsTile(
                    leading: Icons.cloud_sync_rounded,
                    title: '跨设备同步',
                    subtitle: provider.syncEnabled ? '已开启 • 最近同步: ${_formatTime(provider.lastSyncTime)}' : '未开启',
                    trailing: Switch(
                      value: provider.syncEnabled,
                      onChanged: provider.toggleSync,
                    ),
                    onTap: () => provider.toggleSync(!provider.syncEnabled),
                  ),
                  SettingsTile(
                    leading: Icons.account_circle_rounded,
                    title: '账户管理',
                    subtitle: provider.isLoggedIn ? '已登录: ${provider.username}' : '未登录',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {}, // TODO: 账户页面
                  ),
                  SettingsTile(
                    leading: Icons.backup_rounded,
                    title: '备份与恢复',
                    subtitle: '导出/导入配置、观看记录、收藏',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {}, // TODO: 备份页面
                  ),
                ],
              ),

              // 播放设置
              SettingsSection(
                title: '播放设置',
                children: [
                  SettingsTile(
                    leading: Icons.hdr_strong_rounded,
                    title: '画质偏好',
                    subtitle: _qualityLabel(provider.preferredQuality),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showQualityDialog(context, provider),
                  ),
                  SettingsTile(
                    leading: Icons.surround_sound_rounded,
                    title: '音频偏好',
                    subtitle: _audioLabel(provider.preferredAudio),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showAudioDialog(context, provider),
                  ),
                  SettingsTile(
                    leading: Icons.subtitles_rounded,
                    title: '字幕设置',
                    subtitle: '字体、大小、颜色、位置、编码',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {}, // TODO: 字幕设置页面
                  ),
                  SettingsTile(
                    leading: Icons.speed_rounded,
                    title: '播放速度',
                    subtitle: '${provider.playbackSpeed}x',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showSpeedDialog(context, provider),
                  ),
                  SettingsTile(
                    leading: Icons.hdr_on_rounded,
                    title: 'HDR / Dolby Vision',
                    subtitle: provider.hdrEnabled ? '开启 • 自动匹配显示能力' : '关闭',
                    trailing: Switch(
                      value: provider.hdrEnabled,
                      onChanged: provider.toggleHdr,
                    ),
                    onTap: () => provider.toggleHdr(!provider.hdrEnabled),
                  ),
                  SettingsTile(
                    leading: Icons.auto_fix_high_rounded,
                    title: 'AI 画质增强',
                    subtitle: provider.aiEnhancementEnabled ? '开启 (FSRCNN)' : '关闭',
                    trailing: Switch(
                      value: provider.aiEnhancementEnabled,
                      onChanged: provider.toggleAiEnhancement,
                    ),
                    onTap: () => provider.toggleAiEnhancement(!provider.aiEnhancementEnabled),
                  ),
                ],
              ),

              // 网络与缓存
              SettingsSection(
                title: '网络与缓存',
                children: [
                  SettingsTile(
                    leading: Icons.wifi_rounded,
                    title: '仅 Wi-Fi 下载/同步',
                    subtitle: provider.wifiOnly ? '开启 • 节省流量' : '关闭',
                    trailing: Switch(
                      value: provider.wifiOnly,
                      onChanged: provider.toggleWifiOnly,
                    ),
                    onTap: () => provider.toggleWifiOnly(!provider.wifiOnly),
                  ),
                  SettingsTile(
                    leading: Icons.cached_rounded,
                    title: '缓存管理',
                    subtitle: '已用: ${_formatBytes(provider.cacheSize)} • 点击清理',
                    trailing: TextButton(
                      onPressed: provider.clearCache,
                      child: Text('清理', style: TextStyle(color: context.brandViolet)),
                    ),
                    onTap: () => _showCacheDialog(context, provider),
                  ),
                  SettingsTile(
                    leading: Icons.dns_rounded,
                    title: '自定义 DNS',
                    subtitle: provider.customDns ?? '自动 (系统默认)',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showDnsDialog(context, provider),
                  ),
                ],
              ),

              // 界面与语言
              SettingsSection(
                title: '界面与语言',
                children: [
                  SettingsTile(
                    leading: Icons.palette_rounded,
                    title: '主题模式',
                    subtitle: _themeLabel(provider.themeMode),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showThemeDialog(context, provider),
                  ),
                  SettingsTile(
                    leading: Icons.language_rounded,
                    title: '应用语言',
                    subtitle: _languageLabel(provider.languageCode),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showLanguageDialog(context, provider),
                  ),
                  SettingsTile(
                    leading: Icons.text_fields_rounded,
                    title: '字体大小',
                    subtitle: '${(provider.fontScale * 100).round()}%',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showFontScaleDialog(context, provider),
                  ),
                ],
              ),

              // 媒体库
              SettingsSection(
                title: '媒体库',
                children: [
                  SettingsTile(
                    leading: Icons.folder_special_rounded,
                    title: '刮削器设置',
                    subtitle: '元数据来源、海报语言、命名规则',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {}, // TODO
                  ),
                  SettingsTile(
                    leading: Icons.sync_rounded,
                    title: '定时刷新',
                    subtitle: provider.autoRefreshEnabled ? '每日 ${provider.autoRefreshTime} 自动刷新' : '关闭',
                    trailing: Switch(
                      value: provider.autoRefreshEnabled,
                      onChanged: provider.toggleAutoRefresh,
                    ),
                    onTap: () => provider.toggleAutoRefresh(!provider.autoRefreshEnabled),
                  ),
                  SettingsTile(
                    leading: Icons.delete_sweep_rounded,
                    title: '清理无效条目',
                    subtitle: '移除文件丢失、链接失效的媒体项',
                    trailing: TextButton(
                      onPressed: provider.cleanInvalidEntries,
                      child: Text('执行', style: TextStyle(color: context.warningAmber)),
                    ),
                  ),
                ],
              ),

              // 高级设置
              SettingsSection(
                title: '高级设置',
                children: [
                  SettingsTile(
                    leading: Icons.developer_mode_rounded,
                    title: '开发者选项',
                    subtitle: '日志级别、调试面板、性能覆盖层',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {}, // TODO
                  ),
                  SettingsTile(
                    leading: Icons.bug_report_rounded,
                    title: '发送反馈',
                    subtitle: '提交问题报告、功能建议',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _launchFeedback(),
                  ),
                  SettingsTile(
                    leading: Icons.info_rounded,
                    title: '关于 BeamTV',
                    subtitle: '版本 ${AppConstants.version} (${AppConstants.buildNumber})',
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () => _showAboutDialog(context),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 版本信息
              Center(
                child: Column(
                  children: [
                    Text(
                      'BeamTV ${AppConstants.version}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.textQuaternary,
                        fontFamily: 'JetBrainsMono',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '光线传播 • 让好的内容流动',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.textQuaternary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return '从未';
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 1) return '刚刚';
    if (diff.inHours < 1) return '${diff.inMinutes}分钟前';
    if (diff.inDays < 1) return '${diff.inHours}小时前';
    return '${diff.inDays}天前';
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  String _qualityLabel(VideoQuality q) {
    switch (q) {
      case VideoQuality.auto: return '自动 (根据网络/设备)';
      case VideoQuality.p4k: return '4K 优先';
      case VideoQuality.p1080: return '1080p 优先';
      case VideoQuality.p720: return '720p 优先';
      case VideoQuality.dataSaver: return '省流模式';
    }
  }

  String _audioLabel(AudioQuality a) {
    switch (a) {
      case AudioQuality.auto: return '自动 (最高可用)';
      case AudioQuality.lossless: return '无损优先';
      case AudioQuality.high: return '高质量';
      case AudioQuality.normal: return '标准';
    }
  }

  String _themeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system: return '跟随系统';
      case ThemeMode.light: return '浅色';
      case ThemeMode.dark: return '深色';
    }
  }

  String _languageLabel(String code) {
    switch (code) {
      case 'zh': return '简体中文';
      case 'en': return 'English';
      case 'ja': return '日本語';
      default: return code;
    }
  }

  void _showQualityDialog(BuildContext context, SettingsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _OptionBottomSheet<VideoQuality>(
        title: '画质偏好',
        currentValue: provider.preferredQuality,
        options: VideoQuality.values,
        labelBuilder: (q) => _qualityLabel(q),
        onSelected: provider.setPreferredQuality,
      ),
    );
  }

  void _showAudioDialog(BuildContext context, SettingsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _OptionBottomSheet<AudioQuality>(
        title: '音频偏好',
        currentValue: provider.preferredAudio,
        options: AudioQuality.values,
        labelBuilder: (a) => _audioLabel(a),
        onSelected: provider.setPreferredAudio,
      ),
    );
  }

  void _showSpeedDialog(BuildContext context, SettingsProvider provider) {
    final speeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _OptionBottomSheet<double>(
        title: '播放速度',
        currentValue: provider.playbackSpeed,
        options: speeds,
        labelBuilder: (s) => '${s}x',
        onSelected: provider.setPlaybackSpeed,
      ),
    );
  }

  void _showThemeDialog(BuildContext context, SettingsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _OptionBottomSheet<ThemeMode>(
        title: '主题模式',
        currentValue: provider.themeMode,
        options: ThemeMode.values,
        labelBuilder: _themeLabel,
        onSelected: provider.setThemeMode,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, SettingsProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _OptionBottomSheet<String>(
        title: '应用语言',
        currentValue: provider.languageCode,
        options: ['zh', 'en', 'ja'],
        labelBuilder: _languageLabel,
        onSelected: provider.setLanguage,
      ),
    );
  }

  void _showFontScaleDialog(BuildContext context, SettingsProvider provider) {
    final scales = [0.85, 0.9, 1.0, 1.1, 1.2, 1.3];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _OptionBottomSheet<double>(
        title: '字体大小',
        currentValue: provider.fontScale,
        options: scales,
        labelBuilder: (s) => '${(s * 100).round()}%',
        onSelected: provider.setFontScale,
      ),
    );
  }

  void _showCacheDialog(BuildContext context, SettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('缓存管理'),
        content: Text('缓存大小: ${_formatBytes(provider.cacheSize)}\n\n清理将删除所有临时文件、缩略图、预加载数据。'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('取消')),
          FilledButton(
            onPressed: () {
              context.pop();
              provider.clearCache();
            },
            style: FilledButton.styleFrom(backgroundColor: context.warningAmber),
            child: const Text('清理缓存'),
          ),
        ],
      ),
    );
  }

  void _showDnsDialog(BuildContext context, SettingsProvider provider) {
    final controller = TextEditingController(text: provider.customDns ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('自定义 DNS'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '例如: 1.1.1.1, 8.8.8.8 或 https://dns.example.com/dns-query',
            labelText: 'DNS 服务器',
          ),
        ),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('取消')),
          FilledButton(
            onPressed: () {
              provider.setCustomDns(controller.text.trim().isEmpty ? null : controller.text.trim());
              context.pop();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.brandIndigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tv_rounded, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),
            const Text('关于 BeamTV'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('版本: ${AppConstants.version} (${AppConstants.buildNumber})'),
            const SizedBox(height: 8),
            Text('包名: ${AppConstants.packageName}'),
            const SizedBox(height: 8),
            Text('最低支持: Android ${AppConstants.minSdkVersion}+'),
            const SizedBox(height: 16),
            const Text('基于 Flutter 构建 · 采用 Linear 设计语言'),
            const SizedBox(height: 8),
            const Text('开源协议: MIT License'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('关闭'),
          ),
          FilledButton(
            onPressed: () {
              context.pop();
              _launchGithub();
            },
            child: const Text('GitHub'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchFeedback() async {
    await launchUrlString('https://github.com/beamtv/beamtv/issues/new');
  }

  Future<void> _launchGithub() async {
    await launchUrlString('https://github.com/beamtv/beamtv');
  }
}

/// 通用选项底部弹层
class _OptionBottomSheet<T> extends StatelessWidget {
  final String title;
  final T currentValue;
  final List<T> options;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;

  const _OptionBottomSheet({
    required this.title,
    required this.currentValue,
    required this.options,
    required this.labelBuilder,
    required this.onSelected,
  });

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
            margin: const EdgeInsets.only(bottom: 16, top: 8),
            decoration: BoxDecoration(
              color: context.textQuaternary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ...options.map((option) {
            final isSelected = option == currentValue;
            return ListTile(
              title: Text(
                labelBuilder(option),
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  color: isSelected ? context.brandViolet : context.textPrimary,
                ),
              ),
              trailing: isSelected
                  ? Icon(Icons.check_rounded, color: context.brandViolet, size: 22)
                  : null,
              onTap: () {
                onSelected(option);
                context.pop();
              },
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}