import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  static const String themeModeKey = 'theme_mode';
  static const String localeKey = 'locale';
  
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;
  final Rx<Locale> locale = const Locale('zh', 'CN').obs;
  
  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }
  
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    // 加载主题设置
    final themeModeIndex = prefs.getInt(themeModeKey);
    if (themeModeIndex != null) {
      themeMode.value = ThemeMode.values[themeModeIndex];
    }
    
    // 加载语言设置
    final languageCode = prefs.getString('${localeKey}_languageCode');
    final countryCode = prefs.getString('${localeKey}_countryCode');
    
    if (languageCode != null) {
      locale.value = Locale(languageCode, countryCode);
    }
  }
  
  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModeKey, mode.index);
  }
  
  Future<void> setLocale(Locale newLocale) async {
    locale.value = newLocale;
    Get.updateLocale(newLocale);
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${localeKey}_languageCode', newLocale.languageCode);
    if (newLocale.countryCode != null) {
      await prefs.setString('${localeKey}_countryCode', newLocale.countryCode!);
    }
  }
  
  bool get isDarkMode {
    if (themeMode.value == ThemeMode.system) {
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
    return themeMode.value == ThemeMode.dark;
  }
  
  // 获取当前的主题
  ThemeData get theme => isDarkMode ? _darkTheme : _lightTheme;
  
  // 亮色主题
  static final _lightTheme = ThemeData(
    primaryColor: const Color(0xFF0175C2),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0175C2),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0175C2),
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );
  
  // 暗色主题
  static final _darkTheme = ThemeData(
    primaryColor: const Color(0xFF0175C2),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0175C2),
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF0175C2),
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.dark,
  );
} 