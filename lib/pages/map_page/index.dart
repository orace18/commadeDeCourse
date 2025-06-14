import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/map_controller.dart';
import 'widgets/map_view.dart';

class MapPage extends GetWidget<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<MapController>(
          builder: (_) => MapView(),
        ));
  }
}
