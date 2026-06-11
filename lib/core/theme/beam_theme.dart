// BeamTV 主题系统 - 参考 Linear 设计语言
// 深色模式优先、近黑背景、半透明白边框、品牌青蓝强调色
library core.theme;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// BeamTV 设计令牌
class BeamTokens {
  // ===== 背景层级 =====
  static const Color bgMarketing = Color(0xFF08090A); // 最深：营销/启动页
  static const Color bgPanel = Color(0xFF0F1011); // 面板/侧边栏
  static const Color bgSurface = Color(0xFF191A1B); // 卡片/弹层/下拉
  static const Color bgSecondary = Color(0xFF28282C); // 悬停/稍高层级

  // ===== 文本层级 =====
  static const Color textPrimary = Color(0xFFF7F8F8); // 主文本：近白，微暖
  static const Color textSecondary = Color(0xFFD0D6E0); // 次级文本：银灰
  static const Color textTertiary = Color(0xFF8A8F98); // 三级：置灰
  static const Color textQuaternary = Color(0xFF62666D); // 四级：时间戳/禁用

  // ===== 品牌强调色 =====
  static const Color brandIndigo = Color(0xFF5E6AD2); // 主品牌色：CTA 背景
  static const Color brandViolet = Color(0xFF7170FF); // 交互强调：链接/激活态
  static const Color brandVioletHover = Color(0xFF828FFF); // 悬停态
  static const Color brandLavender = Color(0xFF7A7FAD); // 安全/次要品牌

  // ===== 状态色 =====
  static const Color successGreen = Color(0xFF27A644); // 进行中/成功
  static const Color successEmerald = Color(0xFF10B981); // 完成/徽章
  static const Color warningAmber = Color(0xFFF59E0B); // 警告
  static const Color errorRed = Color(0xFFEF4444); // 错误

  // ===== 边框系统 =====
  static const Color borderSubtle = Color(0x0DFFFFFF); // rgba(255,255,255,0.05)
  static const Color borderStandard = Color(0x14FFFFFF); // rgba(255,255,255,0.08)
  static const Color borderSolid = Color(0xFF23252A); // 实线深色边框
  static const Color borderLineTint = Color(0xFF141516); // 极淡分割线
  static const Color borderLineTertiary = Color(0xFF18191A); // 稍可见分割线

  // ===== 覆盖层 =====
  static const Color overlayPrimary = Color(0xD9000000); // rgba(0,0,0,0.85)

  // ===== 语义别名 =====
  static const Color primary = brandViolet;
  static const Color primaryContainer = brandIndigo;
  static const Color onPrimary = Colors.white;
  static const Color secondary = brandLavender;
  static const Color onSecondary = Colors.white;
  static const Color surface = bgSurface;
  static const Color onSurface = textPrimary;
  static const Color surfaceContainer = bgSecondary;
  static const Color onSurfaceContainer = textSecondary;
  static const Color outline = borderStandard;
  static const Color outlineVariant = borderSubtle;
  static const Color error = errorRed;
  static const Color success = successGreen;
  static const Color warning = warningAmber;
}

/// 圆角系统
class BeamRadius {
  static const double micro = 2.0; // 内联徽章/工具栏按钮
  static const double small = 4.0; // 小容器/列表项
  static const double standard = 6.0; // 按钮/输入框/功能元素
  static const double card = 8.0; // 卡片/下拉/弹出
  static const double panel = 12.0; // 面板/特色卡片/区块容器
  static const double large = 22.0; // 大面板元素
  static const double pill = 9999.0; // 胶囊/筛选标签/状态标签
  static const double circle = 50.0; // 圆形按钮/头像/状态点
}

