import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/profile_edit_contact_address_controller.dart';

class ProfileEditContactAddressPage extends GetWidget<ProfileEditContactAddressController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileEditContactAddressController>(
          builder: (_) => Placeholder(),
        ));
  }
}
