import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/model/response/GstResponseModel.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/product_repo.dart';

import '../../../../../../common/app_constants.dart';
import '../../../../../../common/local_storage_constants.dart';
import '../../../../../../common/model/response/categories_list_model.dart';
import '../../../../../../common/model/user_pref_data.dart';
import '../../../../../../repositories/categories_repo.dart';
import '../../../../../../utils/alert_message_utils.dart';
import '../../../../../../utils/local_storage.dart';
import '../../../../../../utils/logger_utils.dart';
import '../../../../../../widgets/dynamic_textfiled_widget.dart';
import '../model/add_product_request_model.dart';

class SAddProductBaseController extends GetxController {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productSpecificationController =
      TextEditingController();
  TextEditingController gstController = TextEditingController();
  Rx<XFile> selectedProfileImage = XFile('').obs;
  RxList<XFile> imageList = List<XFile>.empty(growable: true).obs;
  Rx<UserPrefData> userPrefData = UserPrefData().obs;
  RxBool isVarient = false.obs;
  Map<String, String>? reqData;
  RxString categoriesStr = ''.obs;
  RxString gstStr = ''.obs;
  var isLoading = false.obs;
  Rx<CategoriesListResponseData> categoriesData =
      CategoriesListResponseData().obs;
  RxList<Categories> categoriesDataList =
      List<Categories>.empty(growable: true).obs;
  Rx<GSTResponseData> gstData =
      GSTResponseData().obs;
  RxList<Prices> gstDataList =
      List<Prices>.empty(growable: true).obs;
  Rx<Categories> selectedCategories = Categories().obs;
  Rx<Prices> selectedGstPrice = Prices().obs;
  /// validations variables
  RxBool isImageSelected = false.obs;
  RxBool isCategoriesSelected = false.obs;
  RxBool isGstSelected = false.obs;
  RxBool isImageValidate = false.obs;
  RxBool isProductNamevalidate =false.obs;
  RxBool isCategoriesValidate = false.obs;
  RxBool isSizeValidate=false.obs;
  RxBool isQtyValidate=false.obs;
  RxBool isPriceValidate=false.obs;
  RxBool isDiscountValidate=false.obs;
  RxBool isGstValidate=false.obs;
  RxBool isSpecificationValidate=false.obs;

  RxString productNameStr = ''.obs;
  RxString imgStr=''.obs;
  RxString sizeStr = ''.obs;
  RxString qtyStr = ''.obs;
  RxString priceStr = ''.obs;
  RxString discountStr = ''.obs;
  RxString specificationStr = ''.obs;

  RxList<dynamicWidget> dynamicList =
      List<dynamicWidget>.empty(growable: true).obs;

  RxList<String> Sizes = List<String>.empty(growable: true).obs;
  RxList<String> Qty = List<String>.empty(growable: true).obs;
  RxList<String> Price = List<String>.empty(growable: true).obs;

  RxList<String> Discount = List<String>.empty(growable: true).obs;

