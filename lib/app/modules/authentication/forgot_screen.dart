// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../../../components/button/button.dart';
import '../../../components/common_textfield.dart';
import '../../../helper/utils/common_container.dart';
import '../../../helper/utils/images.dart';
import '../../../helper/utils/math_utils.dart';
import '../../../helper/utils/string_utils.dart';
import '../../../schemata/color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'authentication_controller.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key? key}) : super(key: key);

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
                        AppLocalizations.of(context)!.recoverPassword,
                        style: const TextStyle().medium20,
                      ),
                      SizedBox(
                        height: getSize(100),
                      ),
                      TextfieldContainer(widget: emailTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      _buttonWidget(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: Platform.isAndroid
              ? const EdgeInsets.only(top: 15, bottom: 15)
              : const EdgeInsets.only(top: 30, bottom: 30),
          width: double.infinity,
          // height: getSize(60),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 1, color: ColorSchema.greyColor),
            ),
          ),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.keyboard_arrow_left,
                  color: ColorSchema.primaryColor,
                ),
                Text(
                  AppLocalizations.of(context)!.returnText,
                  style: const TextStyle()
                      .size(18)
                      .textColor(ColorSchema.primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return CommonAppButton(
        text: AppLocalizations.of(context)!.forgotPassword,
        onTap: () async {
          authenticationController.isForgotEmailValid.value = false;
          if (formKey.currentState!.validate()) {
            await authenticationController.forgotPasswordApiCall();
            print("Forgot Password");
          }
        },
        width: double.infinity,
        color: authenticationController.isForgotEmailButtonValid.value
            ? ColorSchema.primaryColor
            : ColorSchema.grey38Color,
        style: const TextStyle().normal16.textColor(
            authenticationController.isForgotEmailButtonValid.value
                ? ColorSchema.whiteColor
                : ColorSchema.black2Color),
        borderRadius: 5);
  }

  CommonTextfield emailTextField(BuildContext context) {
    return CommonTextfield(
      inputAction: TextInputAction.done,
      focusNode: authenticationController.emailForgotFocusNode,
      textOption: TextFieldOption(
          inputController: authenticationController.emailForgotController,
          keyboardType: TextInputType.emailAddress,
          labelText: AppLocalizations.of(context)!.email,
          labelStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      clearIcon: authenticationController.emailForgotController.text.isNotEmpty
          ? true
          : false,
      function: () {
        authenticationController.emailForgotController.clear();
        authenticationController.isForgotEmailValid.value = false;
        authenticationController.isForgotEmailButtonValid.value = false;
        authenticationController.update();
      },
      validation: (val) {
        if (val!.isEmpty) {
          authenticationController.isForgotEmailValid.value = false;
          authenticationController.isForgotEmailButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterEmail;
        } else if (!ValidationUtils.validateEmail(val)) {
          authenticationController.isForgotEmailValid.value = false;
          authenticationController.isForgotEmailButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterValidEmail;
        } else {
          authenticationController.isForgotEmailValid.value = true;
          authenticationController.isForgotEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          authenticationController.isForgotEmailValid.value = false;
          authenticationController.isForgotEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          authenticationController.isForgotEmailValid.value = false;
          authenticationController.isForgotEmailButtonValid.value = false;
        } else {
          authenticationController.isForgotEmailValid.value = true;
          authenticationController.isForgotEmailButtonValid.value = true;
        }
        authenticationController.update();
      },
    );
  }
}
