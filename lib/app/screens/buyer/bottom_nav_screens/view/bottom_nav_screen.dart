import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/bottom_nav_screens/controller/bottom_nav_controller.dart';
import 'package:tsofie/app/screens/buyer/dashboard/home/view/b_home_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/base/view/b_more_base_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/order/base/view/b_order_base_screen.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/view/b_product_base_screen.dart';

import '../../../../utils/text_styles.dart';

class BuyerBottomNavScreen extends GetView<BuyerBottomNavController> {
  const BuyerBottomNavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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
      ),
    );
  }

  Widget _stackedContainers() {
    return Expanded(
      child: Obx(() {
        return IndexedStack(
          index: controller.index.value,
          children: [
            BHomeScreen(),
            BProductBaseScreen(),
            BOrderBaseScreen(),
            BMoreBaseScreen(),
          ],
        );
      }),
    );
  }

  Widget _navigationButtons() {
    return Obx(() {
      return Container(
        color: kColorWhite,
        padding: EdgeInsets.symmetric(vertical: 12),
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
              //  width: 90,
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
                //width: 90,
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
               // width: 90,
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
              //  width: 90,
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
            SizedBox(width: 1,),
          ],
        ),
      );
    });
  }
}
