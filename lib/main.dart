// BeamTV 应用入口
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/beam_theme.dart';
import 'core/routing/app_router.dart';
import 'core/constants/app_constants.dart';
import 'features/local_media/presentation/providers/local_media_provider.dart';
import 'features/discover/presentation/providers/discover_provider.dart';
import 'features/settings/presentation/providers/settings_provider.dart';

void main() {
  // 确保 Flutter 绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BeamTVApp());
}

class BeamTVApp extends StatelessWidget {
  const BeamTVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => LocalMediaProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => DiscoverProvider()..initialize()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            themeMode: settings.themeMode,
            theme: BeamTheme.light,
            darkTheme: BeamTheme.dark,
            routerConfig: AppRouter.router,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(settings.fontScale),
                ),
                child: child!,
              );
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CN'),
              Locale('en', 'US'),
              Locale('ja', 'JP'),
            ],
            locale: Locale(settings.languageCode),
          );
        },
      ),
    );
  }
}