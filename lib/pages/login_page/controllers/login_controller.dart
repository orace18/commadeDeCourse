import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/auth/auth_api_client.dart';
import 'package:otrip/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

  Future<void> loginRequest(String phoneNumber, String password) async {
    try {
      bool valid = await AuthApiClient().signIn(phoneNumber, password);
      Map<String, dynamic> userData = await getUserData(phoneNumber);
      print(userData);
      final role_id = userData['role_id'];
      userInfos.write('balance', userData['solde']);
      userInfos.write('phone_number', userData['mobile_number']);
      userInfos.write('id', userData['id']);
      if (valid == true) {
        navigateToHome(role_id);
      }
    } catch (e) {
      throw Exception('Erreur lors de la connexion: $e');
    }
  }

  Future<Map<String, dynamic>> getUserData(String phoneNumber) async {
    try {
      final response =
          await http.get(Uri.parse('$userInfoByPhoneUrl/$phoneNumber'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> responseData = json.decode(response.body);

        // Vérifiez si la requête a réussi
        if (responseData['success'] == true) {
          // Récupérez les données de l'utilisateur
          Map<String, dynamic> userData = responseData['data']['user'];

          // Affichez les informations de l'utilisateur
          print('L\'utilisateur est : ${userData}');

          return userData;
        } else {
          throw Exception(
              'Erreur lors de la récupération des données utilisateur: ${responseData['message']}');
        }
      } else {
        throw Exception(
            'Erreur lors de la récupération des données utilisateur');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }
}
