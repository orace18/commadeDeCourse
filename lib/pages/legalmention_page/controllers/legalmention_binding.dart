import 'package:get/get.dart';
import 'legalmention_controller.dart';

class LegalmentionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LegalmentionController>(() => LegalmentionController());
  }
}
