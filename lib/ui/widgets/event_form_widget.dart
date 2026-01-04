import 'package:easy_localization/easy_localization.dart';
import 'package:evently/model/event.dart';
import 'package:evently/ui/home/tabs/home_tab/widget/event_tab_item.dart';
import 'package:evently/ui/widgets/custom_date_or_time.dart';
import 'package:evently/ui/widgets/custom_elevated_botton.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class EventFormWidget extends StatefulWidget {
  final Event? initialEvent;
  final void Function(Event event) onSubmit;
  final String submitText;

  const EventFormWidget({
    super.key,
    this.initialEvent,
    required this.onSubmit,
    required this.submitText,
  });

  @override
  State<EventFormWidget> createState() => _EventFormWidgetState();
}

class _EventFormWidgetState extends State<EventFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;

  DateTime? selectedDate;
  String? formatDate;
  String? formatTime;

  int selectedIndex = 0;

  final List<String> eventsNameList = [
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

  final Map<String, String> eventsImagesMap = {
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

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(
      text: widget.initialEvent?.title ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.initialEvent?.description ?? '',
    );

    if (widget.initialEvent != null) {
      selectedDate = widget.initialEvent!.dateTime;
      formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      formatTime = widget.initialEvent!.time;

      selectedIndex = eventsNameList.indexOf(widget.initialEvent!.eventName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final selectedEventName = eventsNameList[selectedIndex];
    final selectedImage = eventsImagesMap[selectedEventName]!;

    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(selectedImage),
              ),
              SizedBox(height: height * .02),

              /// Event Type Tabs
              SizedBox(
                height: height * .04,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsNameList.length,
                  separatorBuilder: (_, __) => SizedBox(width: width * .02),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() => selectedIndex = index);
                      },
                      child: EventTabItem(
                        eventName: eventsNameList[index],
                        isSelected: selectedIndex == index,
                        borderColor: AppColors.primaryLight,
                        selectedBgColor: AppColors.primaryLight,
                        selectedTextStyle: Theme.of(
                          context,
                        ).textTheme.headlineSmall,
                        unSelectedTextStyle: Theme.of(
                          context,
                        ).textTheme.headlineMedium,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: height * .02),

              /// Title
              Text('title'.tr(), style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: height * .01),
              CustomTextFormField(
                controller: titleController,
                hintText: 'event title'.tr(),
                prefixIcon: Image.asset(AppAssets.title_icon),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter event title'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: height * .02),

              /// Description
              Text(
                'description'.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: height * .01),
              CustomTextFormField(
                controller: descriptionController,
                hintText: 'event description'.tr(),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter event description'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: height * .02),

              /// Date
              CustomDateOrTime(
                iconDateOrTime: Icon(Icons.date_range_outlined),
                textDateOrTime: 'event date'.tr(),
                chooseDateOrTime: formatDate ?? 'choose date'.tr(),
                onPressed: chooseDate,
              ),

              /// Time
              CustomDateOrTime(
                iconDateOrTime: Icon(Icons.access_time),
                textDateOrTime: 'event time'.tr(),
                chooseDateOrTime: formatTime ?? 'choose time'.tr(),
                onPressed: chooseTime,
              ),

              SizedBox(height: height * .03),

              /// Submit
              CustomElevatedBotton(
                padding: EdgeInsets.zero,
                backGroundColor: AppColors.primaryLight,
                onPressed: () => submit(selectedImage, selectedEventName),
                text: widget.submitText,
                textStyle: AppStyles.medium20White,
              ),

              SizedBox(height: height * .02),
            ],
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        formatDate = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void chooseTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedDate != null
          ? TimeOfDay.fromDateTime(selectedDate!)
          : TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        final baseDate = selectedDate ?? DateTime.now();

        selectedDate = DateTime(
          baseDate.year,
          baseDate.month,
          baseDate.day,
          picked.hour,
          picked.minute,
        );

        formatTime = DateFormat('hh:mm a').format(selectedDate!);
      });
    }
  }

  void submit(String image, String eventName) {
    if (_formKey.currentState?.validate() == false) return;

    if (selectedDate == null || formatTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('please select date and time'.tr())),
      );
      return;
    }

    final event = Event(
      id: widget.initialEvent?.id ?? '',
      image: image,
      title: titleController.text,
      description: descriptionController.text,
      eventName: eventName,
      dateTime: selectedDate!,
      time: formatTime!,
      isFavorite: widget.initialEvent?.isFavorite ?? false,
    );

    widget.onSubmit(event);
  }
}
