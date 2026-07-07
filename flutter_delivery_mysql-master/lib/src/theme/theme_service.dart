import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:udemy_flutter_delivery/src/theme/app_theme.dart';

/// Gestiona el modo claro/oscuro y lo persiste en el dispositivo.
class ThemeService {
  static const String _key = 'is_dark_mode';

  static bool get isDark => GetStorage().read(_key) ?? false;

  static ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  /// Debe llamarse una vez al iniciar la app, despues de GetStorage.init().
  static void init() {
    AppColors.setDark(isDark);
  }

  static void setDark(bool dark) {
    GetStorage().write(_key, dark);
    AppColors.setDark(dark);
    Get.changeThemeMode(dark ? ThemeMode.dark : ThemeMode.light);
    Get.forceAppUpdate(); // reconstruye la app para aplicar AppColors
  }
}
