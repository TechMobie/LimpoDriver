// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/data/models/profile/profile_model.dart';
import 'package:linpo_driver/app/modules/plus/plus_controller.dart';
import 'package:linpo_driver/components/common_class.dart';
import 'package:linpo_driver/helper/utils/math_utils.dart';
import 'package:linpo_driver/helper/utils/pref_utils.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../../../components/button/button.dart';
import '../../../components/common_textfield.dart';
import '../../../helper/rut_text_fields.dart';
import '../../../helper/utils/common_container.dart';
import '../../../helper/utils/images.dart';
import '../../../helper/utils/pref_utils.dart';
import '../../../helper/utils/string_utils.dart';
import '../../../schemata/color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../data/models/profile/profile_model.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final formKey = GlobalKey<FormState>();
  final plusController = Get.put<PlusController>(PlusController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      plusController.profileModel =
          ProfileModel.fromJson(PrefUtils.getInstance.readData(
        PrefUtils.getInstance.profile,
      ));

      plusController.myFirstNameController.text =
          plusController.profileModel.data!.firstName.toString();
      plusController.myLastNameController.text =
          plusController.profileModel.data!.lastName.toString();
      plusController.myEmailController.text =
          plusController.profileModel.data!.email.toString();
      plusController.myPhoneNumberController.text =
          plusController.profileModel.data!.mobileNumber.toString();
      plusController.myRutController.text =
          plusController.profileModel.data!.rut.toString();
      plusController.isFirstNameButtonValid.value = true;
      plusController.isLastNameButtonValid.value = true;
      plusController.isPhoneNumberButtonValid.value = true;
      plusController.isRutButtonValid.value = true;
      plusController.isEmailButtonValid.value = true;

      plusController.isFirstNameValid.value = true;
      plusController.isLastNameValid.value = true;
      plusController.isPhoneNumberValid.value = true;
      plusController.isRutValid.value = true;
      plusController.isEmailValid.value = true;
      plusController.isEditAccount.value = false;
      plusController.update();
    });
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
            physics: const BouncingScrollPhysics(),
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
                        title: AppLocalizations.of(context)!.myAccount,
                      ),
                      SizedBox(
                        height: getSize(35),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context)!.personalInformation,
                              style: const TextStyle()
                                  .bold20
                                  .textColor(ColorSchema.black2Color),
                            ),
                          ),
                          // const Spacer(),
                          if (plusController.isEditAccount.value == false)
                            GestureDetector(
                              onTap: () {
                                plusController.isEditAccount.value = true;
                              },
                              child: Text(
                                AppLocalizations.of(context)!.editAccount,
                                style: const TextStyle()
                                    .normal18
                                    .textColor(ColorSchema.primaryColor),
                              ),
                            ),
                          if (plusController.isEditAccount.value == false)
                            SizedBox(
                              width: getSize(5),
                            ),
                          if (plusController.isEditAccount.value == false)
                            SvgPicture.asset(
                              ImageConstants.edit,
                              height: 20,
                              width: 20,
                            ),
                          // Icon(
                          //   Icons.edit,
                          //   color: ColorSchema.greenColor,
                          //   size: getSize(20),
                          // )
                        ],
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: firstNameTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: lastNameTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: emailTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: rutTextField(context)),
                      SizedBox(
                        height: getSize(18),
                      ),
                      TextfieldContainer(widget: phoneNumberTextField(context)),
                      SizedBox(
                        height: getSize(30),
                      ),
                      if (plusController.isEditAccount.value)
                        _buttonWidget(context),
                      SizedBox(
                        height: getSize(18),
                      ),
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

  Widget _buttonWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CommonButton(
            buttonColor: ColorSchema.whiteColor,
            borderRadius: 5,
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                color: ColorSchema.grey54Color,
                offset: Offset(2.0, 2.0),
              ),
            ],
            text: AppLocalizations.of(context)!.cancel,
            textStyle:
                const TextStyle().medium16.textColor(ColorSchema.black2Color),
            onTap: () {
              FocusScope.of(context).unfocus();
              plusController.isEditAccount.value = false;
            },
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: CommonButton(
            borderRadius: 5,
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
                color: ColorSchema.grey54Color,
                offset: Offset(2.0, 2.0),
              ),
            ],
            buttonColor: plusController.isFirstNameButtonValid.value &&
                    plusController.isLastNameButtonValid.value &&
                    plusController.isPhoneNumberButtonValid.value &&
                    plusController.isRutButtonValid.value &&
                    plusController.isEmailButtonValid.value
                ? ColorSchema.primaryColor
                : ColorSchema.grey38Color,
            text: AppLocalizations.of(context)!.update,
            textStyle:
                const TextStyle().medium16.textColor(ColorSchema.whiteColor),
            onTap: () async {
              FocusScope.of(context).unfocus();
              plusController.isFirstNameValid.value = false;
              plusController.isLastNameValid.value = false;
              plusController.isPhoneNumberValid.value = false;
              plusController.isRutValid.value = false;
              plusController.isEmailValid.value = false;
              if (formKey.currentState!.validate()) {
                await plusController.editProfileApiCall();
                print('Update');
              }
            },
          ),
        ),
      ],
    );
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme:
                const ColorScheme.light(primary: ColorSchema.primaryColor),
          ),
          child: child ?? const Text(""),
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != plusController.selectedDate) {
      plusController.selectedDate = selected;
    }
  }

  CommonTextfield firstNameTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditAccount.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.myFirstNameFocusNode,
      textOption: TextFieldOption(
        inputController: plusController.myFirstNameController,
        keyboardType: TextInputType.name,
        labelText: AppLocalizations.of(context)!.firstName,
        labelStyleText: plusController.isFirstNameValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        plusController.myLastNameFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isFirstNameValid.value = false;
          plusController.isFirstNameButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterName;
        } else {
          plusController.isFirstNameValid.value = true;
          plusController.isFirstNameButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isFirstNameValid.value = false;
          plusController.isFirstNameButtonValid.value = false;
        } else {
          plusController.isFirstNameValid.value = true;
          plusController.isFirstNameButtonValid.value = true;
        }
      },
    );
  }

  CommonTextfield lastNameTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditAccount.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.myLastNameFocusNode,
      textOption: TextFieldOption(
        inputController: plusController.myLastNameController,
        keyboardType: TextInputType.name,
        labelText: AppLocalizations.of(context)!.lastName,
        labelStyleText: plusController.isLastNameValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        plusController.myEmailFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isLastNameValid.value = false;
          plusController.isLastNameButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterName;
        } else {
          plusController.isLastNameValid.value = true;
          plusController.isLastNameButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isLastNameValid.value = false;
          plusController.isLastNameButtonValid.value = false;
        } else {
          plusController.isLastNameValid.value = true;
          plusController.isLastNameButtonValid.value = true;
        }
      },
    );
  }

  CommonTextfield emailTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditAccount.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.myEmailFocusNode,
      textOption: TextFieldOption(
        inputController: plusController.myEmailController,
        keyboardType: TextInputType.emailAddress,
        labelText: AppLocalizations.of(context)!.email,
        labelStyleText: plusController.isEmailValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        plusController.myRutFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isEmailValid.value = false;
          plusController.isEmailButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterEmail;
        } else if (!ValidationUtils.validateEmail(val)) {
          plusController.isEmailValid.value = false;
          plusController.isEmailButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterValidEmail;
        } else {
          plusController.isEmailValid.value = true;
          plusController.isEmailButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isEmailValid.value = false;
          plusController.isEmailButtonValid.value = false;
        } else if (!ValidationUtils.validateEmail(val)) {
          plusController.isEmailValid.value = false;
          plusController.isEmailButtonValid.value = false;
        } else {
          plusController.isEmailValid.value = true;
          plusController.isEmailButtonValid.value = true;
        }
      },
    );
  }

  CommonTextfield rutTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditAccount.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.myRutFocusNode,
      textOption: TextFieldOption(
        inputController: plusController.myRutController,
        keyboardType: TextInputType.visiblePassword,
        labelText: AppLocalizations.of(context)!.rut,
        labelStyleText: plusController.isRutValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {
        plusController.myPhoneNumberFocusNode.requestFocus();
      },
      validation: (val) {
        RUTValidator(
                validationErrorText: AppLocalizations.of(context)!.enterRut)
            .validator;
        if (val!.isEmpty) {
          plusController.isRutValid.value = false;
          plusController.isRutButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterRut;
        } else if (!ValidationUtils.validateRut(val)) {
          plusController.isRutValid.value = true;
          plusController.isRutButtonValid.value = true;
          return ""; //AppLocalizations.of(context)!.enterValidRut;
        } else {
          plusController.isRutValid.value = true;
          plusController.isRutButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        RUTValidator.formatFromTextController(plusController.myRutController);
        plusController.update();
        if (val.isEmpty) {
          plusController.isRutValid.value = false;
          plusController.isRutButtonValid.value = false;
        } else if (!ValidationUtils.validateRut(val)) {
          plusController.isRutValid.value = true;
          plusController.isRutButtonValid.value = true;
        } else {
          plusController.isRutValid.value = true;
          plusController.isRutButtonValid.value = true;
        }
        plusController.update();
      },
    );
  }

  CommonTextfield phoneNumberTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditAccount.value,
      inputAction: TextInputAction.done,
      focusNode: plusController.myPhoneNumberFocusNode,
      textOption: TextFieldOption(
        // maxLength: 10,
        prefixWid: Text('+56',
            style:
                const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
        inputController: plusController.myPhoneNumberController,
        keyboardType: TextInputType.number,
        labelText: AppLocalizations.of(context)!.cellPhoneNumber,
        labelStyleText: plusController.isPhoneNumberValid.value
            ? const TextStyle().normal16.textColor(ColorSchema.grey54Color)
            : const TextStyle().normal16.textColor(ColorSchema.redColor),
      ),
      clearIcon: false,
      onNextPress: () {},
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isPhoneNumberValid.value = false;
          plusController.isPhoneNumberButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterPhoneNumber;
        } else if (val.length != 9) {
          plusController.isPhoneNumberValid.value = false;
          plusController.isPhoneNumberButtonValid.value = false;
          return ""; //AppLocalizations.of(context)!.enterPhoneNumber;
        } else {
          plusController.isPhoneNumberValid.value = true;
          plusController.isPhoneNumberButtonValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isPhoneNumberValid.value = false;
          plusController.isPhoneNumberButtonValid.value = false;
        } else if (val.length != 9) {
          plusController.isPhoneNumberValid.value = false;
          plusController.isPhoneNumberButtonValid.value = false;
        } else {
          plusController.isPhoneNumberValid.value = true;
          plusController.isPhoneNumberButtonValid.value = true;
        }
        plusController.update();
      },
    );
  }
}
