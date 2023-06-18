import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/home/controller/b_home_controller.dart';
import 'package:tsofie/app/utils/return_discounted_product_price.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_image_slider.dart';
import 'package:tsofie/app/widgets/common_product_data_container.dart';

class BHomeScreen extends GetView<BHomeController> {
  const BHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            locationAndCartWidgets(),
            bannerSliderWidget(),
            categoriesListView(),
            Obx(
                  () {
                return Visibility(
                  visible: controller.recentOrdersList.isNotEmpty,
                  child: recentOrderListView(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget locationAndCartWidgets() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(bottom: 30, top: 6),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              kImgAppBarBG,
            ),
            fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Image.asset(kImgAppHorizontalLogo, width: 105),
            ),
            // Row(
            //   children: [
            //     SvgPicture.asset(kIconLocation),
            //     SizedBox(width: 4),
            //     Text(controller.defaultLocation.value,
            //         style: TextStyles.kH12PrimaryTextBold400),
            //   ],
            // ),
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
                      visible: controller.cartCount.value!=0,
                      child: Positioned(
                        left: 16,
                        child: Container(
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: kColorRedFF0000,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child:  Center(
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
          ],
        ),
      ),
    );
  }

  bannerSliderWidget() {
    return Obx(
          () {
        return Visibility(
          visible: controller.bannerImageListResponseDataList.length==0 ? false : true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: commonImageSlider(
              bannerList: controller.bannerImageListResponseDataList,
              // imageList: controller.bannerImageListResponseDataList.image ?? '',
              isShowForwardOrBackButton: true,
              currentIndex: controller.current.value,
              imageSliderController: controller.imageSliderController.value,
              isShowBannersList: true,
              callBack: (values) {
                controller.current.value = values;
              },
            ),
          ),
        );
      },
    );
  }

  categoriesListView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(kLabelCategory, style: TextStyles.kH14PrimaryBold700),
              GestureDetector(
                onTap: () {
                  controller.navigateToAllCategoryListingScreen();
                },
                child: Text(kLabelMore, style: TextStyles.kH14PrimaryBold700),
              ),
            ],
          ),
          SizedBox(
            height: 140,
            child: Obx(() {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 12, right: 12),
                shrinkWrap: true,
                itemCount: controller.categoriesDataList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.navigateToCatProductListingScreen(
                                controller.categoriesDataList[index].id ?? 0);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CircleAvatar(
                              radius: 38,
                              backgroundColor: kColorWhite,
                              child: CachedNetworkImage(
                                height: 76,
                                fit: BoxFit.fill,
                                imageUrl:
                                controller.categoriesDataList[index].image ??
                                    '',
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return SpinKitFadingCircle(
                                    color: kColorPrimary,
                                  );
                                },
                                errorWidget: (context, url, error) {
                                  return Icon(Icons.error);
                                },
                              ),
                              // NetworkImage(
                              //   controller.categoriesDataList[index].image ?? '',
                              // ),

                              // child: Image.network(
                              //   controller.categoriesDataList[index].image ?? '',
                              //   height: 27,
                              //   width: 27,
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(controller.categoriesDataList[index].name ?? '',
                            style: TextStyles.kH14PrimaryBold700),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget recentOrderListView() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(kLabelRecentOrder, style: TextStyles.kH14PrimaryBold700),
              GestureDetector(
                  onTap: () {
                    controller.navigateToOrderListingScreen();
                  },
                  child: Text(kLabelSeeMore,
                      style: TextStyles.kH14Grey9098B1Bold700)),
            ],
          ),
          Obx(() {
            return Container(
              height: Get.height * 0.3,
              margin: const EdgeInsets.only(top: 24),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.recentOrdersList.length,
                itemBuilder: (context, index) {
                  var recentOrderData = controller.recentOrdersList[index];
                  return InkWell(
                    onTap: () {
                      controller.navigateToOrderDetailsScreen(
                          orderData: recentOrderData);
                    },
                    child: commonProductDataContainer(
                      productImage:
                      (recentOrderData.productImages ?? []).isEmpty
                          ? ''
                          : recentOrderData.productImages?[0].image ?? '',
                      productName: recentOrderData.productName ?? '',
                      categoryName: recentOrderData.categoryName ?? '',
                      productOriginalPrice:
                      double.parse(recentOrderData.productVariantPrice ?? '0'),
                      productDiscountedPrice:  double.parse(
                              recentOrderData.productVariantDiscountedPrice ??
                                  '0'),
                      isShowFavIcon: false,
                      isFav: controller.tempBool.value,
                      onFavTap: () {
                        controller.tempBool.value = !controller.tempBool.value;
                      },
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
