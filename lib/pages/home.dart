import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zhige_flutter_tempate/components/shimmer_effect.dart';
import 'package:zhige_flutter_tempate/controller/user.dart';
import 'package:zhige_flutter_tempate/pages/todo_list.dart';

/// 主页面控制器
class MainController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}

/// 首页容器
/// 管理底部导航栏和内容页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 初始化控制器
    final mainController = Get.put(MainController());
    final userController = Get.find<UserController>();

    return Scaffold(
      body: Obx(() => IndexedStack(
        index: mainController.currentIndex.value,
        children: const [
          // 首页内容
          HomeContent(),
          // 待办事项页面
          TodoListPage(),
          // 我的页面
          ProfilePage(),
        ],
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: mainController.currentIndex.value,
        onTap: (index) {
          // 无论用户是否登录，都直接切换到对应的页面
          // "我的"页面内部会根据登录状态显示不同的内容
          mainController.changePage(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'home'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.task_alt_rounded),
            label: 'todo_list'.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: '我的',
          ),
        ],
        selectedItemColor: const Color(0xFF0175C2),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      )),
    );
  }
}

/// 首页内容
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'app_name'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
      drawer: Drawer(
        elevation: 2.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // 用户信息头部，响应式更新
            Obx(() {
              return UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xFF0175C2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                // 用户名或登录提示
                accountName: Text(
                  userController.isLoggedIn
                      ? userController.user.value!.username
                      : 'not_logged_in'.tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                // 邮箱或登录提示
                accountEmail: Text(
                  userController.isLoggedIn
                      ? (userController.user.value!.email ?? '')
                      : 'login_to_continue'.tr,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                // 用户头像
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: userController.isLoggedIn
                      ? ClipOval(
                          child: userController.user.value!.avatarUrl != null
                            ? Image.network(
                                userController.user.value!.avatarUrl!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.person),
                              )
                            : const Icon(Icons.person)
                        )
                      : const Icon(
                          Icons.person,
                          color: Color(0xFF0175C2),
                          size: 50,
                        ),
                ),
              );
            }),
            // 导航菜单列表
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // 首页菜单项
                  _buildDrawerItem(
                    context,
                    icon: Icons.home_rounded,
                    title: 'home'.tr,
                    onTap: () {
                      Navigator.pop(context);
                      Get.find<MainController>().changePage(0);
                    },
                  ),
                  // 待办事项菜单项
                  _buildDrawerItem(
                    context,
                    icon: Icons.task_alt_rounded,
                    title: 'todo_list'.tr,
                    onTap: () {
                      Navigator.pop(context);
                      Get.find<MainController>().changePage(1);
                    },
                  ),
                  const Divider(),
                  // 设置菜单项
                  _buildDrawerItem(
                    context,
                    icon: Icons.settings_rounded,
                    title: 'settings'.tr,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed('/settings');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0175C2).withOpacity(0.05),
              theme.colorScheme.background,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0175C2),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0175C2).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/flutter_logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => 
                        const Icon(Icons.flutter_dash, size: 60, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 32),
                // 应用名称
                ShimmerText(
                  text: 'app_name'.tr,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0175C2),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                // 应用描述
                ShimmerText(
                  text: '一个高质量的Flutter项目模板',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0175C2),
                    letterSpacing: 0.3,
                  ),
                  period: const Duration(milliseconds: 2000),
                ),
                const SizedBox(height: 48),
                // 待办事项按钮
                _buildShimmerActionButton(
                  context,
                  icon: Icons.task_alt_rounded,
                  onPressed: () {
                    Get.find<MainController>().changePage(1);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建抽屉菜单项
  /// 
  /// [context] 上下文
  /// [icon] 图标
  /// [title] 标题
  /// [onTap] 点击回调
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF0175C2),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  /// 构建带扫光效果的操作按钮
  /// 
  /// [context] 上下文
  /// [icon] 按钮图标
  /// [onPressed] 点击回调
  Widget _buildShimmerActionButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 56,
      width: 56,
      child: ShimmerButton(
        onPressed: onPressed,
        baseColor: const Color(0xFF0175C2),
        highlightColor: Colors.white.withOpacity(0.8),
        period: const Duration(milliseconds: 3500),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
        ),
        child: Icon(icon, size: 28, color: Colors.white),
      ),
    );
  }
}

