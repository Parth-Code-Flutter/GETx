import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget commonOrderDataContainer({
  required String productImage,
  required String productName,
  required double productOriginalPrice,
  required int qty,
  required String orderStatus,
  required String orderId,
  required String orderDate,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16, top: 4),
    padding: const EdgeInsets.all(12),
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
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
            color: kColorGreyF6F6F6,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: productImage,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(productName, style: TextStyles.kH16PrimaryBold700),
                    Text('#$orderId', style: TextStyles.kH14PrimaryBold400),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$kRupee $productOriginalPrice',
                        style: TextStyles.kH14BlackBold700),
                    Text('$kQty. $qty', style: TextStyles.kH14BlackBold700),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        DateFormat('dd MMM yyyy')
                            .format(DateTime.parse(orderDate)),
                        style: TextStyles.kH12Grey616161Bold400),
                    // Placed: 0, Delivered: 1, Cancelled: 2
                    Text(
                      orderStatus,
                      style: orderStatus == 'Delivered'
                          ? TextStyles.kH12Green48A300Bold700
                          : orderStatus == 'Placed'
                              ? TextStyles.kH12OrangeFF6B00Bold700
                              : TextStyles.kH12RedFF0000Bold700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
