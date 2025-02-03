import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_app/core/assets/app_image.dart';
import 'package:todo_app/core/themes/app_colors.dart';
import 'package:todo_app/core/ui/icons/leading_icon_app_bar.dart';
import 'package:todo_app/core/ui/widgets/buttons/elevated_button_widget.dart';
import 'package:todo_app/core/ui/widgets/texts/text_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 10.w,
              left: 5.w,
              child: LeadingIconAppBar(
                backgroundColor: AppColors.primaryColor.withOpacity(.1),
              )),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AppImage.iAvatarDefault),
                      fit: BoxFit.cover,
                    ),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackColor.withOpacity(.2),
                          blurRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(1000)),
              ),
              const SizedBox(
                height: 20,
              ),
              TextWidget(
                text: "Phuoc truong ",
                size: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 40.w,
                child: ElevatedButtonWidget(
                  text: "Logout",
                  onPressed: () {},
                  backgroundColor: AppColors.primaryColor,
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
