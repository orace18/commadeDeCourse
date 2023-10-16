import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'controllers/profile_edit_info_controller.dart';
import 'forms/edit_profile_form.dart';

class ProfileEditInfoPage extends GetWidget<ProfileEditInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("edit_profile".tr),
        ),
        body: GetBuilder<ProfileEditInfoController>(
          builder: (_) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: EditInfoForm(),
                ),
              )
            ],
          ),
        ));
  }
}
