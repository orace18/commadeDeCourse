import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/auth/auth_api_client.dart';
import 'package:otrip/constants.dart';
import 'package:phone_number/phone_number.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final mobileFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  final isButtonEnabled = false.obs;
  final userInfos = GetStorage();


  void updateButtonEnabled(bool isEnabled) {
    isButtonEnabled.value = isEnabled;
  }

  void validateField(GlobalKey<FormBuilderFieldState> key) {
    key.currentState?.validate();
    updateButtonEnabled(formKey.currentState?.isValid ?? false);
  }

  var phoneNumber = ''.obs;

  void navigateBack() => Get.back();

  void loginRequest(String phone, String password) async {
    await AuthApiClient().signIn(phone, password);
  }
}
