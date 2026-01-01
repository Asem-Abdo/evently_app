import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

typedef OnValidator = String? Function(String?)?;

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.colorBorderSide = ThemeMode == ThemeMode.light
        ? AppColors.greyColor
        : AppColors.primaryLight,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.showPassword = false,
    this.obscuringCharacter = '*',
    this.maxLines = 1,
  });
  final Color colorBorderSide;
  String? hintText;
  String? labelText;
  TextStyle? hintStyle;
  TextStyle? labelStyle;
  Widget? prefixIcon;
  Widget? suffixIcon;
  OnValidator validator;
  TextEditingController controller;
  TextInputType keyboardType;
  bool showPassword;
  String obscuringCharacter;
  int maxLines;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .04),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          enabledBorder: builtDecorationBorder(color: colorBorderSide),
          focusedBorder: builtDecorationBorder(color: colorBorderSide),
          errorBorder: builtDecorationBorder(color: AppColors.redColor),
          focusedErrorBorder: builtDecorationBorder(color: AppColors.redColor),
          errorStyle: AppStyles.medium16Primary.copyWith(
            color: AppColors.redColor,
          ),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleMedium,
          labelText: labelText,
          labelStyle: labelStyle ?? AppStyles.medium16Grey,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: showPassword,
        obscuringCharacter: obscuringCharacter,
      ),
    );
  }

  OutlineInputBorder builtDecorationBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color, width: 1),
    );
  }
}
