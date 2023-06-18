import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/category/all_category_listing/controller/b_all_category_listing_controller.dart';
import 'package:tsofie/app/screens/seller/dashboard/category/all_category_listing/controller/s_all_category_listing_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';

class SAllCategoryListing extends GetView<SAllCategoryListingController> {
  const SAllCategoryListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Column(
          children: [
            headerWidget(),
            categoryListing(),
          ],
        ),
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelAllCategory,
    );
  }

  Widget categoryListing() {
    return Obx(() {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.categoriesDataList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.navigateToCatProductListingScreen(controller.categoriesDataList[index].id??0);
              },
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: kColorWhite,
                              backgroundImage: getCategoryImage(index)
                            ),
                            SizedBox(width: 10),
                            Text(
                                controller.categoriesDataList[index].name ?? '',
                                style: TextStyles.kH20PrimaryBold400),
                          ],
                        ),
                        SvgPicture.asset(kIconForward),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: Get.width,
                    color: kColorGrey9098B1,
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }

  getCategoryImage(int index) {
    try{
     return NetworkImage(
        controller.categoriesDataList[index].image ??
            '',
      );
    }catch(e){
      return AssetImage(kImgDummyBanner);
    }
  }
}
