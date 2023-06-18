 import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/local_storage.dart';
import 'local_storage_constants.dart';
 LocalStorage localStorage = Get.put(LocalStorage());

Future<Map<String, String>> commonHeaders() async {
  String getToken= await localStorage.getStringFromStorage(kStorageToken);
  var headers = {'content-Type': 'application/json',"accept" : "application/json","Authorization":getToken ?? ''};
  return headers;
}

