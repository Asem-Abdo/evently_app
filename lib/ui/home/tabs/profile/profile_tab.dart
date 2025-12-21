import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/ui/home/tabs/profile/language/language_bottom_sheet.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => LanguageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryLight),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Language', style: Theme.of(context).textTheme.headlineLarge),
            Container(
              margin: EdgeInsets.symmetric(vertical: height * .02),
              padding: EdgeInsets.symmetric(
                horizontal: width * .01,
                vertical: height * .01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryLight, width: 2),
              ),
              child: InkWell(
                onTap: showLanguageBottomSheet,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      languageProvider.language == 'en' ? 'english' : 'arabic',
                      style: AppStyles.bold20Primary,
                    ).tr(),
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 35,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
