import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedBotton extends StatelessWidget {
  CustomElevatedBotton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backGroundColor = AppColors.primaryLight,
    this.textStyle,
    this.borderColor,
    this.icon = false,
    this.iconButton,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.padding,
  });
  final VoidCallback onPressed;
  final String text;
  Color? backGroundColor;
  TextStyle? textStyle;
  Color? borderColor;
  bool icon;
  Widget? iconButton;
  MainAxisAlignment mainAxisAlignment;
  EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: width * .04),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: width * .02,
            vertical: height * .015,
          ),
          elevation: 0,
          backgroundColor: backGroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: borderColor ?? AppColors.primaryLight),
          ),
        ),
        onPressed: onPressed,
        child: icon
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,

                  children: [
                    iconButton!,
                    SizedBox(width: 5),
                    Text(text, style: textStyle ?? AppStyles.medium20White),
                  ],
                ),
              )
            : Text(text, style: textStyle ?? AppStyles.medium20White),
      ),
    );
  }
}
