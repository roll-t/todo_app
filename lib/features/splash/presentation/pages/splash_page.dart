import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:todo_app/core/assets/app_image.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/features/splash/presentation/bloc/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().showSplash();

    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, TaskDetailScreen.todoList);
      }
    });

    return Scaffold(
      body: _buildBody(),
    );
  }

  // Body for the splash screen
  BlocBuilder<SplashCubit, bool> _buildBody() {
    return BlocBuilder<SplashCubit, bool>(
      builder: (context, isVisible) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.primaryColorLight,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: AnimatedOpacity(
                opacity:
                    isVisible ? 0.1 : 1,
                duration: const Duration(seconds: 2),
                child: const Image(image: Svg(AppImage.iLogo))),
          ),
        );
      },
    );
  }
}
