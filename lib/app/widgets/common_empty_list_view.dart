import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget commonEmptyListView({required String img, required String txt}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(img),
      SizedBox(height: 20),
      Text(txt, style: TextStyles.kH24PrimaryBold700),
    ],
  );
}
