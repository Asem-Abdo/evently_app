import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  /// todo : data
  String language = 'en';

  ///todo : change language
  void changeLanguage(BuildContext context, String newLanguage) {
    if (language == newLanguage) {
      return;
    }
    language = newLanguage;
    if (language == 'en') {
      EasyLocalization.of(context)!.setLocale(Locale('en'));
    } else {
      EasyLocalization.of(context)!.setLocale(Locale('ar'));
    }
    notifyListeners();
  }
}
