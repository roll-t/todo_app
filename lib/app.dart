import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/routes/app_routes.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/injections.dart';
import 'package:todo_app/presentation/splash/bloc/splash_cubit.dart';
import 'package:todo_app/presentation/splash/pages/splash_page.dart';
import 'package:todo_app/presentation/theme_mode/bloc/theme_cubit.dart';
import 'package:todo_app/presentation/todo/bloc/add_todo/add_todo_bloc.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_bloc.dart';
import 'package:todo_app/presentation/todo/bloc/todo_list/todo_event.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit(), lazy: false),
          BlocProvider(create: (_) => SplashCubit(), lazy: false),
          BlocProvider(
            create: (_) => sl<TodoBloc>()..add(InitializeTodoEvent()),
            lazy: false,
          ),
          BlocProvider(
            create: (_) => sl<AddTodoBloc>(),
            lazy: false,
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, mode) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: const SplashPage(),
                  themeMode: mode,
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  initialRoute: TaskDetailScreen.splash,
                  onGenerateRoute: AppRouter.generateRoute,
                )),
      );
    });
  }
}
