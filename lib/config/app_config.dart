import 'package:flutter/foundation.dart';
import 'package:zhige_flutter_tempate/service/http_service.dart';

/// 应用程序配置类
/// 用于管理全局配置参数
class AppConfig {
  /// 生产环境API地址
  static const String prodApiBaseUrl = 'https://api.example.com';
  
  /// 测试环境API地址
  static const String testApiBaseUrl = 'https://test-api.example.com';
  
  /// 开发环境API地址
  static const String devApiBaseUrl = 'http://localhost:8080';
  
  /// 当前环境
  static const Environment currentEnvironment = Environment.development;
  
  /// 初始化应用程序配置
  static void init() {
    // 根据当前环境设置API基础URL
    switch (currentEnvironment) {
      case Environment.production:
        HttpService.updateBaseUrl(prodApiBaseUrl);
        break;
      case Environment.testing:
        HttpService.updateBaseUrl(testApiBaseUrl);
        break;
      case Environment.development:
        HttpService.updateBaseUrl(devApiBaseUrl);
        break;
    }
    
    // 其他全局配置初始化
    if (kDebugMode) {
      print('App配置初始化完成，当前环境: ${currentEnvironment.name}');
      print('API基础URL: ${HttpService.getBaseUrl()}');
    }
  }
  
  /// 获取当前环境名称
  static String get environmentName => currentEnvironment.name;
  
  /// 判断是否为生产环境
  static bool get isProduction => currentEnvironment == Environment.production;
  
  /// 判断是否为开发环境
  static bool get isDevelopment => currentEnvironment == Environment.development;
  
  /// 判断是否为测试环境
  static bool get isTesting => currentEnvironment == Environment.testing;
}

/// 环境枚举
enum Environment {
  /// 开发环境
  development,
  
  /// 测试环境
  testing,
  
  /// 生产环境
  production,
} 