import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * .03,
        horizontal: width * .03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
            },
            child: themeProvider.theme == ThemeMode.light
                ? getSelectedLanguageItem(textTheme: 'light')
                : getUnSelectedLanguageItem(textTheme: 'light'),
          ),
          SizedBox(height: height * .01),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: themeProvider.theme == ThemeMode.dark
                ? getSelectedLanguageItem(textTheme: 'dark')
                : getUnSelectedLanguageItem(textTheme: 'dark'),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String textTheme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(textTheme, style: AppStyles.bold20Primary).tr(),
        Icon(Icons.check, color: AppColors.primaryLight, size: 35),
      ],
    );
  }

  Widget getUnSelectedLanguageItem({required String textTheme}) {
    return Row(children: [Text(textTheme, style: AppStyles.bold20Black).tr()]);
  }
}
