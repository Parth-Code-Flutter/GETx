import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/base/controller/b_order_base_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_empty_list_view.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_order_data_container.dart';
import 'package:tsofie/app/widgets/common_search_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BOrderBaseScreen extends GetView<BOrderBaseController> {
  const BOrderBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: Column(
        children: [
          headerWidget(),
          Obx(() {
            return Visibility(
              visible: controller.filterOrdersList.isEmpty,
              child: Container(
                height: Get.height * .7,
                child:
                    commonEmptyListView(img: kImgEmptyOrder, txt: kEmptyOrder),
              ),
            );
          }),
          Obx(() {
            return Visibility(
              visible: controller.filterOrdersList.isNotEmpty,
              child: searchTextField(),
            );
          }),
          orderListView(),
        ],
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {},
      title: kLabelMyOrders,
      isShowBackButton: false,
      isShowActionWidgets: true,
      actionWidgets: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.navigateToMyCartScreen();
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(kIconCart, height: 25, width: 25),
                Obx(() {
                  return Visibility(
                    visible: controller.cartCount.value != 0,
                    child: Positioned(
                      left: 16,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: kColorRedFF0000,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                            child: Text(
                          controller.cartCount.value.toString(),
                          style: TextStyles.kH10WhiteBold400,
                        )),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(width: 14),
          GestureDetector(
              onTap: () {
                showFilterBottomModal();
              },
              child: SvgPicture.asset(kIconFilter, height: 25, width: 25)),
        ],
      ),
    );
  }

  searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: commonSearchTextField(
        controller: controller.orderSearchController,
        preFixIcon: SvgPicture.asset(kIconSearchCoffee),
        hintText: kLabelOrderName,
        onChange: (value) {
          controller.searchText.value =
              controller.orderSearchController.text.trim();
          if (controller.searchText.value.isEmpty) {
            controller.searchOrdersList.clear();
          } else {
            controller.searchOrder();
          }
        },
      ),
    );
  }

  orderListView() {
    return Obx(() {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: controller.searchText.isNotEmpty &&
                  controller.searchOrdersList.isEmpty
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: Get.height * .65,
                    child: commonEmptyListView(
                        img: kImgEmptyOrder, txt: kEmptyOrder),
                  ),
                )
              : ListView.builder(
                  itemCount: controller.searchText.isNotEmpty
                      ? controller.searchOrdersList.length
                      : controller.filterOrdersList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var orderData = controller.searchText.isNotEmpty
                        ? controller.searchOrdersList[index]
                        : controller.filterOrdersList[index];
                    return GestureDetector(
                      onTap: () {
                        controller.navigateToOrderDetailsScreen(
                            orderData: orderData);
                      },
                      child: commonOrderDataContainer(
                          productImage: (orderData.productImages ?? []).isEmpty
                              ? ''
                              : orderData.productImages?[0].image ?? '',
                          productName: orderData.productName ?? '',
                          productOriginalPrice: double.parse(
                              orderData.orderDetails?.grandTotalPrice ?? '0'),
                          qty: orderData.quantity ?? 0,
                          orderStatus:
                              orderData.orderDetails?.orderStatus ?? '',
                          orderId: orderData.orderDetails?.orderNumber ?? '',
                          orderDate: orderData.orderDetails?.orderStatusDate??''),
                    );
                  },
                ),
        ),
      );
    });
  }

  void showFilterBottomModal() {
    Get.bottomSheet(
      isDismissible: false,
      backgroundColor: kColorWhite,
      Container(
        decoration: const BoxDecoration(
          color: kColorBackground,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: Obx(() {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                color: kColorBackground,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(kFilterSelectFilter,
                        style: TextStyles.kH20PrimaryBold700),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                color: kColorWhite,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        controller.isLatestSelected.value = true;
                        controller.isOldestSelected.value = false;
                      },
                      child: Row(
                        children: [
                          controller.isLatestSelected.value
                              ? Icon(Icons.circle)
                              : Icon(Icons.circle_outlined),
                          SizedBox(width: 8),
                          Text(kFilterLatestOrders,
                              style: TextStyles.kH16PrimaryBold700),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        controller.isLatestSelected.value = false;
                        controller.isOldestSelected.value = true;
                      },
                      child: Row(
                        children: [
                          controller.isOldestSelected.value
                              ? Icon(Icons.circle)
                              : Icon(Icons.circle_outlined),
                          SizedBox(width: 8),
                          Text(kFilterOldestOrders,
                              style: TextStyles.kH16PrimaryBold700),
                        ],
                      ),
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        primaryButton(
                            onPress: () {
                              Get.back();
                              controller.applyFilter();
                            },
                            buttonTxt: kLabelApply,
                            width: 100,
                            height: 40),
                        primaryButton(
                            onPress: () {
                              Get.back();
                              controller.resetOrderFilter();
                            },
                            buttonTxt: kLabelReset,
                            width: 100,
                            height: 40),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
