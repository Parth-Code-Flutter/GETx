import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';
import 'package:tsofie/app/widgets/profile_yello_bg.dart';
import '../controller/s_edit_profile_controller.dart';

class SEditProfileScreen extends GetView<SEditProfileController> {
  SEditProfileScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
    // controller.isFromOtpScreen.value = arg;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: kColorBackground,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                commonHeaderWidget(
                    isShowBackButton: !controller.isFromOtpScreen.value,
                    onBackTap: () {
                      Get.back();
                    },
                    title: kLabelEditProfile),
                profileImageContainer(),
                const SizedBox(height: 16),
                companyNameTextField(),
                const SizedBox(height: 16),
                companyAddressTextField(),
                const SizedBox(height: 16),
                // cityDropDown(),
                stateDropDown(),
                const SizedBox(height: 16),
                // stateTextField(),
                cityDropDown(),
                const SizedBox(height: 16),
                pinCodeTextField(),
                const SizedBox(height: 16),
                GstTextField(),
                const SizedBox(height: 16),
                contactPersonTextField(),
                const SizedBox(height: 16),
                officeNumberTextField(),
                const SizedBox(height: 16),
                cellNumberTextField(),
                const SizedBox(height: 16),
                emailIdTextField(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 34, vertical: 20),
                  child:
                      Text('Bank Details', style: TextStyles.kH16BlackBold700),
                ),
                accountNoTextField(),
                const SizedBox(height: 16),
                bankNameTextField(),
                const SizedBox(height: 16),
                IFSCnoTextField(),
                // userNameTextField(),
                // mobileNumberTextField(),
                controller.isFromOtpScreen.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 32),
                        child: primaryButton(
                            onPress: () {
                              // controller.editProfileAPICall();
                              controller.validateUserInput();
                            },
                            buttonTxt: kLabelUpdate),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: primaryButton(
                                  onPress: () {
                                    // controller.editProfileAPICall();
                                    controller.validateUserInput();
                                  },
                                  buttonTxt: kLabelUpdate),
                            ),
                          ),
                          const SizedBox(width: 16),
                          SizedBox(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: primaryButton(
                                  onPress: () {
                                    Get.back();
                                    //  controller.validateUserInput();
                                  },
                                  buttonTxt: kLabelCancel),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileImageContainer() {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          openBottomSheet();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 46, bottom: 40),
          child: controller.selectedProfileImage.value.path.isNotEmpty
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    profileYellowBG(),
                    Container(
                      height: 95,
                      width: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: kColorBlack, width: 4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.file(
                          File(controller.selectedProfileImage.value.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  ],
                )
              : controller.userPrefData.value.userProfilePic != null &&
                      (controller.userPrefData.value.userProfilePic ?? '')
                          .isNotEmpty
                  ? Stack(
                      clipBehavior: Clip.none,
                      children: [
                        profileYellowBG(),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: kColorBlack, width: 4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: getProfileImage(),
                          ),
                        )
                      ],
                    )
                  : Image.asset(kImgProfilePlaceholder),
        ),
      );
    });
  }

  getProfileImage() {
    try {
      return Image.network(
        controller.userPrefData.value.userProfilePic ?? '',
        fit: BoxFit.fill,
      );
    } catch (e) {
      return Image.asset(kImgProfilePlaceholder);
    }
  }

  // Widget profileImageContainer() {
  //   return Obx(() {
  //     return GestureDetector(
  //       onTap: () {
  //         openBottomSheet();
  //       },
  //       child: Padding(
  //         padding: const EdgeInsets.only(top: 46, bottom: 40),
  //         child: controller.selectedProfileImage.value.path.isNotEmpty
  //             ? Stack(
  //                 clipBehavior: Clip.none,
  //                 children: [
  //                   profileYellowBG(),
  //                   Container(
  //                     height: 95,
  //                     width: 95,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(22),
  //                       border: Border.all(color: kColorBlack, width: 4),
  //                     ),
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(18),
  //                       child: Image.file(
  //                         File(controller.selectedProfileImage.value.path),
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               )
  //             : Image.asset(kImgProfilePlaceholder),
  //       ),
  //     );
  //   });
  // }

  Widget companyNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            // enabled: false,
            controller: controller.companyNameController,
            hintText: kLabelCompanyName,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconBuilding,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isCompanyNameValidate.value == false,
              child: controller.companyNameStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.companyNameStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget companyAddressTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.companyAddressController,
            hintText: kLabelCompanyAddress,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconCompany,
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isCompanyAddressValidate.value == false,
              child: controller.companyAddressStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.companyAddressStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget cityTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: commonTextField(
        controller: controller.cityController,
        hintText: kLabelCity,
        preFixIcon: Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14),
          child: SvgPicture.asset(
            kIconCity,
            // color: controller.fNode.value.hasFocus
            //     ? kColorPrimary
            //     :
            color: kColorGrey9098B1,
          ),
        ),
      ),
    );
  }

  Widget cityDropDown() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 8,
              shadowColor: kColorDropShadow,
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 58,
                padding: EdgeInsets.only(right: 12),
                // decoration: BoxDecoration(
                //     border: Border.all(), borderRadius: BorderRadius.circular(20)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    // decoration: InputDecoration.collapsed(hintText: ''),
                    value: controller.selectedCity.value,
                    borderRadius: BorderRadius.circular(40),
                    isExpanded: true,
                    elevation: 0,
                    alignment: Alignment.center,
                    isDense: true,
                    items: controller.cityList
                        .map(
                          (values) => DropdownMenuItem(
                            value: values,
                            enabled: controller.isStateSelected.value == false
                                ? false
                                : true,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: SvgPicture.asset(
                                      kIconCity,
                                      // color: controller.fNode.value.hasFocus
                                      //     ? kColorPrimary
                                      //     :
                                      color: kColorGrey9098B1,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    values.cityName ?? '',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      controller.selectedCity.value = value!;
                      // controller.setSelected(selectdCategories);
                      //  controller.selectedCategory.value = selectdCategories;
                    },
                    onTap: () {
                      // if (controller.isStateSelected.value == false) {
                      //   Get.find<AlertMessageUtils>()
                      //       .showSnackBar(message: 'Please select state first');
                      // }
                    },
                  ),
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: controller.isCitySelected.value == false,
                child: controller.cityStr.value == ''
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(controller.cityStr.value,
                            style: TextStyles.kH14RedBold400),
                      ),
              );
            }),
          ],
        ),
      );
    });
  }

  Widget stateDropDown() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 8,
              shadowColor: kColorDropShadow,
              borderRadius: BorderRadius.circular(40),
              child: Container(
                height: 58,
                padding: EdgeInsets.only(right: 12),
                // decoration: BoxDecoration(
                //   color: kColorWhite,
                //   border: Border.all(color: kColorWhite),
                //   borderRadius: BorderRadius.circular(40),
                // ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: controller.stateList // <- Here
                        .map(
                          (values) => DropdownMenuItem(
                            value: values,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    kIconState,
                                    // color: controller.fNode.value.hasFocus
                                    //     ? kColorPrimary
                                    //     :
                                    color: kColorGrey9098B1,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    values.stateName ?? '',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      // controller.setSelected(selectdCategories);
                      controller.selectedState.value = value!;
                      if (value.stateName != kHintSelectState) {
                        controller.isStateSelected.value = true;
                        controller.getCityDataFromServer();
                      }
                    },
                    value: controller.selectedState.value,
                    borderRadius: BorderRadius.circular(40),
                    isExpanded: true,
                    //  value: controller.selectedCategory.value,
                    //   hint: const Text(
                    //     'Choose Account Type',
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                  ),
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: controller.isStateSelected.value == false,
                child: controller.stateStr.value == ''
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(controller.stateStr.value,
                            style: TextStyles.kH14RedBold400),
                      ),
              );
            }),
          ],
        ),
      );
    });
  }

  Widget stateTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: commonTextField(
        controller: controller.stateController,
        hintText: kLabelState,
        preFixIcon: Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14),
          child: SvgPicture.asset(
            kIconState,
            // color: controller.fNode.value.hasFocus
            //     ? kColorPrimary
            //     :
            color: kColorGrey9098B1,
          ),
        ),
      ),
    );
  }

  Widget pinCodeTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.pinCodeController,
            keyboardType: TextInputType.phone,
            hintText: kLabelPinCode,
            maxLength: 6,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconPinCode,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isPinCodeValidate.value == false,
              child: controller.pinCodeStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.pinCodeStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget GstTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: commonTextField(
        controller: controller.gstController,
        keyboardType: TextInputType.number,
        hintText: kLabelGST,
        enabled: false,
        preFixIcon: Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 14),
          child: SvgPicture.asset(
            kIconGst,
            // color: controller.fNode.value.hasFocus
            //     ? kColorPrimary
            //     :
            color: kColorGrey9098B1,
          ),
        ),
      ),
    );
  }

  Widget contactPersonTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.contactPersonController,
            hintText: kLabelContactPerson,
            //   enabled: false,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconUser,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isContactPersonValidate.value == false,
              child: controller.contactPersonStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.contactPersonStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget officeNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.officeNumberController,
            hintText: kLabelOfficeNumber,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: SvgPicture.asset(
                kIconPhone,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isOfficeNoValidate.value == false,
              child: controller.officeNoStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.officeNoStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget cellNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 34,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            keyboardType: TextInputType.phone,
            controller: controller.cellNumberController,
            maxLength: 10,
            hintText: kLabelCellNumber,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 18, bottom: 18),
              child: SvgPicture.asset(
                kIconCellPhone,
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isCellNoValidate.value == false,
              child: controller.cellNoStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.cellNoStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget emailIdTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.emailIdController,
            keyboardType: TextInputType.emailAddress,
            hintText: kLabelEmailId,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconMail,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isEmailIdValidate.value == false,
              child: controller.emailIdStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.emailIdStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget accountNoTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.accountNumberController,
            hintText: kLabelAccountNo,
            keyboardType: TextInputType.phone,
            maxLength: 15,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconAccountNo,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isAccountNoValidate.value == false,
              child: controller.accountNoStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.accountNoStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget bankNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.bankNameController,
            hintText: kLabelBankName,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconBankName,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isBankNameValidate.value == false,
              child: controller.bankNameStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.bankNameStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  Widget IFSCnoTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonTextField(
            controller: controller.iFSCnoController,
            hintText: kLabelIFSCno,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 14),
              child: SvgPicture.asset(
                kIconIFSCno,
                // color: controller.fNode.value.hasFocus
                //     ? kColorPrimary
                //     :
                color: kColorGrey9098B1,
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isIFSCNoValidate.value == false,
              child: controller.ifscNoStr.value == ''
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(controller.ifscNoStr.value,
                          style: TextStyles.kH14RedBold400),
                    ),
            );
          }),
        ],
      ),
    );
  }

  openBottomSheet() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.none,
          child: Container(
            height: 100,
            width: Get.width,
            padding: const EdgeInsets.only(left: 18, top: 18),
            decoration: BoxDecoration(
                color: kColorWhite, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.imagePicker(ImageSource.gallery);
                    Get.back();
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.image),
                      const SizedBox(width: 6),
                      const Text(
                        'Select from gallery',
                        style: TextStyles.kH14BlackBold400,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: Get.width,
                  color: kColorD8D8D8,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                GestureDetector(
                  onTap: () {
                    controller.imagePicker(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.camera),
                      const SizedBox(width: 6),
                      const Text(
                        'Take a new photo',
                        style: TextStyles.kH14BlackBold400,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
