import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/widgets/event_form_widget.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/event.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class EditEvent extends StatelessWidget {
  final Event event;
  const EditEvent({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);
    var eventListProvider = Provider.of<EventListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text('edit event'.tr(), style: AppStyles.medium24Primary),
      ),
      body: EventFormWidget(
        initialEvent: event,
        onSubmit: (updatedEvent) {
          FirebaseUtils.getEventCollection(
            userProvider.currentUser!.id,
          ).doc(updatedEvent.id).update(updatedEvent.toJson()).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('event updated successfully'.tr())),
            );
            eventListProvider.getAllEvents(userProvider.currentUser!.id);
            Navigator.pop(context, updatedEvent);
          });
        },
        submitText: 'update event'.tr(),
      ),
    );
  }
}
