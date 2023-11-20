import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/add_user_controller.dart';

class AddUserPage extends GetWidget<AddUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AddUserController>(
          builder: (_) => Placeholder(),
        ));
  }
}
