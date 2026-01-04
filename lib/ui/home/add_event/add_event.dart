import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/widgets/event_form_widget.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/event_list_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_styles.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final eventListProvider = Provider.of<EventListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primaryLight),
        title: Text('create event'.tr(), style: AppStyles.medium24Primary),
      ),
      body: EventFormWidget(
        onSubmit: (event) {
          FirebaseUtils.addEventToFireStore(
            event,
            userProvider.currentUser!.id,
          ).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('event added successfully'.tr())),
            );

            eventListProvider.getAllEvents(userProvider.currentUser!.id);

            Navigator.pop(context);
          });
        },
        submitText: 'add event'.tr(),
      ),
    );
  }
}
