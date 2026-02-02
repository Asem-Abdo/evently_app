import 'package:easy_localization/easy_localization.dart';
import 'package:evently/ui/auth/register/register_navigator.dart';
import 'package:evently/ui/auth/register/register_screen_view_model.dart';
import 'package:evently/ui/widgets/custom_text_form_field.dart';
import 'package:evently/utils/app_assets.dart';
import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:evently/utils/dialog_utils.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_elevated_botton.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterNavigator {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegisterScreenViewModel viewModel = RegisterScreenViewModel();

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
      ),
    );
  }

  void register(BuildContext context) async {
    if (formKey.currentState?.validate() == true) {
      viewModel.register(emailController.text, passwordController.text);
    }
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
  void showMyMessage(String msg) {
    DialogUtils.showMsg(context: context, message: msg, posActionName: 'Ok');
  }
}
