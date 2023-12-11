import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
            Text('recharge_way'.tr),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: FormBuilderDropdown(
                name: "recharge_way",
                key: controller.recharge_way,
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
                onChanged: (value){
                  controller.updateRechargePhoneNumbers();
                  controller.validateField(controller.recharge_way);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required()
                ]),
              ),
            ),
            Text('phone_number'.tr),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Obx((){
                return FormBuilderDropdown(
                  name: "recharge_phone_number",
                  key: controller.recharge_phone_number,
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
                  initialValue: controller.recharge_phone_numbers.isNotEmpty ?
                        controller.recharge_phone_numbers.first.toString() :
                        '',
                  items: List.generate(
                      controller.recharge_phone_numbers.length,
                          (index) => DropdownMenuItem(
                          value: controller.recharge_phone_numbers[index],
                          child: Text(
                            controller.recharge_phone_numbers[index].toString(),
                          )
                      )
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required()
                  ]),
                  onChanged: (value){
                    controller.validateField(controller.recharge_phone_number);
                  },
                );
              }),
            ),
            Text('recharge_amount'.tr),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: FormBuilderTextField(
                name: "amount",
                keyboardType: TextInputType.number,
                onChanged: (value){
                  controller.validateField(controller.recharge_amount);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  suffix: Text(
                      "FCFA",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  hintText: 'enter_amount'.tr,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          width: 0.5
                      )
                  ),
                  contentPadding: EdgeInsets.all(defaultPadding),

                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr
                  ),
                  FormBuilderValidators.numeric(
                      errorText: 'number_too_small'.tr
                  ),
                  FormBuilderValidators.minLength(
                      3,
                      errorText: 'int_too_short'.tr
                  ),
                  FormBuilderValidators.maxLength(
                      8,
                      errorText: 'int_too_long'.tr
                  ),
                ]),
              ),
            ),

            Obx(()
              {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: controller.isButtonEnabled.isFalse ?
                  SizedBox() :
                  ElevatedButton(
                    child: Text(
                      "recharge".tr,
                    ),
                    onPressed: (){

                    },
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}
