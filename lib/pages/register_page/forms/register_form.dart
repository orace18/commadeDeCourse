import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_phone_field/form_builder_phone_field.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/register_page/controllers/register_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../api/auth/auth_api_client.dart';
import '../../../constants.dart';
import '../../../providers/theme/theme.dart';

class RegisterForm extends GetWidget<RegisterController> {
  final RegisterController registerController;

 const RegisterForm({Key? key, required this.registerController}) : super(key: key);

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
                onChanged: (value) {
                  controller.validateField(controller.lastnameFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(width: 0.5)),
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
                onChanged: (value) {
                  controller.validateField(controller.firstnameFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(width: 0.5)),
                  hintText: 'firstname'.tr,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr),
                  FormBuilderValidators.minLength(4,
                      errorText: 'string_too_short'.tr),
                  FormBuilderValidators.maxLength(50,
                      errorText: 'string_too_long'.tr),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderTextField(
                name: 'username',
                key: controller.usernameFieldKey,
                onChanged: (value) {
                  controller.validateField(controller.usernameFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(width: 0.5)),
                  hintText: 'username'.tr,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr),
                  FormBuilderValidators.minLength(4,
                      errorText: 'string_too_short'.tr),
                  FormBuilderValidators.maxLength(50,
                      errorText: 'string_too_long'.tr),
                ]),
              ),
            ),
            defaultSizedBox,
            Padding(
              padding: EdgeInsets.only(right: defaultPadding),
              child: FormBuilderPhoneField(
                name: 'phone_number',
                key: controller.mobileFieldKey,
                onChanged: (value) {
                  controller.validateField(controller.mobileFieldKey);
                },
                inputFormatters: [],
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  hintText: 'phone_number'.tr,
                ),
                priorityListByIsoCode: ['BJ'],
                defaultSelectedCountryIsoCode: 'BJ',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
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
                onChanged: (value) {
                  controller.validateField(controller.passwordFieldKey);
                },
                autovalidateMode: AutovalidateMode.disabled,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: defaultPadding, horizontal: defaultPadding * 2),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(width: 0.5)),
                  hintText: 'password'.tr,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'field_required'.tr),
                  FormBuilderValidators.minLength(8,
                      errorText: 'string_too_short'.tr),
                ]),
              ),
            ),
            defaultSizedBox,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'you_accept'.tr,
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'terms'.tr,
                        style: TextStyle(color: AppTheme.otripMaterial))
                  ]),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
              child: Obx(() => ElevatedButton(
                  onPressed: () {
                    if (controller.isButtonEnabled.value) {
                      print('Le role est : ${registerController.roleId}');
                      registerController.registerRequest();
                    }
                  },
                  child: Text(
                    'continue'.tr,
                    style: TextStyle(
                        color: controller.isButtonEnabled.value
                            ? Colors.white
                            : Colors.black26,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    elevation: 0,
                    backgroundColor: controller.isButtonEnabled.value
                        ? AppTheme.otripMaterial
                        : Colors.grey[300],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ))),
            )
          ],
        ),
      ),
    );
  }

  // Fonction pour register
  /* void registerRequest() {
    String? firstname =
        controller.firstnameFieldKey.currentState?.value.toString();
    String? lastname =
        controller.lastnameFieldKey.currentState?.value.toString();
    String? username =
        controller.usernameFieldKey.currentState?.value.toString();
    String? phoneNumber =
        controller.mobileFieldKey.currentState?.value.toString();
    String? password =
        controller.passwordFieldKey.currentState?.value.toString();
    int? roleId = controller.roleId;
    AuthApiClient().register(roleId!, username!, firstname!, lastname!,
        phoneNumber!, "+229", 1, password!);
    Get.toNamed("/"); */
  //}
}
