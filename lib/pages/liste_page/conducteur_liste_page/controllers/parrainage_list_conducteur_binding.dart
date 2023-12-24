import 'package:get/get.dart';
import 'parrainage_list_conducteur_controller.dart';

class ListConducteurBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListConducteurController>(() => ListConducteurController());
  }
}
