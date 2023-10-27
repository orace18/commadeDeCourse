import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/wallet_recharge_page/forms/recharge_form.dart';
import 'controllers/wallet_recharge_controller.dart';

class WalletRechargePage extends GetWidget<WalletRechargeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('recharge'.tr),
      ),
        body: GetBuilder<WalletRechargeController>(
          builder: (_) => Container(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('recharge_ways'.tr),
                Text('recharge_amount'.tr),
              ],
            ),
          ),
        ));
  }
}
