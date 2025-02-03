import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/assets/app_image.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/icons/leading_icon_app_bar.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 10.w,
              left: 5.w,
              child: LeadingIconAppBar(
                backgroundColor: AppColors.primaryColor.withOpacity(.2),
              )),
          Column(
            children: [
              Column(
                children: [
                  const TextWidget(text: "Theme Mode"),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(AppImage.iSun)),
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(1000)),
                        width: 50,
                        height: 50,
                      )
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
