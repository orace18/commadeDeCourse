import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/test_controller.dart';

class TestPage extends GetWidget<TestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<TestController>(
          builder: (_) => Placeholder(),
        ));
  }
}