/// 阴影/高度系统
class BeamElevation {
  static const List<BoxShadow> level0 = []; // 页面背景
  static const List<BoxShadow> level1 = [ // 微高度：工具栏按钮
    BoxShadow(
      color: Color(0x08000000),
      offset: Offset(0, 1.2),
      blurRadius: 0,
    ),
  ];
  static const List<BoxShadow> level2 = [ // 表面：卡片/输入框
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 1,
    ),
  ];
  static const List<BoxShadow> level2Inset = [ // 内凹面板
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 0),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
  static const List<BoxShadow> level3 = [ // 环：边框即阴影技巧
    BoxShadow(
      color: Color(0x33000000),
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 1,
    ),
  ];
  static const List<BoxShadow> level4 = [ // 悬浮：下拉/浮层
    BoxShadow(
      color: Color(0x66000000),
      offset: Offset(0, 2),
      blurRadius: 4,
    ),
  ];
  static const List<BoxShadow> level5 = [ // 对话框/命令面板
    BoxShadow(
      color: Colors.transparent,
      offset: Offset(0, 8),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Color(0x03000000),
      offset: Offset(0, 5),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 3),
      blurRadius: 2,
    ),
    BoxShadow(
      color: Color(0x12000000),
      offset: Offset(0, 1),
      blurRadius: 1,
    ),
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 0),
      blurRadius: 1,
    ),
  ];
  static const List<BoxShadow> focus = [ // 键盘焦点
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];
}

/// 间距系统（8px 基准）
class BeamSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
  // 光学微调值
  static const double micro1 = 1.0;
  static const double micro2 = 7.0;
  static const double micro3 = 11.0;
  static const double micro4 = 19.0;
  static const double micro5 = 22.0;
  static const double micro6 = 35.0;
}

/// 典型内边距组合
class BeamPadding {
  static const EdgeInsets button = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
  static const EdgeInsets buttonSmall = EdgeInsets.symmetric(horizontal: 10, vertical: 4);
  static const EdgeInsets card = EdgeInsets.all(16);
  static const EdgeInsets cardCompact = EdgeInsets.all(12);
  static const EdgeInsets screen = EdgeInsets.all(24);
  static const EdgeInsets screenCompact = EdgeInsets.all(16);
  static const EdgeInsets listItem = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const EdgeInsets pill = EdgeInsets.symmetric(horizontal: 10, vertical: 4);
  static const EdgeInsets badge = EdgeInsets.symmetric(horizontal: 8, vertical: 2);
}

/// 字体系统 - Inter Variable + JetBrains Mono
class BeamTypography {
  // 字体族
  static const String fontFamily = 'Inter';
  static const String fontFamilyMono = 'JetBrainsMono';

