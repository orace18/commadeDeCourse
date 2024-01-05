import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/pages/profile_page/controllers/profile_marchand_controller.dart';

class ProfileEditMarchandController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final userData = GetStorage();
  final imagePath = ''.obs;

  Map<String, dynamic> getUserData() {
    return {
      'firstname': userData.read('firstname') ?? '',
      'lastname': userData.read('lastname') ?? '',
      'username': userData.read('username') ?? '',
      'phoneNumber': userData.read('phone_number') ?? '',
      // 'password': userData.read('password') ?? '',
    };
  }

  void updateProfile(Map<String, dynamic> updatedData, String updatedGender,
      DateTime updatedBirthday, String updatedAddress) {
    final profileController = Get.find<MerchantController>();

    userData.write('firstname', updatedData['firstname']);
    userData.write('lastname', updatedData['lastname']);
    userData.write('phone_number', updatedData['phone_number']);

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
    );

    // Naviguer vers la page de profil après la mise à jour
    Get.toNamed('/profile_marchand');
  }

  void navigateBack() => Get.back();
  void updateProfileInfo(
    String updatedGender,
    DateTime updatedBirthday,
    String updatedAddress,
  ) {}
}
