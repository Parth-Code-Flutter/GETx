import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget whiteTopWidget({required String txt}) {
  return Container(
    width: Get.width,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(
            kImgAppBarBG,
          ),
          fit: BoxFit.fill),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16,bottom: 8),
            child: Image.asset(kImgAppHorizontalLogo,height: 50),
          ),
          Text(txt, style: TextStyles.kH16PrimaryBold700),
          SizedBox(height: 40),
        ],
      ),
    ),
  );
}
