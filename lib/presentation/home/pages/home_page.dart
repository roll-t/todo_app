import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/routes/task_detail_screen.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';

class HomePage extends StatelessWidget {
  static String routeName = TaskDetailScreen.home;
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  // method builder body for home page
  Widget _buildBody(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primaryColor,
            AppColors.whiteColor,
            AppColors.whiteColor,
            AppColors.whiteColor
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 10.h,
            child: _buildTitle(),
          ),
          Center(child: _buildMenuItems(context)),
        ],
      ),
    );
  }

  // Method build title for home page
  Widget _buildTitle() {
    return TextWidget(
      text: "Home",
      fontWeight: FontWeight.bold,
      size: 30.sp,
      textAlign: TextAlign.center,
    );
  }

  // Method build menu items for home page
  Widget _buildMenuItems(BuildContext context) {
    return Wrap(
      spacing: 5.w,
      runSpacing: 5.w,
      children: [
        _buildMenuItem(
          context,
          onTap: () {
            Navigator.pushNamed(context, TaskDetailScreen.todoList);
          },
          title: "Todo List",
        ),
        _buildMenuItem(
          context,
          onTap: () {
            Navigator.pushNamed(context, TaskDetailScreen.category);
          },
          title: "Category",
        ),
        _buildMenuItem(
          context,
          onTap: () {
            Navigator.pushNamed(context, TaskDetailScreen.setting);
          },
          title: "Setting",
        ),
        _buildMenuItem(
          context,
          onTap: () {
            Navigator.pushNamed(context, TaskDetailScreen.profile);
          },
          title: "Profile",
        ),
      ],
    );
  }

  // Phương thức xây dựng một menu item
  Widget _buildMenuItem(BuildContext context,
      {required Function() onTap, required String title}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withOpacity(.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: TextWidget(text: title),
        ),
      ),
    );
  }
}
