import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/auth/login/login_navigator.dart';
import 'package:evently/ui/auth/login/login_screen_view_model.dart';
import 'package:evently/ui/auth/register/register_screen.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/event_list_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/dialog_utils.dart';
import '../../../utils/firebase_utils.dart';
import '../../home/home_screen.dart';
import '../../widgets/custom_elevated_botton.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  LoginScreenViewModel viewModel = LoginScreenViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.login, height: height * .20),
                SizedBox(height: height * .02),
                Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        hintText: 'email'.tr(),
                        prefixIcon: Icon(Icons.email),
                        controller: viewModel.emailController,
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
                        controller: viewModel.passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'password is required'.tr();
                          }
                          if (text.length < 6) {
                            return 'password must be at least 6 characters'
                                .tr();
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
                          viewModel.login(
                            context.read<UserProvider>(),
                            context.read<EventListProvider>(),
                          );
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
      ),
    );
  }

  @override
  void hideMyLoading() {
    DialogUtils.hideLoading(context: context);
  }

  @override
  void showMyLoading() {
    DialogUtils.showLoading(context: context);
  }

  @override
  Future<void> showMyMessage(String msg) async {
    return DialogUtils.showMsg(
      context: context,
      message: msg,
      posActionName: 'Ok',
    );
  }

  @override
  void navigateToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (route) => false,
    );
  }
}
