import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/contacts_controller.dart';

class ContactsPage extends GetWidget<ContactsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ContactsController>(
          builder: (_) => Placeholder(),
        ));
  }
}
