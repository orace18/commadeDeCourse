import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/wallet_page/widgets/expense_tile.dart';
import 'package:otrip/pages/wallet_page/widgets/recharge_tile.dart';
import 'controllers/wallet_controller.dart';

class WalletPage extends GetWidget<WalletController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('wallet'.tr),
      ),
        body: GetBuilder<WalletController>(
          builder: (_) => Container(
            padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding, bottom: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("balance".tr),
                          Text("0f", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      ElevatedButton(
                        child: Text('recharge'.tr),
                        onPressed: (){
                          Get.toNamed('/wallet_recharge');
                        },
                      )
                    ],
                  ),
                ),
                defaultSizedBox,
                Text('wallet_history'.tr),
                defaultSizedBox,
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                        RechargeTile(amount: 1000, currency: "XOF"),
                        ExpenseTile(amount: 500, currency: "XOF"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
