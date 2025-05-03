import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          // 通用
          'app_name': 'Flutter Template',
          'ok': 'OK',
          'cancel': 'Cancel',
          'save': 'Save',
          'delete': 'Delete',
          'edit': 'Edit',
          'loading': 'Loading...',
          'error': 'Error',
          'success': 'Success',
          'retry': 'Retry',
          
          // 导航
          'home': 'Home',
          'settings': 'Settings',
          'profile': 'Profile',
          
          // Todo 页面
          'todo_list': 'Todo List',
          'add_todo': 'Add Todo',
          'edit_todo': 'Edit Todo',
          'delete_todo_confirmation': 'Are you sure you want to delete this task?',
          'delete_todo_success': 'Task deleted successfully',
          'todo_title': 'Title',
          'todo_description': 'Description',
          'todo_completed': 'Completed',
          'no_todos': 'No tasks yet. Add your first task!',
          'please_enter_title': 'Please enter a title',
          
          // 设置页面
          'theme': 'Theme',
          'light_theme': 'Light',
          'dark_theme': 'Dark',
          'system_theme': 'System',
          'language': 'Language',
          'english': 'English',
          'chinese': 'Chinese',
          'about': 'About',
          'version': 'Version',
          'logout': 'Logout',
          'login': 'Login',
          'github_login': 'Login with GitHub',
          
          // 用户页面
          'not_logged_in': 'Not logged in',
          'login_to_continue': 'Please login to continue',
        },
        
        'zh_CN': {
          // 通用
          'app_name': 'Flutter模板',
          'ok': '确定',
          'cancel': '取消',
          'save': '保存',
          'delete': '删除',
          'edit': '编辑',
          'loading': '加载中...',
          'error': '错误',
          'success': '成功',
          'retry': '重试',
          
          // 导航
          'home': '首页',
          'settings': '设置',
          'profile': '个人资料',
          
          // Todo 页面
          'todo_list': '任务列表',
          'add_todo': '添加任务',
          'edit_todo': '编辑任务',
          'delete_todo_confirmation': '确定要删除这个任务吗？',
          'delete_todo_success': '任务删除成功',
          'todo_title': '标题',
          'todo_description': '描述',
          'todo_completed': '已完成',
          'no_todos': '暂无任务，添加你的第一个任务吧！',
          'please_enter_title': '请输入任务标题',
          
          // 设置页面
          'theme': '主题',
          'light_theme': '浅色',
          'dark_theme': '深色',
          'system_theme': '跟随系统',
          'language': '语言',
          'english': '英文',
          'chinese': '中文',
          'about': '关于',
          'version': '版本',
          'logout': '退出登录',
          'login': '登录',
          'github_login': '使用GitHub登录',
          
          // 用户页面
          'not_logged_in': '未登录',
          'login_to_continue': '请登录后继续',
        },
      };
} 