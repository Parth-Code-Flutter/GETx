import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/screens/buyer/dashboard/more/select_language/controller/b_select_language_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/primary_button.dart';

class BSelectLanguageScreen extends GetView<BSelectLanguageController> {
  const BSelectLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: Column(
          children: [
            headerWidget(),
            selectLanguageCheckbox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: primaryButton(onPress: () {}, buttonTxt: kLabelSave),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
        onBackTap: () {
          Get.back();
        },
        title: kLabelSelectLanguage);
  }

  selectLanguageCheckbox() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Theme(
                  data: ThemeData(unselectedWidgetColor: kColorD8D8D8),
                  child: Checkbox(
                    value: controller.isEngSelected.value,
                    onChanged: (value) {
                      controller.changeLanguage(0);
                    },
                    activeColor: kColorPrimary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  kLabelEnglish,
                  style: TextStyles.kH16PrimaryBold700,
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Theme(
                  data: ThemeData(unselectedWidgetColor: kColorD8D8D8),
                  child: Checkbox(
                    value: controller.isHindiSelected.value,
                    onChanged: (value) {
                      controller.changeLanguage(1);
                    },
                    activeColor: kColorPrimary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  kLabelHindi,
                  style: TextStyles.kH16PrimaryBold700,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
