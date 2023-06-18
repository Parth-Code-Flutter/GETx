import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

Widget alertDialogWidget({
  required String title,
  required String subTitle,
  required String icon,
  required Function onSuccessTap,
  required Function onCancelTap,
  bool isSvg = false,
}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width,
          height: 120,
          decoration: BoxDecoration(color: kColorBackground),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              isSvg?SvgPicture.asset(icon): Image.asset(icon)
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(title, style: TextStyles.kH16PrimaryBold700),
        SizedBox(height: 4),
        Text(subTitle, style: TextStyles.kH14PrimaryBold400),
        Container(
          margin: EdgeInsets.only(top: 12, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              primaryButton(
                onPress: () {
                  onSuccessTap();
                },
                buttonTxt: kLabelYes,
                width: 78,
                height: 38,
              ),
              primaryButton(
                onPress: () {
                  onCancelTap();
                },
                buttonTxt: kLabelNo,
                width: 78,
                height: 38,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
