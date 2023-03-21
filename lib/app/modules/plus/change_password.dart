// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/plus/plus_controller.dart';
import 'package:linpo_driver/helper/utils/string_utils.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../../../components/button/button.dart';
import '../../../components/common_class.dart';
import '../../../components/common_textfield.dart';
import '../../../helper/utils/math_utils.dart';
import '../../../schemata/color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../helper/utils/common_container.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final formKey = GlobalKey<FormState>();

  final plusController = Get.put<PlusController>(PlusController());

  @override
  void dispose() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      plusController.oldPasswordController.clear();
      plusController.newPasswordController.clear();
      plusController.confirmPasswordController.clear();
      plusController.isOldPasswordValid.value = true;
      plusController.isNewPasswordValid.value = true;
      plusController.isConfirmPasswordValid.value = true;
    });

    super.dispose();
  }

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
            physics: const NeverScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Obx(
                () => Padding(
                  padding: EdgeInsets.symmetric(horizontal: getSize(15.0)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getSize(20),
                      ),
                      CommonHeader(
                        title: AppLocalizations.of(context)!.changePassword,
                      ),
                      SizedBox(
                        height: getSize(35),
                      ),
                      TextfieldContainer(widget: oldPasswordTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: newPasswordTextField(context)),
                      SizedBox(
                        height: getSize(5),
                      ),
                      FlutterPwValidator(
                        strings: SpanishString(),
                        controller: plusController.newPasswordController,
                        minLength: 8,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        // specialCharCount: 1,
                        // normalCharCount: 3,
                        width: 400,
                        height: 110,
                        onSuccess: () {
                          plusController.isNewPasswordValid.value = true;
                          plusController.isNewPasswordButtonValid.value = true;
                          plusController.update();
                        },
                        onFail: () {
                          plusController.isNewPasswordValid.value = false;
                          plusController.isNewPasswordButtonValid.value = false;
                          plusController.update();
                        },
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(
                          widget: _confirmPasswordTextField(context)),
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
      ),
    );
  }

  CommonTextfield _confirmPasswordTextField(BuildContext context) {
    return CommonTextfield(
      inputAction: TextInputAction.done,
      focusNode: plusController.confirmPasswordFocusNode,
      function: () {
        plusController.isShowConfirmPassword.value =
            !plusController.isShowConfirmPassword.value;
      },
      textOption: TextFieldOption(
        inputController: plusController.confirmPasswordController,
        isSecureTextField: !plusController.isShowConfirmPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.confirmPassword,
        labelStyleText: plusController.isConfirmPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isConfirmPasswordValid.value = false;
          plusController.isConfirmPasswordButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterMinimumCharacter;
        }
        if (val != plusController.newPasswordController.text) {
          plusController.isConfirmPasswordValid.value = false;
          plusController.isConfirmPasswordButtonValid.value = false;
          return "";
        } else {
          plusController.isConfirmPasswordValid.value = true;
          plusController.isConfirmPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isConfirmPasswordValid.value = false;
          plusController.isConfirmPasswordButtonValid.value = false;
        }
        if (val != plusController.newPasswordController.text) {
          plusController.isConfirmPasswordValid.value = false;
          plusController.isConfirmPasswordButtonValid.value = false;
        } else {
          plusController.isConfirmPasswordValid.value = true;
          plusController.isConfirmPasswordButtonValid.value = true;
        }
        plusController.update();
      },
    );
  }

  Widget _buttonWidget(BuildContext context) {
    return CommonButton(
      borderRadius: 5,
      boxShadow: const [
        BoxShadow(
          blurRadius: 2,
          color: ColorSchema.grey54Color,
          offset: Offset(2.0, 2.0),
        ),
      ],
      buttonColor: plusController.isOldPasswordButtonValid.value &&
              plusController.isNewPasswordButtonValid.value &&
              plusController.isConfirmPasswordButtonValid.value
          ? ColorSchema.primaryColor
          : ColorSchema.grey38Color,
      text: AppLocalizations.of(context)!.update,
      textStyle: const TextStyle().medium16.textColor(
          (plusController.isOldPasswordButtonValid.value &&
                  plusController.isNewPasswordButtonValid.value &&
                  plusController.isConfirmPasswordButtonValid.value)
              ? ColorSchema.whiteColor
              : ColorSchema.black2Color),
      onTap: () async {
        FocusScope.of(context).unfocus();
        plusController.isOldPasswordValid.value = false;
        plusController.isNewPasswordValid.value = false;
        plusController.isConfirmPasswordValid.value = false;

        if (formKey.currentState!.validate()) {
          await plusController.changePasswordApiCall();
          print('Update');
        }
      },
    );
  }

  CommonTextfield oldPasswordTextField(BuildContext context) {
    return CommonTextfield(
      inputAction: TextInputAction.next,
      focusNode: plusController.oldPasswordFocusNode,
      function: () {
        plusController.isShowOldPassword.value =
            !plusController.isShowOldPassword.value;
      },
      textOption: TextFieldOption(
        inputController: plusController.oldPasswordController,
        isSecureTextField: !plusController.isShowOldPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.oldPassword,
        labelStyleText: plusController.isOldPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      validation: (val) {
        if (val!.length < 6) {
          plusController.isOldPasswordValid.value = false;
          plusController.isOldPasswordButtonValid.value = false;
          return AppLocalizations.of(context)!.enterMinimumCharacter;
        } else {
          plusController.isOldPasswordValid.value = true;
          plusController.isOldPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.length < 6) {
          plusController.isOldPasswordValid.value = false;
          plusController.isOldPasswordButtonValid.value = false;
        } else {
          plusController.isOldPasswordValid.value = true;
          plusController.isOldPasswordButtonValid.value = true;
        }
      },
    );
  }

  CommonTextfield newPasswordTextField(BuildContext context) {
    return CommonTextfield(
      inputAction: TextInputAction.next,
      focusNode: plusController.newPasswordFocusNode,
      function: () {
        plusController.isShowNewPassword.value =
            !plusController.isShowNewPassword.value;
      },
      textOption: TextFieldOption(
        inputController: plusController.newPasswordController,
        isSecureTextField: !plusController.isShowNewPassword.value,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.newPassword,
        labelStyleText: plusController.isNewPasswordValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      isEyeIcon: true,
      validation: (val) {
        if (val!.length < 6) {
          plusController.isNewPasswordValid.value = false;
          plusController.isNewPasswordButtonValid.value = false;
          return AppLocalizations.of(context)!.enterMinimumCharacter;
        } else {
          plusController.isNewPasswordValid.value = true;
          plusController.isNewPasswordButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.length < 6) {
          plusController.isNewPasswordValid.value = false;
          plusController.isNewPasswordButtonValid.value = false;
        } else {
          plusController.isNewPasswordValid.value = true;
          plusController.isNewPasswordButtonValid.value = true;
        }
      },
    );
  }
}
