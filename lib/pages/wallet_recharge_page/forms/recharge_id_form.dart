import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
                key: controller.recharge_way_add,
                name: "recharge_way",
                onChanged: (value){
                  print(controller.recharge_way_add.currentState?.value);
                },
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
                    fontSize: 14.0
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
                          "MTN Momo",
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
            Text('phone_number'.tr),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: FormBuilderPhoneField(
                name: "recharge_phone_number",
                key: controller.phone_number,
                onChanged: (value) {
                  controller.validateField(controller.phone_number);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: 'phone_number'.tr,
                ),
                priorityListByIsoCode: ['BJ'],
                defaultSelectedCountryIsoCode: 'BJ',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: (){
                   storeRechargeId();
                  // cleanBox();
                },
                child: Text(
                    "add".tr
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void storeRechargeId(){
    List<dynamic> phoneNumbersList = [];
    final box = GetStorage('Otrip');

    if(controller.recharge_way_add.currentState?.value.toString() == "mtn") {
      phoneNumbersList = box.read<List<dynamic>>('mtn_phone_numbers') ?? [];
      phoneNumbersList.add(controller.phone_number.currentState?.value);
      box.write('mtn_phone_numbers', phoneNumbersList);
    } else {
      phoneNumbersList = box.read<List<dynamic>>('moov_phone_numbers') ?? [];
      phoneNumbersList.add(controller.phone_number.currentState?.value);
      box.write('moov_phone_numbers', phoneNumbersList);
    }

    print(phoneNumbersList);
  }

  void cleanBox(){
    final box = GetStorage('Otrip');
    box.erase();
    print("box cleared");
  }


}
