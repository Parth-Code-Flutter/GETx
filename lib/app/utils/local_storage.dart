import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tsofie/app/utils/logger_utils.dart';

class LocalStorage extends GetxController {
  late final FlutterSecureStorage _mEncryptedStorage;

  RxInt cartCount = 0.obs;
  static bool isFromProductDetailsScreen = false;

  @override
  void onInit() {
    super.onInit();
    initStorageBox();
  }

  /// initialize FlutterSecureStorage
  initStorageBox() {
    _mEncryptedStorage = const FlutterSecureStorage();
  }

  /// store string values to Getx storage
  Future writeStringToStorage(String key, String value) async {
    await _mEncryptedStorage.write(key: key, value: value);
  }

  /// store string values to Getx storage
  Future writeIntToStorage(String key, int value) async {
    var intToString = value.toString();
    await _mEncryptedStorage.write(key: key, value: intToString);
  }

  /// store bool values to Getx storage
  Future writeBoolToStorage(String key, bool value) async {
    var boolToString = value.toString();
    await _mEncryptedStorage.write(key: key, value: boolToString);
  }

  /// read String value from Getx storage
  Future<String> getStringFromStorage(String key) async {
    var value = await _mEncryptedStorage.read(key: key);
    return value ?? '';
  }

  /// read int value from Getx storage
  Future<int> getIntFromStorage(String key) async {
    var value = await _mEncryptedStorage.read(key: key);
    var stringToInt = int.parse(value ?? '0');
    return stringToInt;
  }

  /// read bool value from Getx storage
  Future<bool> getBoolFromStorage(String key) async {
    try {
      String value = await _mEncryptedStorage.read(key: key) ?? 'false';
      return value.toLowerCase() == 'true' ? true : false;
    } catch (e) {
      return false;
    }
  }

  /// clear all storage data
  Future clearAllStorageData() async {
    try {
      _mEncryptedStorage.deleteAll();
    } catch (e) {
      LoggerUtils.logException('clearAllStorageData', e);
    }
  }
}
