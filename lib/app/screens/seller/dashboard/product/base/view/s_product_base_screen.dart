import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/model/response/product_list_model.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/alert_dialog_widget.dart';
import 'package:tsofie/app/widgets/common_empty_list_view.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_product_data_container.dart';
import 'package:tsofie/app/widgets/common_search_textfield.dart';

import '../../../../../../widgets/common_progress_bar_widget.dart';
import '../../../../../../widgets/primary_button.dart';
import '../../../../../../widgets/recent_buyers_listview.dart';
import '../controller/s_product_base_controller.dart';

class SProductBaseScreen extends GetView<SProductBaseController> {
  const SProductBaseScreen({Key? key}) : super(key: key);

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
              //  controller.filterProductList.length==0 ? searchTextField():SizedBox(),
               searchTextField(),
                controller.filterProductList.isEmpty &&
                    controller.isDataLoading.value == false
                    ? Expanded(
                  child: commonEmptyListView(
                    img: kImgEmptyProduct2,
                    txt: kEmptyProduct,
                  ),
                )
                    : productListView(),
              ],
            ),
            Visibility(
              visible: controller.isDataLoading.value,
              child: commonProgressBarWidget(),
            ),
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
      title: kLabelProduct,
      isShowBackButton: false,
      isShowActionWidgets: true,
      actionWidgets: Row(
        children: [
          GestureDetector(
              onTap: () {
                controller.navigateToAddProductScreen();
              },
              child: Image.asset(kIconAdd, height: 25, width: 25)),
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
                        controller.isNewestProductSelected.value = true;
                        controller.isHighToLowSelected.value = false;
                        controller.isLowToHighSelected.value = false;
                      },
                      child: Row(
                        children: [
                          controller.isNewestProductSelected.value
                              ? Icon(Icons.circle)
                              : Icon(Icons.circle_outlined),
                          SizedBox(width: 8),
                          Text(kFilterNewestProduct,
                              style: TextStyles.kH16PrimaryBold700),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        controller.isNewestProductSelected.value = false;
                        controller.isHighToLowSelected.value = true;
                        controller.isLowToHighSelected.value = false;
                      },
                      child: Row(
                        children: [
                          controller.isHighToLowSelected.value
                              ? Icon(Icons.circle)
                              : Icon(Icons.circle_outlined),
                          SizedBox(width: 8),
                          Text(kFilterHighToLow,
                              style: TextStyles.kH16PrimaryBold700),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        controller.isNewestProductSelected.value = false;
                        controller.isHighToLowSelected.value = false;
                        controller.isLowToHighSelected.value = true;
                      },
                      child: Row(
                        children: [
                          controller.isLowToHighSelected.value
                              ? Icon(Icons.circle)
                              : Icon(Icons.circle_outlined),
                          SizedBox(width: 8),
                          Text(kFilterLowToHigh,
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
                              controller.resetProductFilter();
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
  // searchTextField() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
  //     child: commonSearchTextField(
  //       controller: controller.searchController,
  //       preFixIcon: SvgPicture.asset(kIconSearchCoffee),
  //       hintText: kLabelProductName,
  //       onChange: (value) {},
  //     ),
  //   );
  // }

  productListView() {
    return Obx(() {
  return Expanded(
      child:
      // Column(
      //   children: [
          Container(
            margin: EdgeInsets.only(bottom: 16,top: 16),
            child: GridView.builder(
              controller: controller.scrollController,
              itemCount: controller.filterProductList.length,
              // controller: controller.scrollController,
              // itemCount: controller.productList.length,
           //   reverse: true,
           //    shrinkWrap: true,
           //    physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // mainAxisExtent: Get.height * 0.29,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 0,
                  childAspectRatio: (60 / 100)),
              padding: EdgeInsets.only(left: 16),
              itemBuilder: (context, index) {
                var productData = controller.filterProductList[index];
                return GestureDetector(
                  onTap: () {
                    controller.navigateToProductDetailsScreen(index);
                  },
                  // child: sCommonProductDataContainer(
                  //   productImage: kImgDummyBanner,
                  //   productName: 'Wood working Tools.....',
                  //   productOriginalPrice: 533.50,
                  //   productDiscountedPrice: 299.49,
                  //   buyersName: 'Buyers name', productQty: 10,
                  //     isMainProductListing:true
                  // ),
                  child: Stack(
                    children: [
                      commonProductDataContainer(
                        productImage: productData.productImages?[0].image ?? '',
                        productName: productData.name ?? '',
                        categoryName: productData.categoryName ?? '',
                        // productDiscountedPrice: 111,
                        // productOriginalPrice: 222,
                        productOriginalPrice: (controller
                                        .filterProductList[index].productVariants ??
                                    [])
                                .isNotEmpty
                            ? double.parse(
                                '${(controller.filterProductList[index].productVariants?[0].price ?? 0.0)}')
                            : 0,
                        // 533.50
                        productDiscountedPrice: (controller
                                        .filterProductList[index].productVariants ??
                                    [])
                                .isNotEmpty
                            ?  (double.parse(productData.productVariants?[0].discountedPrice??'0'))
                            : 0,
                        isMainProductListing: true,
                        isShowFavIcon: false,
                        isFav: true,
                        isShowDelete: productData.isOrderPlaced==false ? true :false,
                        isDelete: true,
                        onDeleteTap: (){
                          deleteProductDialog(productData: controller.filterProductList[index]);
                        },
                        onFavTap: () {},
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     deleteProductDialog(productData: controller.productList[index]);
                      //   },
                      //   child: Align(
                      //     alignment: Alignment.bottomRight,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 22, right: 38),
                      //       child: SvgPicture.asset(kIconClose, color: kColorRed),
                      //      // child: SvgPicture.asset(kIconDelete, color: kColorRed),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          ),
      //     // when the _loadMore function is running
      //     if (controller.isLoadMoreRunning == true)
      //       const Padding(
      //         padding: EdgeInsets.only(top: 10, bottom: 40),
      //         child: Center(
      //           child: CircularProgressIndicator(),
      //         ),
      //       ),
      //
      //     // When nothing else to load
      //     if (controller.hasNextPage == false)
      //       Container(
      //         padding: const EdgeInsets.only(top: 30, bottom: 40),
      //         color: Colors.amber,
      //         child: const Center(
      //           child: Text('You have fetched all of the content'),
      //         ),
      //       ),
      //   ],
      // ),
    );
});
  }
  searchTextField() {

    return  Obx(() {
  return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: (controller.filterProductList.length>4) ?Row(
        children: [
          Expanded(
            child: commonSearchTextField(
              controller: controller.searchController,
              preFixIcon: SvgPicture.asset(kIconSearchCoffee),
              hintText: kLabelProductName,
              onChange: (value) {
                controller.searchProductText.value = value.trim();
                if (value.trim().isNotEmpty && value.trim().length >= 3) {
                  // controller.isDataLoading.value = true;
                  controller.filterProductList.clear();
                  controller.getProductListFromServer();
                  controller.isNewestProductSelected.value = true;
                  controller.isHighToLowSelected.value = false;
                  controller.isLowToHighSelected.value = false;
                }
                if (value.trim().isEmpty) {
                  controller.isDataLoading.value = true;
                  controller.filterProductList.clear();
                  controller.getProductListFromServer();
                  controller.isNewestProductSelected.value = true;
                  controller.isHighToLowSelected.value = false;
                  controller.isLowToHighSelected.value = false;
                }
              },
            ),
          ),
        ],
      ):SizedBox() ,
    );
});
  }
  void deleteProductDialog({required Products productData}) {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return alertDialogWidget(
            title: productData.name ?? '',
            subTitle: productData.categoryName ?? '',
            icon: kIconDelete2,
            onSuccessTap: () {
              controller.deleteProductApiCall(productData.id??0);
            },
            onCancelTap: () {
              Get.back();
            });
      },
    );
  }
}
