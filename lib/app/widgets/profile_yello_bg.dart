import 'package:flutter/material.dart';
import 'package:tsofie/app/common/color_constants.dart';

Widget profileYellowBG() {
  return Positioned(
    top: -16,
    left: 25,
    child: Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: kColorYellowFFBE10,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    ),
  );
}
