import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_order_data_container.dart';
import 'package:tsofie/app/widgets/common_search_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

import '../../../../../../widgets/common_empty_list_view.dart';
import '../../../../../../widgets/common_progress_bar_widget.dart';
import '../controller/s_order_list_controller.dart';

class SOrderBaseScreen extends GetView<SOrderBaseController> {
  const SOrderBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kColorBackground,
      body: Obx(() {
        return Stack(
          children: [
            Column(
              children: [
                headerWidget(),
                Obx(() {
                  return Visibility(
                    visible: controller.recentOrderResponseDataList.isNotEmpty,
                    child: searchTextField(),
                  );
                }),
                SizedBox(
                  height: 15,
                ),
                controller.recentOrderResponseDataList.isEmpty &&
                        controller.isDataLoading.value == false
                    ? Expanded(
                        child: commonEmptyListView(
                          img: kImgEmptyProduct2,
                          txt: kEmptyOrder,
                        ),
                      )
                    : orderListView(),
              ],
            ),
            // Visibility(
            //   visible: controller.isDataLoading.value,
            //   child: commonProgressBarWidget(),
            // ),
          ],
        );
      }),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelMyOrdersList,
      isShowBackButton: false,
      isShowActionWidgets: true,
      actionWidgets: Row(
        children: [
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
                physics: BouncingScrollPhysics(),
                itemCount: controller.searchText.isNotEmpty
                    ? controller.searchOrdersList.length
                    : controller.recentOrderResponseDataList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var orderData = controller.searchText.isNotEmpty
                      ? controller.searchOrdersList[index]
                      : controller.recentOrderResponseDataList[index];
                  return GestureDetector(
                    onTap: () {
                      controller.navigateToOrderDetailsScreen(index);
                    },
                    child: commonOrderDataContainer(
                        productImage: orderData.productImages?[0].image ?? '',
                        productName: orderData.productName ?? '',
                        productOriginalPrice: double.parse(
                            orderData.productVariantDiscountedPrice ?? '0'),
                        qty: orderData.orderProductVariantQuantity ?? 0,
                        orderStatus: orderData.orderStatus ?? '',
                        orderId: orderData.orderNumber ?? '',
                        orderDate: orderData.orderCreatedAt ?? ''),
                  );
                },
              ),
      ),
    );
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
