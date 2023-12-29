import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:location/location.dart';
import 'package:otrip/api/auth/auth_api_client.dart';
import 'package:otrip/api/auth/auth_api_controller.dart';

import '../../../constants.dart';

class AddUserController extends GetxController {
  
  final formKey = GlobalKey<FormBuilderState>();
  final firstnameFieldKey = GlobalKey<FormBuilderFieldState>();
  final lastnameFieldKey = GlobalKey<FormBuilderFieldState>();
  final usernameFieldKey = GlobalKey<FormBuilderFieldState>();
  final mobileFieldKey = GlobalKey<FormBuilderFieldState>();
  final mobileFieldController = TextEditingController();
  final passwordFieldKey = GlobalKey<FormBuilderFieldState>();
  final roleId = Get.arguments["role_id"];
  final isButtonEnabled = false.obs;
  final Location _location = Location();
  Map<String, double> location = {};
  RxString phoneNumber = ''.obs;
  void navigateBack() => Get.back();

  void updateButtonEnabled(bool isEnabled) {
    isButtonEnabled.value = isEnabled;
  }

  void validateField(GlobalKey<FormBuilderFieldState> key){
    key.currentState?.validate();
    updateButtonEnabled(formKey.currentState?.isValid ?? false);
  }

  Future<Map<String, double?>> getPostion() async {
    try {
      var currentLocation = await _location.getLocation();
      print(
          "Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}");
      return {
        'longitude': currentLocation.longitude,
        'latitude': currentLocation.latitude,
      };
    } catch (e) {
      print("Erreur: $e");

      return {'longitude': 0.0, 'latitude': 0.0};
    }
  }

  Future<void> registerRequest(int role, String username, String firstname, String lastname, String phoneNumber, String phoneCode, String password, Map<String, double> location) async {
    try {
      bool valid = await AuthApiClient().signUp(role, username, firstname, lastname, phoneNumber, phoneCode, password, location);
      if (valid) {
        navigateToHome(roleId);
       /*  Map<String, dynamic> userData = await AuthApiClient().getUserData(phoneNumber);

      // Stockez les informations de l'utilisateur dans le contrôleur d'authentification
      Get.find<AuthController>().setAuthenticated(true);
      Get.find<AuthController>().setUserData(userData);  */

          final userData = GetStorage('user_infos');
          userData.write('firstname', firstname);
          userData.write('lastname', lastname);
          userData.write('username', username);
          userData.write('phone_number', phoneNumber);
          userData.write('password', password);
          userData.write('user_role', roleId);
      }
    } catch (e) {
      print("Error during registration: $e");
    }
}

}