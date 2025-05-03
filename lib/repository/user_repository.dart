import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhige_flutter_tempate/models/user.dart';
import 'package:zhige_flutter_tempate/service/http_service.dart';

class UserRepository {
  static const _userKey = 'user_data';
  final HttpService _httpService;

  UserRepository({HttpService? httpService})
      : _httpService = httpService ?? HttpService();

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userData);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    
    if (userData != null) {
      final userMap = jsonDecode(userData) as Map<String, dynamic>;
      return User.fromJson(userMap);
    }
    
    return null;
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  Future<User?> fetchUserByCredentials(String username, String password) async {
    // 此处应实现真正的身份验证逻辑
    // 示例实现，实际项目中应替换为真实API调用
    try {
      // 模拟API调用延迟
      await Future.delayed(Duration(seconds: 1));
      
      // 模拟用户数据 (在实际项目中，这将来自API响应)
      if (username.isNotEmpty && password.isNotEmpty) {
        final user = User(
          id: 1,
          username: username,
          name: '用户 $username',
          email: '$username@example.com',
        );
        
        await saveUser(user);
        return user;
      }
    } catch (e) {
      print('登录错误: $e');
    }
    
    return null;
  }
} 