import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/assistance_controller.dart';

class AssistancePage extends GetWidget<AssistanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AssistanceController>(
          builder: (_) => Placeholder(),
        ));
  }
}
