import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zhige_flutter_tempate/config/app_config.dart';
import 'package:zhige_flutter_tempate/controller/settings.dart';
import 'package:zhige_flutter_tempate/controller/user.dart';
import 'package:zhige_flutter_tempate/service/http_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsController settingsController = Get.find<SettingsController>();
  final UserController userController = Get.find<UserController>();
  final TextEditingController _apiUrlController = TextEditingController();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    _apiUrlController.text = HttpService.getBaseUrl();
  }

  @override
  void dispose() {
    _apiUrlController.dispose();
    super.dispose();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // 主题设置
          _buildSection(
            context,
            icon: Icons.palette_rounded,
            title: 'theme'.tr,
            children: [
              Obx(() => _buildThemeOption(ThemeMode.light)),
              Obx(() => _buildThemeOption(ThemeMode.dark)),
              Obx(() => _buildThemeOption(ThemeMode.system)),
            ],
          ),
          
          // 语言设置
          _buildSection(
            context,
            icon: Icons.language_rounded,
            title: 'language'.tr,
            children: [
              Obx(() => _buildLanguageOption('en', 'US', 'english'.tr)),
              Obx(() => _buildLanguageOption('zh', 'CN', 'chinese'.tr)),
            ],
          ),
          
          // 用户相关
          _buildSection(
            context,
            icon: Icons.person_rounded,
            title: 'profile'.tr,
            children: [
              Obx(() {
                return userController.isLoggedIn
                    ? _buildLogoutButton(context)
                    : _buildLoginButton(context);
              })
            ],
          ),
          
          // 关于
          _buildSection(
            context,
            icon: Icons.info_outline_rounded,
            title: 'about'.tr,
            children: [
              _buildInfoItem(
                context, 
                title: 'app_name'.tr, 
                value: _packageInfo.appName,
                icon: Icons.app_shortcut_rounded,
              ),
              _buildInfoItem(
                context, 
                title: 'version'.tr, 
                value: '${_packageInfo.version} (${_packageInfo.buildNumber})',
                icon: Icons.new_releases_rounded,
              ),
            ],
          ),
          
          // API设置卡片
          Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '后端接口设置',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '当前环境: ${AppConfig.environmentName}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _apiUrlController,
                    decoration: const InputDecoration(
                      labelText: 'API基础URL',
                      hintText: 'http://example.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // 重置为当前环境的默认URL
                          setState(() {
                            switch (AppConfig.currentEnvironment) {
                              case Environment.production:
                                _apiUrlController.text = AppConfig.prodApiBaseUrl;
                                break;
                              case Environment.testing:
                                _apiUrlController.text = AppConfig.testApiBaseUrl;
                                break;
                              case Environment.development:
                                _apiUrlController.text = AppConfig.devApiBaseUrl;
                                break;
                            }
                          });
                        },
                        child: const Text('重置'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          final newUrl = _apiUrlController.text.trim();
                          if (newUrl.isNotEmpty) {
                            HttpService.updateBaseUrl(newUrl);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('API基础URL已更新'),
                              ),
                            );
                          }
                        },
                        child: const Text('保存'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        ...children,
        Divider(
          height: 32,
          thickness: 1,
          indent: 24,
          endIndent: 24,
          color: theme.dividerColor.withOpacity(0.3),
        ),
      ],
    );
  }

  Widget _buildThemeOption(ThemeMode mode) {
    final theme = Theme.of(context);
    String title;
    IconData iconData;
    
    switch (mode) {
      case ThemeMode.light:
        title = 'light_theme'.tr;
        iconData = Icons.wb_sunny_rounded;
        break;
      case ThemeMode.dark:
        title = 'dark_theme'.tr;
        iconData = Icons.nights_stay_rounded;
        break;
      case ThemeMode.system:
        title = 'system_theme'.tr;
        iconData = Icons.brightness_auto_rounded;
        break;
    }

    final isSelected = settingsController.themeMode.value == mode;

    return _buildOptionTile(
      context: context,
      leading: Icon(
        iconData,
        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.7),
      ),
      title: title,
      isSelected: isSelected,
      onTap: () {
        settingsController.setThemeMode(mode);
      },
    );
  }

  Widget _buildLanguageOption(String languageCode, String countryCode, String title) {
    final theme = Theme.of(context);
    final currentLocale = settingsController.locale.value;
    final isSelected = currentLocale.languageCode == languageCode && 
                      (currentLocale.countryCode ?? '') == countryCode;
    
    IconData iconData = languageCode == 'en' ? Icons.flag_circle : Icons.language;

    return _buildOptionTile(
      context: context,
      leading: Icon(
        iconData,
        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.7),
      ),
      title: title,
      isSelected: isSelected,
      onTap: () {
        settingsController.setLocale(Locale(languageCode, countryCode));
      },
    );
  }

  Widget _buildOptionTile({
    required BuildContext context,
    required Widget leading,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: theme.colorScheme.primary.withOpacity(0.1),
        highlightColor: theme.colorScheme.primary.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 32, child: leading),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected 
                        ? theme.colorScheme.primary 
                        : theme.colorScheme.onBackground,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle_rounded,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          // 显示登录对话框
          _showLoginDialog(context);
        },
        splashColor: theme.colorScheme.primary.withOpacity(0.1),
        highlightColor: theme.colorScheme.primary.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.login_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                '登录'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 显示登录对话框
  void _showLoginDialog(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('登录'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: '用户名'.tr,
                hintText: '请输入用户名'.tr,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码'.tr,
                hintText: '请输入密码'.tr,
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('取消'.tr),
          ),
          ElevatedButton(
            onPressed: () async {
              if (usernameController.text.isNotEmpty && 
                  passwordController.text.isNotEmpty) {
                Navigator.pop(context);
                await userController.login(
                  usernameController.text, 
                  passwordController.text
                );
              }
            },
            child: Text('登录'.tr),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final theme = Theme.of(context);
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          await userController.logout();
        },
        splashColor: theme.colorScheme.error.withOpacity(0.1),
        highlightColor: theme.colorScheme.error.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              Icon(
                Icons.logout_rounded,
                color: theme.colorScheme.error,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                'logout'.tr,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: theme.colorScheme.primary.withOpacity(0.8),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 