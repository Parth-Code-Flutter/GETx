import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/screens/buyer/cart/shipping_details/base/controller/b_shipping_details_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BShippingDetailsScreen extends GetView<BShippingDetailsController> {
  BShippingDetailsScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: false);
        return false;
      },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: kColorBackground,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  headerWidget(),
                  SizedBox(
                    height: Get.height * .85,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(height: 22),
                          // cityTextField(),
                          stateDropDown(),
                          const SizedBox(height: 22),
                          // stateTextField(),
                          cityDropDown(),
                          const SizedBox(height: 22),
                          pinCodeTextField(),
                          const SizedBox(height: 22),
                          addressTextField(),
                          const Spacer(),
                          Obx(() {
                            return primaryButton(
                                onPress: () {
                                  controller.validateUserInputs();
                                  // Get.toNamed(kRouteBOrderSummaryScreen);
                                },
                                buttonTxt: controller.isForEdit.value
                                    ? kLabelUpdate
                                    : kLabelSave);
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return commonHeaderWidget(
        onBackTap: () {
          Get.back(result: false);
        },
        title: kLabelShippingDetails);
  }

  //
  // Widget cityTextField() {
  //   return commonTextField(
  //     controller: controller.cityController,
  //     hintText: kLabelCity,
  //     preFixIcon: Padding(
  //       padding:
  //           const EdgeInsets.only(left: 12, bottom: 12, top: 12, right: 12),
  //       child: SvgPicture.asset(kIconCity),
  //     ),
  //   );
  // }

  // Widget stateTextField() {
  //   return commonTextField(
  //     controller: controller.stateController,
  //     hintText: kLabelState,
  //     preFixIcon: Padding(
  //       padding:
  //           const EdgeInsets.only(left: 12, bottom: 12, top: 12, right: 12),
  //       child: SvgPicture.asset(kIconState),
  //     ),
  //   );
  // }

  Widget stateDropDown() {
    return Obx(() {
      return Column(
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
                        (values) =>
                        DropdownMenuItem(
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
      );
    });
  }

  Widget cityDropDown() {
    return Obx(() {
      return Column(
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
                        (values) =>
                        DropdownMenuItem(
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
      );
    });
  }

  Widget pinCodeTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTextField(
          controller: controller.pinCodeController,
          hintText: kLabelPinCode,
          maxLength: 6,
          keyboardType: TextInputType.phone,
          preFixIcon: Padding(
            padding:
            const EdgeInsets.only(left: 6, bottom: 0, top: 0, right: 6),
            child: SvgPicture.asset(kIconPinCode),
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
    );
  }

  Widget addressTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTextField(
          controller: controller.shippingAddressController,
          hintText:
          'E-202, Rudram Icon, opp. Lambada house, Gota Cross Road, Ahmdabad.',
          preFixIcon: Padding(
            padding:
            const EdgeInsets.only(left: 12, bottom: 12, top: 12, right: 12),
            child: SvgPicture.asset(
              kIconLocation,
              color: kColorGrey9098B1,
            ),
          ),
          maxLines: 4,
        ),
        Obx(() {
          return Visibility(
            visible: controller.isShippingAddressValidate.value == false,
            child: controller.shippingAddressStr.value == ''
                ? Container()
                : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(controller.shippingAddressStr.value,
                  style: TextStyles.kH14RedBold400),
            ),
          );
        }),
      ],
    );
  }
}
