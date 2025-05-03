import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:zhige_flutter_tempate/config/app_config.dart';
import 'package:zhige_flutter_tempate/controller/settings.dart';
import 'package:zhige_flutter_tempate/controller/todo.dart';
import 'package:zhige_flutter_tempate/controller/user.dart';
import 'package:zhige_flutter_tempate/i18n/translations.dart';
import 'package:zhige_flutter_tempate/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化应用配置
  AppConfig.init();
  
  // 初始化控制器
  await _initServices();
  
  runApp(const MyApp());
}

Future<void> _initServices() async {
  // 注册控制器，确保Get可以找到它们
  Get.put(SettingsController());
  Get.put(UserController());
  Get.put(TodoController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    
    return Obx(() {
      return GetMaterialApp(
        title: 'Flutter Template',
        debugShowCheckedModeBanner: false,
        
        // 主题设置
        theme: settingsController.theme,
        themeMode: settingsController.themeMode.value,
        
        // 国际化设置
        translations: AppTranslations(),
        locale: settingsController.locale.value,
        fallbackLocale: const Locale('zh', 'CN'),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('zh', 'CN'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        
        // 路由设置
        initialRoute: AppRoutes.home,
        getPages: AppRoutes.routes,
        unknownRoute: AppRoutes.unknownRoute,
        
        defaultTransition: Transition.fade,
      );
    });
  }
}
