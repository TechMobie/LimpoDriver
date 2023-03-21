// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/routes/app_pages.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../../../components/button/button.dart';
import '../../../components/common_textfield.dart';
import '../../../helper/utils/common_container.dart';
import '../../../helper/utils/images.dart';
import '../../../helper/utils/math_utils.dart';
import '../../../helper/utils/pref_utils.dart';
import '../../../helper/utils/string_utils.dart';
import '../../../schemata/color_schema.dart';
import 'authentication_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final authenticationController =
      Get.put<AuthenticationController>(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorSchema.whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: GetBuilder<AuthenticationController>(
                init: authenticationController,
                builder: (controller) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: getSize(100),
                      ),
                      SvgPicture.asset(
                        ImageConstants.appIcon,
                        height: getSize(40),
                        color: ColorSchema.primaryColor,
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Text(
                        AppLocalizations.of(context)!.logInText,
                        style: const TextStyle().medium20,
                      ),
                      SizedBox(
                        height: getSize(100),
                      ),
                      TextfieldContainer(widget: emailTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: passwordTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Wrap(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.didYouForget,
                            style: const TextStyle().normal16,
                          ),
                          SizedBox(
                            width: getSize(5),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.forgotScreen);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.clickHere,
                              textAlign: TextAlign.center,
                              style: const TextStyle()
                                  .normal16
                                  .textColor(ColorSchema.primaryColor),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      _loginButtonWidget(context),
                      SizedBox(
                        height: getSize(18),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       AppLocalizations.of(context)!.noAccount,
                      //       style: const TextStyle().normal16,
                      //     ),
                      //     SizedBox(
                      //       width: getSize(10),
                      //     ),
                      //     GestureDetector(
                      //         onTap: () {
                      //           Get.toNamed(Routes.signUp);
                      //         },
                      //         child: Text(
                      //           AppLocalizations.of(context)!.signUpHere,
                      //           style: const TextStyle()
                      //               .normal16
                      //               .textColor(ColorSchema.primaryColor),
                      //         ))
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginButtonWidget(BuildContext context) {
    return CommonAppButton(
        text: AppLocalizations.of(context)!.logInText,
        onTap: () async {
          authenticationController.isSignInEmailValid.value = false;
          authenticationController.isSignInPasswordValid.value = false;
          if (formKey.currentState!.validate()) {
            PrefUtils.getInstance.writeData(
              PrefUtils.getInstance.isUserLoginKey,
              true,
            );
            await authenticationController.logInApiCall();
            print("Log In");
          }
        },
        width: double.infinity,
        color: authenticationController.isSignInPasswordButtonValid.value &&
                authenticationController.isSignInEmailButtonValid.value
            ? ColorSchema.primaryColor
            : ColorSchema.grey38Color,
        style: const TextStyle().medium16.textColor(
            authenticationController.isSignInPasswordButtonValid.value &&
                    authenticationController.isSignInEmailButtonValid.value
                ? ColorSchema.whiteColor
                : ColorSchema.black2Color),
        borderRadius: 5);
  }

  CommonTextfield emailTextField(BuildContext context) {
    return CommonTextfield(
      inputAction: TextInputAction.next,
      focusNode: authenticationController.emailSignInFocusNode,
      textOption: TextFieldOption(
        inputController: authenticationController.emailSignInController,
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        labelStyleText: authenticationController.isSignInEmailValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: authenticationController.emailSignInController.text.isNotEmpty
          ? true
          : false,
      function: () {
        authenticationController.emailSignInController.clear();
        authenticationController.isSignInEmailValid.value = false;
        authenticationController.isSignInEmailButtonValid.value = false;
        authenticationController.update();
      },
      onNextPress: () {
        authenticationController.passwordSignInFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          authenticationController.isSignInEmailValid.value = false;
          authenticationController.isSignInEmailButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterEmail;
        } else if (!ValidationUtils.validateEmail(val)) {
          authenticationController.isSignInEmailValid.value = false;
          authenticationController.isSignInEmailButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterValidEmail;
        } else {
          authenticationController.isSignInEmailValid.value = true;
          authenticationController.isSignInEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          authenticationController.isSignInEmailValid.value = false;
          authenticationController.isSignInEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          authenticationController.isSignInEmailValid.value = false;
          authenticationController.isSignInEmailButtonValid.value = false;
        } else {
          authenticationController.isSignInEmailValid.value = true;
          authenticationController.isSignInEmailButtonValid.value = true;
        }
        authenticationController.update();
      },
    );
  }

  CommonTextfield passwordTextField(BuildContext context) {
    return CommonTextfield(
      inputAction: TextInputAction.done,
      focusNode: authenticationController.passwordSignInFocusNode,
      textOption: TextFieldOption(
        isSecureTextField: true,
        inputController: authenticationController.passwordSignInController,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.password,
        labelStyleText: authenticationController.isSignInPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      function: () {
        authenticationController.passwordSignInController.clear();
        authenticationController.isSignInPasswordValid.value = false;
        authenticationController.isSignInPasswordButtonValid.value = false;
        authenticationController.update();
      },
      clearIcon:
          authenticationController.passwordSignInController.text.isNotEmpty
              ? true
              : false,
      validation: (val) {
        if (val!.isEmpty) {
          authenticationController.isSignInPasswordValid.value = false;
          authenticationController.isSignInPasswordButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterMinimumCharacter;
        } else {
          authenticationController.isSignInPasswordValid.value = true;
          authenticationController.isSignInPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          authenticationController.isSignInPasswordValid.value = false;
          authenticationController.isSignInPasswordButtonValid.value = false;
        } else {
          authenticationController.isSignInPasswordValid.value = true;
          authenticationController.isSignInPasswordButtonValid.value = true;
        }
        authenticationController.update();
      },
    );
  }
}
