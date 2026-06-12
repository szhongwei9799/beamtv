/// 设置状态管理
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/extensions/context_ext.dart';
import '../../../../core/models/media_models.dart';

class SettingsProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;
  String _languageCode = 'zh';
  double _fontScale = 1.0;
  VideoQuality _defaultVideoQuality = VideoQuality.auto;
  AudioQuality _defaultAudioQuality = AudioQuality.auto;

  ThemeMode get mode => _mode;
  String get languageCode => _languageCode;
  double get fontScale => _fontScale;
  VideoQuality get defaultVideoQuality => _defaultVideoQuality;
  AudioQuality get defaultAudioQuality => _defaultAudioQuality;

  void initialize() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('language_code') ?? 'zh';
    _fontScale = prefs.getDouble('font_scale') ?? 1.0;
    final modeIndex = prefs.getInt('theme_mode') ?? 1;
    _mode = ThemeMode.values[modeIndex.clamp(0, ThemeMode.values.length - 1)];
    final vqIndex = prefs.getInt('video_quality') ?? 5;
    _defaultVideoQuality = VideoQuality.values[vqIndex.clamp(0, VideoQuality.values.length - 1)];
    final aqIndex = prefs.getInt('audio_quality') ?? 4;
    _defaultAudioQuality = AudioQuality.values[aqIndex.clamp(0, AudioQuality.values.length - 1)];
    notifyListeners();
  }

  Future<void> setMode(ThemeMode mode) async {
    _mode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme_mode', mode.index);
  }

  Future<void> setLanguageCode(String code) async {
    _languageCode = code;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);
  }

  Future<void> setFontScale(double scale) async {
    _fontScale = scale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_scale', scale);
  }

  List<String> getLanguageOptions() => ['zh', 'en', 'ja'];
  String getLanguageLabel(String code) {
    switch (code) {
      case 'zh': return '中文';
      case 'en': return 'English';
      case 'ja': return '日本語';
      default: return code;
    }
  }
}
