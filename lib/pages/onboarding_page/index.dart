import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/onboarding_controller.dart';

class OnboardingPage extends GetWidget<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<OnboardingController>(
          builder: (_) => Placeholder(),
        ));
  }
}
