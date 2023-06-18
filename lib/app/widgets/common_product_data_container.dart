import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget commonProductDataContainer({
  required String productImage,
  required String productName,
  required String categoryName,
  required double productOriginalPrice,
  required double productDiscountedPrice,
  bool isMainProductListing = false,
  bool isShowFavIcon = false,
  bool isFav = false,
  bool isShowDelete = false,
  bool isDelete = false,
  Function? onFavTap,
  Function? onDeleteTap,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 0, right: 20, bottom: 10),
    decoration: const BoxDecoration(
      color: kColorWhite,
    ),
    child: Stack(
      children: [
        Column(
          children: [
            Container(
              height: isMainProductListing ? 130 : 110,
              width: isMainProductListing ? 140 : 110,
              margin: const EdgeInsets.only(
                  left: 14, right: 14, top: 16, bottom: 8),
              decoration: BoxDecoration(
                color: kColorGreyF6F6F6,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Stack(
                children: [
                  // SizedBox(height: 140, child: Image.network(productImage)),
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
                  Visibility(
                    visible: false,
                    // visible: isShowFavIcon,
                    child: GestureDetector(
                      onTap: () {
                        // onFavTap!();
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4, right: 4),
                          child: isFav
                              ? SvgPicture.asset(kIconFav)
                              : SvgPicture.asset(kIconUnFav, height: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: isMainProductListing ? 120 : 100,
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: isMainProductListing ? 48 : 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: isMainProductListing
                              ? TextStyles.kH18PrimaryBold700
                              : TextStyles.kH12PrimaryTextBold700,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        SizedBox(
                          width: 120,
                          child: Text(
                            categoryName,
                            style: TextStyles.kH12BlackTextBold400,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$kRupee ${productOriginalPrice.toStringAsFixed(2)}',
                    style: TextStyles.kH12Grey9098B1LineThroughBold400,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$kRupee ${productDiscountedPrice.toStringAsFixed(2)}',
                    style: TextStyles.kH14PrimaryBold700,
                  ),

                  /// fav / unfav container
                  Visibility(
                    visible: isShowFavIcon,
                    child: GestureDetector(
                      onTap: () {
                        onFavTap!();
                      },
                      child: Container(
                        width: isMainProductListing ? 120 : 100,
                        padding: EdgeInsets.symmetric(vertical: 4),
                        margin: EdgeInsets.only(top: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: isFav == false ? kColorWhite : kColorPrimary,
                            border: Border.all(color: kColorPrimary),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                            isFav ? kLabelUnFavourite : kLabelAddToFavourite,
                            style: isFav == false
                                ? TextStyles.kH12PrimaryTextBold700
                                : TextStyles.kH12WhiteTextBold700),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isShowDelete,
                    child: GestureDetector(
                      onTap: () {
                        onDeleteTap!();
                      },
                      child: Container(
                      //  width: isMainProductListing ? 120 : 100,
                         padding: EdgeInsets.symmetric(vertical: 4),
                        margin: EdgeInsets.only(top: 8),
                         alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       color: isDelete == false ? kColorWhite : kColorWhite,
                      //       border: Border.all(color: kColorRedFF0000),
                      //       borderRadius: BorderRadius.circular(4)),
                        child: Text(
                            kLabelDelete,
                            style: TextStyle(color: kColorRedFF0000,  fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: fontFamily,)),
                            //style:TextStyles.kH12WhiteTextBold700,
                      ),
                    ),
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