  // OpenType 特性：cv01(单层a) + ss03(几何字形)
  static const List<String> fontFeatures = ['cv01', 'ss03'];

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    double? height,
    double? letterSpacing,
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? BeamTypography.fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color ?? BeamTokens.textPrimary,
      fontFeatures: fontFeatures.map((f) => FontFeature.enable(f)).toList(),
    );
  }

  // ===== Display 层级（负 letter-spacing）=====
  static TextStyle displayXL({Color? color}) => _base(
    fontSize: 72,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: -1.584,
    color: color,
  );

  static TextStyle displayLarge({Color? color}) => _base(
    fontSize: 64,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: -1.408,
    color: color,
  );

  static TextStyle display({Color? color}) => _base(
    fontSize: 48,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: -1.056,
    color: color,
  );

  // ===== Heading 层级 =====
  static TextStyle h1({Color? color}) => _base(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    height: 1.125,
    letterSpacing: -0.704,
    color: color,
  );

  static TextStyle h2({Color? color}) => _base(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.333,
    letterSpacing: -0.288,
    color: color,
  );

  static TextStyle h3({Color? color}) => _base(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.333,
    letterSpacing: -0.24,
    color: color,
  );

  // ===== Body 层级 =====
  static TextStyle bodyLarge({Color? color}) => _base(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: -0.165,
    color: color ?? BeamTokens.textSecondary,
  );

  static TextStyle bodyEmphasis({Color? color}) => _base(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.6,
    color: color ?? BeamTokens.textPrimary,
  );

  static TextStyle body({Color? color}) => _base(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: color ?? BeamTokens.textSecondary,
  );

  static TextStyle bodyMedium({Color? color}) => _base(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: color ?? BeamTokens.textPrimary,
  );

  static TextStyle bodySemibold({Color? color}) => _base(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: color ?? BeamTokens.textPrimary,
  );

  // ===== Small 层级 =====
  static TextStyle small({Color? color}) => _base(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: -0.165,
    color: color ?? BeamTokens.textTertiary,
  );

  static TextStyle smallMedium({Color? color}) => _base(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 1.6,
    letterSpacing: -0.165,
    color: color ?? BeamTokens.textSecondary,
  );

  static TextStyle smallSemibold({Color? color}) => _base(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.6,
    letterSpacing: -0.165,
    color: color ?? BeamTokens.textPrimary,
  );

  static TextStyle smallLight({Color? color}) => _base(
    fontSize: 15,
    fontWeight: FontWeight.w300,
    height: 1.47,
    letterSpacing: -0.165,
    color: color ?? BeamTokens.textQuaternary,
  );

  // ===== Caption / Label =====
  static TextStyle captionLarge({Color? color}) => _base(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: -0.182,
    color: color ?? BeamTokens.textTertiary,
  );

  static TextStyle caption({Color? color}) => _base(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.13,
    color: color ?? BeamTokens.textQuaternary,
  );

  static TextStyle label({Color? color}) => _base(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: color ?? BeamTokens.textTertiary,
  );

  static TextStyle micro({Color? color}) => _base(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: color ?? BeamTokens.textQuaternary,
  );

  static TextStyle tiny({Color? color}) => _base(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.15,
    color: color ?? BeamTokens.textQuaternary,
  );

  // ===== Link =====
  static TextStyle linkLarge({Color? color}) => _base(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: color ?? BeamTokens.brandViolet,
  );

  static TextStyle linkMedium({Color? color}) => _base(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    height: 2.67,
    color: color ?? BeamTokens.brandViolet,
  );

  static TextStyle linkSmall({Color? color}) => _base(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: color ?? BeamTokens.brandViolet,
  );

  // ===== Monospace (代码/技术标签) =====
  static TextStyle monoBody({Color? color}) => _base(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontFamily: fontFamilyMono,
    color: color ?? BeamTokens.textSecondary,
  );

  static TextStyle monoCaption({Color? color}) => _base(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    fontFamily: fontFamilyMono,
    color: color ?? BeamTokens.textTertiary,
  );

  static TextStyle monoLabel({Color? color}) => _base(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    fontFamily: fontFamilyMono,
    color: color ?? BeamTokens.textQuaternary,
  );
}

