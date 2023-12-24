import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/profile_edit_info_page/controllers/profile_edit_conducteur_controller.dart';
import 'forms/edit_profileconducteur_form.dart';

class ProfileEditDriverPage extends GetWidget<ProfileEditDriverController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("edit_profile".tr),
        ),
        body: GetBuilder<ProfileEditDriverController>(
          builder: (_) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: EditConducteurForm(),
                ),
              )
            ],
          ),
        ));
  }
}