  @override
  Future<void> onInit() async {
    Get.lazyPut(() => CategoriesRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCategoriesListFromServer();

    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getGSTListFromServer();

    });
    var userData =
        await Get.find<LocalStorage>().getStringFromStorage(kStorageUserData);
    if (userData.isNotEmpty) {
      Map decodedData = jsonDecode(userData);
      userPrefData.value =
          UserPrefData.fromJson(decodedData as Map<String, dynamic>);
      //  AppConstants.userId = userPrefData.value.id??0;
      print('Seller Id :: ${userPrefData.value.sellerId}');
    }
    addDynamic();
   // selectedGstPrice.value = kHintSelectGst;
    super.onInit();
  }

  imagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    //imageList.clear();
    final List<XFile> selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageList.addAll(selectedImages);
      Get.back();
    }
    print("Image List Length:" + imageList.length.toString());

  }
  // imagePicker(ImageSource source) async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? pickedFile = await picker.pickImage(source: source);
  //
  //   if (pickedFile != null) {
  //     selectedProfileImage.value = pickedFile;
  //     imageList.add(pickedFile);
  //     // for (int i = 0; i < imageList.length; i++) {
  //     //   debugPrint("imageList: ${imageList[i].path}");
  //     //   //reqData?.addAll(imageList[i].path as Map<String, String>);
  //     // }
  //     Get.back();
  //   }
  // }

  productNameValidation() {
    isProductNamevalidate.value = false;
    if (productNameController.text.trim().isEmpty) {
      productNameStr.value = kErrorProductName;
      isProductNamevalidate.value = false;
    } else {
      productNameStr.value = '';
      isProductNamevalidate.value = true;
    }
  }
  imgValidation() {
    isImageSelected.value = false;
    if (dynamicList.value.isEmpty) {
      imgStr.value = kErrorImg;
      isImageSelected.value = false;
    } else {
      imgStr.value = '';
      isImageSelected.value = true;
    }
  }
  sizeValidation() {
    isSizeValidate.value = false;
    if (dynamicWidget(isVarient: isVarient.value,).sizeController.text.trim().isEmpty) {
      sizeStr.value = kErrorSize;
      isSizeValidate.value = false;
    } else {
      sizeStr.value = '';
      isSizeValidate.value = true;
    }
  }
  qtyValidation() {
    isQtyValidate.value = false;
    if (dynamicWidget(isVarient: isVarient.value,).qtyController.text.trim().isEmpty) {
      qtyStr.value = kErrorQty;
      isQtyValidate.value = false;
    } else {
      qtyStr.value = '';
      isQtyValidate.value = true;
    }
  }
  priceValidation() {
    isPriceValidate.value = false;
    if (dynamicWidget(isVarient: isVarient.value,).priceController.text.trim().isEmpty) {
      priceStr.value = kErrorPrice;
      isPriceValidate.value = false;
    } else {
      priceStr.value = '';
      isPriceValidate.value = true;
    }
  }
  discountValidation() {
    isDiscountValidate.value = false;
    if (dynamicWidget(isVarient: isVarient.value,).discountController.text.trim().isEmpty) {
      discountStr.value = kErrorDiscount;
      isDiscountValidate.value = false;
    } else {
      discountStr.value = '';
      isDiscountValidate.value = true;
    }
  }
  gstValidation() {
    isGstValidate.value = false;
    if (selectedGstPrice.value.priceInPer == kHintSelectGst) {
      gstStr.value = kErrorGst;
      isGstValidate.value = false;
    } else {
      gstStr.value = '';
      isGstValidate.value = true;
    }
  }
  specificationValidation() {
    isSpecificationValidate.value = false;
    if (productSpecificationController.text.trim().isEmpty) {
      specificationStr.value = kErrorSpecification;
      isSpecificationValidate.value = false;
    } else {
      specificationStr.value = '';
      isSpecificationValidate.value = true;
    }
  }
  categoriesValidation() {
    isCategoriesSelected.value = false;
    if (selectedCategories.value.name == kHintSelectCategories) {
      categoriesStr.value = kErrorCategories;
      isCategoriesSelected.value = false;
    } else {
      categoriesStr.value = '';
      isCategoriesSelected.value = true;
    }
  }

  void validateUserInput() {
    if (isProductNamevalidate.value &&
        isCategoriesSelected.value &&
        isGstValidate.value &&
        isSpecificationValidate.value
        //&&
        // isImageSelected.value &&
        // isSizeValidate.value &&
        // isQtyValidate.value &&
        // isPriceValidate.value &&
        // isDiscountValidate.value
    ) {
      addProductAPICall();

      // editProfileAPICall();
    } else {
      categoriesValidation();
     //imgValidation();
      productNameValidation();
     // sizeValidation();
     // qtyValidation();
     // priceValidation();
     // discountValidation();
      gstValidation();
      specificationValidation();
    }
  }

  addDynamic() {
    // if(Size.length != 0){
    if (Sizes.isNotEmpty) {
      //floatingIcon = new Icon(Icons.add);

      if (isVarient.value) {}
      Sizes = List<String>.empty(growable: true).obs;
      Price = List<String>.empty(growable: true).obs;
      Qty = List<String>.empty(growable: true).obs;
      Discount = List<String>.empty(growable: true).obs;
      dynamicList = List<dynamicWidget>.empty(growable: true).obs;
    }
    if (dynamicList.length >= 10) {
      return;
    }
    dynamicList.add(dynamicWidget(
      isVarient: isVarient.value,
    ));
  }

  Future<void> getCategoriesListFromServer() async {
    try {
      var response =
          await Get.find<CategoriesRepo>().getCategoriesList(page: 1);
      if (response != null && response.responseData != null) {
        categoriesData.value = response.responseData!;
        categoriesDataList.clear();
        //categoriesDataList.addAll(categoriesData.value.categories ?? []);
        categoriesDataList.addAll(response.responseData?.categories ?? []);
        if (categoriesDataList.isNotEmpty) {
          categoriesDataList.insert(
            0,
            Categories(name: kHintSelectCategories),
          );
          if (selectedCategories.value.name == kHintSelectCategories ||
              selectedCategories.value.name == '' ||
              selectedCategories.value.name == null) {
            selectedCategories.value = categoriesDataList[0];
          }
          int i = categoriesDataList.indexWhere(
              (element) => element.name == selectedCategories.value.name);
          if (i != -1) {
            selectedCategories.value = categoriesDataList[i];
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('getCategoriesListFromServer', e);
    }
  }
  Future<void> getGSTListFromServer() async {
    try {
      var response =
      await Get.find<CategoriesRepo>().getGstList();
      if (response != null && response.responseData != null) {
        gstData.value = response.responseData!;
        gstDataList.clear();
        //categoriesDataList.addAll(categoriesData.value.categories ?? []);
        gstDataList.addAll(response.responseData?.prices ?? []);
        if (gstDataList.isNotEmpty) {
          gstDataList.insert(
            0,
            Prices(priceInPer: kHintSelectGst),
          );
          //selectedGstPrice.value.priceInPer == kHintSelectCategories ||
          if (selectedGstPrice.value.priceInPer == kHintSelectGst ||
              selectedGstPrice.value.priceInPer == null) {
            selectedGstPrice.value = gstDataList[0];
          }
          int i = gstDataList.indexWhere(
                  (element) => element.priceInPer == selectedGstPrice.value.priceInPer);
          if (i != -1) {
            selectedGstPrice.value = gstDataList[i];
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('get GST ListFromServer', e);
    }
  }
  removeDynamicList(int index){
    dynamicList.removeAt(index);
  }
  removeImageList(int index){
    imageList.removeAt(index);
  }
  void navigateToProductDetailsScreen() {
    Get.toNamed(kRouteBProductDetailsScreen);
  }

  Future<void> addProductAPICall() async {
    // String fileName = selectedProfileImage.value.path.split("/").last;
    // String imgExtension = fileName.split(".").last;

    // var requestModel = AddProductRequestModel(
    //     product: Product(
    //       name: productNameController.text.trim(),
    //       specification: productSpecificationController.text.trim(),
    //       categoryId: selectedCategories.value.id,
    //       isVariant: isVarient.value,
    //       gst: gstController.text.trim(),
    //      productVariantsAttributes: [
    //
    //       ProductVariantsAttributes(
    //
    //         size: jsonEncode(dynamicList[0].sizeController.text.trim()),
    //         availableQuantity: jsonEncode(dynamicList[0].qtyController.text.trim()),
    //         price: jsonEncode(dynamicList[0].priceController.text.trim()),
    //         discountedPrice: jsonEncode(dynamicList[0].discountController.text.trim()),
    //         sellerId: userPrefData.value.sellerId.toString(),
    //         categoryId:  selectedCategories.value.id.toString()
    //       )
    //
    //      ],
    //      productImages: []
    //      // productImages:List<ProductImages>.from(imageList.map((x) => x)),
    //      // productVariantsAttributes:  ,
    //     ),
    //
    // );

    List<ProductVariantsAttributes> productVariantsAttributes = [];
    for (var element in dynamicList) {
      print(element.sizeController.text.trim());
      // size: int.parse(element.sizeController.text.trim()
      if (isVarient.value == true) {
        productVariantsAttributes.add(ProductVariantsAttributes(

            size: int.parse(element.sizeController.text.trim()),
            availableQuantity: int.parse(element.qtyController.text.trim()),
          //  sellerId: int.parse(userPrefData.value.sellerId.toString()),
            price:element.priceController.text.trim(),
            discountedPrice:element.discountController.text.trim().length==0? '0' : element.discountController.text.trim(),
            //  discountedPrice:element.discountController.text.trim(),
            categoryId: selectedCategories.value.id));
      } else {
            productVariantsAttributes.add(ProductVariantsAttributes(
                availableQuantity: int.parse(element.qtyController.text.trim()),
                //  availableQuantity: element.qtyController.text.trim().isNotEmpty?int.parse(element.qtyController.text.trim()):0,
           // sellerId: userPrefData.value.sellerId,
            price: element.priceController.text.trim(),
                discountedPrice:element.discountController.text.trim().length==0? '0' : element.discountController.text.trim(),
                // discountedPrice: element.discountController.text.trim(),
            categoryId: selectedCategories.value.id));
      }
      print(userPrefData.value.sellerId);
      // productVariantsAttributes.add(ProductVariantsAttributes(
      //   availableQuantity: int.parse(element.qtyController.text.trim()),
      //   sellerId: int.parse(userPrefData.value.sellerId.toString()),
      //   price: int.parse(element.priceController.text.trim()),
      //   discountedPrice: int.parse(element.discountController.text.trim()),
      //   categoryId: selectedCategories.value.id,
      // ));
      //productVariantsAttributes.add(ProductVariantsAttributes(size: 11,sellerId: 66,availableQuantity: 5,price: 444,discountedPrice: 333,categoryId: 11));
      //int.parse(element.discountController.text.trim()
    }
    print(productVariantsAttributes);
    // for(var element in imageList  ){
    //
    //   // var path = await FlutterAbsolutePath.getAbsolutePath(files[i].identifier);
    //   // formData.files.addAll([
    //   //   MapEntry("img", await MultipartFile.fromFile(path, filename: path))
    //   // ]);
    // }

    List<String> productImageList = [];
    for (var images in imageList) {
      productImageList.add(images.path);
    }
    print('imageList ::: ${imageList.length}');

    var requestModel = AddProductRequestModel(
        product: Product(
            name: productNameController.text.trim(),
            specification: productSpecificationController.text.trim(),
            categoryId: selectedCategories.value.id,
            isVariant: isVarient.value,
            gst: selectedGstPrice.value.priceInPer.toString() ?? '',
            productVariantsAttributes: productVariantsAttributes,
            productImages: productImageList));
    print('AddProductRequestModel :: ${requestModel}');
    var response = await Get.find<ProductRepo>().addProductWithMultiPart(
      requestModel: requestModel,imageList: imageList
      // imagePath: selectedProfileImage.value.path ?? '',
      // imgExtension: imgExtension,
    );
    /*var response = await Get.find<ProductRepo>().addProductTextDataCallAPI(
      requestModel: requestModel,imageList: imageList
      // imagePath: selectedProfileImage.value.path ?? '',
      // imgExtension: imgExtension,
    );*/
    if (response != null) {

       Get.back(result: true);
      Get.find<AlertMessageUtils>()
          .showSnackBar(message: response.responseMessage ?? '');
      /// store user data into sharedPref
      // String productData = jsonEncode(response.product);
      // print("Product Data$productData");
    }
    // } catch (e) {
    //   LoggerUtils.logException('EditProfileSellerAPICall', e);
    // }
  }
}
