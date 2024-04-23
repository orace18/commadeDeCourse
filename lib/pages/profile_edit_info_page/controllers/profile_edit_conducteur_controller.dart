import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/profile_page/controllers/conducteur_profile_controller.dart';

class ProfileEditDriverController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final userData = GetStorage();
  final imagePath = ''.obs;

  Map<String, dynamic> getUserData() {
    return {
      'firstname': userData.read('firstname') ?? '',
      'lastname': userData.read('lastname') ?? '',
      'username': userData.read('username') ?? '',
      'phoneNumber': userData.read('phone_number') ?? '',
       'address': userData.read('address') ?? '',
      'immatriculation': userData.read('immatriculation') ?? '',
      'birthday': userData.read('birthday') ?? '',
    };
  }

  void updateProfile(
      Map<String, dynamic> updatedData,
      String updatedGender,
      DateTime updatedBirthday,
      String updatedAddress,
      String updatedNumeroImmatricule) {
    final profileController = Get.find<ConducteurProfileController>();

    userData.write('firstname', updatedData['firstname']);
    userData.write('lastname', updatedData['lastname']);
    userData.write('phone_number', updatedData['phone_number']);
    userData.write('birthday', updatedBirthday);
    userData.write('immatriculation', updatedNumeroImmatricule);
    userData.write('address', updatedAddress);

    Map<String, dynamic> userDataMap = {
      'firstname': updatedData['firstname'],
      'lastname': updatedData['lastname'],
      'phone_number': updatedData['phone_number'],
    };

    // Appel à la méthode updateProfile du profileController avec les données mises à jour
    profileController.updateProfile(userDataMap);
    profileController.updateProfileInfo(
      updatedGender,
      updatedBirthday, // Mise à jour de l'anniversaire ici si nécessaire
      updatedAddress,
      updatedNumeroImmatricule,
    );

    // Naviguer vers la page de profil après la mise à jour
    // Get.toNamed('/profile_conducteur');
  }

  void navigateBack() => Get.back();
  void updateProfileInfo(String updatedGender, DateTime updatedBirthday,
      String updatedAddress, String updatedNumeroImmatricule) {

  }

  Future<bool> saveUserInfos(
      String engin, String immatriculation, String userId, String etat) async {
    final body = jsonEncode({
      'type': engin,
      'immatriculation': immatriculation,
      'users_id': userId,
      'etat': etat
    });
    try {
      print('Request body: $body');
      final response = await http.post(Uri.parse(driverUpdateUrl),
          headers: {'Content-Type': 'application/json'}, body: body);

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        print('Success message: ${res['message']}');
        returnSuccess(res['message']);
        return true;
      } else {
        final res = jsonDecode(response.body);
        print('Error message: ${res['message']}');
        returnError(res['message']);
        return false;
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error to update profile');
    }
  }
}
