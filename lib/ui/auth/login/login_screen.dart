import 'package:easy_localization/easy_localization.dart';
import 'package:evently/model/my_user.dart';
import 'package:evently/providers/event_list_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/ui/auth/register/register_screen.dart';
import 'package:evently/ui/home/home_screen.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/dialog_utils.dart';
import '../../widgets/custom_elevated_botton.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                          return 'password must be less than 20 characters'
                              .tr();
                        }
                        if (text.contains(' ')) {
                          return 'password must not contain spaces'.tr();
                        }

                        return null;
                      },
                      showPassword: true,
                    ),

                    TextButton(
                      onPressed: () {},
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          'forget password'.tr(),
                          textAlign: TextAlign.end,
                          style: AppStyles.bold16Primary.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryLight,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .02),
                    CustomElevatedBotton(
                      onPressed: () {
                        login(context);
                      },
                      text: 'login'.tr(),
                    ),
                    SizedBox(height: height * .02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'don’t have account ?',
                          style: AppStyles.medium16Black,
                        ).tr(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'create account',
                            style: AppStyles.bold16Primary.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primaryLight,
                            ),
                          ).tr(),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .02),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: width * .1,
                            endIndent: 10,
                            thickness: 2,
                            color: AppColors.primaryLight,
                          ),
                        ),
                        Text('or', style: AppStyles.medium16Primary).tr(),
                        Expanded(
                          child: Divider(
                            indent: 10,
                            endIndent: width * .1,
                            thickness: 2,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * .02),
                    CustomElevatedBotton(
                      icon: true,
                      iconButton: Image.asset(AppAssets.google_icon),
                      backGroundColor: AppColors.transparentColor,
                      textStyle: AppStyles.medium16Primary,
                      onPressed: () {},
                      text: 'login with google'.tr(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      /// show loading
      DialogUtils.showLoading(context: context);
      try {
        /// sign in firebase auth
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        /// read user from firebase
        var myUser = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? "",
        );
        if (myUser == null) {
          return;
        }
        if (!context.mounted) return;

        /// save user in provider
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);

        /// change selected index to start from All tab
        var eventListProvider = Provider.of<EventListProvider>(
          context,
          listen: false,
        );
        eventListProvider.changeSelectedIndex(0, userProvider.currentUser!.id);

        /// hide loading
        DialogUtils.hideLoading(context: context);

        /// show msg
        DialogUtils.showMsg(
          context: context,
          message: 'login successfully'.tr(),
          title: "success".tr(),
          posActionName: 'ok'.tr(),
          posAction: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        );

        /// get favorite events
        eventListProvider.getAllFavoriteEvents(userProvider.currentUser!.id);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMsg(
            title: "error".tr(),
            posActionName: 'ok'.tr(),
            context: context,
            message: 'The supplied auth credential is incorrect.'.tr(),
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
