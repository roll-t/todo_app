import 'package:flutter/material.dart';
import 'package:todo_app/core/themes/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final IconData? subIcon;
  final Function(String)? onChanged;
  final TextEditingController? controller;

  const TextFieldWidget(
      {super.key,
      this.hintText,
      this.subIcon,
      this.onChanged,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 30,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(subIcon),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: AppColors.greyColor, fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black, width: .5)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.black, width: .5)),
      ),
    );
  }
}
