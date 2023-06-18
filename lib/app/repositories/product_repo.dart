import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tsofie/app/common/response_status_codes.dart';
import 'package:tsofie/app/screens/buyer/dashboard/product/base/model/response/product_list_response_model.dart';
import 'package:tsofie/app/screens/seller/dashboard/product/edit_product/model/response/edit_product_resposne_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/services/api_services.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

import '../common/app_constants.dart';
import '../common/model/response/product_list_model.dart';
import '../screens/seller/dashboard/product/add_product/model/add_product_request_model.dart';
import '../screens/seller/dashboard/product/add_product/model/add_product_response_model.dart';
import 'package:image_picker/image_picker.dart';

class ProductRepo {
  Future<ProductListResponseModel?> getProductListApiCall(
      {required int pageNumber,
      required String name,
      required String state,
      String catId = '',
      bool isShowLoader = true,
      bool isFromSellerSide = false,}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint:
              isFromSellerSide?'${ApiConst.productList_seller}?page=$pageNumber&name=$name&state=$state&category_id=$catId'
              :'${ApiConst.productList}?page=$pageNumber&name=$name&state=$state&category_id=$catId',
          isShowLoader: isShowLoader);

      if (response != null) {
        var responseModel = productListResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode ||
            responseModel.responseCode == noDataFoundCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getProductListApiCall', e);
    }
    return null;
  }

  Future<ProductList?> getRecentProductsList({required int page}) async {
    try {
      var response = await ApiService()
          .getRequest(endPoint: '${ApiConst.recentProducts}?page=$page');

      /// update : locationList in appCosnt file

      if (response != null) {
        print("response recent products :: ${response.body}");
        var responseModel =
            productListSellerResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          // Get.find<AlertMessageUtils>()
          //     .showSnackBar(message: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('RecentProductsList', e);
    }
    return null;
  }

  Future<ProductList?> getSellerProductListApiCall(
      {required int pageNumber,required String name,}) async {
    try {
      var response = await ApiService().getRequest(
          endPoint: '${ApiConst.productList_seller}?page=$pageNumber&name=$name',
          isShowLoader: false);

      if (response != null) {
        var responseModel =
            productListSellerResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode ||
            responseModel.responseCode == noDataFoundCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel.responseMessage ?? '');
        }
      }
    } catch (e) {
      LoggerUtils.logException('getSellerProductListApiCall', e);
    }
    return null;
  }

  /// fav/unfav product api call
  Future<bool?> favUnFavProductApi({
    required int productId,
    required bool isFavourite,
    required int buyerId,
  }) async {
    try {
      var response = await ApiService().postRequest(
          endPoint:
              '${ApiConst.productList}/$productId/${ApiConst.favUnFav}?is_favourite=$isFavourite&buyer_id=$buyerId');

      if (response != null) {
        var responseModel = jsonDecode(response.body);
        if (responseModel['response_code'] == 200) {
          return true;
        } else {
          Get.find<AlertMessageUtils>()
              .showToastMessages(msg: responseModel['response_message']);
          return false;
        }
      }
    } catch (e) {
      LoggerUtils.logException('favUnFavProductApi', e);
    }
    return false;
  }

  Future<AddProductResponseModel?> addProductWithMultiPart({
    required AddProductRequestModel requestModel,
    required List<XFile> imageList,
    // required String imagePath,
    // required String imgExtension,
    bool isVeriant = true,
  }) async {
    var response = await ApiService().postRequestWithMultiPartForAddProduct(
        endPoint: ApiConst.addProduct,
        imageList: imageList,
        //  imagePath: imagePath,
        // imgExtension: imgExtension,
        // isBuyerProfileUpdate: isBuyerProfileUpdate,
        // requestModel: editProfileRequestModelToJson(requestModel));
        requestModel: requestModel,
        isVeriant: isVeriant);

    if (response != null) {
      var responseModel = addProductResponseModelFromJson(response.body);

      if (responseModel.responseCode == successCode) {
        print('Add product Response :: ${response.body}');

        return responseModel;
      } else {
        Get.find<AlertMessageUtils>()
            .showToastMessages(msg: responseModel.responseMessage ?? '');
      }
    }
    try {} catch (e) {
      LoggerUtils.logException('addProductWithMultiPart', e);
    }
    return null;
  }

  Future<AddProductRequestModel?> addProductTextDataCallAPI(
      {required AddProductRequestModel requestModel,
      required List<XFile> imageList}) async {
    try {
      var response = await ApiService().postRequest(
        endPoint: ApiConst.addProduct,
        requestModel: addProductRequestModelToJson(requestModel),
      );
      if (response != null) {
        print(response.body);
        // var responseModel =
        // buyerLoginResponseModelFromJson(response.body ?? '');
        // if (response.statusCode == successCode) {
        //   return responseModel;
        // } else {
        //   Get.find<AlertMessageUtils>()
        //       .showSnackBar(message: responseModel.responseMessage ?? '');
        // }
      }
    } catch (e) {
      LoggerUtils.logException('addProductTextDataCallAPI', e);
      Get.find<AlertMessageUtils>().showToastMessages(msg: kError);
    }
    return null;
  }

  /// delete product api call
  Future<bool?> deleteProductApi({required int productId}) async {
    try {
      var response = await ApiService()
          .deleteRequest(endPoint: '${ApiConst.deleteProduct}/$productId');

      if (response != null && response.statusCode == successCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      LoggerUtils.logException('deleteProductApi', e);
    }
    return false;
  }

  /// update product api call
  Future<EditProductResponseModel?> updateProductWithMultiPart(
      {required AddProductRequestModel requestModel,
      required int productId,
      required List<XFile> imageList,
      // required String imagePath,
      // required String imgExtension,
      bool isVariant = true}) async {
    try {
      var response = await ApiService().putRequestWithMultiPartForAddProduct(
          endPoint: '${ApiConst.updateProduct}/$productId',
          requestModel: requestModel,
          isVariant: isVariant,
          imageList: imageList);

      if (response != null && response.statusCode == successCode) {
        var responseModel = editProductResponseModelFromJson(response.body);
        if (responseModel.responseCode == successCode) {
          return responseModel;
        } else {
          Get.find<AlertMessageUtils>().showToastMessages(msg: responseModel.responseMessage??'');
        }
      }
    } catch (e) {
      LoggerUtils.logException('updateProduct', e);
    }
    return  null;
  }
}
