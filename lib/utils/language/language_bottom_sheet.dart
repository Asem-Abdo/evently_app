import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
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
              languageProvider.changeLanguage(context, 'en');
              Navigator.pop(context);
            },
            child: languageProvider.language == 'en'
                ? getSelectedLanguageItem(text: 'english')
                : getUnSelectedLanguageItem(text: 'english'),
          ),
          SizedBox(height: height * .01),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage(context, 'ar');
              Navigator.pop(context);
            },
            child: languageProvider.language == 'ar'
                ? getSelectedLanguageItem(text: 'arabic')
                : getUnSelectedLanguageItem(text: 'arabic'),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.bold20Primary).tr(),
        Icon(Icons.check, color: AppColors.primaryLight, size: 35),
      ],
    );
  }

  Widget getUnSelectedLanguageItem({required String text}) {
    return Row(children: [Text(text, style: AppStyles.bold20Black).tr()]);
  }
}
