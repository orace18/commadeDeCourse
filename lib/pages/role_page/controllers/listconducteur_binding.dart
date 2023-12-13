import 'package:get/get.dart';
import 'listconducteur_controller.dart';

class ListConducteurBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListConducteurController>(() => ListConducteurController());
  }
}
