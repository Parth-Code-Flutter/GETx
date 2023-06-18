import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/model/response/banner_image_list_response_model.dart';

Widget commonImageSlider({
  // required List<String> imageList,
  List<String>? imageList,
  List<Banners>? bannerList,
  CarouselController? imageSliderController,
  int? currentIndex,
  bool isShowForwardOrBackButton = false,
  bool isShowBannersList = false,
  required Function(int) callBack,
}) {
  return Column(
    children: [
      Stack(
        children: [
          CarouselSlider.builder(
            itemCount:
                isShowBannersList ? bannerList?.length : imageList?.length,
            carouselController: imageSliderController,
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.transparent, // kColorPrimary
                ),
                // child: bannerList == null || bannerList.isEmpty
                child: (bannerList == null || bannerList.isEmpty) &&
                        isShowBannersList
                    ? Container()
                    : isShowBannersList
                        ? getImage(index, bannerList)
                        : Image.asset(imageList?[index] ?? '',
                            fit: BoxFit.fill),
              );
            },
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
              height: 216,
              // height: Get.height*0.2,
              onPageChanged: (index, reason) {
                // currentIndex = index;
                callBack(index);
              },
            ),
          ),
          Visibility(
            visible: isShowForwardOrBackButton,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * 0.09),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            imageSliderController?.previousPage();
                          },
                          child: Image.asset(kImgReverse),
                        ),
                        GestureDetector(
                          onTap: () {
                            imageSliderController?.nextPage();
                          },
                          child: Image.asset(kImgForward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: (isShowBannersList ? bannerList ?? [] : imageList ?? [])
            .asMap()
            .entries
            .map((entry) {
          return GestureDetector(
            onTap: () => imageSliderController?.animateToPage(entry.key),
            child: Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentIndex == entry.key
                      ? kColorPrimary
                      : kColorGreyD7D7D7),
            ),
          );
        }).toList(),
      )
    ],
  );
}

getImage(int index, bannerList) {
  try {
    // return Image.network(bannerList?[index].image ?? 'https://dummyimage.com/'); /// added dummy online url
    return CachedNetworkImage(
      imageUrl: bannerList?[index].image ?? 'https://dummyimage.com/',
      progressIndicatorBuilder: (context, url, progress) {
        return const SpinKitFadingCircle(
          color: kColorPrimary,
        );
      },
      errorWidget: (context, url, error) {
        return const Icon(Icons.error);
      },
    );

    /// added dummy online url
  } catch (e) {
    return Image.asset(kImgDummyBanner);
  }
}
