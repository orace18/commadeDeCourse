import 'package:get/get.dart';
import 'customers_controller.dart';

class CustomersBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController());
  }
}
