import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  const ElevatedButtonWidget({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          width: 70.w,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: const Center(
            child: TextWidget(
              text: "Add New Task",
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
            ),
          ),
        ));
  }
}
