import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_image_slider.dart';
import '../../../../../widgets/common_search_textfield.dart';
import '../../../../../widgets/recent_buyers_listview.dart';
import '../controller/s_home_controller.dart';

class SHomeScreen extends GetView<SHomeController> {
  const SHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorBackground,
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tiltleWidgets(),
              // searchLocationTextField(),
              bannerSliderWidget(),
              controller.recentBuyersResponseDataList.isNotEmpty
                  ? recentBuyersListView()
                  : SizedBox(),
              recentProductListView(),
            ],
          );
        }),
      ),
    );
  }

  Widget tiltleWidgets() {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Image.asset(kImgAppHorizontalLogo, width: 105),
            ),
          ],
        ),
      ),
    );
  }

  searchLocationTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: commonSearchTextField(
        controller: controller.searchLocationController,
        preFixIcon: SvgPicture.asset(kIconSearchCoffee),
        hintText: kLabelLocationCapital,
        onChange: (value) {},
      ),
    );
  }

  bannerSliderWidget() {
    return Obx(
          () {
        return Visibility(
          visible: controller.bannerImageListResponseDataList.length == 0 ? false : true,
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

  recentProductListView() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    kLabelRecentProducts, style: TextStyles.kH14PrimaryBold700),

                //  Text(kLabelSeeMore, style: TextStyles.kH14Grey9098B1Bold700),
              ],
            ),

            SizedBox(
              height: 200,
              child: controller.recentProductsResponseDataList.isNotEmpty
                  ? ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(top: 12, right: 12),
                shrinkWrap: true,
                itemCount: controller.recentProductsResponseDataList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.navigateToProductDetailsScreen(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 24, right: 20, bottom: 10),
                        decoration: const BoxDecoration(
                          color: kColorWhite,
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                // Container(
                                //     height: 105,
                                //     width: 113,
                                //     margin: const EdgeInsets.only(
                                //         left: 14, right: 14, top: 16, bottom: 8),
                                //     decoration: BoxDecoration(
                                //       color: kColorGreyF6F6F6,
                                //       borderRadius: BorderRadius.circular(6),
                                //     ),
                                //   child: Container(
                                //     height: 100,
                                //     width: 108,
                                //     decoration: BoxDecoration(
                                //       color: kColorGreyF6F6F6,
                                //       borderRadius: BorderRadius.circular(6),
                                //     ),
                                //     child: CachedNetworkImage(
                                //       fit: BoxFit.fill,
                                //       imageUrl:  controller.recentProductsResponseDataList[index].productImages?[0].image.toString() ?? '',
                                //       progressIndicatorBuilder: (context, url, progress) {
                                //         return SpinKitFadingCircle(
                                //           color: kColorPrimary,
                                //         );
                                //       },
                                //       errorWidget: (context, url, error) {
                                //         return Center(child: Icon(Icons.error));
                                //       },
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  height: 105,
                                  width: 113,
                                  margin: const EdgeInsets.only(
                                      left: 14, right: 14, top: 16, bottom: 8),
                                  decoration: BoxDecoration(
                                    color: kColorGreyF6F6F6,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child:
                                  SizedBox(
                                    height: 140,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,width: Get.width,
                                      imageUrl:  controller
                                              .recentProductsResponseDataList[index]
                                              .productImages?[0].image.toString() ??
                                              '',
                                      progressIndicatorBuilder: (context, url, progress) {
                                        return SpinKitFadingCircle(
                                          color: kColorPrimary,
                                        );
                                      },
                                      errorWidget: (context, url, error) {
                                        return Center(child: Icon(Icons.error));
                                      },
                                    ),
                                  ),
                                  // Image.network(
                                  //   controller
                                  //       .recentProductsResponseDataList[index]
                                  //       .productImages?[0].image.toString() ??
                                  //       '',
                                  //   height: 104,
                                  //   width: 81,
                                  //   fit: BoxFit.fill,
                                  // ),
                                ),
                                Container(
                                  // width:140,
                                  margin: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller
                                            .recentProductsResponseDataList[index]
                                            .name ?? '',
                                        style: TextStyles.kH14BlackBold700,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Image.network(
                      //       controller.recentProductsResponseDataList[index].productImages?[0].image.toString() ?? '',
                      //       height: 27,
                      //       width: 27,
                      //     ),
                      //     // CircleAvatar(
                      //     //   radius: 35,
                      //     //   backgroundColor: kColorWhite,
                      //     //   child: Image.asset(
                      //     //     kImgDummyBanner,
                      //     //     height: 27,
                      //     //     width: 27,
                      //     //   ),
                      //     // ),
                      //     SizedBox(height: 4),
                      //     Text(controller.recentProductsResponseDataList[index].name ?? '', style: TextStyles.kH14PrimaryBold700),
                      //     Text(
                      //       controller.recentProductsResponseDataList[index].productVariants?[0].price ?? '',
                      //       style: TextStyles.kH12BlackTextBold400,
                      //     ),
                      //   ],
                      // ),
                    ),
                  );
                },
              )
                  : GestureDetector(
                  onTap: () {
                    controller.navigateToAddProductScreen();
                  },
                  child:  Container(
                      height: 105,
                      width: 113,
                      margin: const EdgeInsets.only(
                          left: 14, right: 14, top: 16, bottom: 8),
                      decoration: BoxDecoration(
                        color: kColorGreyF6F6F6,
                        borderRadius: BorderRadius.circular(6),
                      ),child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(kIconAdd, height: 20, width: 20),
                          SizedBox(
                            height: 10,
                          ),
                          Text(kLabelAddProduct, style: TextStyles.kH12PrimaryTextBold700),
                        ],
                      ))),
            ),
          ],
        ),
      );
    });
  }

  Widget recentBuyersListView() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(kLabelRecentBuyers, style: TextStyles.kH14PrimaryBold700),
                InkWell(
                    onTap: () {
                      controller.navigateToRecentBuyersListScreen();
                    },
                    child: Text(
                        kLabelSeeMore, style: TextStyles.kH14PrimaryBold700)),
                //  Text(kLabelSeeMore, style: TextStyles.kH14Grey9098B1Bold700),
              ],
            ),
            SizedBox(
              height: Get.height * 0.33,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.recentBuyersResponseDataList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.navigateToBuyersDetailsScreen(index);
                    },
                    child: sRecentBuyersDataContainer(
                      productImage: controller
                          .recentBuyersResponseDataList[index].productImages?[0]
                          .image.toString() ?? '',
                      productName: controller
                          .recentBuyersResponseDataList[index].productName ??
                          '',
                      productOriginalPrice: double.parse('${controller
                          .recentBuyersResponseDataList[index]
                          .productVariantDiscountedPrice}'),
                      buyersName: controller.recentBuyersResponseDataList[index]
                          .name ?? '',
                      productQty: int.parse('${controller
                          .recentBuyersResponseDataList[index]
                          .orderProductVariantQuantity}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
