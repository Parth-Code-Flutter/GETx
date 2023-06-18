import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/splash/razor_pay_testing.dart';
import 'package:tsofie/app/widgets/primary_button.dart';
import 'package:tsofie/app/widgets/while_top_widget.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({Key? key}) : super(key: key);

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Column(
          children: [
            whiteTopWidget(txt: kLabelIWantTo),
            roleSelectionWidget(),
            Visibility(
              visible: false,
              child: primaryButton(
                  onPress: () {
                    Get.to(RazorPayTesting());
                  },
                  buttonTxt: 'Razorpay Testing'),
            ),
          ],
        ),
      ),
    );
  }

  Widget roleSelectionWidget() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(kRouteLoginAsBuyerScreen);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 38),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      kImgBuyCircle,
                    ),
                    //Image.asset(kImgBuyCircle),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(kRouteLoginAsSellerScreen);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    kImgSellCircle,
                  ),
                  //Image.asset(kImgSellCircle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
