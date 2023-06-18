import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/location/add_location/controller/b_add_location_controller.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_textfield.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BAddLocationScreen extends GetView<BAddLocationController> {
  const BAddLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: kColorBackground,
          body: Column(
            children: [
              headerWidget(),
              SizedBox(height: 16),
              stateAndCityTextFields(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 50),
                child: primaryButton(
                  onPress: () {},
                  buttonTxt: kLabelSave,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelAddLocation,
    );
  }

  stateAndCityTextFields() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: commonTextField(
            controller: controller.stateController,
            hintText: kLabelYourState,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(left: 12,bottom: 12,top: 12,right: 12),
              child: SvgPicture.asset(kIconState),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: commonTextField(
            controller: controller.cityController,
            hintText: kLabelYourCity,
            preFixIcon: Padding(
              padding: const EdgeInsets.only(left: 12,bottom: 12,top: 12,right: 12),
              child: SvgPicture.asset(kIconCity),
            ),
          ),
        ),
      ],
    );
  }
}
