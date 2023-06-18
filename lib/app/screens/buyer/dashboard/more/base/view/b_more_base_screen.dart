import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/base/controller/b_more_base_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/alert_dialog_widget.dart';
import 'package:tsofie/app/widgets/common_progress_bar_widget.dart';
import 'package:tsofie/app/widgets/primary_button.dart';
import 'package:tsofie/app/widgets/profile_yello_bg.dart';

class BMoreBaseScreen extends GetView<BMoreBaseController> {
  const BMoreBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              headerWidget(),
              settingsDataListView(),
            ],
          ),
          Visibility(
            visible: controller.isDataLoading.value,
            child: commonProgressBarWidget(),
          ),
        ],
      ),
    );
  }

  Widget headerWidget() {
    return Obx(() {
      return Container(
        height: 155,
        width: Get.width,
        padding: const EdgeInsets.only(top: 24, bottom: 60),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              kImgAppBarBG,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          children: [
            profileImageContainer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.userPrefData.value.userName ?? '',
                    style: TextStyles.kH18PrimaryBold700),
                const SizedBox(height: 4),
                Text(controller.userPrefData.value.mobileNumber ?? '',
                    style: TextStyles.kH14Grey9098B1Bold400),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget profileImageContainer() {
    return Obx(() {
      return (controller.userPrefData.value.userProfilePic ?? '').isNotEmpty
          ? SizedBox(
              width: 130,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  profileYellowBG(),
                  Positioned(
                    left: 20,
                    child: Container(
                      height: 82,
                      width: 82,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: kColorBlack, width: 4),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.network(
                          controller.userPrefData.value.userProfilePic ?? '',
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              kImgProfilePlaceholder,
                              width: 120,
                              height: 80,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Image.asset(
              kImgProfilePlaceholder,
              width: 120,
              height: 80,
            );
    });
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
                    children: const [
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

  Widget settingsDataListView() {
    return ListView.builder(
      itemCount: controller.settingsDataList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemBuilder: (context, index) {
        var settingsData = controller.settingsDataList[index];
        return InkWell(
          onTap: () {
            if (index == 8) {
              openLogoutDialogBox();
            } else if (index == 5) {
              openSelectLanguageDialogBox();
            } else {
              controller.manageNavigation(index);
            }
          },
          child: Row(
            children: [
              SvgPicture.asset(settingsData.icon,
                  color: kColorGrey9098B1, height: 18, width: 18),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(settingsData.name,
                            style: TextStyles.kH16PrimaryBold700),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: SvgPicture.asset(kIconForward, height: 12),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: kColorGreyCBCBCB,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openLogoutDialogBox() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return alertDialogWidget(
          title: kLabelLogout,
          subTitle: kLabelAreYouSureYouWantToLogout,
          icon: kIconLogoutLarge,
          isSvg: true,
          onSuccessTap: () {
            controller.clearAllStorageData();
          },
          onCancelTap: () {
            Get.back();
          },
        );
      },
    );
  }

  void openSelectLanguageDialogBox() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: Get.width,
                height: 85,
                decoration: const BoxDecoration(color: kColorBackground),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        padding: const EdgeInsets.only(right: 8, top: 8),
                        visualDensity:
                            const VisualDensity(vertical: -4, horizontal: -4),
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    const Text(kLabelSelectLanguage,
                        style: TextStyles.kH22PrimaryBold700),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Theme(
                            data:
                                ThemeData(unselectedWidgetColor: kColorD8D8D8),
                            child: Checkbox(
                              value: controller.isEngSelected.value,
                              onChanged: (value) {
                                controller.changeLanguage(0);
                              },
                              activeColor: kColorPrimary,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity:
                                  const VisualDensity(vertical: -4, horizontal: -4),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            kLabelEnglish,
                            style: TextStyles.kH16PrimaryBold700,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Theme(
                            data:
                                ThemeData(unselectedWidgetColor: kColorD8D8D8),
                            child: Checkbox(
                              value: controller.isHindiSelected.value,
                              onChanged: (value) {
                                controller.changeLanguage(1);
                              },
                              activeColor: kColorPrimary,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              visualDensity:
                                  const VisualDensity(vertical: -4, horizontal: -4),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            kLabelHindi,
                            style: TextStyles.kH16PrimaryBold700,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: primaryButton(
                  onPress: () {},
                  buttonTxt: kLabelSave,
                  height: 40,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
