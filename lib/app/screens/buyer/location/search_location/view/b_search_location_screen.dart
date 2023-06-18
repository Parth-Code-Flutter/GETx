import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/buyer/location/search_location/controller/b_search_location_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_search_textfield.dart';

class BSearchLocationScreen extends GetView<BSearchLocationController> {
  BSearchLocationScreen({Key? key}) : super(key: key) {
    final intentData = Get.arguments;
    controller.setIntentData(intentData: intentData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            headerWidget(),
            searchLocationTextField(),
            searchLocationListView(),
          ],
        ),
      ),
    );
  }

  headerWidget() {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          Get.back();
        },
        child: commonHeaderWidget(
          onBackTap: () {
            Get.back();
          },
          title: kLabelSearchLocation,
          actionWidgets: GestureDetector(
            onTap: () {
              controller.clearAllLocationFilter();
            },
            child: Visibility(
              visible: controller.selectedLocationData.value.state != null ||
                  (controller.selectedLocationData.value.state ?? '')
                      .isNotEmpty,
              child: GestureDetector(
                child: Text(kLabelClear,style: TextStyles.kH14PrimaryBold700),
              ),
            ),
          ),
          isShowActionWidgets: controller.selectedLocationData.value.state !=
                  null ||
              (controller.selectedLocationData.value.state ?? '').isNotEmpty,
        ),
      );
    });
  }

  Widget searchLocationTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: commonSearchTextField(
        controller: controller.searchController,
        hintText: kLabelSearchLocation,
        preFixIcon: SvgPicture.asset(kIconSearchCoffee),
        hintStyle: TextStyles.kH14PrimaryBold700,
        onChange: (value) {
          if (value.trim().isNotEmpty) {
            controller.searchLocationText.value = value.trim();
            controller.onSearchValueChange();
          } else {
            controller.searchLocationText.value = '';
          }
        },
      ),
    );
  }

  Widget searchLocationListView() {
    return Obx(() {
      return SizedBox(
        height: Get.height * 0.75,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: controller.searchLocationText.value.isNotEmpty
              ? controller.searchLocationDataList.length
              : controller.locationDataList.length,
          itemBuilder: (context, index) {
            var locationData = controller.searchLocationText.value.isNotEmpty
                ? controller.searchLocationDataList[index]
                : controller.locationDataList[index];
            return Column(
              children: [
                ListTile(
                  leading: SvgPicture.asset(kIconLocation),
                  dense: true,
                  minLeadingWidth: 0,
                  onTap: () {
                    controller.navigateToBackScreen(index);
                  },
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(locationData.state ?? '',
                          style: TextStyles.kH14PrimaryBold700),
                      // Text('Ahmedabad, Gujarat',
                      //     style: TextStyles.kH14Grey9098B1Bold700),
                    ],
                  ),
                  trailing: Visibility(
                    visible: locationData.isDefault == true,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: kColorPrimary,
                      child: Icon(Icons.done, size: 14, color: kColorWhite),
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.locationDataList.length - 1 != index,
                  child: Container(
                    height: 1,
                    width: Get.width,
                    color: kColorGrey9098B1,
                    margin: EdgeInsets.symmetric(horizontal: 6),
                  ),
                )
              ],
            );
          },
        ),
      );
    });
  }
}
