import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/wallet_recharge_page/controllers/wallet_recharge_controller.dart';

class RechargeIdForm extends GetWidget<WalletRechargeController> {
  const RechargeIdForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: controller.idFormKey,
      child: Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('recharge_way'.tr),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: FormBuilderDropdown(
                name: "recharge_way",
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        )
                    )
                ),
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(10.0),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16.0
                ),
                initialValue: "mtn",
                items: [
                  DropdownMenuItem(
                    value: "mtn",
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            "assets/logos/mtn_momo.png",
                            height: 50,
                            width: 60,
                          ),
                        ),

                        Text(
                          "MTN Mobile Money",
                        )
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: "moov",
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            "assets/logos/moov_momo.png",
                            height: 50,
                            width: 60,
                          ),
                        ),

                        Text(
                          "Moov Money",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('recharge_phone_number'.tr),
            FormBuilderPhoneField(
              name: "recharge_phone_number",
            ),
          ],

          //TODO Try resizing trick and use GetStorage
        ),
      ),
    );
  }
}
