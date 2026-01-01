import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventTabItem extends StatelessWidget {
  EventTabItem({
    super.key,
    required this.isSelected,
    required this.eventName,
    required this.selectedBgColor,
    this.unSelectedTextStyle,
    this.selectedTextStyle,

    this.borderColor,
  });
  bool isSelected;
  String eventName;
  Color? borderColor;
  Color selectedBgColor;
  TextStyle? selectedTextStyle;
  TextStyle? unSelectedTextStyle;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * .01),
      padding: EdgeInsets.symmetric(
        horizontal: width * .04,
        vertical: height * .006,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(46),
        border: Border.all(color: borderColor ?? Theme.of(context).focusColor),
        color: isSelected ? selectedBgColor : AppColors.transparentColor,
      ),

      child: Text(
        eventName.tr(),
        // textAlign: TextAlign.center,
        style: isSelected ? selectedTextStyle : unSelectedTextStyle,
      ),
    );
  }
}
