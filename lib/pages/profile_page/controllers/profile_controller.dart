import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final imagePath = ''.obs;
  final userData = GetStorage();

  // Fonction pour récupérer les données de l'utilisateur
  Map<String, dynamic> getUserData() {
    return {
      'firstname': userData.read('firstname') ?? '',
      'lastname': userData.read('lastname') ?? '',
      'username': userData.read('username') ?? '',
      'phoneNumber': userData.read('phone_number') ?? '',
     // 'password': userData.read('password') ?? '',
    };
  }

  void updateProfile(Map<String, dynamic> updatedUserData) {
    userData.write('firstname', updatedUserData['firstname']);
    userData.write('lastname', updatedUserData['lastname']);
    userData.write('username', updatedUserData['username']);
    userData.write('phone_number', updatedUserData['phone_number']);

    update();
  }

  late String userRole;

  @override
  void onInit() {
    super.onInit();
    userRole = GetStorage().read('user_role') ?? '';
  }

  String getUserRole() {
    return userRole;
  }

  void navigateBack() => Get.back();
}
