import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_image_slider.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

import '../controller/s_recent_buyers_details_controller.dart';

class SBuyersDetailsScreen extends GetView<SBuyersDetailsController> {
  SBuyersDetailsScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            headerWidget(),
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(20),topRight:  Radius.circular(20)),
                  color: kColorWhite,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileImageContainer(),
                    //  productNameAndQtyWidget(),
                      imageSliderWidget(),
                     // priceAndAvailability(),
                      specificationWidget(),
                      address(),
                      paymentDetailsWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelRecentBuyersDetails,
      isShowActionWidgets: true,

    );
  }
  Widget profileImageContainer() {
    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 64  ,
                      width: 63,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kColorBlack, width: 1),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child:CachedNetworkImage(
                          fit: BoxFit.cover,width: Get.width,
                          imageUrl:   controller.recentBuyersResponseData.value.profilePic ?? '',
                          progressIndicatorBuilder: (context, url, progress) {
                            return SpinKitFadingCircle(
                              color: kColorPrimary,
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Center(child: Icon(Icons.person));
                          },
                        ),
                        // Image.network(
                        //  controller.recentBuyersResponseData.value.profilePic ?? '',
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                    SizedBox(width: 18,),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(controller.recentBuyersResponseData.value.name ?? '',
                                style: TextStyles.kH20PrimaryBold700),
                            //  SizedBox(height: 18,),
                            Text(controller.recentBuyersResponseData.value.productName ?? '',
                                style: TextStyles.kH12PrimaryTextBold700),
                            Text(controller.recentBuyersResponseData.value.mobileNumber ?? '',
                                style: TextStyles.kH12PrimaryTextBold700),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  controller.recentBuyersResponseData.value.orderStatus ?? '',
                  style:  controller.recentBuyersResponseData.value.orderStatus == 'Delivered'
                      ? TextStyles.kH12Green48A300Bold700
                      :  controller.recentBuyersResponseData.value.orderStatus == 'Placed'
                      ? TextStyles.kH12OrangeFF6B00Bold700
                      : TextStyles.kH12RedFF0000Bold700,
                ),
              ],
            )
          ],
        )

      );
    });
  }
  Widget imageSliderWidget() {
    return Obx(
          () {
        return Padding(
          padding:  EdgeInsets.only(top: 16),
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
          child: SizedBox(
            height: Get.height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.bannersList.length,
              itemBuilder: (context, index) {
                return  Container(
                  height: 104,
                  width: Get.size.width*0.30,
                  margin:  EdgeInsets.only(top: 24, right: 20, bottom: 10),
                  decoration:  BoxDecoration(
                    color: kColorWhite,
                    border: const Border(
                      top: BorderSide(color: kColorGreyF6F6F6,),
                      bottom:  BorderSide(color: kColorGreyF6F6F6,),
                      left:  BorderSide(color: kColorGreyF6F6F6,),
                      right:  BorderSide(color: kColorGreyF6F6F6,),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    height: 80,
                    width: Get.size.width*0.28,
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      color: kColorGreyF6F6F6,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child:
                    // Image(
                    //   image: NetworkImage(productImage),
                    // )
                    CachedNetworkImage(
                      fit: BoxFit.cover,width: Get.width,
                      imageUrl:    controller.bannersList[index].image.toString(),
                      progressIndicatorBuilder: (context, url, progress) {
                        return SpinKitFadingCircle(
                          color: kColorPrimary,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Center(child: Icon(Icons.error));
                      },
                    ),
                    // Image.network(
                    //   controller.bannersList[index].image.toString(),
                    //   width: 40,
                    //   height: 40,
                    //   errorBuilder: (BuildContext context, Object exception,
                    //       StackTrace? stackTrace) {
                    //     return  Text('😢');
                    //   },
                    // ),
                  ),
                );
                // return sRecentBuyersDataContainer(
                //   productImage:  controller.recentBuyersResponseDataList[index].productImages?[0].image.toString() ?? '',
                //   productName: controller.recentBuyersResponseDataList[index].productName ?? '',
                //   productOriginalPrice: double.parse('${controller.recentBuyersResponseDataList[index].productVariantPrice}'),
                //   buyersName: controller.recentBuyersResponseDataList[index].name ?? '',
                //   productQty:int.parse('${controller.recentBuyersResponseDataList[index].orderProductVariantQuantity}'),
                // );
              },
            ),
          ),
        );
        //   child: commonImageSlider(
        //     bannerList: controller.bannersList,  isShowBannersList: true,
        //     currentIndex: controller.currentIndex.value,
        //     callBack: (value) {
        //       controller.currentIndex.value = value;
        //     },
        //   ),
        // );
      },
    );
  }

  Widget productNameAndQtyWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(controller.recentBuyersResponseData.value.name ?? '',
              style: TextStyles.kH24PrimaryBold700),
          SizedBox(height: 18,),
          Text(controller.recentBuyersResponseData.value.productName ?? '',
              style: TextStyles.kH22BlackBold400),
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
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(right: 18),
          child: ReadMoreText(
            controller.recentBuyersResponseData.value.specification ?? '',
            style: TextStyles.kH14BlackBold400,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Read more',
            trimExpandedText: ' Show less',
            moreStyle: TextStyles.kH14Green48A300Bold400,
            lessStyle: TextStyles.kH14RedFF0000Bold400,
          ),
        ),
      ],
    );
  }

  address() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 28),
        const Text(
          kLabelAddress,
          style: TextStyles.kH18PrimaryBold700,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(right: 18),
          child: ReadMoreText(
            controller.recentBuyersResponseData.value.streetAddress ?? '',
            style: TextStyles.kH14BlackBold400,
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Read more',
            trimExpandedText: ' Show less',
            moreStyle: TextStyles.kH14Green48A300Bold400,
            lessStyle: TextStyles.kH14RedFF0000Bold400,
          ),
        ),
        // Text(controller.recentBuyersResponseData.value.streetAddress ?? '',
        //     style: TextStyles.kH12PrimaryTextBold400),
      ],
    );
  }
  paymentDetailsWidget() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 0.5,
            margin: EdgeInsets.symmetric(vertical: 16),
            color: kColorTextFieldBorder,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                kLabelPrice,
                style: TextStyles.kH14PrimaryBold700,
              ),
              Text(
                '$kRupee${controller.recentBuyersResponseData.value.productVariantDiscountedPrice ?? 0.0}',
                style: TextStyles.kH14PrimaryBold700,
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                kQty,
                style: TextStyles.kH14PrimaryBold700,
              ),
              Text(
                '${controller.recentBuyersResponseData.value.orderProductVariantQuantity ?? 0}',
                style: TextStyles.kH14PrimaryBold400,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 6),
              Container(
                height: 0.5,
                width: Get.width * .25,
                margin: EdgeInsets.symmetric(vertical: 10),
                color: kColorTextFieldBorder,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                kLabelTotal,
                style: TextStyles.kH14PrimaryBold700,
              ),
              Text(
                '${controller.recentBuyersResponseData.value.orderProductVariantQuantityPrice ?? 0.0}',
                style: TextStyles.kH14PrimaryBold700,
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$kLabelGST ${controller.recentBuyersResponseData.value.totalGst ?? 0}%',
                style: TextStyles.kH14PrimaryBold700,
              ),
              Text(
                '${controller.recentBuyersResponseData.value.totalGstPrice ?? '0'}',
                style: TextStyles.kH14PrimaryBold400,
              ),
            ],
          ),
         // SizedBox(height: 6),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       '$kLabelDiscount',
          //       style: TextStyles.kH14PrimaryBold700,
          //     ),
          //     Text(
          //       '${controller.recentBuyersResponseData.value.productVariantDiscountedPrice ?? '0'}',
          //       style: TextStyles.kH14PrimaryBold400,
          //     ),
          //   ],
          // ),

          Container(
            height: 0.5,
            margin: EdgeInsets.symmetric(vertical: 16),
            color: kColorTextFieldBorder,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                kLabelGrandPrice,
                style: TextStyles.kH14PrimaryBold700,
              ),
              Text(
                '$kRupee${controller.recentBuyersResponseData.value.grandTotalPrice ?? '0'}',
                style: TextStyles.kH14PrimaryBold700,
              ),
            ],
          ),
          SizedBox(height: 18),
              ],
            );
    });
  }

  // Widget sellerNameAndLocation() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(controller.productDetailsData.value.sellerName ?? '',
  //             style: TextStyles.kH14BlackBold600),
  //         SizedBox(height: 2),
  //         Text(
  //             '${controller.productDetailsData.value.sellerCity ??
  //                 ''}, ${controller.productDetailsData.value.sellerState ??
  //                 ''}',
  //             style: TextStyles.kH12Grey616161Bold400),
  //       ],
  //     ),
  //   );
  // }

}
