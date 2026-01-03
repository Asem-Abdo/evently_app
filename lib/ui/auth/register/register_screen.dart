import 'package:easy_localization/easy_localization.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/ui/auth/register/register_screen.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../home/home_screen.dart';
import '../../widgets/custom_elevated_botton.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        title: SizedBox(
          child: Text("register".tr(), style: AppStyles.bold16Primary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAssets.login, height: height * .20),
            SizedBox(height: height * .02),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextFormField(
                    hintText: 'name'.tr(),
                    prefixIcon: Icon(Icons.email),
                    controller: nameController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'name is required'.tr();
                      }

                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                    hintText: 'email'.tr(),
                    prefixIcon: Icon(Icons.email),
                    controller: emailController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'email is required'.tr();
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(text.trim());
                      if (!emailValid) {
                        return 'email is not valid'.tr();
                      }
                      if (text.contains(' ')) {
                        return 'email must not contain spaces'.tr();
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                    hintText: 'password'.tr(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    controller: passwordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'password is required'.tr();
                      }
                      if (text.length < 6) {
                        return 'password must be at least 6 characters'.tr();
                      }
                      if (text.length > 20) {
                        return 'password must be less than 20 characters'.tr();
                      }
                      if (text.contains(' ')) {
                        return 'password must not contain spaces'.tr();
                      }

                      return null;
                    },
                    showPassword: true,
                  ),
                  SizedBox(height: height * .02),
                  CustomTextFormField(
                    hintText: 're password'.tr(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    controller: rePasswordController,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 're password is required'.tr();
                      }
                      if (text != passwordController.text) {
                        return 'password not match'.tr();
                      }
                      return null;
                    },
                    showPassword: true,
                  ),
                  SizedBox(height: height * .02),
                  CustomElevatedBotton(
                    onPressed: () {
                      register(context);
                    },
                    text: 'create account'.tr(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don’t have account ?',
                        style: AppStyles.medium16Black,
                      ).tr(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'login',
                          style: AppStyles.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          ),
                        ).tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      DialogUtils.showLoading(context: context);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );
        await FirebaseUtils.addUserToFireStore(myUser);
        if (!context.mounted) return;
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMsg(
          title: "success".tr(),
          posActionName: 'ok'.tr(),
          context: context,
          message: 'register successfully'.tr(),
          posAction: () {
            Navigator.pop(context);
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMsg(
            title: "error".tr(),
            posActionName: 'ok'.tr(),
            context: context,
            message: 'The password provided is too weak.'.tr(),
          );
        } else if (e.code == 'email-already-in-use') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMsg(
            title: "error".tr(),
            posActionName: 'ok'.tr(),
            context: context,
            message: 'The account already exists for that email.'.tr(),
          );
        } else if (e.code == 'network-request-failed') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMsg(
            context: context,
            message: 'Network error.'.tr(),
            title: "error".tr(),
            posActionName: 'ok'.tr(),
          );
        }
      } catch (e) {
        DialogUtils.hideLoading(context: context);
        DialogUtils.showMsg(
          context: context,
          message: e.toString(),
          title: "error".tr(),
          posActionName: 'ok'.tr(),
        );
      }
    } else {
      return;
    }
  }
}
