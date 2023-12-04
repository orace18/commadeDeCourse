import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/profile_edit_seats_controller.dart';

class ProfileEditSeatsPage extends GetWidget<ProfileEditSeatsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileEditSeatsController>(
          builder: (_) => Placeholder(),
        ));
  }
}
