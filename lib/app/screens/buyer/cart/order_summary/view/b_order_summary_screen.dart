import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/cart/my_cart/model/response/cart_items_response_model.dart';
import 'package:tsofie/app/screens/buyer/cart/order_summary/controller/b_order_summary_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BOrderSummaryScreen extends GetView<BOrderSummaryController> {
  BOrderSummaryScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerWidget(),
                cartItemsListView(),
                shippingAddressWidget(),
                paymentDetailsWidget(),
                // Spacer(),
                continueShoppingButton(),
              ],
            ),
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
      title: kLabelOrderSummary,
    );
  }

  cartItemsListView() {
    return Obx(() {
      return SizedBox(
        height: Get.height * 0.34, // .44
        child: ListView.builder(
          itemCount: controller.cartItemsList.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            var cartData = controller.cartItemsList[index];
            return Container(
              margin:
                  const EdgeInsets.only(bottom: 8, left: 16, right: 16, top: 2),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: kColorTextFieldBorder.withOpacity(.25),
                    offset: const Offset(
                      1.0,
                      4.0,
                    ),
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow//BoxS
                ],
                color: kColorWhite,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  getProductImage(cartData: cartData),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartData.productName ?? '',
                                      style: TextStyles.kH16PrimaryBold700),
                                  Text(
                                      '${cartData.category ?? ''} (${cartData.size ?? ''})',
                                      style: TextStyles.kH14PrimaryBold400),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('$kRupee${cartData.price ?? 0}',
                                  style: TextStyles
                                      .kH12Grey9098B1LineThroughBold700),
                              Row(
                                children: [
                                  Text('$kQty : ${cartData.quantity ?? 0}',
                                      style: (cartData.isOutOfStock ?? false)
                                          ? TextStyles.kH12Grey9098B1Bold400
                                          : TextStyles.kH12BlackTextBold700),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '$kRupee${cartData.discountedPrice ?? 0}',
                                  // '$kRupee${cartData.updatedDiscountPrice ?? 0}',
                                  style: TextStyles.kH14BlackBold700),
                              Text('$kLabelGST - ${cartData.gst ?? 0}%',
                                  style: TextStyles.kH14BlackBold700),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  shippingAddressWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(kLabelShippingAddress, style: TextStyles.kH14PrimaryBold700),
          Container(
            width: Get.width,
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kColorWhite,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
                '${controller.shippingAddressData.city ?? ''}, ${controller.shippingAddressData.state ?? ''}, ${controller.shippingAddressData.streetAddress ?? ''}, ${controller.shippingAddressData.pincode ?? ''}'),
          ),
        ],
      ),
    );
  }

  paymentDetailsWidget() {
    return Obx(() {
      return Padding(
        padding:
        const EdgeInsets.only(left: 16, right: 16, bottom: 12, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kLabelPaymentDetails,
              style: TextStyles.kH14PrimaryBold700,
            ),
            Container(
              margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kColorWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        kLabelTotalPrice,
                        style: TextStyles.kH14PrimaryBold700,
                      ),
                      Text(
                        '$kRupee${controller.cartData.value.totalPrice ?? 0.0}',
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
                        '${controller.cartData.value.totalQty ?? 0}',
                        style: TextStyles.kH14PrimaryBold400,
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Column(
                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [
                      //     // Text(
                      //     //   kLabelGST,
                      //     //   style: TextStyles.kH14PrimaryBold700,
                      //     // ),
                      //     // Text(
                      //     //   '15%',
                      //     //   style: TextStyles.kH12PrimaryTextBold400,
                      //     // ),
                      //   ],
                      // ),
                      Container(
                        height: 1,
                        width: Get.width,
                        color: kColorGreyD7D7D7,
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      ListView.builder(
                        itemCount: controller.gstDataList.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var gstData = controller.gstDataList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${gstData.gstPerc}%',
                                  style: TextStyles.kH14PrimaryBold400,
                                ),
                                Text(
                                  '$kRupee${gstData.price}',
                                  style: TextStyles.kH14PrimaryBold400,
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    width: Get.width,
                    color: kColorGreyD7D7D7,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$kLabelGrandTotal',
                        //'${(controller.cartData.value.totalGSTPerc ?? 0.0).toStringAsFixed(0)}%',
                        style: TextStyles.kH14PrimaryBold700,
                      ),
                      Text(
                        '$kRupee${((controller.cartData.value.totalPrice ?? 0.0) + (controller.cartData.value.totalGSTPrice ?? 0.0)).toStringAsFixed(2)}',
                        style: TextStyles.kH14PrimaryBold700,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  continueShoppingButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: primaryButton(
        onPress: () {
          controller.createOrderApiCall();
        },
        buttonTxt: kLabelContinueShopping,
      ),
    );
  }

  getProductImage({required CartData cartData}) {
    return Stack(
      children: [
        Container(
          height: 95,
          width: 95,
          decoration: BoxDecoration(
            color: kColorGreyF6F6F6,
            borderRadius: BorderRadius.circular(8),
          ),
          // child: Image.network(cartData.productImage??''),
          child: CachedNetworkImage(
            imageUrl: cartData.productImage ?? '',
            progressIndicatorBuilder: (context, url, progress) {
              return SpinKitFadingCircle(
                color: kColorPrimary,
              );
            },
            errorWidget: (context, url, error) {
              return Icon(Icons.error);
            },
          ),
        ),
        Visibility(
          visible: cartData.isOutOfStock == true,
          child: Container(
            height: 95,
            width: 95,
            decoration: BoxDecoration(
              color: kColorPrimary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                kLabelOutOfStock,
                style: TextStyles.kH14WhiteBold700,
              ),
            ),
          ),
        )
      ],
    );
  }
}
