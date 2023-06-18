import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget sRecentBuyersDataContainer({
  required String productImage,
  required String productName,
  required String buyersName,
  required double productOriginalPrice,
  required int productQty,
  bool isMainProductListing = false,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 24, right: 20, bottom: 10),
    decoration: const BoxDecoration(
      color: kColorWhite,
    ),
    child: Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 105,
              width: isMainProductListing ? Get.size.width*0.90 : Get.size.width*0.28,
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
                  imageUrl: productImage,
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
            //   Image.network(
            //     productImage,
            //     // width: 40,
            //     height: 40,
            //     errorBuilder: (BuildContext context, Object exception,
            //         StackTrace? stackTrace) {
            //       return const Text('😢');
            //     },
            // ),
              ),
            Container(
              width: 100,
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:25,
                    child: Text(
                      buyersName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: isMainProductListing?TextStyles.kH18PrimaryBold700:TextStyles.kH14BlackBold700,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                    child: Text(
                      productName,
                      style: isMainProductListing?TextStyles.kH12BlackTextBold400:TextStyles.kH12BlackTextBold400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$kRupee ${productOriginalPrice.toString()}',
                    style: TextStyles.kH12BlackTextBold400,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$kQty ${productQty.toString()}',
                    style: TextStyles.kH12BlackTextBold400,
                  ),

                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
