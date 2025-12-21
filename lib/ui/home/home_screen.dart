import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/home/tabs/profile/profile_tab.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProfileTab());
  }
}
