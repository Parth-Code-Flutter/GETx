import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/home/view/b_home_screen.dart';
import 'package:tsofie/app/screens/seller/dashboard/order/base/view/s_order_list_view.dart';
import 'package:tsofie/app/screens/seller/s_bootom_nav_screen/controller/s_bottom_nav_controller.dart';

import '../../../../utils/text_styles.dart';
import '../../dashboard/home/view/s_home_screen.dart';
import '../../dashboard/more/base/view/s_more_base_screen.dart';
import '../../dashboard/product/base/view/s_product_base_screen.dart';

class SellerBottomNavScreen extends GetView<SellerBottomNavController> {
  const SellerBottomNavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kColorBackground,
        body: Column(
          children: [
            _stackedContainers(),
            _navigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _stackedContainers() {
    return Expanded(
      child: Obx(() {
        return IndexedStack(
          index: controller.index.value,
          children: [
           SHomeScreen(),
            SProductBaseScreen(),
            SOrderBaseScreen(),
            SMoreBaseScreen(),
          ],
        );
      }),
    );
  }

  Widget _navigationButtons() {
    return Obx(() {
      return Container(
        color: kColorWhite,
        padding: EdgeInsets.symmetric(vertical: 12,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           SizedBox(width: 1,),
            GestureDetector(
              onTap: () {
                controller.index.value = 0;
              },
              child: Container(
                color: kColorWhite,
                //width: 90,
                // height: 60,
                child: Column(
                  children: [
                    controller.index.value == 0
                        ? SvgPicture.asset(kIconHome, color: kColorPrimary)
                        : SvgPicture.asset(kIconHome, color: kColorGrey9098B1),
                    SizedBox(height: controller.bottomBarNamePadding),
                    Text(
                      kLabelHome,
                      style: controller.index.value == 0
                          ? TextStyles.kH12PrimaryTextBold400
                          : TextStyles.kH12HintTextBold400,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.index.value = 1;
              },
              child: Container(
                color: kColorWhite,
                //width: 95,
                child: Column(
                  children: [
                    controller.index.value == 1
                        ? SvgPicture.asset(kIconProduct, color: kColorPrimary)
                        : SvgPicture.asset(kIconProduct, color: kColorGrey9098B1),
                    SizedBox(height: controller.bottomBarNamePadding),
                    Text(
                      kLabelProduct,
                      style: controller.index.value == 1
                          ? TextStyles.kH12PrimaryTextBold400
                          : TextStyles.kH12HintTextBold400,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.index.value = 2;
              },
              child: Container(
                color: kColorWhite,
              //  width: 95,
                child: Column(
                  children: [
                    controller.index.value == 2
                        ? SvgPicture.asset(kIconOrder, color: kColorPrimary)
                        : SvgPicture.asset(kIconOrder, color: kColorGrey9098B1),
                    SizedBox(height: controller.bottomBarNamePadding),
                    Text(
                      kLabelOrder,
                      style: controller.index.value == 2
                          ? TextStyles.kH12PrimaryTextBold400
                          : TextStyles.kH12HintTextBold400,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.index.value = 3;
              },
              child: Container(
                color: kColorWhite,
                // width: 95,
                child: Column(
                  children: [
                    controller.index.value == 3
                        ? SvgPicture.asset(kIconMore, color: kColorPrimary)
                        : SvgPicture.asset(kIconMore, color: kColorGrey9098B1),
                    SizedBox(height: controller.bottomBarNamePadding),
                    Text(
                      kLabelMore,
                      style: controller.index.value == 3
                          ? TextStyles.kH12PrimaryTextBold400
                          : TextStyles.kH12HintTextBold400,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 1),
          ],
        ),
      );
    });
  }
}
