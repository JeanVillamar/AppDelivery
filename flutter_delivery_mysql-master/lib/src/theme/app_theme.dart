import 'package:flutter/material.dart';

/// Paleta de colores de la app. Los tonos de marca (primary, accent, estados)
/// son fijos; los tonos de superficie/texto cambian segun el modo claro/oscuro.
class _Palette {
  final Color ink;
  final Color muted;
  final Color background;
  final Color surface;
  final Color border;

  const _Palette({
    required this.ink,
    required this.muted,
    required this.background,
    required this.surface,
    required this.border,
  });
}

const _Palette _lightPalette = _Palette(
  ink: Color(0xFF17212B),
  muted: Color(0xFF687385),
  background: Color(0xFFF6F7F9),
  surface: Color(0xFFFFFFFF),
  border: Color(0xFFE5E8EE),
);

const _Palette _darkPalette = _Palette(
  ink: Color(0xFFECEFF4),
  muted: Color(0xFF9AA4B2),
  background: Color(0xFF12141A),
  surface: Color(0xFF1C1F27),
  border: Color(0xFF2A2F3A),
);

class AppColors {
  static bool _isDark = false;

  static void setDark(bool value) => _isDark = value;
  static bool get isDark => _isDark;

  static _Palette get _p => _isDark ? _darkPalette : _lightPalette;

  // Colores de marca (iguales en ambos modos)
  static const Color primary = Color(0xFFFF5A1F);
  static const Color primaryDark = Color(0xFFE94B12);
  static const Color accent = Color(0xFF0E9F6E);
  static const Color danger = Color(0xFFDE3B40);
  static const Color success = Color(0xFF12A875);
  static const Color warning = Color(0xFFFFB020);

  // Colores dependientes del modo
  static Color get ink => _p.ink;
  static Color get muted => _p.muted;
  static Color get background => _p.background;
  static Color get surface => _p.surface;
  static Color get border => _p.border;

  // Tonos fijos para cabeceras oscuras (perfil, etc.) en ambos modos
  static const Color headerDark = Color(0xFF17212B);
  static const Color headerDarkEnd = Color(0xFF263648);
}

class AppTheme {
  static ThemeData get light => _build(_lightPalette, Brightness.light);
  static ThemeData get dark => _build(_darkPalette, Brightness.dark);

  static ThemeData _build(_Palette p, Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: p.surface,
      error: AppColors.danger,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: p.background,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        foregroundColor: p.ink,
        elevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: p.ink),
        titleTextStyle: TextStyle(
          color: p.ink,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      cardTheme: CardThemeData(
        color: p.surface,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: p.border),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(48, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        hintStyle: TextStyle(color: p.muted),
        labelStyle: TextStyle(color: p.muted),
        prefixIconColor: p.muted,
        suffixIconColor: p.muted,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: p.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: p.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.6),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: p.ink,
        unselectedLabelColor: p.muted,
        indicatorColor: AppColors.primary,
        labelStyle:
            const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
      listTileTheme: ListTileThemeData(
        textColor: p.ink,
        iconColor: p.muted,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? Colors.white : p.muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : p.border,
        ),
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          color: p.ink,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          color: p.ink,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          color: p.ink,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
        bodyMedium: TextStyle(color: p.ink, letterSpacing: 0),
      ),
    );
  }
}
