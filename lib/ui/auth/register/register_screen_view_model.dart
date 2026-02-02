import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/auth/register/register_navigator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreenViewModel extends ChangeNotifier {
  /// hold data & handel logic
  late RegisterNavigator navigator;

  void register(String email, String password) async {
    navigator.showMyLoading();

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // MyUser myUser = MyUser(
      //   id: credential.user?.uid ?? '',
      //   name: nameController.text,
      //   email: email,
      // );
      // await FirebaseUtils.addUserToFireStore(myUser);
      // if (!context.mounted) return;
      navigator.hideMyLoading();

      navigator.showMyMessage('register successfully'.tr());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        navigator.hideMyLoading();

        navigator.showMyMessage('The password provided is too weak.'.tr());
      } else if (e.code == 'email-already-in-use') {
        navigator.hideMyLoading();

        navigator.showMyMessage(
          'The account already exists for that email.'.tr(),
        );
      } else if (e.code == 'network-request-failed') {
        navigator.hideMyLoading();

        navigator.showMyMessage('Network error.'.tr());
      }
    } catch (e) {
      navigator.hideMyLoading();

      navigator.showMyMessage(e.toString());
    }
  }
}
