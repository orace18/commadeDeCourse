import 'package:get/get.dart';
import 'connexion_controller.dart';

class ConnexionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnexionController>(() => ConnexionController());
  }
}
