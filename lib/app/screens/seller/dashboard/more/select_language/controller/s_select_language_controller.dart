import 'package:get/get.dart';

class BSelectLanguageController extends GetxController {
  RxBool isEngSelected = false.obs;
  RxBool isHindiSelected = false.obs;

  void changeLanguage(int i) {
    /// 0 = english , 1 = hindi
    if(i==0){
      isEngSelected.value = !isEngSelected.value;
      isHindiSelected.value=false;
    }else {
      isHindiSelected.value = !isHindiSelected.value;
      isEngSelected.value=false;
    }
  }
}
