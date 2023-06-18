import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_image_slider.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

import '../controller/s_product_details_controller.dart';

class SProductDetailsScreen extends GetView<SProductDetailsController> {
  SProductDetailsScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                headerWidget(),
                imageSliderWidget(),
                Obx(() {
                  return Container(
                    height: controller.isReadMoreExpanded.value == false
                        ? Get.height * 0.85
                        : Get.height * 0.55,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    margin: const EdgeInsets.all(6),
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
                        // priceAndQTY(),
                        priceAndAvailability(),
                        categoryAndAvailability(),
                        variantListView(),
                        specificationWidget(),
                        sellerNameAndLocation(),
                      ],
                    ),
                  );
                }),
                // Expanded(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 16),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         imageSliderWidget(),
                //         productNameAndQtyWidget(),
                //         priceAndAvailability(),
                //         variantListView(),
                //         specificationWidget(),
                //         sellerNameAndLocation(),
                //         //Spacer(),
                //         //addToCartAndBuyButtons(),
                //       ],
                //     ),
                //
                //   ),
                // ),
              ],
            ),
          );
        }),
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
      actionWidgets: Row(
        children: [
          GestureDetector(
              onTap: () {
                controller.navigateToEditProductScreen();
              },
              child: SvgPicture.asset(kIconEditProduct, height: 26, width: 26)),
        ],
      ),
    );
  }

  Widget imageSliderWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      //   commonImageSlider(
      // //  bannerList: controller.productDetailsData.value.productImages,
      //   // imageList: controller.bannerImageListResponseDataList.image ?? '',
      //   isShowForwardOrBackButton: true,
      //   currentIndex: controller.currentIndex.value,
      //   //imageSliderController: controller.imageSliderController.value,
      //   isShowBannersList: true,
      //   callBack: (values) {
      //     controller.currentIndex.value = values;
      //   },
      // ),
      child: commonImageSlider(
        bannerList: controller.bannersList,
        isShowBannersList: true,
        currentIndex: controller.currentIndex.value,
        callBack: (value) {
          controller.currentIndex.value = value;
        },
      ),
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
          ],
        ),
      );
    });
  }

  Widget productNameAndQtyWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(controller.productDetailsData.value.name ?? '',
              style: TextStyles.kH20PrimaryBold700),
        ],
      ),
    );
  }

  Widget priceAndAvailability() {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              '$kRupee ${controller.productDetailsData.value.productVariants?[controller.currentVariantIndex.value].discountedPrice}',
              // '$kRupee${controller.productDetailsData.value.productVariants?[controller.currentVariantIndex.value].price ?? 0}',
              style: TextStyles.kH18PrimaryBold700),
          Text(
              '$kLabelAvailable -  ${controller.productDetailsData.value.productVariants?[controller.currentVariantIndex.value].stockQty}',
              style: TextStyles.kH14BlackBold700),
        ],
      ),
    );
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
            Text(
                '$kLabelGST -  ${controller.productDetailsData.value.gst ?? 0}%',
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
                      // elevation: 10,
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
}
