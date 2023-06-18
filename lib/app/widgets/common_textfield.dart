import 'package:flutter/material.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/utils/text_styles.dart';

Widget commonTextField(
    {required TextEditingController controller,
    required String hintText,
     Widget? preFixIcon,
    FocusNode? focusNode,
    TextInputType keyboardType = TextInputType.text,
      Function(String)? onChanged,
    int maxLength = 50,
      double elevation=8.0,
    int maxLines = 1,
      double contentPadding = 15,
    bool enabled = true,
  //    Function(String)? validator,
    bool prefixIconVisible = true}) {
  return Material(
    elevation: elevation,
    shadowColor: kColorDropShadow,
    borderRadius: BorderRadius.circular(40),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
    //  validator: validator,
      maxLength: maxLength,
      maxLines: maxLines,
      enabled: enabled,
      // autofocus: true,
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding),
        hintText: hintText,
        hintStyle: TextStyles.kH12HintTextBold400,
        prefixIcon: prefixIconVisible ? preFixIcon : null,
        counterText: '',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kColorTextFieldBorder, width: 1),
        ),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color:  Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 1),
        ),
      ),
    ),
  );
}
