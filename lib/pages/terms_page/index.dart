import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/terms_controller.dart';

class TermsPage extends GetWidget<TermsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<TermsController>(
          builder: (_) => Placeholder(),
        ));
  }
}
