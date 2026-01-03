import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/ui/auth/login/login_screen.dart';
import 'package:evently/ui/widgets/custom_elevated_botton.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/user_provider.dart';
import '../../../../utils/language/language_bottom_sheet.dart';
import '../../../../utils/theme/theme_bottom_sheet.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  void showThemeBottomSheet() {
    showModalBottomSheet(context: context, builder: (_) => ThemeBottomSheet());
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) => LanguageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryLight,
        toolbarHeight: height * .18,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
        ),
        title: Row(
          children: [
            Image.asset(AppAssets.routeImage),
            SizedBox(width: width * .03),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyles.bold24White,
                ),
                SizedBox(height: height * .001),
                Text(
                  userProvider.currentUser!.email,
                  style: AppStyles.medium16White,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * .04,
          vertical: height * .04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'language',
              style: Theme.of(context).textTheme.headlineLarge,
            ).tr(),
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
            SizedBox(height: height * .02),
            Text(
              'theme',
              style: Theme.of(context).textTheme.headlineLarge,
            ).tr(),
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
                onTap: showThemeBottomSheet,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      themeProvider.theme == ThemeMode.light ? 'light' : 'dark',
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
            Spacer(),
            CustomElevatedBotton(
              mainAxisAlignment: MainAxisAlignment.start,
              backGroundColor: AppColors.redColor,
              borderColor: AppColors.redColor,
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) {
                    return false;
                  },
                );
              },
              text: 'logout'.tr(),
              icon: true,
              iconButton: Icon(
                Icons.logout,
                color: AppColors.whiteColor,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                backgroundColor: AppColors.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.logout, color: AppColors.whiteColor, size: 30),
                  SizedBox(width: width * .02),
                  Text('logout', style: AppStyles.regular20White).tr(),
                ],
              ),
            ),
 */