/// 个人中心页面
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.toNamed('/settings'),
          ),
        ],
      ),
      body: Obx(() {
        if (!userController.isLoggedIn) {
          // 未登录状态下的页面
          return _buildNotLoggedInView(context);
        }
        
        // 已登录状态下的页面
        return _buildLoggedInView(context, userController);
      }),
    );
  }
  
  /// 构建未登录状态的视图
  Widget _buildNotLoggedInView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.account_circle,
            size: 100,
            color: Color(0xFF0175C2),
          ),
          const SizedBox(height: 20),
          const Text(
            '未登录',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '请登录后查看个人信息',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              // 显示登录表单对话框
              showLoginDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0175C2),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '登录',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              // 显示注册表单对话框
              showRegisterDialog(context);
            },
            child: const Text(
              '注册账号',
              style: TextStyle(
                color: Color(0xFF0175C2),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// 显示登录对话框
  void showLoginDialog(BuildContext context) {
    final userController = Get.find<UserController>();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('用户登录'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '密码',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              // 这里应该调用真实的登录API
              // 为了演示，这里使用硬编码的模拟登录
              if (usernameController.text == 'admin' && 
                  passwordController.text == 'admin') {
                // 模拟成功登录
                userController.login(usernameController.text, passwordController.text);
                Navigator.pop(context);
                Get.snackbar('登录成功', '欢迎回来，${usernameController.text}！',
                  snackPosition: SnackPosition.BOTTOM);
              } else {
                // 模拟失败
                Get.snackbar('登录失败', '用户名或密码错误',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red[100],
                  colorText: Colors.red[900]);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0175C2),
            ),
            child: const Text('登录'),
          ),
        ],
      ),
    );
  }
  
  /// 显示注册对话框
  void showRegisterDialog(BuildContext context) {
    final usernameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('注册账号'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: '邮箱',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '密码',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: '确认密码',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              // 验证两次密码是否一致
              if (passwordController.text != confirmPasswordController.text) {
                Get.snackbar('注册失败', '两次输入的密码不一致',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red[100],
                  colorText: Colors.red[900]);
                return;
              }
              
              // 这里应该调用真实的注册API
              // 为了演示，这里只显示成功消息
              Navigator.pop(context);
              Get.snackbar('注册成功', '请使用新账号登录',
                snackPosition: SnackPosition.BOTTOM);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0175C2),
            ),
            child: const Text('注册'),
          ),
        ],
      ),
    );
  }
  
  /// 构建已登录状态的视图
  Widget _buildLoggedInView(BuildContext context, UserController userController) {
    final user = userController.user.value!;
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息卡片
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF0175C2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // 用户头像
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: user.avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          user.avatarUrl!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Text(
                                user.username.substring(0, 1).toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Color(0xFF0175C2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        ),
                      )
                    : Text(
                        user.username.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Color(0xFF0175C2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
                const SizedBox(height: 16),
                // 用户名
                Text(
                  user.username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                // 用户邮箱
                if (user.email != null && user.email!.isNotEmpty)
                  Text(
                    user.email!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
              ],
            ),
          ),
          
          // 功能列表
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              '个人中心',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          
          // 个人信息
          _buildMenuTile(
            icon: Icons.person_outline,
            title: '个人资料',
            onTap: () => Get.toNamed('/profile/edit'),
          ),
          
          // 我的收藏
          _buildMenuTile(
            icon: Icons.favorite_border,
            title: '我的收藏',
            onTap: () => Get.toNamed('/favorites'),
          ),
          
          // 系统设置
          _buildMenuTile(
            icon: Icons.settings_outlined,
            title: '系统设置',
            onTap: () => Get.toNamed('/settings'),
          ),
          
          // 帮助与反馈
          _buildMenuTile(
            icon: Icons.help_outline,
            title: '帮助与反馈',
            onTap: () => Get.toNamed('/help'),
          ),
          
          // 关于我们
          _buildMenuTile(
            icon: Icons.info_outline,
            title: '关于我们',
            onTap: () => Get.toNamed('/about'),
          ),
          
          const SizedBox(height: 20),
          
          // 退出登录按钮
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('logout_confirm_title'.tr),
                      content: Text('logout_confirm_message'.tr),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('cancel'.tr),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            userController.logout();
                            Get.snackbar(
                              'logout_success_title'.tr,
                              'logout_success_message'.tr,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          child: Text(
                            'confirm'.tr,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'logout'.tr,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 30),
        ],
      ),
    );
  }
  
  /// 构建菜单项
  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF0175C2),
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}