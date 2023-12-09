import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/about_controller.dart';

class AboutPage extends GetWidget<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AboutController>(
          builder: (_) => Placeholder(),
        ));
  }
}
