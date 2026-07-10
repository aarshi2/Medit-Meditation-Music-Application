import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedValue = 1.obs;

  void changeLanguage(int value) {
    selectedValue.value = value;
  }
}
