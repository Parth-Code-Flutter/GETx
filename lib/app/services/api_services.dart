

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:json_data/json_data.dart';
import 'package:tsofie/app/common/common_header.dart';
import 'package:tsofie/app/screens/seller/dashboard/product/add_product/model/add_product_request_model.dart';
import 'package:tsofie/app/services/api_constants.dart';
import 'package:tsofie/app/utils/alert_message_utils.dart';
import 'package:tsofie/app/utils/logger_utils.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as imageFilePath;

class ApiService {
  Future<http.Response?> getRequest(
      {required String endPoint, bool isShowLoader = true}) async {
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }
      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();
      debugPrint('headers :::: $headers');
      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');
      var response = await http.get(url, headers: headers);
    //  debugPrint('response :::: $response');
      return response;
    } catch (e) {
      LoggerUtils.logException('getRequest', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }

  Future<http.Response?> postRequest({required String endPoint,
    dynamic requestModel,
    bool isShowLoader = true}) async {
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }
      debugPrint('requestModel :::: $requestModel');
      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();
      debugPrint('headers :::: $headers');

      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');
      var response = await http.post(url, body: requestModel, headers: headers);
      debugPrint('response :::: ${response.body}');
      return response;
    } catch (e) {
      LoggerUtils.logException('postRequest', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }

  Future<http.Response?> postRequestWithMultiPart({required String endPoint,
    required String imagePath,
    required String imgExtension,
    required dynamic requestModel,
    bool isShowLoader = true}) async {
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }
      debugPrint('requestModel :::: $requestModel');
      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();
      debugPrint('headers :::: $headers');

      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');

      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(headers);
      request.fields['mobile_code'] = requestModel.mobileCode;
      request.fields['mobile_number'] = requestModel.mobileNumber;
      request.fields['name'] = requestModel.name;
      request.fields['company_name'] = requestModel.companyName;
      request.fields['gst_number'] = requestModel.gstNumber;

      if (imagePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_pic',
          imagePath,
          contentType: MediaType('Image', imgExtension),
        ));
      }
      var res = await request.send();

      return http.Response.fromStream(res).then((value) async {
        return value;
      });
    } catch (e) {
      LoggerUtils.logException('postRequest', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }

  Future<http.Response?> putRequest({required String endPoint,
    dynamic requestModel,
    bool isShowLoader = true}) async {
    // try {
    //   var url = Uri.parse(endPoint);
    //
    //   var response = await http.put(url);
    //   return response;
    // } catch (e) {
    //   LoggerUtils.logException('putRequest', e);
    // }
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }
      debugPrint('requestModel :::: $requestModel');
      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();
      debugPrint('headers :::: $headers');

      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');
      var response = await http.put(url, body: requestModel, headers: headers);
      debugPrint('response :::: ${response.body}');
      return response;
    } catch (e) {
      LoggerUtils.logException('put Request', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }

  Future<http.Response?> deleteRequest(
      {required String endPoint, bool isShowLoader = true}) async {
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }
      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();
      debugPrint('headers :::: $headers');

      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');
      var response = await http.delete(url, headers: headers);
      return response;
    } catch (e) {
      LoggerUtils.logException('deleteRequest', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }

  Future<http.Response?> putRequestWithMultiPart({
    required String endPoint,
    required String imagePath,
    required String imgExtension,
    required dynamic requestModel,
    required bool isBuyerProfileUpdate,
    bool isShowLoader = true,
  }) async {
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }

      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();

      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');
      debugPrint('requestModel :::: ${requestModel}');

      var request = http.MultipartRequest('PUT', url);
      request.headers.addAll(headers);
      request.fields['mobile_code'] = requestModel.mobileCode;
      request.fields['mobile_number'] = requestModel.mobileNumber;
      request.fields['name'] = requestModel.name;
      request.fields['email'] = requestModel.email;
      if (isBuyerProfileUpdate == false) {
        request.fields['company_name'] = requestModel.companyName;
        request.fields['gst_number'] = requestModel.gstNumber;
        request.fields['company_address'] = requestModel.companyAddress;
        request.fields['city'] = requestModel.city;
        request.fields['state'] = requestModel.state;
        request.fields['zip_code'] = requestModel.zipCode;
        request.fields['contact_person'] = requestModel.contactPerson;
        request.fields['office_number'] = requestModel.officeNumber;
        request.fields['cell_number'] = requestModel.cellNumber;
        request.fields['email'] = requestModel.email;
        request.fields['account_number'] = requestModel.accountNumber;
        request.fields['bank_name'] = requestModel.bankName;
        request.fields['ifsc_number'] = requestModel.ifscNumber;
      }

      if (imagePath.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_pic',
          imagePath,
          contentType: MediaType('Image', imgExtension),
        ));
      }
      var res = await request.send();

      return http.Response.fromStream(res).then((value) async {
        return value;
      });
    } catch (e) {
      LoggerUtils.logException('putRequestWithMultiPart', e);
    } finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }

  Future<http.Response?> postRequestWithMultiPartForAddProduct({required String endPoint,
    // required String imagePath,
    // required String imgExtension,
    required AddProductRequestModel requestModel,
    required bool isVeriant,
    bool isShowLoader = true,required List<XFile> imageList}) async {
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }
      debugPrint('requestModel :::: ${requestModel}');
      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();
      debugPrint('headers :::: ${headers}');

      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');

      var request = http.MultipartRequest('POST', url);



      debugPrint('url1 ::::');
      request.headers.addAll(headers);
      /*
      var v = {
        "name":requestModel.product!.name!.toString(),
        "specification":requestModel.product!.specification!.toString(),
        "category_id":requestModel.product!.categoryId.toString(),
        "is_variant":requestModel.product!.isVariant.toString(),
        "gst":requestModel.product!.gst.toString(),
        "product_variants_attributes":requestModel.product!.productVariantsAttributes,
        "product_images":requestModel.product!.productImages,
      };
       */
