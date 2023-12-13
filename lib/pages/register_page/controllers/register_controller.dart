import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:otrip/api/auth/auth_api_client.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final firstnameFieldKey = GlobalKey<FormBuilderFieldState>();
  final lastnameFieldKey = GlobalKey<FormBuilderFieldState>();
  final usernameFieldKey = GlobalKey<FormBuilderFieldState>();
  final mobileFieldKey = GlobalKey<FormBuilderFieldState>();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();

  final isButtonEnabled = false.obs;
  void updateButtonEnabled(bool isEnabled) {
    isButtonEnabled.value = isEnabled;
  }

  final roleId = Get.arguments["role_id"];

  void validateField(GlobalKey<FormBuilderFieldState> key){
    key.currentState?.validate();
    updateButtonEnabled(formKey.currentState?.isValid ?? false);
  }
  void navigateBack() => Get.back();


   void registerRequest(int role, String username, String firstname, String lastname, String phoneNumber, String password) {

    AuthApiClient().register(role,username, firstname, lastname, phoneNumber,password);

    navigateToHome(roleId);
  }

  void navigateToHome(int roleId){
    switch (roleId) {
      case 1:
        Get.toNamed("/marchand");
        break;
      case 3:
        Get.toNamed("/driver");
        break;
      case 4:
        Get.toNamed("/passager");
        break;
      case 5:
        Get.toNamed("/");
        break;
      default:
        // Gérer le cas par défaut si nécessaire
        break;
    }
  }
}
