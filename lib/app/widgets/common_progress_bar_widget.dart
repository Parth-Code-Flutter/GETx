import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tsofie/app/common/color_constants.dart';

Widget commonProgressBarWidget() {
  return Container(
    color: Colors.white.withOpacity(0.5),
    child: SpinKitFadingCircle(
      color: kColorPrimary,
    ),
  );
}
