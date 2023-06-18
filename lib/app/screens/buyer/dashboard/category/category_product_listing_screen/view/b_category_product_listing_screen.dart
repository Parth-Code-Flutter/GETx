import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/category/category_product_listing_screen/controller/b_category_product_listing_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_empty_list_view.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_product_data_container.dart';
import 'package:tsofie/app/widgets/common_progress_bar_widget.dart';
import 'package:tsofie/app/widgets/common_search_textfield.dart';

class BCategoryProductListingScreen
    extends GetView<BCategoryProductListingController> {
  BCategoryProductListingScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  controller.productList.isEmpty &&
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
      onBackTap: () {
        Get.back();
      },
      title: kLabelProduct,
      isShowBackButton: true,
    );
  }

  searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      // child: (controller.productList.length>4) ? Row(
      child: (controller.productList.isNotEmpty) ||
              controller.isDataLoading.value == false
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
                        controller.productList.clear();
                        controller.getProductListFromServer();
                      }
                      if (value.trim().isEmpty) {
                        controller.isDataLoading.value = true;
                        controller.productList.clear();
                        controller.getProductListFromServer();
                      }
                    },
                  ),
                ),
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
          itemCount: controller.productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: Get.height * 0.29,
              crossAxisSpacing: 6,
              mainAxisSpacing: 0,
              childAspectRatio: (58 / 100)),
          // 60/100
          padding: const EdgeInsets.only(left: 16),
          itemBuilder: (context, index) {
            var productData = controller.productList[index];
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
}
