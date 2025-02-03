import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:todo_app/core/assets/app_image.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/presentation/home/pages/home_page.dart';
import 'package:todo_app/presentation/splash/bloc/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    onInit();
    super.initState();
  }

  void onInit() {
    context.read<SplashCubit>().showSplash();
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // Body for the splash screen
  Widget _buildBody() {
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
              opacity: isVisible ? 0.1 : 1,
              duration: const Duration(seconds: 2),
              child: const Image(
                image: Svg(
                  AppImage.iLogo,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