/*
      debugPrint('url2 ::::');
      request.fields['name'] = requestModel.product!.name!;
      debugPrint('url3 ::::');
      request.fields['specification'] = requestModel.product!.specification!;
      debugPrint('url4 ::::');
      request.fields['category_id'] = requestModel.product!.categoryId.toString();
      debugPrint('url5 ::::');
      request.fields['is_variant'] = requestModel.product!.isVariant.toString();
      request.fields['gst'] = requestModel.product!.gst.toString();

      request.fields['product_variants_attributes'] = jsonEncode(requestModel.product!.productVariantsAttributes).replaceAll('\\', '');
      debugPrint('url6 :::: ${jsonEncode(requestModel.product!.productVariantsAttributes)}');
      request.fields['product_images'] = json.encode(requestModel.product!.productImages);
      debugPrint('url7 :::: ${jsonEncode(requestModel.product!.productImages)}');
      //request.fields['product_images'] = requestModel.product.product_images[0];
      //request.fields['product_variants_attributes[discounted_price]'] = requestModel.product.productVariantsAttributes[0].discountedPrice.toString();
      //request.fields['product_variants_attributes[category_id]'] = requestModel.product.categoryId;
      //request.fields['product_variants_attributes[seller_id]'] = requestModel.product.sellerId;
      //request.fields['product_variants_attributes[available_quantity]'] = requestModel.product.availableQuantity;
      // request.fields['gst'] = requestModel.gst;
      //request.fields['product_variants_attributes[price]'] = requestModel.product.price;
      //debugPrint('url7 ::::');
      //if (isVeriant == true) {
        //request.fields['product_variants_attributes[size]'] = requestModel.product.size;
      //}
      // request.fields['token'] = requestModel.token;
      // request.fields['otp'] = requestModel.otp;

      //request.fields.addAll(v);
      //request.fields.addAll(requestModel.product!.toJson());

 */
      request.fields.addAll({
        'product[name]': requestModel.product!.name.toString(),
        'product[specification]': requestModel.product!.specification.toString(),
        'product[category_id]': requestModel.product!.categoryId.toString(),
        'product[is_variant]': requestModel.product!.isVariant.toString(),
        'product[gst]': requestModel.product!.gst.toString(),
      });
      // for(var dat in requestModel.product!.productVariantsAttributes!)
      for(int i=0;i<requestModel.product!.productVariantsAttributes!.length;i++)
      {
        request.fields.addAll({
          'product[product_variants_attributes][$i][category_id]': requestModel.product!.productVariantsAttributes![i].categoryId.toString(),
          'product[product_variants_attributes][$i][seller_id]': requestModel.product!.productVariantsAttributes![i].sellerId.toString(),
          'product[product_variants_attributes][$i][size]': requestModel.product!.productVariantsAttributes![i].size.toString(),
          'product[product_variants_attributes][$i][available_quantity]': requestModel.product!.productVariantsAttributes![i].availableQuantity.toString(),
          //'product[product_variants_attributes][][gst]': dat.gst,
          'product[product_variants_attributes][$i][price]': requestModel.product!.productVariantsAttributes![i].price.toString(),
          'product[product_variants_attributes][$i][discounted_price]': requestModel.product!.productVariantsAttributes![i].discountedPrice.toString(),
          //'product[product_variants_attributes][][left_quantity]': '8'
        });
      }
      // for(var dat in requestModel.product!.productImages!)
      // {
      //   request.fields.addAll({
      //     'product[product_images][]': dat
      //   });
      // }
      if (imageList.length > 0) {
        for (var i = 0; i < imageList.length; i++) {
          request.files.add(await http.MultipartFile.fromPath(
            'product[product_images][]',
            imageList[i].path,
            contentType: MediaType('Image', (imageList[i].path
                .split("/")
                .last)),
          ));
        }
      }
      debugPrint('url7 ::::');
      var res = await request.send();

      return http.Response.fromStream(res).then((value) async {
        return value;
      });
    } catch (e) {
      LoggerUtils.logException('postRequest', e);
    }
    finally {
      debugPrint('url8 ::::');
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }



  Future<http.Response?> putRequestWithMultiPartForAddProduct({required String endPoint,
    // required String imagePath,
    // required String imgExtension,
    required AddProductRequestModel requestModel,
    required bool isVariant,
    bool isShowLoader = true,required List<XFile> imageList}) async {
    try {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().showLoaderDialog();
      }
      var domainUrl = ApiConst.baseUrl;

      var headers = await commonHeaders();
      debugPrint('headers :::: ${headers}');

      var url = Uri.parse(domainUrl + endPoint);
      debugPrint('url :::: $url');

      var request = http.MultipartRequest('PUT', url);
      print('Request model Edit product ${requestModel}');
      request.headers.addAll(headers);

      request.fields.addAll({
        'product[name]': requestModel.product!.name.toString(),
        'product[specification]': requestModel.product!.specification.toString(),
        'product[category_id]': requestModel.product!.categoryId.toString(),
        'product[is_variant]': requestModel.product!.isVariant.toString(),
        'product[gst]': requestModel.product!.gst.toString(),
      });
      // for(var dat in requestModel.product!.productVariantsAttributes!)
        for(int i=0;i<requestModel.product!.productVariantsAttributes!.length;i++)
        {
          request.fields.addAll({
            'product[product_variants_attributes][$i][id]': requestModel.product!.productVariantsAttributes![i].id.toString(),
            'product[product_variants_attributes][$i][category_id]': requestModel.product!.productVariantsAttributes![i].categoryId.toString(),
            'product[product_variants_attributes][$i][seller_id]': requestModel.product!.productVariantsAttributes![i].sellerId.toString(),
            'product[product_variants_attributes][$i][size]': requestModel.product!.productVariantsAttributes![i].size.toString(),
            'product[product_variants_attributes][$i][available_quantity]': requestModel.product!.productVariantsAttributes![i].availableQuantity.toString(),
            //'product[product_variants_attributes][][gst]': dat.gst,
            'product[product_variants_attributes][$i][price]': requestModel.product!.productVariantsAttributes![i].price.toString(),
            'product[product_variants_attributes][$i][discounted_price]': requestModel.product!.productVariantsAttributes![i].discountedPrice.toString(),
            //'product[product_variants_attributes][][left_quantity]': '8'
          });
        }

      if (imageList.length > 0) {
        for (var i = 0; i < imageList.length; i++) {
          request.files.add(await http.MultipartFile.fromPath(
            'product[product_images][]',
            imageList[i].path,
            contentType: MediaType('Image', (imageList[i].path
                .split("/")
                .last)),
          ));
        }
      }
      var res = await request.send();

      return http.Response.fromStream(res).then((value) async {
        print('response :: ${value.body}');
        return value;
      });
    } catch (e) {
      LoggerUtils.logException('putRequestWithMultiPartForAddProduct', e);
    }
    finally {
      if (isShowLoader) {
        Get.find<AlertMessageUtils>().hideLoaderDialog();
      }
    }
    return null;
  }
}