/// 应用主题构建器
class BeamTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: BeamTypography.fontFamily,

    // ===== 颜色方案 =====
    colorScheme: const ColorScheme.dark(
      primary: BeamTokens.primary,
      primaryContainer: BeamTokens.primaryContainer,
      onPrimary: BeamTokens.onPrimary,
      secondary: BeamTokens.secondary,
      onSecondary: BeamTokens.onSecondary,
      surface: BeamTokens.surface,
      onSurface: BeamTokens.onSurface,
      surfaceContainer: BeamTokens.surfaceContainer,
      onSurfaceContainer: BeamTokens.onSurfaceContainer,
      outline: BeamTokens.outline,
      outlineVariant: BeamTokens.outlineVariant,
      error: BeamTokens.error,
      errorContainer: Color(0xFF7F1D1D),
      onError: Colors.white,
      onErrorContainer: Colors.white,
      shadow: Colors.black,
      scrim: Colors.black87,
      inverseSurface: BeamTokens.textPrimary,
      onInverseSurface: BeamTokens.bgMarketing,
      inversePrimary: BeamTokens.brandViolet,
    ),

    // ===== 脚手架 =====
    scaffoldBackgroundColor: BeamTokens.bgMarketing,

    // ===== AppBar =====
    appBarTheme: AppBarTheme(
      backgroundColor: BeamTokens.bgPanel,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: BeamTypography.h2(),
      toolbarTextStyle: BeamTypography.bodyMedium(),
      iconTheme: const IconThemeData(
        color: BeamTokens.textPrimary,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: BeamTokens.textSecondary,
        size: 22,
      ),
      shape: const Border(
        bottom: BorderSide(
          color: BeamTokens.borderSubtle,
          width: 0.5,
        ),
      ),
    ),

    // ===== 卡片 =====
    cardTheme: CardThemeData(
      color: BeamTokens.bgSurface.withOpacity(0.5),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeamRadius.card),
        side: const BorderSide(
          color: BeamTokens.borderStandard,
          width: 0.5,
        ),
      ),
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
    ),

    // ===== 按钮系统 =====
    // Ghost Button (默认)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: BeamTokens.brandIndigo,
        foregroundColor: Colors.white,
        padding: BeamPadding.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BeamRadius.standard),
        ),
        elevation: 0,
        textStyle: BeamTypography.label(),
        shadowColor: Colors.transparent,
      ),
    ),

    // Outlined Button
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: BeamTokens.textSecondary,
        padding: BeamPadding.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BeamRadius.standard),
        ),
        side: const BorderSide(
          color: BeamTokens.borderSolid,
          width: 1,
        ),
        textStyle: BeamTypography.label(),
        backgroundColor: Colors.transparent,
      ),
    ),

    // Text Button (Ghost)
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: BeamTokens.textSecondary,
        padding: BeamPadding.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BeamRadius.standard),
        ),
        textStyle: BeamTypography.label(),
        backgroundColor: const Color(0x08FFFFFF), // rgba(255,255,255,0.02)
      ),
    ),

    // Filled Button (次要品牌色)
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: BeamTokens.bgSecondary,
        foregroundColor: BeamTokens.textPrimary,
        padding: BeamPadding.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BeamRadius.standard),
        ),
        textStyle: BeamTypography.label(),
      ),
    ),

    // ===== 输入框 =====
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0x08FFFFFF), // rgba(255,255,255,0.02)
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      labelStyle: BeamTypography.bodyMedium(color: BeamTokens.textTertiary),
      hintStyle: BeamTypography.bodyMedium(color: BeamTokens.textQuaternary),
      floatingLabelStyle: BeamTypography.bodyMedium(color: BeamTokens.brandViolet),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
        borderSide: const BorderSide(
          color: BeamTokens.borderStandard,
          width: 0.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
        borderSide: const BorderSide(
          color: BeamTokens.borderStandard,
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
        borderSide: const BorderSide(
          color: BeamTokens.brandViolet,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
        borderSide: const BorderSide(
          color: BeamTokens.errorRed,
          width: 0.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
        borderSide: const BorderSide(
          color: BeamTokens.errorRed,
          width: 1.5,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
        borderSide: const BorderSide(
          color: BeamTokens.borderSubtle,
          width: 0.5,
        ),
      ),
    ),

    // ===== 分割线 =====
    dividerTheme: DividerThemeData(
      color: BeamTokens.borderLineTint,
      thickness: 0.5,
      space: 1,
      indent: 0,
      endIndent: 0,
    ),

    // ===== 底部导航 =====
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: BeamTokens.bgPanel,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      height: 72,
      indicatorColor: BeamTokens.brandIndigo.withOpacity(0.15),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BeamTypography.label(color: BeamTokens.textPrimary);
        }
        return BeamTypography.label(color: BeamTokens.textQuaternary);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(
            color: BeamTokens.brandViolet,
            size: 24,
          );
        }
        return const IconThemeData(
          color: BeamTokens.textQuaternary,
          size: 24,
        );
      }),
    ),

    // ===== 标签页 =====
    tabBarTheme: TabBarThemeData(
      labelColor: BeamTokens.textPrimary,
      unselectedLabelColor: BeamTokens.textQuaternary,
      indicatorColor: BeamTokens.brandViolet,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: BeamTypography.label(),
      unselectedLabelStyle: BeamTypography.label(),
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.pressed)) {
          return BeamTokens.bgSecondary;
        }
        return Colors.transparent;
      }),
    ),

    // ===== Chip =====
    chipTheme: ChipThemeData(
      backgroundColor: Colors.transparent,
      disabledColor: BeamTokens.bgSecondary,
      selectedColor: BeamTokens.brandIndigo.withOpacity(0.3),
      secondarySelectedColor: BeamTokens.brandIndigo,
      padding: BeamPadding.pill,
      labelStyle: BeamTypography.label(),
      secondaryLabelStyle: BeamTypography.label(color: Colors.white),
      brightness: Brightness.dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeamRadius.pill),
        side: const BorderSide(
          color: BeamTokens.borderSolid,
          width: 1,
        ),
      ),
      side: const BorderSide(
        color: BeamTokens.borderSolid,
        width: 1,
      ),
      pressElevation: 0,
      elevation: 0,
    ),

    // ===== 对话框 =====
    dialogTheme: DialogThemeData(
      backgroundColor: BeamTokens.bgSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeamRadius.panel),
        side: const BorderSide(
          color: BeamTokens.borderStandard,
          width: 0.5,
        ),
      ),
      titleTextStyle: BeamTypography.h3(),
      contentTextStyle: BeamTypography.body(),
    ),

    // ===== 底部弹层 =====
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: BeamTokens.bgSurface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(BeamRadius.large)),
        side: const BorderSide(
          color: BeamTokens.borderStandard,
          width: 0.5,
        ),
      ),
      modalBackgroundColor: BeamTokens.bgSurface,
      dragHandleColor: BeamTokens.textQuaternary,
      showDragHandle: true,
    ),

    // ===== 滑块 =====
    sliderTheme: SliderThemeData(
      activeTrackColor: BeamTokens.brandViolet,
      inactiveTrackColor: BeamTokens.borderStandard,
      thumbColor: BeamTokens.brandViolet,
      overlayColor: BeamTokens.brandViolet.withOpacity(0.15),
      valueIndicatorColor: BeamTokens.brandIndigo,
      valueIndicatorTextStyle: BeamTypography.monoCaption(color: Colors.white),
      trackHeight: 2,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    ),

    // ===== 进度指示器 =====
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: BeamTokens.brandViolet,
      linearTrackColor: BeamTokens.borderStandard,
      circularTrackColor: BeamTokens.borderStandard,
    ),

    // ===== 开关/复选框/单选 =====
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BeamTokens.brandViolet;
        }
        return BeamTokens.textQuaternary;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BeamTokens.brandViolet.withOpacity(0.3);
        }
        return BeamTokens.borderStandard;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BeamTokens.brandViolet;
        }
        return BeamTokens.borderSolid;
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BeamTokens.brandViolet;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: const BorderSide(
        color: BeamTokens.borderSolid,
        width: 1.5,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeamRadius.small),
      ),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BeamTokens.brandViolet;
        }
        return BeamTokens.textQuaternary;
      }),
    ),

    // ===== 列表项 =====
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      titleTextStyle: BeamTypography.bodyMedium(),
      subtitleTextStyle: BeamTypography.caption(),
      leadingAndTrailingTextStyle: BeamTypography.caption(),
      iconColor: BeamTokens.textTertiary,
      selectedColor: BeamTokens.brandViolet,
      selectedTileColor: BeamTokens.brandIndigo.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeamRadius.standard),
      ),
    ),

    // ===== 扩展 =====
    extensions: [
      _BeamCustomColors(),
    ],
  );

  // Light theme (fallback - 基于 Linear 的浅色中性色)
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: BeamTypography.fontFamily,
    colorScheme: ColorScheme.light(
      primary: BeamTokens.brandIndigo,
      primaryContainer: BeamTokens.brandViolet.withOpacity(0.15),
      onPrimary: Colors.white,
      secondary: BeamTokens.brandLavender,
      onSecondary: Colors.white,
      surface: const Color(0xFFF7F8F8),
      onSurface: const Color(0xFF08090A),
      surfaceContainer: const Color(0xFFF3F4F5),
      onSurfaceContainer: const Color(0xFF171717),
      outline: const Color(0xFFD0D6E0),
      outlineVariant: const Color(0xFFE6E6E6),
      error: BeamTokens.errorRed,
      errorContainer: const Color(0xFFFEF2F2),
      onError: Colors.white,
      onErrorContainer: const Color(0xFF7F1D1D),
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: const Color(0xFF08090A),
      onInverseSurface: const Color(0xFFF7F8F8),
      inversePrimary: BeamTokens.brandViolet,
    ),
    scaffoldBackgroundColor: const Color(0xFFF7F8F8),
    extensions: [_BeamCustomColors()],
  );
}

