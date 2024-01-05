import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/newMap_page/widgets/map_view.dart';
import 'controllers/newMap_controller.dart';

class NewMapPage extends GetWidget<NewMapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<NewMapController>(
          builder: (_) => Obx(() {
            return (controller.isLoadingPosition.isFalse && controller.isLoadingIcon.isFalse) ?
            MapView(initialPositon: controller.initialPosition, userIcon: controller.userIcon,) :
            const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
                color: Colors.green,
              ),
            );
          }),
        ));
  }
}
