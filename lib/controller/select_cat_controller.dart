import 'package:get/get.dart';

class SelectCatController extends GetxController {
  RxString cat = "".obs;

  setCat(cat) {
    this.cat.value = cat;
  }
}

class SelectCatController2 extends GetxController {
  RxString cat2 = "".obs;

  setCat(cat2) {
    this.cat2.value = cat2;
  }
}
