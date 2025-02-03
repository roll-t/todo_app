import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/injections.dart';
import 'package:todo_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:todo_app/presentation/theme_mode/bloc/theme_cubit.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_bloc.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_event.dart';

class Providers {
  static List<BlocProvider> getProviders() {
    return [
      BlocProvider(create: (_) => ThemeCubit(), lazy: false),
      BlocProvider(create: (_) => SplashCubit(), lazy: false),
      BlocProvider(
        create: (_) => sl<TodoBloc>()..add(InitializeTodoEvent()),
        lazy: false,
      ),
    ];
  }
}
