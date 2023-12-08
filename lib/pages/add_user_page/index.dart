import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/add_user_page/forms/register_user_form.dart';
import 'controllers/add_user_controller.dart';

class AddUserPage extends GetWidget<AddUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AddUserController>(
          builder: (_) => Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Text('add_user'.tr),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AddUserForm(),
                )
              ],
            ),
          ),
        )
    );
  }
}
