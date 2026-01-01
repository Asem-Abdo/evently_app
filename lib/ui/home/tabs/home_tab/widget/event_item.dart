import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../model/event.dart';

class EventItem extends StatelessWidget {
  EventItem({super.key, required this.event});

  Event event;

  @override
  Widget build(BuildContext context) {
    var eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height * .31,
      margin: EdgeInsets.symmetric(horizontal: width * .04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryLight, width: 2),
        image: DecorationImage(
          image: AssetImage(event.image),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .02,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .001,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Column(
              children: [
                Text(
                  event.dateTime.day.toString(),
                  style: AppStyles.bold20Primary,
                ),
                Text(
                  DateFormat('MMM').format(event.dateTime),
                  style: AppStyles.bold14Primary,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .01,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: width * .02,
              vertical: height * .01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(event.title, style: AppStyles.bold14Black),
                ),
                InkWell(
                  onTap: () {
                    eventListProvider.updateIsFavorite(event);
                  },
                  child: event.isFavorite == true
                      ? ImageIcon(
                          AssetImage(AppAssets.selectedLikeIcon),
                          color: AppColors.primaryLight,
                        )
                      : ImageIcon(
                          AssetImage(AppAssets.unSelectedLikeIcon),
                          color: AppColors.primaryLight,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
