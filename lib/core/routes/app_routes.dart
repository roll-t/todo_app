import 'package:flutter/material.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/features/home/add_todo/presentation/page/add_todo_page.dart';
import 'package:todo_app/features/home/todo_list/presentation/pages/todo_list_page.dart';
import 'package:todo_app/features/splash/presentation/pages/splash_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TaskDetailScreen.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case TaskDetailScreen.todoList:
        return MaterialPageRoute(builder: (_) => const TodoListPage());
      case TaskDetailScreen.addNew:
        return MaterialPageRoute(builder: (_) => const AddTodoPage());
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
