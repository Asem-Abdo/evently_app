import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomDateOrTime extends StatelessWidget {
  CustomDateOrTime({
    super.key,
    required this.iconDateOrTime,
    required this.textDateOrTime,
    required this.chooseDateOrTime,
    required this.onPressed,
  });

  Widget iconDateOrTime;
  String textDateOrTime;
  String chooseDateOrTime;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconDateOrTime,
        SizedBox(width: 6),
        Text(textDateOrTime, style: Theme.of(context).textTheme.titleLarge),
        Spacer(),
        TextButton(
          onPressed: onPressed,
          child: Text(
            chooseDateOrTime,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
