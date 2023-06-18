import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/favourite/controller/b_fav_controller.dart';
import 'package:tsofie/app/widgets/common_empty_list_view.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_product_data_container.dart';

class BFavScreen extends GetView<BFavController> {
  BFavScreen({Key? key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getFavouriteProductsListFromServer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Column(
          children: [
            headerWidget(),
            Obx(() {
              return Visibility(
                visible: controller.favouriteProductList.isEmpty,
                child: Container(height: Get.height*.8,child: commonEmptyListView(img: kImgEmptyFav, txt: kEmptyFav)),
              );
            }),
            productListView(),
          ],
        ),
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelFavourite,
      isShowBackButton: true,
    );
  }

  Widget productListView() {
    return Obx(() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 16, top: 24),
          child: GridView.builder(
            itemCount: controller.favouriteProductList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisExtent: Get.height * 0.29,
                crossAxisSpacing: 6,
                mainAxisSpacing: 0,
                childAspectRatio: (58 / 100)),
            padding: EdgeInsets.only(left: 16),
            itemBuilder: (context, index) {
              var favProductData = controller.favouriteProductList[index];
              return Visibility(
                visible: favProductData.isFavourite==true,
                child: GestureDetector(
                  onTap: () {
                    controller.navigateToProductDetailsScreen(index);
                  },
                  child: commonProductDataContainer(
                    productImage: favProductData.productImages?[0].image??'',
                    productName: favProductData.name ?? '',
                    categoryName: favProductData.categoryName ?? '',
                    productOriginalPrice: (favProductData.productVariants ?? [])
                        .isNotEmpty
                        ? double.parse((favProductData.productVariants?[0].price ?? '0.0'))
                        : 0,
                    // 533.50
                    productDiscountedPrice: (favProductData.productVariants ?? [])
                        .isNotEmpty
                        ? double.parse((favProductData.productVariants?[0].discountedPrice ?? '0.0'))
                        : 0,
                    // 299.49
                    isMainProductListing: true,
                    isShowFavIcon: true,
                    isFav: favProductData.isFavourite ?? false,
                    onFavTap: () {
                      controller.favUnFavApiCall(index: index);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
