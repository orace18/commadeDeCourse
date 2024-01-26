import 'package:get/get.dart';
import 'statistic_controller.dart';

class StatisticBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatisticController>(() => StatisticController());
  }
}