/// 自定义主题扩展 - 暴露 BeamTokens 到 Theme.extensions
class _BeamCustomColors extends ThemeExtension<_BeamCustomColors> {
  const _BeamCustomColors();

  @override
  _BeamCustomColors copyWith() => const _BeamCustomColors();

  @override
  _BeamCustomColors lerp(ThemeExtension<_BeamCustomColors>? other, double t) =>
      const _BeamCustomColors();
}

/// 便捷扩展：在 BuildContext 中快速访问 BeamTokens
extension BeamThemeExtension on BuildContext {
  _BeamCustomColors get beamColors => Theme.of(this).extension<_BeamCustomColors>()!;

  Color get bgMarketing => BeamTokens.bgMarketing;
  Color get bgPanel => BeamTokens.bgPanel;
  Color get bgSurface => BeamTokens.bgSurface;
  Color get bgSecondary => BeamTokens.bgSecondary;

  Color get textPrimary => BeamTokens.textPrimary;
  Color get textSecondary => BeamTokens.textSecondary;
  Color get textTertiary => BeamTokens.textTertiary;
  Color get textQuaternary => BeamTokens.textQuaternary;

  Color get brandIndigo => BeamTokens.brandIndigo;
  Color get brandViolet => BeamTokens.brandViolet;
  Color get brandVioletHover => BeamTokens.brandVioletHover;

  Color get successGreen => BeamTokens.successGreen;
  Color get successEmerald => BeamTokens.successEmerald;
  Color get warningAmber => BeamTokens.warningAmber;
  Color get errorRed => BeamTokens.errorRed;

  Color get borderSubtle => BeamTokens.borderSubtle;
  Color get borderStandard => BeamTokens.borderStandard;
  Color get borderSolid => BeamTokens.borderSolid;

  double get radiusMicro => BeamRadius.micro;
  double get radiusSmall => BeamRadius.small;
  double get radiusStandard => BeamRadius.standard;
  double get radiusCard => BeamRadius.card;
  double get radiusPanel => BeamRadius.panel;
  double get radiusLarge => BeamRadius.large;
  double get radiusPill => BeamRadius.pill;
  double get radiusCircle => BeamRadius.circle;

  List<BoxShadow> get elevationLevel1 => BeamElevation.level1;
  List<BoxShadow> get elevationLevel2 => BeamElevation.level2;
  List<BoxShadow> get elevationLevel4 => BeamElevation.level4;
  List<BoxShadow> get elevationLevel5 => BeamElevation.level5;
  List<BoxShadow> get elevationFocus => BeamElevation.focus;
}