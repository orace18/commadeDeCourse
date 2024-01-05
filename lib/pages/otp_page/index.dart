import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/otp_controller.dart';

class OtpPage extends GetWidget<OtpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<OtpController>(
          builder: (_) => Placeholder(),
        ));
  }
}
