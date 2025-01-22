import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/routes/app_routes.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/features/splash/presentation/bloc/splash_cubit.dart';
import 'package:todo_app/features/splash/presentation/pages/splash_page.dart';
import 'package:todo_app/features/theme_mode/presentation/bloc/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit(), lazy: true),
          BlocProvider(create: (_) => SplashCubit(), lazy: false),
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
