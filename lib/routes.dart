import 'package:get/get.dart';
import 'package:zhige_flutter_tempate/pages/home.dart';
import 'package:zhige_flutter_tempate/pages/settings.dart';
import 'package:zhige_flutter_tempate/pages/todo_list.dart';
import 'package:zhige_flutter_tempate/pages/unknown.dart';

class AppRoutes {
  static const String home = '/';
  static const String todoList = '/todo-list';
  static const String settings = '/settings';
  
  static final List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: todoList,
      page: () => const TodoListPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: settings,
      page: () => const SettingsPage(),
      transition: Transition.rightToLeft,
    ),
  ];
  
  static final GetPage unknownRoute = GetPage(
    name: '/not-found',
    page: () => const UnknownPage(),
  );
} 