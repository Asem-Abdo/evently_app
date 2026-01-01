import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/home/add_event/add_event.dart';
import 'package:evently/ui/home/tabs/favorite/favorite_tab.dart';
import 'package:evently/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently/ui/home/tabs/map/map_tab.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<Widget> tabs = [HomeTab(), MapTab(), FavoriteTab(), ProfileTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          buildBottomNavigationBarItem(
            index: 0,
            selectedIcon: AppAssets.selectedHomeIcon,
            unSelectedIcon: AppAssets.unSelectedHomeIcon,
            label: 'home'.tr(),
          ),
          buildBottomNavigationBarItem(
            index: 1,
            selectedIcon: AppAssets.selectedMapIcon,
            unSelectedIcon: AppAssets.unSelectedMapIcon,
            label: 'map'.tr(),
          ),
          buildBottomNavigationBarItem(
            index: 2,
            selectedIcon: AppAssets.selectedLikeIcon,
            unSelectedIcon: AppAssets.unSelectedLikeIcon,
            label: 'favorite'.tr(),
          ),
          buildBottomNavigationBarItem(
            index: 3,
            selectedIcon: AppAssets.selectedProfileIcon,
            unSelectedIcon: AppAssets.unSelectedProfileIcon,
            label: 'profile'.tr(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEvent()),
          );
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: ThemeMode == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.goldColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[selectedIndex],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String selectedIcon,
    required String unSelectedIcon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(selectedIndex == index ? selectedIcon : unSelectedIcon),
        size: 30,
      ),
      label: label,
    );
  }
}
