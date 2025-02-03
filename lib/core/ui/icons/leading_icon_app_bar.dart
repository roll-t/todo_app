import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/themes/app_colors.dart';

class LeadingIconAppBar extends StatelessWidget {
  final Color? backgroundColor;
  const LeadingIconAppBar({super.key, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10000)),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 17.sp,
          weight: 700,
          color: AppColors.primaryColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
