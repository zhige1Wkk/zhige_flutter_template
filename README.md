# Zhige Flutter Template

[![GitHub stars](https://img.shields.io/github/stars/zhige1Wkk/zhige_flutter_template?style=flat&logo=github)](https://github.com/zhige1Wkk/zhige_flutter_template/stargazers)
[![Gitee stars](https://gitee.com/zhige1Wkk/zhige_flutter_template/badge/star.svg)](https://gitee.com/zhige1Wkk/zhige_flutter_template/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/zhige1Wkk/zhige_flutter_template?style=flat&logo=github)](https://github.com/zhige1Wkk/zhige_flutter_template/network/members)
[![GitHub issues](https://img.shields.io/github/issues/zhige1Wkk/zhige_flutter_template?style=flat&logo=github)](https://github.com/zhige1Wkk/zhige_flutter_template/issues)
[![GitHub license](https://img.shields.io/github/license/zhige1Wkk/zhige_flutter_template?style=flat&logo=github)](https://github.com/zhige1Wkk/zhige_flutter_template/blob/main/LICENSE)

Zhige Flutter Template 是一个高质量、易于使用的 Flutter 项目模板，旨在帮助开发者快速构建出色的跨平台应用程序。该模板采用了 Get 框架、优秀的设计模式和合理的文件结构，以确保开发者能够编写出易于维护的代码。此外，该模板还使用了 Isar 数据库，以提供卓越的性能和全平台支持。

![微信图片_20250503202453](https://github.com/user-attachments/assets/8287c077-bc1c-40f7-8886-7e9fd2d7603f)
![微信图片_20250503202442](https://github.com/user-attachments/assets/d4fd9cdb-99c7-4498-8ea3-f3f88010c2bb)
![微信图片_20250503202450](https://github.com/user-attachments/assets/6850eaca-8db7-42b4-8440-7926cccc8301)
![微信图片_20250503202445](https://github.com/user-attachments/assets/c7e31018-8446-4d2f-9762-40ee4d070e03)





## 同步托管
- GitHub: [https://github.com/zhige1Wkk/zhige_flutter_template](https://github.com/zhige1Wkk/zhige_flutter_template)
- Gitee: [https://gitee.com/zhige1Wkk/zhige_flutter_template](https://gitee.com/zhige1Wkk/zhige_flutter_template)

## 环境要求

- Flutter: 3.7.2 或更高版本
- Dart SDK: 3.1.0 或更高版本
- Android: SDK 21+ (Android 5.0 Lollipop 或更高版本)
- iOS: 12.0 或更高版本

## 重要插件版本

- **状态管理**: [Get](https://pub.dev/packages/get) ^4.6.6
- **数据库**: [Isar](https://pub.dev/packages/isar) ^3.1.0+1
- **网络请求**: [Dio](https://pub.dev/packages/dio) ^5.4.0
- **身份验证**: [flutter_web_auth_2](https://pub.dev/packages/flutter_web_auth_2) ^2.2.1
- **图片加载**: [extended_image](https://pub.dev/packages/extended_image) ^8.2.0
- **国际化**: [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html)
- **共享偏好设置**: [shared_preferences](https://pub.dev/packages/shared_preferences) ^2.2.2

## 特点

- 使用 [Get](https://pub.dev/packages/get) 框架进行状态管理、依赖注入和路由管理，简化了应用程序的开发和维护。
- 采用模块化的设计模式，使代码结构清晰、组织良好，便于扩展和维护。
- 使用 [Isar](https://pub.dev/packages/isar) 数据库，提供高性能、跨平台的数据存储和查询功能。
- 优化的文件结构，使开发者能够轻松找到和管理项目中的各个部分。
- `dio` 网络请求框架，轻松处理网络请求，支持拦截器，支持便捷的错误处理，请求重试，请求缓存等功能。
- oauth2 `flutter_web_auth_2` 登录框架，轻松实现 github 登录，支持多平台。
- 图片加载框架`extended_image`，支持加载网络图片，支持缓存图片，支持图片加载进度条，支持图片加载失败的占位图。
- 轻松替换 app 的 icon。
- 包含一些预构建的组件和页面，以帮助开发者快速开始构建应用程序。
- 开箱即用，开发者只需要关注业务即可。
- 多语言的支持。
- 主题设置的支持。
- 灵活扩展的设置页

## 项目结构

项目中，TodoList 应用程序的结构如下所示：

```shell
lib/
├── components/         # 可复用的UI组件
│   ├── add_todo_dialog.dart
│   ├── code_wrapper.dart
│   ├── latex.dart
│   ├── markdown.dart
│   └── todo_item.dart
├── controller/         # 控制器，负责业务逻辑和状态管理
│   ├── settings.dart
│   ├── todo.dart
│   └── user.dart
├── i18n/               # 国际化资源
│   └── translations.dart
├── main.dart           # 应用入口
├── models/             # 数据模型
│   ├── github_user.dart
│   └── todo.dart
├── pages/              # 页面
│   ├── home.dart
│   ├── settings.dart
│   ├── todo_list.dart
│   └── unknown.dart
├── repository/         # 数据仓库，处理数据持久化
│   ├── todo_repository.dart
│   └── user_repository.dart
├── routes.dart         # 路由配置
└── service/            # 服务，如网络请求
    └── http_service.dart
```

## 快速开始

要开始使用 Flutter Template，请按照以下步骤操作：

1. 确保您的开发环境已满足上述版本要求

2. 克隆此仓库：

```bash
# 从GitHub克隆
git clone https://github.com/zhige1Wkk/zhige_flutter_template.git

# 或从Gitee克隆
git clone https://gitee.com/zhige1Wkk/zhige_flutter_template.git
```

或直接点击本项目的 `Use this template` 按钮，直接通过这个模板创建一个自己的项目。

3. 进入项目目录：

```
cd zhige_flutter_template
```

4. 获取依赖项：

```
flutter pub get
```

5. 生成Isar数据库代码：

```
flutter pub run build_runner build --delete-conflicting-outputs
```

6. 运行项目：

```
flutter run
```

现在，你已经成功运行了 Flutter Template，并可以开始构建你的应用程序。

## 项目配置

修改项目名字，请到项目的根目录下执行，**请注意 flutter 项目命名规范**，因为会体现在包名中，所以尽量取类似这样的名字 `flutter_app`,`todo_list`,`flutter_template`

```shell
./rename_project.sh your_project_name
```

## 生成Isar数据库代码

如果修改了模型类，需要重新生成Isar辅助代码：

```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Isar数据库注意事项

在使用Isar时，请注意以下几点：

1. 模型类需要一个无参构造函数
2. 推荐使用工厂构造函数创建模型实例
3. 字段类型和构造函数参数类型需要匹配

例如：

```dart
@collection
class Todo {
  Id id = Isar.autoIncrement;
  late String title;
  
  Todo();
  
  factory Todo.create({required String title}) {
    return Todo()..title = title;
  }
}
```

## 贡献

我们欢迎任何形式的贡献！如果你有任何建议、问题或需求，请随时提交Issue或Pull Request。

## 许可证

本项目采用 MIT 许可证。
