import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/wallet_recharge_page/controllers/wallet_recharge_controller.dart';

class RechargeForm extends GetWidget<WalletRechargeController> {
  const RechargeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.formKey,
      child: Flexible(

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBuilderDropdown(
              name: "recharge_way",
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  child: Text("MTN"),
                ),
                DropdownMenuItem(
                  child: Text("Moov Africa"),
                ),
              ],
            ),
            FormBuilderTextField(
              name: "amount",
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffix: Text("F"),
                hintText: 'enter_amount',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                        width: 0.5
                    )
                ),
                contentPadding: EdgeInsets.all(defaultPadding)
              ),
            )
          ],
        ),
      ),
    );
  }
}
