import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/shipping_addresses/controller/shipping_addresses_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/alert_dialog_widget.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BShippingAddressesScreen extends GetView<BShippingAddressesController> {
  BShippingAddressesScreen({Key? key}) : super(key: key) {
    final intentData =Get.arguments ;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Obx(() {
          return Column(
            children: [
              commonHeaderWidget(
                onBackTap: () {
                  Get.back();
                },
                title: kLabelShippingAddresses,
                isShowActionWidgets: true,
                actionWidgets: InkWell(
                  onTap: () {
                    controller.navigateToAddShippingDetailsScreen();
                  },
                  child: Image.asset(kIconAdd, width: 26, height: 26),
                ),
              ),
              controller.shippingAddressList.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text('No Records Found'),
                      ),
                    )
                  : addressesListView(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: primaryButton(
                    onPress: () {
                      if (controller.shippingAddressList.isEmpty) {
                        controller.navigateToAddShippingDetailsScreen();
                      }
                      else{
                        controller.navigateToOrderSummaryScreen();
                      }
                    },
                    buttonTxt: controller.shippingAddressList.isEmpty
                        ? kLabelAddShippingAddresses
                        : kLabelDeliverHere),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget addressesListView() {
    return Expanded(
      // height: Get.height * 0.7,
      child: Obx(() {
        return ListView.builder(
          itemCount: controller.shippingAddressList.length,
          padding: EdgeInsets.only(top: 16),
          itemBuilder: (context, index) {
            var shippingData = controller.shippingAddressList[index];
            return InkWell(
              onTap: () {
                controller.updateDefaultShippingAddress(index);
              },
              child: Container(
                padding: EdgeInsets.all(14),
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 18),
                decoration: BoxDecoration(
                  color: (shippingData.isDefault ?? false)
                      ? kColorPrimary
                      : kColorWhite,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kColorPrimary),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      margin: EdgeInsets.only(top: 2, right: 6),
                      decoration: BoxDecoration(
                        color: (shippingData.isDefault ?? false)
                            ? kColorWhite
                            : kColorPrimary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),

                    /// address and edit or delete icons
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  '${shippingData.city ?? ''}, ${shippingData.state ?? ''}',
                                  style: (shippingData.isDefault ?? false)
                                      ? TextStyles.kH16WhiteBold700
                                      : TextStyles.kH16PrimaryBold700,
                                  maxLines: 2,
                                ),
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller
                                          .navigateToAddShippingDetailsScreen(
                                              isForEditAddress: true,
                                              shippingData: shippingData);
                                    },
                                    child: SvgPicture.asset(kIconEdit,
                                        color: (shippingData.isDefault ?? false)
                                            ? kColorWhite
                                            : kColorPrimary),
                                  ),
                                  // SizedBox(width: 6),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     openDeleteDialogBox(index, '', 0);
                                  //   },
                                  //   child: SvgPicture.asset(kIconDelete,
                                  //       color: kColorPrimary),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            width: Get.width * 0.8,
                            margin: EdgeInsets.only(top: 4),
                            child: Text(
                              shippingData.streetAddress ?? '',
                              style: (shippingData.isDefault ?? false)
                                  ? TextStyles.kH14WhiteBold400
                                  : TextStyles.kH14PrimaryBold400,
                              maxLines: 3,
                            ),
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
      }),
    );
  }

  void openDeleteDialogBox(int index, String productName, int cartItemID) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return alertDialogWidget(
          title: productName,
          // title: kLabelDeleteNote,
          subTitle: kLabelAreYouSureYouWantToDelete,
          icon: kIconDelete2,
          onSuccessTap: () {
            Get.back();
            // controller.removeCartItemApiCall(cartItemID, index);
          },
          onCancelTap: () {
            Get.back();
          },
        );
      },
    );
  }
}
