import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/image_constants.dart';
import 'package:tsofie/app/common/model/response/GstResponseModel.dart';
import 'package:tsofie/app/screens/seller/dashboard/product/add_product/controller/add_product_controller.dart';
import '../../../../../../common/app_constants.dart';
import '../../../../../../common/color_constants.dart';
import '../../../../../../common/model/response/categories_list_model.dart';
import '../../../../../../utils/text_styles.dart';
import '../../../../../../widgets/common_header_widget.dart';
import 'dart:io';

import '../../../../../../widgets/common_textfield.dart';
import '../../../../../../widgets/dynamic_textfiled_widget.dart';
import '../../../../../../widgets/primary_button.dart';

class SAddProductBaseScreen extends GetView<SAddProductBaseController> {
  const SAddProductBaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorBackground,
        body: SingleChildScrollView(
          child: Obx(() {
            return Column(
              children: [
                headerWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageSliderWidget(),
                      const SizedBox(
                        height: 54,
                      ),
                      addProductName(),
                      const SizedBox(
                        height: 20,
                      ),
                      selectCategories(),
                      const SizedBox(
                        height: 20,
                      ),
                      selectGstNumber(),
                      const SizedBox(
                        height: 20,
                      ),
                      qtyPriceDicount(),
                      const SizedBox(
                        height: 20,
                      ),

                    //  gstwithTexformfiled(),
                    //   const SizedBox(
                    //     height: 20,
                    //   ),
                      specification(),

                      addProductButton(),
                      // specificationWidget(),
                      // sellerNameAndLocation(),
                      //Spacer(),
                      //addToCartAndBuyButtons(),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  headerWidget() {
    return commonHeaderWidget(
      onBackTap: () {
        Get.back();
      },
      title: kLabelAddProduct,
      isShowActionWidgets: true,
    );
  }

  imageSliderWidget() {
    return SizedBox(
      height: Get.height * 0.15,
      // width: Get.width*7,
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            return Visibility(
              visible: controller.imageList.isNotEmpty,
              child: Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                    itemCount: controller.imageList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctxt, int index) {
                      print(controller.imageList[index].path);
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Material(
                              elevation: 8.0,
                              shadowColor: kColorDropShadow,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 117,
                                width: 115.4,
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(12),
                                //    // border: Border.all(color: kColorBlack, width: 1),
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    width: 76.5,
                                    height: 76.5,
                                    child: Image.file(
                                      File(controller.imageList[index].path ?? ''),
                                      //  File(controller.selectedProfileImage.value.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 99,
                            bottom: 99,
                            child: GestureDetector(
                              onTap: () {
                                controller.removeImageList(index);
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: SvgPicture.asset(kIconClose),
                              ),
                            ),
                          ),
                        ],
                      );
                      //Text(controller.imageList[Index]);
                    }),
              ),
            );
          }),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: GestureDetector(
                onTap: () {
                  openBottomSheet();
                },
                child: SvgPicture.asset(kIconAddProduct, width: 44,height: 44,)),
          ),
        ],
      ),
    );
  }

  openBottomSheet() {
    showDialog(
      context: Get.overlayContext!,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.none,
          child: Container(
            height: 100,
            width: Get.width,
            padding: const EdgeInsets.only(left: 18, top: 18),
            decoration: BoxDecoration(
                color: kColorWhite, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.imagePicker();
                  },
                  child: Container(
                    width: Get.width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Icon(Icons.image),
                        const SizedBox(width: 6),
                        const Text(
                          'Select from gallery',
                          style: TextStyles.kH14BlackBold400,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: Get.width,
                  color: kColorD8D8D8,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                ),
                GestureDetector(
                  onTap: () {
                   Get.back();
                  },
                  child: Container(
                    width: Get.width,
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Icon(Icons.close),
                        const SizedBox(width: 6),
                        const Text(
                          'Cancel',
                          style: TextStyles.kH14BlackBold400,
                        ),
                      ],
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     controller.imagePicker(ImageSource.camera);
                //   },
                //   child: Row(
                //     children: [
                //       const Icon(Icons.camera),
                //       const SizedBox(width: 6),
                //       const Text(
                //         'Take a new photo',
                //         style: TextStyles.kH14BlackBold400,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  addProductName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonTextField(
          controller: controller.productNameController,
          hintText: kLabelProductName,
          elevation: 0.0,
          prefixIconVisible: false,
          contentPadding: 20,
          onChanged: (value) {
            // controller.productNameController.text = value!;
            print("Test1 : "+controller.productNameController.text);
            if (controller.productNameController.text.trim().isEmpty) {
              controller.productNameStr.value = kErrorProductName;
              controller.isProductNamevalidate.value = false;
            } else {
              controller.productNameStr.value = '';
              controller.isProductNamevalidate.value = true;
            }
          },
        ),
        Obx(() {
          return Visibility(
            visible: controller.isProductNamevalidate.value == false,
            child: controller.productNameStr.value == ''
                ? Container()
                : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(controller.productNameStr.value,
                  style: TextStyles.kH14RedBold400),
            ),
          );
        }),
      ],
    );
  }
  specification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          elevation: 0.0,
          shadowColor: kColorDropShadow,
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 12.0, top: 12),
                child: Text(
                  kLabelSpecification,
                  style: TextStyles.kH20BlackBold700,
                ),
              ),
              SizedBox(
                height: Get.height * 0.133,
                child: TextFormField(
                  controller: controller.productSpecificationController,
                  keyboardType: TextInputType.multiline,
                  maxLength: null,
                  maxLines: null,
                  // maxLines: 5,
                  onChanged: (value) {
                    if (controller.productSpecificationController.text.trim().isEmpty) {
                      controller.specificationStr.value = kErrorSpecification;
                      controller.isSpecificationValidate.value = false;
                    } else {
                      controller.specificationStr.value = '';
                      controller.isSpecificationValidate.value = true;
                    }
                  },
                  //maxLength: 5,
                  decoration: const InputDecoration(
                    hintText: kLabelHintSpecification,
                    hintStyle: TextStyles.kH12HintTextBold400,
                    // prefixIcon: preFixIcon,
                    counterText: '',
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(color: kColorTextFieldBorder, width: 1),
                    // ),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: kColorTextFieldBorder, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Obx(() {
          return Visibility(
            visible: controller.isSpecificationValidate.value == false,
            child: controller.specificationStr.value == ''
                ? Container()
                : Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(controller.specificationStr.value,
                  style: TextStyles.kH14RedBold400),
            ),
          );
        }),
      ],
    );
  }
  selectCategories() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 0.0,
            shadowColor: kColorDropShadow,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              height: 58,
              padding: EdgeInsets.only(right: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  borderRadius: BorderRadius.circular(40),
                  isExpanded: true,
                  elevation: 0,
                  alignment: Alignment.center,
                  isDense: true,
                  items: controller.categoriesDataList
                      .map(
                        (values) =>
                        DropdownMenuItem(
                          value: values,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  values.name ?? '',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ).toList(),
                  onChanged: (value) {
                    controller.selectedCategories.value = value!;
                    if (value.name != kHintSelectCategories) {
                      controller.isCategoriesSelected.value = true;
                      controller.getCategoriesListFromServer();
                    }
                  },
                  value: controller.selectedCategories.value,
                ),
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isCategoriesSelected.value == false,
              child: controller.categoriesStr.value == ''
                  ? Container()
                  : Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(controller.categoriesStr.value,
                    style: TextStyles.kH14RedBold400),
              ),
            );
          }),
        ],
      );
    });
  }
  selectGstNumber() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 0.0,
            shadowColor: kColorDropShadow,
            borderRadius: BorderRadius.circular(40),
            child: Container(
              height: 58,
             // width: 110,
              padding: EdgeInsets.only(right: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Prices>(
                  borderRadius: BorderRadius.circular(40),
                  isExpanded: true,
                  elevation: 0,
                  alignment: Alignment.center,
                  isDense: true,value:  controller.selectedGstPrice.value ,
                  items: controller.gstDataList
                      .map(
                        (values) =>
                        DropdownMenuItem<Prices>(
                          value: values,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Text(
                                  values.priceInPer ?? '',
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ).toList(),
                  onChanged: ( value) {
                    controller.selectedGstPrice.value = value!;
                    if (value.priceInPer != kHintSelectGst) {
                      controller.isGstValidate.value = true;
                      controller.getGSTListFromServer();
                    }
                  },
                ),
              ),
            ),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isGstValidate.value == false,
              child: controller.gstStr.value == ''
                  ? Container()
                  : Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(controller.gstStr.value,
                    style: TextStyles.kH14RedBold400),
              ),
            );
          }),
        ],
      );
    });
  }

  addProductButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
      child: primaryButton(
        onPress: () {
             //controller.addProductAPICall();
         controller.validateUserInput();
        },
        buttonTxt: kLabelAddProduct,
      ),
    );
  }

  // gstwithTexformfiled() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           const Text(
  //             kLabelGST,
  //             style: TextStyles.kH20BlackBold700,
  //           ),
  //           const SizedBox(
  //             width: 30,
  //           ),
  //           Material(
  //             elevation: 8.0,
  //             shadowColor: kColorDropShadow,
  //             // borderRadius: BorderRadius.circular(8),
  //             child: SizedBox(
  //               // height: Get.height * 0.06,
  //               // width: Get.width * 0.12,
  //               child:selectGstNumber(),
  //               // child: TextFormField(
  //               //   maxLines: 1,
  //               //   maxLength: 2,
  //               //   controller: controller.gstController,
  //               //   keyboardType: TextInputType.number,
  //               //   decoration: const InputDecoration(
  //               //     // hintText: kLabelHintSpecification,
  //               //     // hintStyle: TextStyles.kH12HintTextBold400,
  //               //     // prefixIcon: preFixIcon,
  //               //     counterText: '',
  //               //     // border: OutlineInputBorder(
  //               //     //   borderSide: BorderSide(color: kColorTextFieldBorder, width: 1),
  //               //     // ),
  //               //     focusedBorder: OutlineInputBorder(
  //               //         borderSide:
  //               //         BorderSide(color: Colors.transparent, width: 1)),
  //               //     disabledBorder: OutlineInputBorder(
  //               //       borderSide:
  //               //       BorderSide(color: kColorTextFieldBorder, width: 1),
  //               //     ),
  //               //     enabledBorder: OutlineInputBorder(
  //               //       borderSide: BorderSide(
  //               //           color: Colors.transparent, width: 1),
  //               //     ),
  //               //   ),
  //               // ),
  //             ),
  //           ),
  //           const SizedBox(
  //             width: 3,
  //           ),
  //           const Text(
  //             kPercentage,
  //             style: TextStyles.kH20BlackBold700,
  //           ),
  //         ],
  //       ),
  //       Obx(() {
  //         return Visibility(
  //           visible: controller.isGstValidate.value == false,
  //           child: controller.gstStr.value == ''
  //               ? Container()
  //               : Padding(
  //             padding: const EdgeInsets.all(4.0),
  //             child: Text(controller.gstStr.value,
  //                 style: TextStyles.kH14RedBold400),
  //           ),
  //         );
  //       }),
  //     ],
  //   );
  // }

  qtyPriceDicount() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [

            Container(
              width: 20,
              height: 20,
              color: kColorWhite,
              child: Theme(
                data: ThemeData(unselectedWidgetColor: kColorD8D8D8),
                child: Checkbox(
                  value: controller.isVarient.value,
                  onChanged: (value) {
                    controller.isVarient.value = !controller.isVarient.value;
                    controller.dynamicList.clear();
                    controller.addDynamic();
                  },
                  activeColor: kColorPrimary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                      vertical: -4, horizontal: -4),
                ),
              ),
            ),

            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: (){
                controller.isVarient.value = controller.isVarient.value ? false : true;
                controller.dynamicList.clear();
                controller.addDynamic();
              },
              child: const Text(
                kLabelIsVariant,
                style: TextStyles.kH14BlackBold700,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: controller.isVarient.value ? 2 : 2,
              child: InkWell(
                onTap: () => controller.addDynamic(),
                child:  Container(
               //   color: Colors.red,
                  // height: 35,
                  width:  controller.isVarient.value? 25:40,

                  child: Visibility(
                      visible:controller.isVarient.value ? true : false,
                      child: Icon(Icons.add,size: 30,)),
                ),
              ),
            ),
            Expanded(
              flex: controller.isVarient.value ? 21:14,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // controller.addTile(),
                  // if (controller.isVarient.value)
                  //   SizedBox(
                  //     width: 15,
                  //   ),

                  if (controller.isVarient.value)
                    Container(
                 //     color: Colors.red,
                      width: controller.isVarient.value
                          ? Get.width * 0.17
                          : Get.width * 0.22,
                      height: Get.height * 0.05,
                      child: const Text(
                        kLabelSize,
                        style: TextStyles.kH14BlackBold700,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                  //  color: Colors.red,
                    width: controller.isVarient.value
                        ? Get.width * 0.17
                        : Get.width * 0.22,
                    height: Get.height * 0.05,
                    child: const Text(
                      kQty,
                      style: TextStyles.kH14BlackBold700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                  //  color: Colors.red,
                    width: controller.isVarient.value
                        ? Get.width * 0.17
                        : Get.width * 0.22,
                    height: Get.height * 0.05,
                    child: const Text(
                      kLabelPrice,
                      style: TextStyles.kH14BlackBold700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                   // color: Colors.red,
                    width: controller.isVarient.value
                        ? Get.width * 0.17
                        : Get.width * 0.22,
                    height: Get.height * 0.05,
                    child: const Text(
                      kLabelDiscount,
                      style: TextStyles.kH14BlackBold700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // if (!controller.isVarient.value)
                  //   const SizedBox(
                  //     width: 15,
                  //   ),

                  //SizedBox(width: 15,),
                ],
              ),
            ),
          ],
        ),
        //  dynamicWidget(isVarient: controller.isVarient.value),

        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.dynamicList.length,
            itemBuilder: (_, index)
            =>Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Visibility(
                visible: index==0 ? false : true,
                child: GestureDetector(
                          onTap: () {
                            controller.removeDynamicList(index);
                          },
                          child: Container(height:50,width: controller.isVarient.value? 25:40,child: Center(child: Icon(Icons.close))),
                        ),
              )
              ,Expanded(child: controller.dynamicList[index])],)
          );
        }),

        // itemsTextfiled(),
        // Flexible(
        //     flex: 1,
        //     child: Card(
        //       child: ListView.builder(
        //         itemCount: controller.Size.length,
        //         itemBuilder: (_, index) {
        //           return Padding(
        //             padding: new EdgeInsets.all(10.0),
        //             child: new Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 new Container(
        //                   margin: new EdgeInsets.only(left: 10.0),
        //                   child: new Text(
        //                       "${index + 1} : ${Size[index]}"
        //                           " ${Size[index]}"),
        //                 ),
        //                 new Divider()
        //               ],
        //             ),
        //           );
        //         },
        //       ),
        //     )),
        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //  // itemCount: controller.size_fields.length,
        //   itemBuilder: (context, index) {
        //     return itemsTextfiled();
        //   },
        // ),
      ],
    );
  }

  Widget itemsTextfiled() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: controller.isVarient.value
                  ? Get.width * 0.17
                  : Get.width * 0.22,
              height: Get.height * 0.05,
              child: Material(
                shadowColor: kColorDropShadow,
                child: TextFormField(
                  //  controller: controller.sizeController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration: const InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: kColorTextFieldBorder, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.transparent, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: controller.isVarient.value
                  ? Get.width * 0.17
                  : Get.width * 0.22,
              height: Get.height * 0.05,
              child: Material(
                // elevation: 8.0,
                shadowColor: kColorDropShadow,
                child: TextFormField(
                  // controller: controller.qtyController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration: const InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: kColorTextFieldBorder, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.transparent, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            SizedBox(
              width: controller.isVarient.value
                  ? Get.width * 0.17
                  : Get.width * 0.22,
              height: Get.height * 0.05,
              child: Material(
                // elevation: 8.0,
                shadowColor: kColorDropShadow,
                child: TextFormField(
                  //  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration: const InputDecoration(
                    counterText: '',
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1)),
                    disabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: kColorTextFieldBorder, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.transparent, width: 1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            if (controller.isVarient.value)
              SizedBox(
                width: controller.isVarient.value
                    ? Get.width * 0.17
                    : Get.width * 0.22,
                height: Get.height * 0.05,
                child: Material(
                  shadowColor: kColorDropShadow,
                  child: TextFormField(
                    // controller: controller.discountController,
                    keyboardType: TextInputType.number,
                    maxLength: 5,
                    decoration: const InputDecoration(
                      counterText: '',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.transparent, width: 1)),
                      disabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: kColorTextFieldBorder, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
