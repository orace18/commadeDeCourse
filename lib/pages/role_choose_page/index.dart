import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/role_choose_controller.dart';

class RoleChoosePage extends GetWidget<RoleChooseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RoleChooseController>(
          builder: (_) => Placeholder(),
        ));
  }
}
