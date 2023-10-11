import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/activities_controller.dart';

class ActivitiesPage extends GetWidget<ActivitiesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ActivitiesController>(
          builder: (_) => Placeholder(),
        ));
  }
}
