import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/edit_profile/controller/b_edit_profile_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';
import 'package:tsofie/app/widgets/profile_yello_bg.dart';
import 'package:tsofie/app/widgets/while_top_widget.dart';

class BEditProfileScreen extends GetView<BEditProfileController> {
  const BEditProfileScreen({Key? key}) : super(key: key);

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
              children: [
                commonHeaderWidget(
                    onBackTap: () {
                      Get.back(result: false);
                    },
                    title: kLabelEditProfile),
                profileImageContainer(),
                userNameTextField(),
                mobileNumberTextField(),
                userEmailTextField(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
                  child: primaryButton(
                      onPress: () {
                        controller.validateUserInput();
                      },
                      buttonTxt: 'Update'),
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
              : controller.userPrefData.value.userProfilePic != null && controller.userPrefData.value.userProfilePic!=''
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
                            child: CachedNetworkImage(
                              imageUrl: controller.userPrefData.value.userProfilePic ?? '',
                              progressIndicatorBuilder: (context, url, progress) {
                                return SpinKitFadingCircle(
                                  color: kColorPrimary,
                                );
                              },
                              errorWidget: (context, url, error) {
                                return Icon(Icons.error);
                              },
                            ),
                            // Image.network(
                            //   controller.userPrefData.value.userProfilePic ?? '',
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                        )
                      ],
                    )
                  : Image.asset(kImgProfilePlaceholder),
        ),
      );
    });
  }

  Widget userNameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34),
      child: commonTextField(
        controller: controller.userNameController,
        hintText: kLabelUserName,
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
    );
  }

  Widget mobileNumberTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 16),
      child: commonTextField(
        controller: controller.mobileController,
        hintText: kLabelYourMobileNumber,
        maxLength: 10,
        keyboardType: TextInputType.number,
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
    );
  }

  Widget userEmailTextField() {

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonTextField(
              controller: controller.emailController,
              hintText: kLabelEnterYourEmail,
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
                visible: controller.isUserEmailValidate.value == false,
                child: controller.userEmailStr.value == ''
                    ? Container()
                    : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(controller.userEmailStr.value,
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
            padding: EdgeInsets.only(left: 18, top: 18),
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
                      Icon(Icons.image),
                      SizedBox(width: 6),
                      Text(
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
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                GestureDetector(
                  onTap: () {
                    controller.imagePicker(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(width: 6),
                      Text(
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
