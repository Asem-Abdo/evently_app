import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widget/event_item.dart';
import 'package:evently/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/event.dart';
import '../../../../utils/firebase_utils.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    if (eventListProvider.eventsList.isEmpty) {
      eventListProvider.getAllEvents();
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
                Text('Route academy', style: AppStyles.bold24White),
              ],
            ),
            Spacer(),
            ImageIcon(
              AssetImage(AppAssets.iconTheme),
              color: ThemeMode == ThemeMode.light
                  ? AppColors.whiteColor
                  : AppColors.goldColor,
            ),
            Container(
              margin: EdgeInsets.only(left: width * .02),
              padding: EdgeInsets.symmetric(
                horizontal: width * .02,
                vertical: height * .01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.whiteColor,
              ),
              child: Text('EN', style: AppStyles.bold14Primary),
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
                  Text('Location', style: AppStyles.medium14White),
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
                    eventListProvider.changeSelectedIndex(index);
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