// Future<http.Response?> postRequestWithMultiPartForAddProduct({
//   required String endPoint,
//   required String imagePath,
//   required String imgExtension,
//   required dynamic requestModel,
//   required bool isVeriant,
//   bool isShowLoader = true,
// }) async {
//   if (isShowLoader) {
//     Get.find<AlertMessageUtils>().showLoaderDialog();
//   }
//
//   var domainUrl = ApiConst.baseUrl;
//
//   var headers = await commonHeaders();
//
//   var url = Uri.parse(domainUrl + endPoint);
//
//
//   var productImages = [];
//
//   for (int j = 0; j < 5; j++) {
//     var innerObj = {};
//
//     // innerObj["link"] = "$j link";
//     innerObj["image"] = j;
//     productImages.add(innerObj);
//   }
//   debugPrint('url :::: $url');
//   debugPrint('requestModel :::: ${requestModel}');
//
//   var request = http.MultipartRequest('POST', url);
//   request.headers.addAll(headers);
//   request.fields['name'] = requestModel.name;
//   request.fields['specification'] = requestModel.specification;
//   request.fields['category_id'] = requestModel.category_id;
//   request.fields['is_variant'] = requestModel.name;
//   request.fields['gst'] = requestModel.gst;
//
//   // request.fields['category_id'] = requestModel.name;
//   request.fields['seller_id'] = requestModel.seller_id;
//   request.fields['available_quantity'] = requestModel.available_quantity;
//   request.fields['gst'] = requestModel.gst;
//   request.fields['price'] = requestModel.price;
//   request.fields['left_quantity'] = requestModel.name;
//   if (isVeriant == true) {
//     request.fields['size'] = requestModel.name;
//     // request.fields['token'] = requestModel.token;
//     // request.fields['otp'] = requestModel.otp;
//   }
//   //
//   // if (imagePath.isNotEmpty && imagePath != null) {
//   //   request.files.add(await http.MultipartFile.fromPath(
//   //     'profile_pic',
//   //     imagePath,
//   //     contentType: MediaType('Image', imgExtension),
//   //   ));
//   // }
//   var res = await request.send();
//
//   return http.Response.fromStream(res).then((value) async {
//     return value;
//   });
//   return null;
// }