import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final String text;
  const ElevatedButtonWidget(
      {super.key,
      required this.text,
      this.onPressed,
      this.backgroundColor = AppColors.primaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          width: 70.w,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: TextWidget(
              text: text,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
            ),
          ),
        ));
  }
}
