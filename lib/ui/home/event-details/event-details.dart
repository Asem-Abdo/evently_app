import 'package:easy_localization/easy_localization.dart';
import 'package:evently/model/event.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_styles.dart';

class EventDetails extends StatelessWidget {
  EventDetails({super.key, required this.event});
  Event event;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text("event details".tr(), style: AppStyles.medium24Primary),
        centerTitle: true,
        actions: [
          InkWell(onTap: () {}, child: Image.asset(AppAssets.edit_icon)),
          SizedBox(width: width * .03),
          InkWell(onTap: () {}, child: Image.asset(AppAssets.delete_icon)),
          SizedBox(width: width * .02),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(event.image),
              ),
              SizedBox(height: height * .02),
              SizedBox(
                width: double.infinity,
                child: Text(
                  event.title,
                  style: AppStyles.medium24Primary,
                  textAlign: TextAlign.center,
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * .01,
                  horizontal: width * .02,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: Row(
                  children: [
                    Image.asset(AppAssets.clender_icon),
                    SizedBox(width: width * .02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(event.dateTime),
                          style: AppStyles.medium16Primary,
                        ),
                        Text(
                          DateFormat('hh:mm a').format(event.dateTime),
                          style: AppStyles.medium16Black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: height * .01,
                  horizontal: width * .02,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryLight, width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: height * .01,
                        horizontal: width * .02,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.primaryLight,
                      ),
                      child: Image.asset(AppAssets.location_icon),
                    ),
                    SizedBox(width: width * .02),
                    Text('Cairo , Egypt', style: AppStyles.medium16Primary),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.primaryLight,
                      size: 15,
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .02),
              Image.asset(AppAssets.location),
              SizedBox(height: height * .02),
              Text('description'.tr(), style: AppStyles.medium16Black),
              SizedBox(height: height * .01),
              Text(event.description, style: AppStyles.medium16Black),
            ],
          ),
        ),
      ),
    );
  }
}
