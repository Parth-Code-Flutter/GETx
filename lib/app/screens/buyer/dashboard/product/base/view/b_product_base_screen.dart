import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/controller/b_product_base_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_empty_list_view.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_product_data_container.dart';
import 'package:tsofie/app/widgets/common_progress_bar_widget.dart';
import 'package:tsofie/app/widgets/common_search_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BProductBaseScreen extends GetView<BProductBaseController> {
  const BProductBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kColorBackground,
        body: Obx(() {
          return Stack(
            children: [
              Column(
                children: [
                  headerWidget(),
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
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {},
      title: kLabelProduct,
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
          const SizedBox(width: 14),
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
      // child: (controller.filterProductList.length > 4)
      child: (controller.filterProductList.isNotEmpty)  ||  controller.isDataLoading.value == false
          ? Row(
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
                Obx(() {
                  return GestureDetector(
                    onTap: () {
                      controller.navigateToLocationSearchScreen();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(left: 6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: controller.locationData.value.state == '' ||
                                (controller.locationData.value.state ?? '')
                                    .isEmpty
                            ? kColorWhite
                            : kColorPrimary,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: kColorPrimary),
                      ),
                      child: Text(
                        'GO',
                        style: controller.locationData.value.state == '' ||
                                (controller.locationData.value.state ?? '')
                                    .isEmpty
                            ? TextStyles.kH16PrimaryBold700
                            : TextStyles.kH16WhiteBold700,
                      ),
                    ),
                  );
                }),
              ],
            )
          : SizedBox(),
    );
  }

  productListView() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 14, top: 14),
        child: GridView.builder(
          controller: controller.scrollController.value,
          itemCount: controller.filterProductList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: Get.height * 0.29,
              crossAxisSpacing: 6,
              mainAxisSpacing: 0,
              childAspectRatio: (58 / 100)),
          // 60/100
          padding: const EdgeInsets.only(left: 16),
          itemBuilder: (context, index) {
            var productData = controller.filterProductList[index];
            return GestureDetector(
              onTap: () {
                controller.navigateToProductDetailsScreen(index);
              },
              child: commonProductDataContainer(
                productImage: productData.productImages?[0].image ?? '',
                productName: productData.name ?? '',
                categoryName: productData.categoryName ?? '',
                productOriginalPrice:
                    (productData.productVariants ?? []).isNotEmpty
                        ? double.parse(
                            (productData.productVariants?[0].price ?? '0.0'))
                        : 0,
                // 533.50
                productDiscountedPrice:
                    (productData.productVariants ?? []).isNotEmpty
                        ? double.parse(
                            (productData.productVariants?[0].discountedPrice ??
                                '0.0'))
                        : 0,
                // 299.49
                isMainProductListing: true,
                isShowFavIcon: true,
                isFav: productData.isFavourite ?? false,
                onFavTap: () {
                  controller.favUnFavApiCall(index: index);
                },
              ),
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
}
