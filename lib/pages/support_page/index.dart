import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/support_controller.dart';

class SupportPage extends GetWidget<SupportController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SupportController>(
          builder: (_) => Placeholder(),
        ));
  }
}
