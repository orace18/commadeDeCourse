import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/auth/auth_api_client.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/login_page/controllers/login_controller.dart';

import '../../../api/api_client.dart';

import '../../../providers/theme/theme.dart';

class LoginForm extends GetWidget<LoginController> {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FormBuilder(
        key: controller.formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderPhoneField(
                name: 'phone_number',
                key: controller.mobileFieldKey,
                onChanged: (value) {
                  controller.validateField(controller.mobileFieldKey);
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
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'password',
                key: controller.passwordFieldKey,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
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
                  FormBuilderValidators.minLength(
                      8,
                      errorText: 'string_too_short'.tr
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding*2),
              child: Obx(()=> ElevatedButton(
                  onPressed: (){
                    if (controller.isButtonEnabled.value){
                      loginRequest();
                    } else {
                      Get.toNamed('/');
                    }
                  },
                  child: Text('continue'.tr, style: TextStyle(color: controller.isButtonEnabled.value ? Colors.white : Colors.black26, fontSize: 16, fontWeight: FontWeight.bold),),
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

  // Fonction pour login
  void loginRequest(){
    String? phone_number = controller.mobileFieldKey.currentState?.value.toString();
    String? password = controller.passwordFieldKey.currentState?.value.toString();
    print(phone_number);
    AuthApiClient().login(phone_number!, password!);
  }
}
