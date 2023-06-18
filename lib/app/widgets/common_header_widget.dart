import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget commonHeaderWidget({
  bool isShowBackButton = true,
  required Function onBackTap,
  required String title,
  bool isShowActionWidgets = false,
  Widget? actionWidgets,
}) {
  return Container(
    width: Get.width,
    height: 88,
    padding: EdgeInsets.only(bottom: 30, top: 6),
    decoration: const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(
            kImgAppBarBG,
          ),
          fit: BoxFit.fill),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onBackTap();
            },
            child: Container(
           //   color: Colors.red,
              child: Row(
                children: [
                  isShowBackButton
                      ? Padding(
                        padding: const EdgeInsets.only(left: 6, right: 16),
                        child: SvgPicture.asset(kIconBack),
                      )
                      : Container(),
                  Text(
                    title,
                    style: TextStyles.kH22PrimaryBold700,
                  ),
                ],
              ),
            ),
          ),
          isShowActionWidgets ? actionWidgets ?? Container() : Container()
        ],
      ),
    ),
  );
}
