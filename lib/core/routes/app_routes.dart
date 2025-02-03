import 'package:flutter/material.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/presentation/category/pages/category_page.dart';
import 'package:todo_app/presentation/home/pages/home_page.dart';
import 'package:todo_app/presentation/profile/pages/profile_page.dart';
import 'package:todo_app/presentation/settings/pages/setting_page.dart';
import 'package:todo_app/presentation/splash/pages/splash_page.dart';
import 'package:todo_app/presentation/todo/pages/add_todo_page.dart';
import 'package:todo_app/presentation/todo/pages/todo_list_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TaskDetailScreen.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case TaskDetailScreen.todoList:
        return MaterialPageRoute(builder: (_) => const TodoListPage());
      case TaskDetailScreen.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case TaskDetailScreen.category:
        return MaterialPageRoute(builder: (_) => const CategoryPage());
      case TaskDetailScreen.setting:
        return MaterialPageRoute(builder: (_) => const SettingPage());
      case TaskDetailScreen.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case TaskDetailScreen.addNew:
        final value = settings.arguments as AddTodoArg;
        return MaterialPageRoute(
          builder: (_) => AddTodoPage(
            addTodoArg: value,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      ),
    );
  }
}
