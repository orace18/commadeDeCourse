import 'package:get/get.dart';

class HomeController extends GetxController{
  void navigateBack() => Get.back();

  String getName(){
    return "Papa";
  }
}