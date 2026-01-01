import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';

import '../model/event.dart';
import '../utils/firebase_utils.dart';

class EventListProvider extends ChangeNotifier {
  List<Event> eventsList = [];
  List<Event> specificEventList = [];
  List<Event> favoriteEventList = [];
  List<String> eventsNameList = [
    'All',
    'Sport',
    'BirthDay',
    'Meeting',
    'Gaming',
    'WorkShop',
    'Book Club',
    'Exhibition',
    'Holiday',
    'Eating',
  ];
  int selectedIndex = 0;

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection().get();

    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    specificEventList = eventsList;
    specificEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getSpecificEvent() async {
    var querySnapshot = await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    specificEventList = eventsList.where((event) {
      return event.eventName == eventsNameList[selectedIndex];
    }).toList();
    specificEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  void getSpecificEventFromFireStore() async {
    var querySnapshot = await FirebaseUtils.getEventCollection()
        .orderBy("dateTime")
        .where('eventName', isEqualTo: eventsNameList[selectedIndex])
        .get();
    specificEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void changeSelectedIndex(int newIndex) {
    selectedIndex = newIndex;
    selectedIndex == 0 ? getAllEvents() : getSpecificEvent();
  }

  void updateIsFavorite(Event event) {
    FirebaseUtils.getEventCollection()
        .doc(event.id)
        .update({'isFavorite': !event.isFavorite})
        .timeout(
          Duration(milliseconds: 500),
          onTimeout: () {
            ToastUtils.toastMsg(
              msg: 'event updated successfully'.tr(),
              backGroundColor: Colors.green,
              textColor: AppColors.whiteColor,
            );
          },
        );
    selectedIndex == 0 ? getAllEvents() : getSpecificEvent();
    getAllFavoriteEventsFromFirestore();
  }

  void getAllFavoriteEvents() async {
    var querySnapshot = await FirebaseUtils.getEventCollection().get();
    eventsList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    favoriteEventList = eventsList.where((event) {
      return event.isFavorite == true;
    }).toList();
    notifyListeners();
  }

  void getAllFavoriteEventsFromFirestore() async {
    var querySnapshot = await FirebaseUtils.getEventCollection()
        .orderBy("dateTime")
        .where("isFavorite", isEqualTo: true)
        .get();
    favoriteEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
  }
}
