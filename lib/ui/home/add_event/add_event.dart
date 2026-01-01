import 'package:easy_localization/easy_localization.dart';
import 'package:evently/model/event.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently/ui/widgets/custom_date_or_time.dart';
import 'package:evently/ui/widgets/custom_elevated_botton.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:evently/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_form_field.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  int selectedIndex = 0;
  List<String> eventsNameList = [
    'Sport'.tr(),
    'BirthDay'.tr(),
    'Meeting'.tr(),
    'Gaming'.tr(),
    'WorkShop'.tr(),
    'Book Club'.tr(),
    'Exhibition'.tr(),
    'Holiday'.tr(),
    'Eating'.tr(),
  ];
  Map<String, String> eventsImagesMap = {
    'Sport'.tr(): AppAssets.sport,
    'BirthDay'.tr(): AppAssets.birthday,
    'Meeting'.tr(): AppAssets.meeting,
    'Gaming'.tr(): AppAssets.gaming,
    'WorkShop'.tr(): AppAssets.workshop,
    'Book Club'.tr(): AppAssets.bookClub,
    'Exhibition'.tr(): AppAssets.exhibition,
    'Holiday'.tr(): AppAssets.holiday,
    'Eating'.tr(): AppAssets.eating,
  };

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  String? formatDate;
  TimeOfDay? selectedTime;
  String? formatTime;
  String selectedImage = '';
  String selectedEventName = '';
  final GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  late EventListProvider eventListProvider;

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<EventListProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    selectedImage = eventsImagesMap.values.elementAt(selectedIndex);
    selectedEventName = eventsNameList[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: Text('create event'.tr(), style: AppStyles.medium24Primary),
        iconTheme: IconThemeData(color: AppColors.primaryLight),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SingleChildScrollView(
          child: Form(
            key: formKeys,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    eventsImagesMap.values.elementAt(selectedIndex),
                  ),
                ),
                SizedBox(height: height * .02),
                SizedBox(
                  height: height * .04,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          selectedIndex = index;
                          setState(() {});
                        },
                        child: EventTabItem(
                          borderColor: AppColors.primaryLight,
                          selectedBgColor: AppColors.primaryLight,
                          selectedTextStyle: Theme.of(
                            context,
                          ).textTheme.headlineSmall,
                          unSelectedTextStyle: Theme.of(
                            context,
                          ).textTheme.headlineMedium,
                          isSelected: selectedIndex == index ? true : false,
                          eventName: eventsNameList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * .02);
                    },
                    itemCount: eventsNameList.length,
                  ),
                ),
                SizedBox(height: height * .02),
                Text(
                  'title'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: height * .01),
                CustomTextFormField(
                  controller: titleController,
                  prefixIcon: Image.asset(
                    AppAssets.title_icon,
                    color: ThemeData == ThemeMode.light
                        ? AppColors.greyColor
                        : AppColors.whiteColor,
                  ),
                  hintText: 'event title'.tr(),
                ),
                SizedBox(height: height * .01),
                Text(
                  'description'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: height * .01),
                CustomTextFormField(
                  controller: descriptionController,
                  hintText: 'event description'.tr(),
                  maxLines: 4,
                ),
                SizedBox(height: height * .01),
                CustomDateOrTime(
                  iconDateOrTime: Icon(Icons.date_range_outlined),
                  textDateOrTime: 'event date'.tr(),
                  chooseDateOrTime: formatDate ?? 'choose date'.tr(),

                  onPressed: chooseDate,
                ),

                CustomDateOrTime(
                  iconDateOrTime: Icon(Icons.access_time),
                  textDateOrTime: 'event time'.tr(),
                  chooseDateOrTime: formatTime ?? 'choose time'.tr(),

                  onPressed: chooseTime,
                ),
                SizedBox(height: height * .01),
                Text(
                  'location'.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: height * .01),
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
                      Text(
                        'choose event location'.tr(),
                        style: AppStyles.medium16Primary,
                      ),
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
                CustomElevatedBotton(
                  padding: EdgeInsets.zero,
                  backGroundColor: AppColors.primaryLight,
                  onPressed: addEvent,
                  text: 'add event'.tr(),
                  textStyle: AppStyles.medium20White,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    selectedDate = chooseDate;
    setState(() {});
    formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    selectedTime = chooseTime;
    setState(() {});
    if (selectedTime != null) {
      if (!mounted) return;
      formatTime = selectedTime!.format(context);
    }
  }

  void addEvent() {
    if (formKeys.currentState?.validate() == true) {
      Event event = Event(
        image: selectedImage,
        title: titleController.text,
        description: descriptionController.text,
        eventName: selectedEventName,
        dateTime: selectedDate!,
        time: formatTime!,
      );

      FirebaseUtils.addEventToFireStore(event);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('event added successfully'.tr())));
      eventListProvider.getAllEvents();
      Navigator.pop(context);
    }
  }
}
