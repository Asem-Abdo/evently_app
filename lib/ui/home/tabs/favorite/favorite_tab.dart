import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_tab/widget/event_item.dart';

class FavoriteTab extends StatefulWidget {
  FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  TextEditingController searchController = TextEditingController();
  late EventListProvider eventListProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => eventListProvider.getAllFavoriteEventsFromFirestore(
        userProvider.currentUser!.id,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    userProvider = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (eventListProvider.favoriteEventList.isEmpty) {
      eventListProvider.getAllFavoriteEventsFromFirestore(
        userProvider.currentUser!.id,
      );
    }
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height * .02),
          CustomTextFormField(
            controller: searchController,
            hintStyle: AppStyles.bold14Primary,
            hintText: 'Search for Event'.tr(),
            colorBorderSide: AppColors.primaryLight,
            prefixIcon: Icon(Icons.search),
          ),
          SizedBox(height: height * .02),
          Expanded(
            child: eventListProvider.favoriteEventList.isEmpty
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
                        event: eventListProvider.favoriteEventList[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(height: height * .02),
                    itemCount: eventListProvider.favoriteEventList.length,
                  ),
          ),
        ],
      ),
    );
  }
}
