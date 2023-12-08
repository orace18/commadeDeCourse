import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/profile_edit_company_controller.dart';

class ProfileEditCompanyPage extends GetWidget<ProfileEditCompanyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileEditCompanyController>(
          builder: (_) => Placeholder(),
        ));
  }
}
