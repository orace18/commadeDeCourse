import 'package:get/get.dart';

class HomeController extends GetxController{
  void navigateBack() => Get.back();

  static HomeController get to => Get.find();

  var currentIndex = 0.obs;

  final pages = <String>['/home', '/business', '/customers', '/profile'];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }
}