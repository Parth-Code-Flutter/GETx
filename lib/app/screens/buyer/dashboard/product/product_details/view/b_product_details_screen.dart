import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/product_details/controller/b_product_details_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_image_slider.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BProductDetailsScreen extends GetView<BProductDetailsController> {
  BProductDetailsScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              headerWidget(),
              imageSliderWidget(),
              Obx(() {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.all(6),
                  height: controller.isReadMoreExpanded.value == false
                      ? Get.height
                      : Get.height * 0.55,
                  decoration: BoxDecoration(
                    color: kColorWhite,
                    borderRadius: BorderRadius.circular(20),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(20),
                    //   topRight: Radius.circular(20),
                    // ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      productNameWidget(),
                      priceAndQTY(),
                      categoryAndAvailability(),
                      variantListView(),
                      specificationWidget(),
                      sellerNameAndLocation(),
                      Visibility(
                        visible:controller.leftQty.value ==0,
                        // (controller
                        //             .productDetailsData
                        //             .value
                        //             .productVariants?[
                        //                 controller.currentIndex.value]
                        //             .leftQty ??
                        //         1) ==
                        //     0,
                        child: Container(
                          margin: EdgeInsets.only(top: 24),
                          width: Get.width,
                          child: Text(
                            kLabelOutOfStock.toUpperCase(),
                            style: TextStyles.kH20RedBold700,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Visibility(
                        visible: controller.leftQty.value>0,
                        // (controller
                        //             .productDetailsData
                        //             .value
                        //             .productVariants?[
                        //                 controller.currentIndex.value]
                        //             .leftQty ??
                        //         1) >
                        //     0,
                        child: addToCartAndBuyButtons(),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelProductDetails,
      isShowActionWidgets: true,
      actionWidgets: InkWell(
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
    );
  }

  Widget imageSliderWidget() {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Stack(
            children: [
              commonImageSlider(
                bannerList: controller.productImagesList,
                isShowBannersList: true,
                currentIndex: controller.currentIndex.value,
                callBack: (value) {
                  controller.currentIndex.value = value;
                },
              ),
              GestureDetector(
                onTap: () {
                  controller.favUnFavApiCall();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Align(
                    alignment: Alignment.topRight,
                    child:
                        controller.productDetailsData.value.isFavourite ?? false
                            ? SvgPicture.asset(kIconFav, height: 22)
                            : SvgPicture.asset(kIconUnFav),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget productNameWidget() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(controller.productDetailsData.value.name ?? '',
                style: TextStyles.kH20PrimaryBold700),
            Text(
                '$kLabelGST - ${controller.productDetailsData.value.gst ?? 0}%',
                style: TextStyles.kH14PrimaryBold700),
          ],
        ),
      );
    });
  }

  Widget priceAndQTY() {
    print('controller.currentIndex.value :: ${controller.currentIndex.value}');
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                // '$kRupee${controller.returnDiscountedPrice()}',
                '$kRupee${controller.productDetailsData.value.productVariants?[controller.currentVariantIndex.value].discountedPrice ?? 0}',
                style: TextStyles.kH18PrimaryBold700),
            Visibility(
              visible: (controller
                          .productDetailsData
                          .value
                          .productVariants?[controller.currentIndex.value]
                          .leftQty ??
                      1) >
                  0,
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kColorBackground,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        controller.minusQty();
                      },
                      icon: Icon(
                        Icons.remove,
                        size: 16,
                      ),
                    ),
                  ),
                  Text(
                      '${controller.productDetailsData.value.productVariants?[controller.currentVariantIndex.value].qty}'),
                  Container(
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kColorBackground,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        if ((controller
                                    .productDetailsData
                                    .value
                                    .productVariants?[
                                        controller.currentIndex.value]
                                    .qty ??
                                1) <
                            (controller
                                    .productDetailsData
                                    .value
                                    .productVariants?[
                                        controller.currentVariantIndex.value]
                                    .leftQty ??
                                1)) {
                          controller.addQty();
                        }
                      },
                      icon: Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget categoryAndAvailability() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$kLabelCategory ',
                  style: TextStyles.kH18PrimaryBold700,
                ),
                SizedBox(height: 4),
                Text(
                  controller.productDetailsData.value.categoryName ?? '',
                  style: TextStyles.kH16BlackBold400,
                ),
              ],
            ),
            // RichText(
            //   text: TextSpan(
            //     children: [
            //       const TextSpan(
            //         text: '$kLabelCategory : ',
            //         style: TextStyles.kH18PrimaryBold700,
            //       ),
            //       TextSpan(
            //         text: controller.productDetailsData.value.categoryName ??
            //             '',
            //         style: TextStyles.kH16BlackBold400,
            //       ),
            //     ],
            //   ),
            // ),
            Text(
                '$kLabelAvailable -  ${controller.productDetailsData.value.productVariants?[controller.currentVariantIndex.value].leftQty}',
                style: TextStyles.kH14BlackBold700),
          ],
        ),
      );
    });
  }

  Widget variantListView() {
    return Visibility(
      visible: controller.productDetailsData.value.isVariant ?? false,
      child: Row(
        children: [
          const Text(
            '$kLabelVariants : ',
            style: TextStyles.kH18PrimaryBold700,
          ),
          Expanded(
            child: SizedBox(
              height: 34,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    controller.productDetailsData.value.productVariants?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var variantData = controller
                      .productDetailsData.value.productVariants?[index];
                  return GestureDetector(
                    onTap: () {
                      controller.updateProductVariants(index);
                    },
                    child: Card(
                      shadowColor: kColorWhite,
                      elevation: 10,
                      child: Obx(() {
                        return Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          decoration: BoxDecoration(
                            color: controller.currentVariantIndex.value == index
                                ? kColorWhite
                                : kColorBackground,
                            border: Border.all(
                                color: controller.currentVariantIndex.value ==
                                        index
                                    ? kColorPrimary
                                    : Colors.transparent,
                                width: controller.currentVariantIndex.value ==
                                        index
                                    ? 1.5
                                    : 1),
                          ),
                          alignment: Alignment.center,
                          child: Text(variantData?.size ?? '',
                              style: TextStyles.kH12BlackTextBold700),
                        );
                      }),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget specificationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        const Text(
          kLabelSpecification,
          style: TextStyles.kH18PrimaryBold700,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(right: 18),
          child: ReadMoreText(
            callback: (val) {
              controller.isReadMoreExpanded.value = val;
            },
            controller.productDetailsData.value.specification ?? '',
            style: TextStyles.kH14BlackBold400,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Read more',
            trimExpandedText: ' Show less',
            moreStyle: TextStyles.kH14Green48A300Bold400,
            lessStyle: TextStyles.kH14RedFF0000Bold400,
          ),
        ),
      ],
    );
  }

  Widget sellerNameAndLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(controller.productDetailsData.value.sellerName ?? '',
              style: TextStyles.kH14BlackBold600),
          SizedBox(height: 2),
          Text(
              '${controller.productDetailsData.value.sellerCity ?? ''}, ${controller.productDetailsData.value.sellerState ?? ''}',
              style: TextStyles.kH12Grey616161Bold400),
        ],
      ),
    );
  }

  Widget addToCartAndBuyButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          primaryButton(
              onPress: () {
                // controller.addToCartApiCall();
                controller.checkAvailabilityQtyApiCall();
              },
              buttonTxt: kLabelAddToCart,
              width: Get.width * 0.4),
          primaryButton(
              onPress: () {
                controller.checkAvailabilityQtyApiCall(
                    isBuyButtonClicked: true);
              },
              buttonTxt: kLabelBuy,
              width: Get.width * 0.4),
        ],
      ),
    );
  }
}
