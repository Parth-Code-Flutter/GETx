import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/location/base/controller/b_base_location_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/alert_dialog_widget.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BBaseLocationScreen extends GetView<BBaseLocationController> {
  const BBaseLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Column(
          children: [
            headerWidget(),
            locationListView(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: primaryButton(
                buttonTxt: kLabelAddLocation,
                onPress: () {
                  controller.navigateToAddLocationScreen();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      title: kLabelLocation,
      isShowBackButton: true,
      onBackTap: () {
        Get.back();
      },
      isShowActionWidgets: true,
      actionWidgets: GestureDetector(
        onTap: () {
          controller.navigateToSearchLocationScreen();
        },
        child: SvgPicture.asset(kIconSearch),
      ),
    );
  }

  locationListView() {
    return SizedBox(
      height: Get.height * 0.75,
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.tempLocationList.length,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            var locationData = controller.tempLocationList[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              padding: const EdgeInsets.only(
                  left: 16, bottom: 10, top: 10, right: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    locationData.isDefault ? kColorPrimary : Colors.transparent,
                border: Border.all(
                  color: kColorPrimary,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locationData.state,
                          style: locationData.isDefault
                              ? TextStyles.kH20WhiteBold700
                              : TextStyles.kH20PrimaryBold700),
                      SizedBox(height: 4),
                      Text(locationData.city,
                          style: locationData.isDefault
                              ? TextStyles.kH14WhiteBold400
                              : TextStyles.kH14PrimaryBold400),
                    ],
                  ),
                  PopupMenuButton(
                    child: Image.asset(kIconContextMenu,
                        color: locationData.isDefault
                            ? kColorWhite
                            : kColorPrimary,
                        height: 20),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: SizedBox(
                            width: controller.popupMenuItemWidth,
                            child: Row(
                              children: [
                                SvgPicture.asset(kIconEdit),
                                SizedBox(width: 10),
                                Text(
                                  kLabelEdit,
                                  style: TextStyles.kH12PrimaryTextBold700,
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          enabled: true,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              openDeleteDialogBox();
                            },
                            child: SizedBox(
                              width: controller.popupMenuItemWidth,
                              child: Row(
                                children: [
                                  SvgPicture.asset(kIconDelete),
                                  SizedBox(width: 10),
                                  Text(
                                    kLabelDelete,
                                    style: TextStyles.kH12PrimaryTextBold700,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            controller.updateDefaultLocation(index);
                          },
                          child: SizedBox(
                            width: controller.popupMenuItemWidth,
                            child: Row(
                              children: [
                                SvgPicture.asset(kIconSetAsDefault),
                                SizedBox(width: 10),
                                Text(
                                  kLabelSetAsDefault,
                                  style: TextStyles.kH12PrimaryTextBold700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void openDeleteDialogBox() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return alertDialogWidget(
          title: kLabelDeleteNote,
          subTitle: kLabelAreYouSureYouWantToDelete,
          icon: kIconDelete2,
          onSuccessTap: () {},
          onCancelTap: () {
            Get.back();
          },
        );
      },
    );
  }
}
