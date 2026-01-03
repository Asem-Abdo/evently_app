import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/app_language_provider.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents(userProvider.currentUser!.id);
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('welcome back', style: AppStyles.regular14White).tr(),
                Text(
                  userProvider.currentUser!.name,
                  style: AppStyles.bold24White,
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
                var newTheme = themeProvider.theme == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
                themeProvider.changeTheme(newTheme);
              },
              child: ImageIcon(
                AssetImage(AppAssets.iconTheme),
                color: ThemeMode == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.goldColor,
              ),
            ),
            SizedBox(width: width * .01),
            Container(
              margin: EdgeInsets.only(left: width * .01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * .02,
                    vertical: height * .01,
                  ),

                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  languageProvider.changeLanguage(
                    context,
                    languageProvider.language == 'en' ? 'ar' : 'en',
                  );
                },
                child: Text('EN'.tr(), style: AppStyles.bold14Primary),
              ),
            ),
          ],
        ),
        bottom: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          toolbarHeight: height * .09,
          title: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.unSelectedMapIcon),
                  SizedBox(width: width * .01),
                  Text('location'.tr(), style: AppStyles.medium14White),
                ],
              ),
              SizedBox(height: 3),
              DefaultTabController(
                length: eventListProvider.eventsNameList.length,
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: AppColors.transparentColor,
                  dividerColor: AppColors.transparentColor,
                  labelPadding: EdgeInsets.zero,
                  tabAlignment: TabAlignment.start,

                  onTap: (index) {
                    eventListProvider.changeSelectedIndex(
                      index,
                      userProvider.currentUser!.id,
                    );
                  },
                  tabs: eventListProvider.eventsNameList.map((eventName) {
                    return Tab(
                      child: EventTabItem(
                        selectedBgColor: Theme.of(context).focusColor,
                        selectedTextStyle: Theme.of(
                          context,
                        ).textTheme.headlineMedium,
                        unSelectedTextStyle: AppStyles.medium16White,
                        isSelected:
                            eventListProvider.selectedIndex ==
                            eventListProvider.eventsNameList.indexOf(eventName),
                        eventName: eventName.tr(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: eventListProvider.specificEventList.isEmpty
                ? Center(
                    child: Text(
                      'No Events Yet'.tr(),
                      style: AppStyles.bold20Black,
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.only(top: height * .02),
                    itemBuilder: (context, index) {
                      return EventItem(
                        event: eventListProvider.specificEventList[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * .02),
                    itemCount: eventListProvider.specificEventList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
