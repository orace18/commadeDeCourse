import 'package:get/get.dart';
import 'terms_controller.dart';

class TermsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsController>(() => TermsController());
  }
}
