import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/profile_edit_info_page/controllers/profile_edit_marchand_controller.dart';
import 'package:otrip/pages/profile_edit_info_page/forms/edit_profilemarchand_form.dart';

class ProfileEditMerchantPage extends GetWidget<ProfileEditMarchandController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("edit_profile".tr),
        ),
        body: GetBuilder<ProfileEditMarchandController>(
          builder: (_) => CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: EditMarchandForm(),
                ),
              )
            ],
          ),
        ));
  }
}
