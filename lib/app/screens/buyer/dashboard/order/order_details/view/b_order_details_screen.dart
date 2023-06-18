import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/order_details/controller/b_order_details_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_image_slider.dart';

class BOrderDetailsScreen extends GetView<BOrderDetailsController> {
  BOrderDetailsScreen({Key? key}) : super(key: key) {
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
              Container(
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
                    /// productName and orderStatus
                    Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.orderData.value.productName ?? '',
                              style: TextStyles.kH18PrimaryBold700),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                controller.orderData.value.orderDetails
                                        ?.orderStatus ??
                                    '',
                                style: controller.orderData.value.orderDetails
                                            ?.orderStatus ==
                                        'Delivered'
                                    ? TextStyles.kH14Green48A300Bold700
                                    : controller.orderData.value.orderDetails
                                                ?.orderStatus ==
                                            'Placed'
                                        ? TextStyles.kH14OrangeFF6B00Bold700
                                        : TextStyles.kH14RedFF0000Bold700,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                  DateFormat('dd MMM yyyy').format(
                                      DateTime.parse(controller.orderData.value
                                              .orderDetails?.orderStatusDate ??
                                          '')),
                                  style: TextStyles.kH12Grey616161Bold400),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// payment method and order placed date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(kLabelPaymentMethod,
                                style: TextStyles.kH16PrimaryBold400),
                            SizedBox(height: 3),
                            Text('Google pay',
                                style: TextStyles.kH12Grey616161Bold400),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(kLabelOrderPlace.toUpperCase(),
                                style: TextStyles.kH16PrimaryBold400),
                            SizedBox(height: 3),
                            Text(
                                DateFormat('dd MMM yyyy').format(DateTime.parse(
                                    controller.orderData.value.orderDetails
                                            ?.orderCreatedAt ??
                                        '')),
                                style: TextStyles.kH12Grey616161Bold400),
                          ],
                        ),
                      ],
                    ),

                    /// category and variant
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(kLabelCategory,
                                  style: TextStyles.kH16PrimaryBold400),
                              SizedBox(height: 3),
                              Text(
                                  controller.orderData.value.categoryName ?? '',
                                  style: TextStyles.kH12Grey616161Bold400),
                            ],
                          ),
                          Visibility(
                            visible:
                                controller.orderData.value.isVariant == true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(kLabelVariant,
                                    style: TextStyles.kH16PrimaryBold400),
                                SizedBox(height: 3),
                                Text(
                                    '${controller.orderData.value.productVariantSize ?? ''}',
                                    style: TextStyles.kH12Grey616161Bold400),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      height: 0.5,
                      color: kColorTextFieldBorder,
                    ),

                    specificationWidget(),
                    sellerNameAndLocation(),

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
                          '$kRupee${controller.orderData.value.productVariantDiscountedPrice ?? 0.0}',
                          // '$kRupee${controller.orderData.value.productVariantPrice ?? 0.0}',
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
                          '${controller.orderData.value.quantity ?? 0}',
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
                          '${controller.orderData.value.quantityPrice ?? 0.0}',
                          style: TextStyles.kH14PrimaryBold700,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$kLabelGST ${controller.orderData.value.orderDetails?.totalGstPercent ?? 0}%',
                          style: TextStyles.kH14PrimaryBold700,
                        ),
                        Text(
                          '${controller.orderData.value.orderDetails?.totalGstPrice ?? '0'}',
                          style: TextStyles.kH14PrimaryBold400,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       '$kLabelDiscount',
                    //       style: TextStyles.kH14PrimaryBold700,
                    //     ),
                    //     Text(
                    //       '${controller.orderData.value.productVariantDiscountedPrice ?? '0'}',
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
                          '$kRupee${controller.orderData.value.orderDetails?.grandTotalPrice ?? '0'}',
                          style: TextStyles.kH14PrimaryBold700,
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // productNameAndOrderStatus(),
                    // priceAndQty(),
                    // variantsListView(),
                    // specificationWidget(),
                    // sellerNameAndLocation(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  headerWidget() {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: commonHeaderWidget(
        onBackTap: () {
          Get.back();
        },
        title:
            '$kLabelOrderDetails (#${controller.orderData.value.orderDetails?.orderNumber ?? '0'})',
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
                bannerList: controller.bannerList,
                isShowBannersList: true,
                currentIndex: controller.currentIndex.value,
                callBack: (value) {
                  controller.currentIndex.value = value;
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 12),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: SvgPicture.asset(kIconUnFav),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget productNameAndOrderStatus() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Drill Machin', style: TextStyles.kH20PrimaryBold700),
          Column(
            children: [
              Text(
                controller.tempOrderStatus.value,
                style: controller.tempOrderStatus.value.toLowerCase() ==
                        'delivered'
                    ? TextStyles.kH16Green48A300Bold700
                    : controller.tempOrderStatus.value.toLowerCase() ==
                            'ordered'
                        ? TextStyles.kH16OrangeFF6B00Bold700
                        : TextStyles.kH16RedFF0000Bold700,
              ),
              Text('22 march 2022', style: TextStyles.kH10Grey616161Bold400),
            ],
          )
        ],
      ),
    );
  }

  Widget priceAndQty() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$kRupee 299.49', style: TextStyles.kH16BlackBold700),
          Text('$kQty. 10', style: TextStyles.kH16BlackBold700),
        ],
      ),
    );
  }

  // Widget variantsListView() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 20),
  //     child: Row(
  //       children: [
  //         const Text(
  //           '$kLabelVariants : ',
  //           style: TextStyles.kH18PrimaryBold700,
  //         ),
  //         Expanded(
  //           child: SizedBox(
  //             height: 34,
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: 10,
  //               scrollDirection: Axis.horizontal,
  //               itemBuilder: (context, index) {
  //                 return Card(
  //                   shadowColor: kColorWhite,
  //                   elevation: 10,
  //                   child: Container(
  //                     padding: EdgeInsets.only(right: 10, left: 10),
  //                     alignment: Alignment.center,
  //                     child:
  //                         Text('50mm', style: TextStyles.kH12BlackTextBold700),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget specificationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        const Text(
          kLabelSpecification,
          style: TextStyles.kH18PrimaryBold700,
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(right: 18),
          child: ReadMoreText(
            controller.orderData.value.specification ?? '',
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
          Text(controller.orderData.value.soldBy?.sellerName ?? '',
              style: TextStyles.kH14BlackBold600),
          SizedBox(height: 2),
          Text(
              '${controller.orderData.value.soldBy?.city ?? ''}, ${controller.orderData.value.soldBy?.state ?? ''}',
              style: TextStyles.kH12Grey616161Bold400),
        ],
      ),
    );
  }
}
