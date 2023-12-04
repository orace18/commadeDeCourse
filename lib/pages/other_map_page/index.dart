import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/other_map_page/widgets/map_widgets.dart';
import 'controllers/map_controller.dart';

class MapPage extends GetWidget<MapController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<MapController>(
          builder: (_) => MapSample(),
        ));
  }
}
