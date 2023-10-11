import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/customers_controller.dart';

class CustomersPage extends GetWidget<CustomersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CustomersController>(
          builder: (_) => Placeholder(),
        ));
  }
}
