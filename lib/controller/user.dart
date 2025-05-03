import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhige_flutter_tempate/models/user.dart';
import 'package:zhige_flutter_tempate/repository/user_repository.dart';
import 'package:zhige_flutter_tempate/service/http_service.dart';

class UserController extends GetxController {
  final UserRepository _repository;
  final HttpService _httpService = HttpService();
  
  // 响应式变量
  final user = Rxn<User>();
  final isLoading = false.obs;
  
  UserController({UserRepository? repository})
      : _repository = repository ?? UserRepository();
  
  @override
  void onInit() {
    super.onInit();
    loadUser();
  }
  
  Future<void> loadUser() async {
    isLoading.value = true;
    try {
      final savedUser = await _repository.getUser();
      user.value = savedUser;
    } catch (e) {
      print('加载用户数据出错: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // 可以在这里添加自定义登录逻辑
  Future<void> login(String username, String password) async {
    isLoading.value = true;
    try {
      // 使用仓库层的登录方法
      final userInfo = await _repository.fetchUserByCredentials(username, password);
      
      if (userInfo != null) {
        user.value = userInfo;
        
        // 存储用户信息或令牌
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', 'example_token'); // 使用实际生成的令牌
      }
    } catch (e) {
      print('登录出错: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> logout() async {
    try {
      await _repository.clearUser();
      user.value = null;
      
      // 清除令牌
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');
    } catch (e) {
      print('登出出错: $e');
    }
  }
  
  bool get isLoggedIn => user.value != null;
} 