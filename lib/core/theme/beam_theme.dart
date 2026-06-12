/// BeamTV 主题系统 — Linear 深色主题
import 'package:flutter/material.dart';

class BeamColors {
  static const Color background = Color(0xFF08090A);
  static const Color surface = Color(0xFF121316);
  static const Color surfaceElevated = Color(0xFF1A1B1E);
  static const Color border = Color(0xFF1E1F22);
  static const Color primary = Color(0xFF5E6AD2);
  static const Color primaryLight = Color(0xFF7B83EB);
  static const Color accent = Color(0xFF5E6AD2);
  static const Color textPrimary = Color(0xFFE6E7EB);
  static const Color textSecondary = Color(0xFF9B9CA3);
  static const Color textTertiary = Color(0xFF5F6065);
  static const Color success = Color(0xFF34D399);
  static const Color warning = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);
  static const Color surfaceDim = Color(0xFF0B0C0E);
  static const Color surfaceBright = Color(0xFF1C1D20);
  static const Color onSurfaceContainer = Color(0xFFD1D2D6);
  static const Color borderLineTint = Color(0xFF2A2B2E);
}

class BeamTextStyles {
  static const String _fontFamily = 'monospace';

  static const TextStyle display = TextStyle(
    fontFamily: _fontFamily, fontSize: 32, fontWeight: FontWeight.w700,
    color: BeamColors.textPrimary, height: 1.2, letterSpacing: -0.5,
  );
  static const TextStyle h1 = TextStyle(
    fontFamily: _fontFamily, fontSize: 24, fontWeight: FontWeight.w600,
    color: BeamColors.textPrimary, height: 1.3,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: _fontFamily, fontSize: 18, fontWeight: FontWeight.w600,
    color: BeamColors.textPrimary, height: 1.3,
  );
  static const TextStyle body = TextStyle(
    fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w400,
    color: BeamColors.textPrimary, height: 1.5,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily, fontSize: 12, fontWeight: FontWeight.w400,
    color: BeamColors.textSecondary, height: 1.4,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: _fontFamily, fontSize: 11, fontWeight: FontWeight.w500,
    color: BeamColors.textTertiary, height: 1.3, letterSpacing: 0.3,
  );
  static const TextStyle label = TextStyle(
    fontFamily: _fontFamily, fontSize: 13, fontWeight: FontWeight.w500,
    color: BeamColors.textPrimary, height: 1.3,
  );
  static const TextStyle button = TextStyle(
    fontFamily: _fontFamily, fontSize: 14, fontWeight: FontWeight.w600,
    color: Colors.white, height: 1.2, letterSpacing: 0.3,
  );
}

class BeamTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: BeamColors.background,
      colorScheme: const ColorScheme.dark(
        primary: BeamColors.primary,
        secondary: BeamColors.primaryLight,
        surface: BeamColors.surface,
        error: BeamColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: BeamColors.textPrimary,
        onError: Colors.white,
        surfaceTint: BeamColors.surfaceElevated,
      ),
      textTheme: const TextTheme(
        displayLarge: BeamTextStyles.display,
        headlineLarge: BeamTextStyles.h1,
        headlineMedium: BeamTextStyles.h2,
        bodyLarge: BeamTextStyles.body,
        bodyMedium: BeamTextStyles.bodySmall,
        labelLarge: BeamTextStyles.label,
        labelSmall: BeamTextStyles.caption,
      ),
      dividerColor: BeamColors.border,
      dividerTheme: const DividerThemeData(color: BeamColors.border, thickness: 1, space: 0),
      dialogTheme: const DialogThemeData(
        backgroundColor: BeamColors.surface,
        titleTextStyle: BeamTextStyles.h2,
        contentTextStyle: BeamTextStyles.body,
      ),
      chipTheme: const ChipThemeData(
        backgroundColor: BeamColors.surface,
        selectedColor: Color(0x335E6AD2),
        labelStyle: BeamTextStyles.bodySmall,
        side: BorderSide(color: BeamColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: BeamColors.surfaceElevated,
        contentTextStyle: BeamTextStyles.bodySmall,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: BeamColors.primary,
        secondary: BeamColors.primaryLight,
        surface: Color(0xFFF5F5F7),
        error: BeamColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1A1A1E),
        onError: Colors.white,
        surfaceTint: Colors.white,
      ),
      scaffoldBackgroundColor: const Color(0xFFF5F5F7),
      dividerColor: const Color(0xFFE1E1E6),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'monospace', fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFF1A1A1E)),
        headlineLarge: TextStyle(fontFamily: 'monospace', fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1E)),
        bodyLarge: TextStyle(fontFamily: 'monospace', fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF1A1A1E)),
      ),
    );
  }
}
