import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/common/app_constants.dart';
import 'package:tsofie/app/common/color_constants.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/screens/seller/dashboard/RecentBuyers/controller/s_recent_buyers_list_controller.dart';
import 'package:tsofie/app/utils/text_styles.dart';
import 'package:tsofie/app/widgets/common_empty_list_view.dart';
import 'package:tsofie/app/widgets/common_header_widget.dart';
import 'package:tsofie/app/widgets/common_product_data_container.dart';
import 'package:tsofie/app/widgets/common_search_textfield.dart';
import '../../../../../widgets/common_progress_bar_widget.dart';
import '../../../../../widgets/recent_buyers_listview.dart';

class SRecentBuyersListScreen extends GetView<SRecentBuyersListController> {
  const SRecentBuyersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kColorBackground,
        body: Obx(() {
          return Stack(
            children: [
              Column(
                children: [
                  headerWidget(),
               //   searchTextField(),
                  controller.recentBuyersResponseDataList.isEmpty &&
                      controller.isDataLoading.value == false
                      ? Expanded(
                    child: commonEmptyListView(
                      img: kImgEmptyProduct2,
                      txt: kEmptyProduct,
                    ),
                  )
                      : buyersListView(),
                ],
              ),
              Visibility(
                visible: controller.isDataLoading.value,
                child: commonProgressBarWidget(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelRecentBuyers,
      isShowBackButton: true,
      isShowActionWidgets: false,
      actionWidgets: Row(
        children: [
          GestureDetector(
              onTap: () {
                controller.navigateToAddProductScreen();
              },
              child: Image.asset(kIconAdd, height: 25, width: 25)),
          SizedBox(width: 14),
          SvgPicture.asset(kIconFilter, height: 25, width: 25),
        ],
      ),
    );
  }

  searchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: commonSearchTextField(
        controller: controller.searchController,
        preFixIcon: SvgPicture.asset(kIconSearchCoffee),
        hintText: kLabelProductName,
        onChange: (value) {},
      ),
    );
  }

  buyersListView() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: GridView.builder(
          itemCount: controller.recentBuyersResponseDataList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: Get.height * 0.29,
              crossAxisSpacing: 6,
              mainAxisSpacing: 0,
              childAspectRatio: (67 / 100)),
          padding: EdgeInsets.only(left: 16),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                controller.navigateToProductDetailsScreen(index);
              },
              child: SizedBox(
                height: Get.height * 0.33,
                child: sRecentBuyersDataContainer(
                  productImage:  controller.recentBuyersResponseDataList[index].productImages?[0].image.toString() ?? '',
                  productName: controller.recentBuyersResponseDataList[index].productName ?? '',
                  productOriginalPrice: double.parse('${controller.recentBuyersResponseDataList[index].productVariantDiscountedPrice}'),
                  buyersName: controller.recentBuyersResponseDataList[index].name ?? '',
                  productQty:int.parse('${controller.recentBuyersResponseDataList[index].orderProductVariantQuantity}'),
                    isMainProductListing:true
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
