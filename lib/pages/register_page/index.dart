import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/register_controller.dart';

class RegisterPage extends GetWidget<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RegisterController>(
          builder: (_) => Placeholder(),
        ));
  }
}
