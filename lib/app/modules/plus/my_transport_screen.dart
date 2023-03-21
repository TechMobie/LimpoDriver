// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:linpo_driver/app/modules/plus/plus_controller.dart';
import 'package:linpo_driver/components/common_class.dart';
import 'package:linpo_driver/helper/utils/math_utils.dart';
import 'package:linpo_driver/schemata/text_style.dart';
import '../../../components/button/button.dart';
import '../../../components/common_textfield.dart';
import '../../../helper/utils/images.dart';
import '../../../schemata/color_schema.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class MyTransportScreen extends StatelessWidget {
  MyTransportScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final plusController = Get.put<PlusController>(PlusController());
  final DateTime selectedDate = DateTime.now();

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
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getSize(20),
                      ),
                      CommonHeader(
                        title: AppLocalizations.of(context)!.myTransport,
                      ),
                      SizedBox(
                        height: getSize(35),
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.vanData,
                            style: const TextStyle()
                                .bold20
                                .textColor(ColorSchema.black2Color),
                          ),
                          const Spacer(),
                          if (plusController.isEditTransport.value == false)
                            GestureDetector(
                              onTap: () {
                                plusController.isEditTransport.value = true;
                              },
                              child: Text(
                                AppLocalizations.of(context)!.editAccount,
                                style: const TextStyle()
                                    .normal18
                                    .textColor(ColorSchema.primaryColor),
                              ),
                            ),
                          if (plusController.isEditTransport.value == false)
                            SizedBox(
                              width: getSize(5),
                            ),
                          if (plusController.isEditTransport.value == false)
                            SvgPicture.asset(
                              ImageConstants.edit,
                              height: 20,
                              width: 20,
                            ),
                        ],
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      brandTextField(context),
                      SizedBox(
                        height: getSize(18),
                      ),
                      modelTextField(context),
                      SizedBox(
                        height: getSize(18),
                      ),
                      yearTextField(context),
                      SizedBox(
                        height: getSize(18),
                      ),
                      patentTextField(context),
                      SizedBox(
                        height: getSize(18),
                      ),
                      abilityTextField(context),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Obx(
                        () => externalTextField(context),
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Obx(
                        () => drivingLicenceTextField(context),
                      ),
                      SizedBox(
                        height: getSize(18),
                      ),
                      Obx(() => safeImageTextField(context)),
                      SizedBox(
                        height: getSize(30),
                      ),
                      if (plusController.isEditTransport.value)
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

  Row _buttonWidget(BuildContext context) {
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
              plusController.isEditTransport.value = false;
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
            buttonColor: ColorSchema.primaryColor,
            text: AppLocalizations.of(context)!.update,
            textStyle:
                const TextStyle().medium16.textColor(ColorSchema.whiteColor),
            onTap: () {
              FocusScope.of(context).unfocus();
              plusController.isBrandValid.value = false;
              plusController.isModelValid.value = false;
              plusController.isYearValid.value = false;
              plusController.isPatentValid.value = false;
              plusController.isAbilityValid.value = false;
              plusController.isExternalValid.value = false;
              if (formKey.currentState!.validate()) {
                print('Update');
              }
            },
          ),
        ),
      ],
    );
  }

  CommonTextfield brandTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.brandFocusNode,
      textOption: TextFieldOption(
          inputController: plusController.brandController,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!.brand,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      clearIcon: false,
      onNextPress: () {
        plusController.modelFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isBrandValid.value = false;
          return AppLocalizations.of(context)!.enterBrand;
        } else {
          plusController.isBrandValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isBrandValid.value = false;
        } else {
          plusController.isBrandValid.value = true;
        }
      },
    );
  }

  CommonTextfield modelTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.modelFocusNode,
      textOption: TextFieldOption(
          inputController: plusController.modelController,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!.model,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      clearIcon: false,
      onNextPress: () {
        plusController.yearFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isModelValid.value = false;
          return AppLocalizations.of(context)!.enterModel;
        } else {
          plusController.isModelValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isModelValid.value = false;
        } else {
          plusController.isModelValid.value = true;
        }
      },
    );
  }

  CommonTextfield yearTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.yearFocusNode,
      textOption: TextFieldOption(
          inputController: plusController.yearController,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!.year,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      clearIcon: false,
      onNextPress: () {
        plusController.patentFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isYearValid.value = false;
          return AppLocalizations.of(context)!.enterYear;
        } else {
          plusController.isYearValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isYearValid.value = false;
        } else {
          plusController.isYearValid.value = true;
        }
      },
    );
  }

  CommonTextfield patentTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.patentFocusNode,
      textOption: TextFieldOption(
          inputController: plusController.patentController,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!.patent,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      clearIcon: false,
      onNextPress: () {
        plusController.abilityFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isPatentValid.value = false;
          return AppLocalizations.of(context)!.enterPatent;
        } else {
          plusController.isPatentValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isPatentValid.value = false;
        } else {
          plusController.isPatentValid.value = true;
        }
      },
    );
  }

  CommonTextfield abilityTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.abilityFocusNode,
      textOption: TextFieldOption(
          inputController: plusController.abilityController,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!.ability,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      clearIcon: false,
      onNextPress: () {
        plusController.externalFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isAbilityValid.value = false;
          return AppLocalizations.of(context)!.enterAbility;
        } else {
          plusController.isAbilityValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isAbilityValid.value = false;
        } else {
          plusController.isAbilityValid.value = true;
        }
      },
    );
  }

  CommonTextfield externalTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.externalFocusNode,
      textOption: TextFieldOption(
          inputController: plusController.externalController,
          keyboardType: TextInputType.name,
          hintText: AppLocalizations.of(context)!.external,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      clearIcon: false,
      onNextPress: () {
        plusController.drivingLicenceFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isExternalValid.value = false;
          return AppLocalizations.of(context)!.enterExternal;
        } else {
          plusController.isExternalValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isExternalValid.value = false;
        } else {
          plusController.isExternalValid.value = true;
        }
      },
    );
  }

  CommonTextfield drivingLicenceTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.next,
      focusNode: plusController.drivingLicenceFocusNode,
      function: () {
        plusController.isShowDrivingLicence.value =
            !plusController.isShowDrivingLicence.value;
      },
      textOption: TextFieldOption(
          isSecureTextField: !plusController.isShowDrivingLicence.value,
          suffixIcon: Icon(
            plusController.isShowDrivingLicence.value
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye,
          ),
          inputController: plusController.drivingLicenceController,
          keyboardType: TextInputType.number,
          hintText: AppLocalizations.of(context)!.drivingLicenseImage,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      isEyeIcon: true,
      onNextPress: () {
        plusController.safeImageFocusNode.requestFocus();
      },
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isDrivingLicenceValid.value = false;
          return AppLocalizations.of(context)!.enterDrivingLicenceImage;
        } else {
          plusController.isDrivingLicenceValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isDrivingLicenceValid.value = false;
        } else {
          plusController.isDrivingLicenceValid.value = true;
        }
      },
    );
  }

  CommonTextfield safeImageTextField(BuildContext context) {
    return CommonTextfield(
      isEditable: plusController.isEditTransport.value,
      inputAction: TextInputAction.done,
      focusNode: plusController.safeImageFocusNode,
      function: () {
        plusController.isShowSafeImage.value =
            !plusController.isShowSafeImage.value;
      },
      textOption: TextFieldOption(
          suffixIcon: Icon(
            plusController.isShowSafeImage.value
                ? Icons.remove_red_eye_outlined
                : Icons.remove_red_eye,
          ),
          isSecureTextField: !plusController.isShowSafeImage.value,
          inputController: plusController.safeImageController,
          keyboardType: TextInputType.number,
          hintText: AppLocalizations.of(context)!.safeImage,
          hintStyleText:
              const TextStyle().normal16.textColor(ColorSchema.grey54Color)),
      onNextPress: () {},
      isEyeIcon: true,
      validation: (val) {
        if (val!.isEmpty) {
          plusController.isSafeImageValid.value = false;
          return AppLocalizations.of(context)!.enterSafeImage;
        } else {
          plusController.isSafeImageValid.value = true;
          return null;
        }
      },
      textCallback: (val) {
        if (val.isEmpty) {
          plusController.isSafeImageValid.value = false;
        } else {
          plusController.isSafeImageValid.value = true;
        }
      },
    );
  }
}
