import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/settings_controller.dart';

class SettingsPage extends GetWidget<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<SettingsController>(
          builder: (_) => Placeholder(),
        ));
  }
}
