import 'package:easy_localization/easy_localization.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/auth/login/login_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/firebase_utils.dart';

class LoginScreenViewModel extends ChangeNotifier {
  final emailController = TextEditingController(text: "asem@gmail.com");
  final passwordController = TextEditingController(text: "123456");
  late LoginNavigator navigator;
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login(
    UserProvider userProvider,
    EventListProvider eventListProvider,
  ) async {
    if (formKey.currentState?.validate() == true) {
      navigator.showMyLoading();
      try {
        /// sign in firebase auth
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        /// read user from firebase
        var myUser = await FirebaseUtils.readUserFromFireStore(
          credential.user!.uid,
        );
        if (myUser == null) {
          navigator.hideMyLoading();
          navigator.showMyMessage('User not found'.tr());
          return;
        }

        /// save user in provider
        userProvider.updateUser(myUser);

        eventListProvider.changeSelectedIndex(0, myUser.id);
        eventListProvider.getAllFavoriteEvents(myUser.id);

        /// hide loading
        navigator.hideMyLoading();

        /// show msg
        await navigator.showMyMessage('login successfully'.tr());
        navigator.navigateToHome();

        /// get favorite events
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          navigator.hideMyLoading();
          navigator.showMyMessage(
            'The supplied auth credential is incorrect.'.tr(),
          );
        } else if (e.code == 'network-request-failed') {
          navigator.hideMyLoading();
          navigator.showMyMessage('Network error.'.tr());
        }
      } catch (e) {
        navigator.hideMyLoading();
        navigator.showMyMessage("error".tr());
      }
    }
  }
}
