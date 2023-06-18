import 'package:flutter/material.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget commonSearchTextField(
    {required TextEditingController controller,
    required Widget preFixIcon,
    required String hintText,
      TextStyle hintStyle = TextStyles.kH12HintTextBold400,
    required Function(String) onChange}) {
  return SizedBox(
    height: 50,
    child: TextFormField(
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: preFixIcon,
        ),
        counterText: '',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kColorPrimary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorPrimary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kColorPrimary, width: 1),
        ),
      ),
    ),
  );
}
