import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otrip/api/marchands/controllers/api_marchand_client.dart';
import 'package:otrip/pages/add_user_page/controllers/add_user_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../api/auth/auth_api_client.dart';
import '../../../constants.dart';
import '../../../providers/theme/theme.dart';

class AddUserForm extends GetWidget<AddUserController> {
  AddUserForm({Key? key}) : super(key: key);
  MarchandService marchandService = MarchandService();
  int maxNumLength = 8;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'lastname',
                key: controller.lastnameFieldKey,
                onChanged: (value){
                  controller.validateField(controller.lastnameFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          width: 0.5
                      )
                  ),
                  hintText: 'lastname'.tr,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'firstname',
                key: controller.firstnameFieldKey,
                onChanged: (value){
                  controller.validateField(controller.firstnameFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          width: 0.5
                      )
                  ),
                  hintText: 'firstname'.tr,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr
                  ),
                  FormBuilderValidators.minLength(
                      4,
                      errorText: 'string_too_short'.tr
                  ),
                  FormBuilderValidators.maxLength(
                      50,
                      errorText: 'string_too_long'.tr
                  ),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'username',
                key: controller.usernameFieldKey,
                onChanged: (value){
                  controller.validateField(controller.usernameFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          width: 0.5
                      )
                  ),
                  hintText: 'username'.tr,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr
                  ),
                  FormBuilderValidators.minLength(
                      4,
                      errorText: 'string_too_short'.tr
                  ),
                  FormBuilderValidators.maxLength(
                      50,
                      errorText: 'string_too_long'.tr
                  ),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderField(
                name: "phone_number",
                key: controller.mobileFieldKey,
                builder: (FormFieldState<dynamic> field){
                  return IntlPhoneField(
                    // key: controller.mobileFieldKey,
                    languageCode: "fr",
                    //c000ontroller: controller.mobileFieldController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      hintText: 'phone_number'.tr,
                    ),

                    disableLengthCheck: true,
                    initialCountryCode: 'BJ',
                    onCountryChanged: (country){
                      maxNumLength = country.maxLength;
                    },
                    autofocus: true,
                    onChanged: (phone) {
                      // field.didChange(controller.phoneNumber.value);
                      field.didChange(phone.number.replaceAll(' ', ''));
                      controller.phoneNumber.value = controller.mobileFieldKey.currentState?.value;
                      controller.mobileFieldKey.currentState?.setValue(phone.number);
                      print(controller.mobileFieldKey.currentState?.value);
                    },
                    // validator: (value) {
                    //   if (value == null || value.number.isEmpty) {
                    //     return "num_required".tr;
                    //   } else if (value.number.length < maxNumLength) {
                    //     return "num_too_short".tr;
                    //   } else if (value.number.length > maxNumLength) {
                    //     return "num_too_long".tr;
                    //   }
                    //   return null;
                    // },
                  );
                },
                autovalidateMode: AutovalidateMode.always,
                onChanged: (value){
                  controller.validateField(controller.mobileFieldKey);
                },
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'number_required'.tr
                  ),
                  FormBuilderValidators.equalLength(
                      maxNumLength,
                      errorText: 'invalid_number'.tr
                  ),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'password',
                key: controller.passwordFieldKey,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (value){
                  controller.validateField(controller.passwordFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                          width: 0.5
                      )
                  ),
                  hintText: 'password'.tr,
                ),
                validator: FormBuilderValidators.compose([

                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr
                  ),

                ]),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding*2),
              child: Obx(() =>ElevatedButton(
                  onPressed: ()async{

                    Map<String, double?> positionsNullable = await controller.getPostion();
                    Map<String, double> positions = positionsNullable.map((key, value) => MapEntry(key, value!));

                    if (controller.isButtonEnabled.value){
                     controller.getPostion();
                     marchandService.getAllMarchand();
                     controller.registerRequest(
                      controller.roleId,
                       controller.usernameFieldKey.currentState!.value,
                        controller.firstnameFieldKey.currentState!.value, 
                        controller.lastnameFieldKey.currentState!.value, 
                        controller.mobileFieldKey.currentState!.value,
                        controller.passwordFieldKey.currentState!.value,
                        "gg",
                        positions);
                    }
                  },
                  child: Text('Register'.tr, style: TextStyle(color: controller.isButtonEnabled.value ? Colors.white : Colors.black26, fontSize: 16, fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    elevation: 0,
                    backgroundColor: controller.isButtonEnabled.value ? AppTheme.otripMaterial : Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  )
              )),
            )
          ],
        ),
      ),
    );
  }
}
