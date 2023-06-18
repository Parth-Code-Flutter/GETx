import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tsofie/app/common/routing_constants.dart';
import 'package:tsofie/app/repositories/product_repo.dart';
import 'package:tsofie/app/screens/seller/dashboard/product/add_product/model/add_product_request_model.dart';

import '../../../../../../common/app_constants.dart';
import '../../../../../../common/local_storage_constants.dart';
import '../../../../../../common/model/response/GstResponseModel.dart';
import '../../../../../../common/model/response/banner_image_list_response_model.dart';
import '../../../../../../common/model/response/categories_list_model.dart';
import '../../../../../../common/model/response/product_list_model.dart';
import '../../../../../../common/model/user_pref_data.dart';
import '../../../../../../repositories/categories_repo.dart';
import '../../../../../../utils/local_storage.dart';
import '../../../../../../utils/logger_utils.dart';
import '../../../../../../widgets/dynamic_textfiled_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SEditProductController extends GetxController {
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
  var isLoading = false.obs;
  Rx<CategoriesListResponseData> categoriesData =
      CategoriesListResponseData().obs;
  RxList<Categories> categoriesDataList =
      List<Categories>.empty(growable: true).obs;

  Rx<Categories> selectedCategories = Categories().obs;
  Rx<Prices> selectedGstPrice = Prices().obs;
  Rx<GSTResponseData> gstData = GSTResponseData().obs;
  RxList<Prices> gstDataList = List<Prices>.empty(growable: true).obs;

  /// validations variables
  RxBool isImageSelected = false.obs;
  RxBool isCategoriesSelected = false.obs;
  RxBool isImageValidate = false.obs;
  RxBool isProductNamevalidate = false.obs;
  RxBool isCategoriesValidate = false.obs;
  RxBool isSizeValidate = false.obs;
  RxBool isQtyValidate = false.obs;
  RxBool isPriceValidate = false.obs;
  RxBool isDiscountValidate = false.obs;
  RxBool isGstValidate = false.obs;
  RxBool isSpecificationValidate = false.obs;

  RxString productNameStr = ''.obs;
  RxString imgStr = ''.obs;
  RxString sizeStr = ''.obs;
  RxString qtyStr = ''.obs;
  RxString priceStr = ''.obs;
  RxString discountStr = ''.obs;
  RxString gstStr = ''.obs;
  RxString specificationStr = ''.obs;

  RxList<dynamicWidget> dynamicList =
      List<dynamicWidget>.empty(growable: true).obs;

  RxList<String> Sizes = List<String>.empty(growable: true).obs;
  RxList<String> Qty = List<String>.empty(growable: true).obs;
  RxList<String> Price = List<String>.empty(growable: true).obs;

  RxList<String> Discount = List<String>.empty(growable: true).obs;
  Rx<Products> productDetailsData = Products().obs;
  RxList<Banners> bannersList = List<Banners>.empty(growable: true).obs;
  var shouldAbsorb = true;
  @override
  Future<void> onInit() async {
    Get.lazyPut(() => CategoriesRepo(), fenix: true);
    Get.lazyPut(() => ProductRepo(), fenix: true);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getCategoriesListFromServer();
    });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await getGSTListFromServer();
    // });
    var userData =
        await Get.find<LocalStorage>().getStringFromStorage(kStorageUserData);
    if (userData.isNotEmpty) {
      Map decodedData = jsonDecode(userData);
      userPrefData.value =
          UserPrefData.fromJson(decodedData as Map<String, dynamic>);
      //  AppConstants.userId = userPrefData.value.id??0;
      print('Seller Id :: ${userPrefData.value.sellerId}');
    }
    // addDynamic();
    super.onInit();
  }

  setIntentData({required dynamic intentData}) {
    try {
      productDetailsData.value = (intentData[0] as Products);
      print(
          'image length :: ${(productDetailsData.value.productImages ?? []).length}');
      if ((productDetailsData.value.productImages ?? []).isNotEmpty) {
        for (ProductImages ele
            in (productDetailsData.value.productImages ?? [])) {
          bannersList.add(Banners(id: ele.id, image: ele.image));
        }
      }
      productNameController.text = productDetailsData.value.name.toString();
      productSpecificationController.text =
          productDetailsData.value.specification.toString();
      // selectedGstPrice.value = Prices(id:productDetailsData.value.id ?? 0, priceInPer:productDetailsData.value.gst.toString() ?? '' );
      // dynamicList.value=productDetailsData.value.productVariants as List<dynamicWidget>;
      selectedCategories.value = Categories(
          id: productDetailsData.value.categoryId ?? 0,
          name: productDetailsData.value.categoryName ?? '');
      // imageList.value = productDetailsData.value.productImages!.cast<XFile>();

      /// adding imageUrl file to Xfile list
      (productDetailsData.value.productImages ?? []).forEach((element) async {
        File file =
            await _fileFromImageUrl(element.image ?? '', element.id ?? 0);
        imageList.add(XFile(file.path));
        // imageList.value.add(XFile);
      });

      isVarient.value = productDetailsData.value.isVariant ?? false;
      addDynamicWidgetList();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await getGSTListFromServer();
      });
      // print('bannersList :: ${bannersList.length}');
      // productDetailsData.value.productVariants?[currentVariantIndex.value].qty =
      // 1;
      // calculateTotalPrice();
    } catch (e) {
      LoggerUtils.logException('setIntentData', e);
    }
  }

  addDynamicWidgetList() {
    try {
      (productDetailsData.value.productVariants ?? []).forEach((element) {
        var widget = dynamicWidget(
            isVarient: productDetailsData.value.isVariant ?? false);
        widget.discountController.text = element.discountedPrice ?? '0';
        widget.priceController.text = element.price ?? '0';
        widget.qtyController.text = (element.stockQty ?? 0).toString();
        if (productDetailsData.value.isVariant == true) {
          widget.sizeController.text = element.size ?? '0';
        }
        dynamicList.add(widget);
      });
    } catch (e) {
      LoggerUtils.logException('addDynamicWidgetList', e);
    }
  }

  /// converting network url to File object
  Future<File> _fileFromImageUrl(String imageUrl, int id) async {
    final response = await http.get(Uri.parse(imageUrl));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final file = File(join(documentDirectory.path, '$id.png'));

    file.writeAsBytesSync(response.bodyBytes);
    return file;
  }

  imagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
  //  imageList.clear();
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageList.addAll(selectedImages);
      Get.back();
    }
    print("Image List Length:" + imageList.length.toString());
  }

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
    if (dynamicWidget(
      isVarient: isVarient.value,
    ).sizeController.text.trim().isEmpty) {
      sizeStr.value = kErrorSize;
      isSizeValidate.value = false;
    } else {
      sizeStr.value = '';
      isSizeValidate.value = true;
    }
  }

  qtyValidation() {
    isQtyValidate.value = false;
    if (dynamicWidget(
      isVarient: isVarient.value,
    ).qtyController.text.trim().isEmpty) {
      qtyStr.value = kErrorQty;
      isQtyValidate.value = false;
    } else {
      qtyStr.value = '';
      isQtyValidate.value = true;
    }
  }

  priceValidation() {
    isPriceValidate.value = false;
    if (dynamicWidget(
      isVarient: isVarient.value,
    ).priceController.text.trim().isEmpty) {
      priceStr.value = kErrorPrice;
      isPriceValidate.value = false;
    } else {
      priceStr.value = '';
      isPriceValidate.value = true;
    }
  }

  discountValidation() {
    isDiscountValidate.value = false;
    if (dynamicWidget(
      isVarient: isVarient.value,
    ).discountController.text.trim().isEmpty) {
      discountStr.value = kErrorDiscount;
      isDiscountValidate.value = false;
    } else {
      discountStr.value = '';
      isDiscountValidate.value = true;
    }
  }

  gstValidation() {
    isGstValidate.value = false;
    // if (gstController.text.trim().isEmpty) {
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
    if (isProductNamevalidate.value &&
        isCategoriesSelected.value &&
        isGstValidate.value &&
        isSpecificationValidate.value) {
      validateUserInput();
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
        isSpecificationValidate.value) {
      updateProductAPICall();
      print('calling....');
      // editProfileAPICall();
    } else {
      categoriesValidation();
      //   imgValidation();
      productNameValidation();
      //   sizeValidation();
      //  qtyValidation();
      //    priceValidation();
      //   discountValidation();
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

  removeImageList(int index) {
    imageList.removeAt(index);
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
      var response = await Get.find<CategoriesRepo>().getGstList();
      if (response != null && response.responseData != null) {
        gstData.value = response.responseData!;
        gstDataList.clear();
        //categoriesDataList.addAll(categoriesData.value.categories ?? []);
        gstDataList.addAll(response.responseData?.prices ?? []);
        if (gstDataList.isNotEmpty) {
          // selectedGstPrice.value = Prices(priceInPer: productDetailsData.value.gst.toString());
          int i = gstDataList.indexWhere((element) =>
          (element.priceInPer??'0').split('.').first == productDetailsData.value.gst.toString());
          if (i != -1) {
            selectedGstPrice.value = gstDataList[i];
          } else {
            gstDataList.insert(
              0,
              Prices(priceInPer: kHintSelectGst),
            );
            //selectedGstPrice.value.priceInPer == kHintSelectCategories ||
            if (selectedGstPrice.value.priceInPer == kHintSelectGst ||
                selectedGstPrice.value.priceInPer == null) {
              selectedGstPrice.value = gstDataList[0];
            }
          }
        }
      }
    } catch (e) {
      LoggerUtils.logException('get GST ListFromServer', e);
    }
  }

  // void navigateToProductDetailsScreen() {
  //   Get.toNamed(kRouteBProductDetailsScreen);
  // }

  Future<void> updateProductAPICall() async {
    List<ProductVariantsAttributes> productVariantsAttributes = [];
    // for (var element in dynamicList) {
    for (int i = 0; i < (dynamicList).length; i++) {
      // print(
      //     '${productDetailsData.value.productVariants?[i].id} :: productVariants ID');
      if (isVarient.value == true) {
        productVariantsAttributes.add(ProductVariantsAttributes(
            size: int.parse(dynamicList[i].sizeController.text.trim()),
            id: productDetailsData.value.productVariants?[i].id,
            availableQuantity:
            dynamicList[i].qtyController.text.trim().isNotEmpty
                ? int.parse(dynamicList[i].qtyController.text.trim())
                : 0,
          //  sellerId: int.parse(userPrefData.value.sellerId.toString()),
            price: dynamicList[i].priceController.text.trim(),
            discountedPrice:dynamicList[i].discountController.text.trim().length==0? '0' : dynamicList[i].discountController.text.trim(),
          //  discountedPrice: dynamicList[i].discountController.text.trim(),
            categoryId: selectedCategories.value.id));
      } else {
        productVariantsAttributes.add(ProductVariantsAttributes(
            id: productDetailsData.value.productVariants?[i].id,
            availableQuantity:
                dynamicList[i].qtyController.text.trim().isNotEmpty
                    ? int.parse(dynamicList[i].qtyController.text.trim())
                    : 0,
            //sellerId: userPrefData.value.sellerId,
            price: dynamicList[i].priceController.text.trim().isNotEmpty
                ? dynamicList[i].priceController.text.trim()
                : '',
            discountedPrice:dynamicList[i].discountController.text.trim().length==0? '0' : dynamicList[i].discountController.text.trim(),
            categoryId: selectedCategories.value.id));
      }
    }
    // }

    List<String> productImageList = [];
    for (var images in imageList) {
      productImageList.add(images.path);
    }

    var requestModel = AddProductRequestModel(
        product: Product(
            name: productNameController.text.trim(),
            specification: productSpecificationController.text.trim(),
            categoryId: selectedCategories.value.id,
            isVariant: isVarient.value,
            // gst: gstController.text.trim().isNotEmpty?int.parse(gstController.text.trim()):0,
            gst: (selectedGstPrice.value.priceInPer ?? '1').split('.').first,
            productVariantsAttributes: productVariantsAttributes,
            productImages: productImageList));

    var response = await Get.find<ProductRepo>().updateProductWithMultiPart(
        requestModel: requestModel,
        productId: productDetailsData.value.id ?? 0,
        imageList: imageList
        // imagePath: selectedProfileImage.value.path ?? '',
        // imgExtension: imgExtension,
        );
    if (response != null) {

      List<ProductVariants> resVariants = [];
      List<ProductImages> resProductImages = [];
      productVariantsAttributes.forEach((element) {
        resVariants.add(
          ProductVariants(
              id: element.id,
              size: element.size.toString(),
              discountedPrice: element.discountedPrice,stockQty: element.availableQuantity,
              price: element.price,sellerId: element.sellerId),
        );
      });

      // productImageList.forEach((element) {
      //   resProductImages.add(ProductImages(image: element));
      // });
      if(productImageList.isNotEmpty){
        for(var ele in productImageList){
          resProductImages.add(ProductImages(image: ele));
        }
      }
      //
      // Products intentProductData = Products(
      //   id: productDetailsData.value.id,
      //   name: requestModel.product?.name,
      //   categoryId: requestModel.product?.categoryId,
      //   categoryName: selectedCategories.value.name,
      //   companyAddress: productDetailsData.value.companyAddress,
      //   gst: int.parse(
      //       (selectedGstPrice.value.priceInPer ?? '0').split('.').first),
      //   isFavourite: productDetailsData.value.isFavourite,
      //   isVariant: isVarient.value,
      //   sellerCity: productDetailsData.value.sellerCity,
      //   sellerEmail: productDetailsData.value.sellerEmail,
      //   sellerId: productDetailsData.value.sellerId,
      //   sellerName: productDetailsData.value.sellerName,
      //   sellerState: productDetailsData.value.sellerState,
      //   specification: productDetailsData.value.specification,
      //   productVariants: resVariants,
      //   productImages: resProductImages,
      // );
      Products? intentProductData ;
      intentProductData = response.responseData?.products;
      Get.back(result: intentProductData);
      // Get.back();
      //  navigateToProductDetailsScreen();
      /// store user data into sharedPref
      // String productData = jsonEncode(response.product);
      // print("Product Data$productData");
    }
    // } catch (e) {
    //   LoggerUtils.logException('EditProfileSellerAPICall', e);
    // }
  }

  // Future<void> updateProductAPICall() async {
  //   List<ProductVariantsAttributes> productVariantsAttributes = [];
  //   for (var element in dynamicList) {
  //     print(element.sizeController.text.trim());
  //     // size: int.parse(element.sizeController.text.trim()
  //     if (isVarient.value == true) {
  //       productVariantsAttributes.add(ProductVariantsAttributes(
  //           size: 22,
  //           availableQuantity: int.parse(element.qtyController.text.trim()),
  //           sellerId: int.parse(userPrefData.value.sellerId.toString()),
  //           price: int.parse(element.priceController.text.trim()),
  //           discountedPrice: int.parse(element.discountController.text.trim()),
  //           categoryId: selectedCategories.value.id));
  //     } else {
  //       productVariantsAttributes.add(ProductVariantsAttributes(
  //           availableQuantity: element.qtyController.text.trim().isNotEmpty
  //               ? int.parse(element.qtyController.text.trim())
  //               : 0,
  //           sellerId: userPrefData.value.sellerId,
  //           price: element.priceController.text.trim().isNotEmpty
  //               ? int.parse(element.priceController.text.trim())
  //               : 0,
  //           discountedPrice: element.discountController.text.trim().isNotEmpty
  //               ? int.parse(element.discountController.text.trim())
  //               : 0,
  //           categoryId: selectedCategories.value.id));
  //     }
  //     // productVariantsAttributes.add(ProductVariantsAttributes(
  //     //   availableQuantity: int.parse(element.qtyController.text.trim()),
  //     //   sellerId: int.parse(userPrefData.value.sellerId.toString()),
  //     //   price: int.parse(element.priceController.text.trim()),
  //     //   discountedPrice: int.parse(element.discountController.text.trim()),
  //     //   categoryId: selectedCategories.value.id,
  //     // ));
  //     //productVariantsAttributes.add(ProductVariantsAttributes(size: 11,sellerId: 66,availableQuantity: 5,price: 444,discountedPrice: 333,categoryId: 11));
  //     //int.parse(element.discountController.text.trim()
  //   }
  //   print(productVariantsAttributes);
  //   // for(var element in imageList  ){
  //   //
  //   //   // var path = await FlutterAbsolutePath.getAbsolutePath(files[i].identifier);
  //   //   // formData.files.addAll([
  //   //   //   MapEntry("img", await MultipartFile.fromFile(path, filename: path))
  //   //   // ]);
  //   // }
  //
  //   List<String> productImageList = [];
  //   for (var images in imageList) {
  //     productImageList.add(images.path);
  //   }
  //   print('imageList ::: ${imageList.length}');
  //
  //   var requestModel = AddProductRequestModel(
  //       product: Product(
  //           name: productNameController.text.trim(),
  //           specification: productSpecificationController.text.trim(),
  //           categoryId: selectedCategories.value.id,
  //           isVariant: isVarient.value,
  //           gst: gstController.text.trim().isNotEmpty
  //               ? int.parse(gstController.text.trim())
  //               : 0,
  //           productVariantsAttributes: productVariantsAttributes,
  //           productImages: productImageList));
  //   print('AddProductRequestModel :: ${requestModel}');
  //   var response = await Get.find<ProductRepo>().addProductWithMultiPart(
  //       requestModel: requestModel, imageList: imageList
  //       // imagePath: selectedProfileImage.value.path ?? '',
  //       // imgExtension: imgExtension,
  //       );
  //   /*var response = await Get.find<ProductRepo>().addProductTextDataCallAPI(
  //     requestModel: requestModel,imageList: imageList
  //     // imagePath: selectedProfileImage.value.path ?? '',
  //     // imgExtension: imgExtension,
  //   );*/
  //   if (response != null) {
  //     Get.back();
  //
  //     /// store user data into sharedPref
  //     // String productData = jsonEncode(response.product);
  //     // print("Product Data$productData");
  //   }
  //   // } catch (e) {
  //   //   LoggerUtils.logException('EditProfileSellerAPICall', e);
  //   // }
  // }
  Future<void> navigateToProductDetailsScreen() async {
    await Get.toNamed(kRouteSProductDetailsScreen,
        arguments: [productDetailsData.value.obs]);
  }
}
