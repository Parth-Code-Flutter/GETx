import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget primaryButton({
  required Function onPress,
  required String buttonTxt,
  double? width,
  double? height,
}) {
  return MaterialButton(
    padding: EdgeInsets.zero,
    onPressed: () {
      onPress();
    },
    child: Container(
      width: width == null ? Get.width : width,
      height: height == null ? 58 : height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [
            const Color(0XFF371400).withOpacity(0.5),
            const Color(0XFF371400).withOpacity(1),
            // Color.fromARGB(255, 29, 221, 163),
          ],
        ),
        // image:
        //     DecorationImage(image: AssetImage(kImgButtonBG), fit: BoxFit.cover),
      ),
      child: Text(
        buttonTxt,
        style: TextStyles.kH14WhiteBold700,
      ),
    ),
  );
}
