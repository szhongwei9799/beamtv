// 设置 Provider
library features.settings.presentation.providers;

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_constants.dart';
import 'settings_page.dart';

class SettingsProvider extends ChangeNotifier {
  // 账户与同步
  bool _syncEnabled = false;
  bool _isLoggedIn = false;
  String _username = '';
  DateTime? _lastSyncTime;

  // 播放设置
  VideoQuality _preferredQuality = VideoQuality.auto;
  AudioQuality _preferredAudio = AudioQuality.auto;
  double _playbackSpeed = 1.0;
  bool _hdrEnabled = true;
  bool _aiEnhancementEnabled = false;

  // 网络与缓存
  bool _wifiOnly = true;
  int _cacheSize = 0;
  String? _customDns;

  // 界面与语言
  ThemeMode _themeMode = ThemeMode.dark; // 默认深色
  String _languageCode = 'zh';
  double _fontScale = 1.0;

  // 媒体库
  bool _autoRefreshEnabled = false;
  String _autoRefreshTime = '03:00';

  // 开发者
  bool _debugMode = false;

  // Getters
  bool get syncEnabled => _syncEnabled;
  bool get isLoggedIn => _isLoggedIn;
  String get username => _username;
  DateTime? get lastSyncTime => _lastSyncTime;

  VideoQuality get preferredQuality => _preferredQuality;
  AudioQuality get preferredAudio => _preferredAudio;
  double get playbackSpeed => _playbackSpeed;
  bool get hdrEnabled => _hdrEnabled;
  bool get aiEnhancementEnabled => _aiEnhancementEnabled;

  bool get wifiOnly => _wifiOnly;
  int get cacheSize => _cacheSize;
  String? get customDns => _customDns;

  ThemeMode get themeMode => _themeMode;
  String get languageCode => _languageCode;
  double get fontScale => _fontScale;

  bool get autoRefreshEnabled => _autoRefreshEnabled;
  String get autoRefreshTime => _autoRefreshTime;

  bool get debugMode => _debugMode;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();

    _syncEnabled = prefs.getBool('sync_enabled') ?? false;
    _isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    _username = prefs.getString('username') ?? '';
    _lastSyncTime = prefs.getString('last_sync_time') != null
        ? DateTime.parse(prefs.getString('last_sync_time')!)
        : null;

    _preferredQuality = VideoQuality.values.firstWhere(
      (e) => e.name == prefs.getString('preferred_quality'),
      orElse: () => VideoQuality.auto,
    );
    _preferredAudio = AudioQuality.values.firstWhere(
      (e) => e.name == prefs.getString('preferred_audio'),
      orElse: () => AudioQuality.auto,
    );
    _playbackSpeed = prefs.getDouble('playback_speed') ?? 1.0;
    _hdrEnabled = prefs.getBool('hdr_enabled') ?? true;
    _aiEnhancementEnabled = prefs.getBool('ai_enhancement_enabled') ?? false;

    _wifiOnly = prefs.getBool('wifi_only') ?? true;
    _cacheSize = prefs.getInt('cache_size') ?? 0;
    _customDns = prefs.getString('custom_dns');

    _themeMode = ThemeMode.values.firstWhere(
      (e) => e.name == prefs.getString('theme_mode'),
      orElse: () => ThemeMode.dark,
    );
    _languageCode = prefs.getString('language_code') ?? 'zh';
    _fontScale = prefs.getDouble('font_scale') ?? 1.0;

    _autoRefreshEnabled = prefs.getBool('auto_refresh_enabled') ?? false;
    _autoRefreshTime = prefs.getString('auto_refresh_time') ?? '03:00';

    _debugMode = prefs.getBool('debug_mode') ?? false;

    notifyListeners();
  }

  // 账户与同步
  void toggleSync(bool value) {
    _syncEnabled = value;
    _saveBool('sync_enabled', value);
    notifyListeners();
  }

  void toggleLogin(bool value, {String username = ''}) {
    _isLoggedIn = value;
    if (value) _username = username;
    _saveBool('is_logged_in', value);
    _saveString('username', username);
    notifyListeners();
  }

  void updateLastSyncTime() {
    _lastSyncTime = DateTime.now();
    _saveString('last_sync_time', _lastSyncTime!.toIso8601String());
    notifyListeners();
  }

  // 播放设置
  void setPreferredQuality(VideoQuality q) {
    _preferredQuality = q;
    _saveString('preferred_quality', q.name);
    notifyListeners();
  }

  void setPreferredAudio(AudioQuality a) {
    _preferredAudio = a;
    _saveString('preferred_audio', a.name);
    notifyListeners();
  }

  void setPlaybackSpeed(double speed) {
    _playbackSpeed = speed;
    _saveDouble('playback_speed', speed);
    notifyListeners();
  }

  void toggleHdr(bool value) {
    _hdrEnabled = value;
    _saveBool('hdr_enabled', value);
    notifyListeners();
  }

  void toggleAiEnhancement(bool value) {
    _aiEnhancementEnabled = value;
    _saveBool('ai_enhancement_enabled', value);
    notifyListeners();
  }

  // 网络与缓存
  void toggleWifiOnly(bool value) {
    _wifiOnly = value;
    _saveBool('wifi_only', value);
    notifyListeners();
  }

  void setCacheSize(int bytes) {
    _cacheSize = bytes;
    _saveInt('cache_size', bytes);
    notifyListeners();
  }

  void clearCache() {
    // TODO: 实际清理缓存文件
    _cacheSize = 0;
    _saveInt('cache_size', 0);
    notifyListeners();
  }

  void setCustomDns(String? dns) {
    _customDns = dns;
    if (dns != null) {
      _saveString('custom_dns', dns);
    } else {
      _remove('custom_dns');
    }
    notifyListeners();
  }

  // 界面与语言
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _saveString('theme_mode', mode.name);
    notifyListeners();
  }

  void setLanguage(String code) {
    _languageCode = code;
    _saveString('language_code', code);
    notifyListeners();
  }

  void setFontScale(double scale) {
    _fontScale = scale.clamp(0.85, 1.5);
    _saveDouble('font_scale', _fontScale);
    notifyListeners();
  }

  // 媒体库
  void toggleAutoRefresh(bool value) {
    _autoRefreshEnabled = value;
    _saveBool('auto_refresh_enabled', value);
    notifyListeners();
  }

  void setAutoRefreshTime(String time) {
    _autoRefreshTime = time;
    _saveString('auto_refresh_time', time);
    notifyListeners();
  }

  void cleanInvalidEntries() {
    // TODO: 实现清理逻辑
    notifyListeners();
  }

  // 开发者
  void toggleDebugMode(bool value) {
    _debugMode = value;
    _saveBool('debug_mode', value);
    notifyListeners();
  }

  // SharedPreferences 辅助
  Future<void> _saveBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> _saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> _saveDouble(String key, double value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<void> _saveInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> _remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}