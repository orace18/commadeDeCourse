import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConducteurProfileController extends GetxController {
  final imagePath = ''.obs;
  late RxString gender;
  late Rx<DateTime> birthday;
  late RxString address;
  late RxString numeroImmatricule;
  final userData = GetStorage();
  late String userRole;
  late final GetStorage storage;

  @override
  void onInit() {
    super.onInit();
    storage = GetStorage();
    userRole = getRole();
    gender = RxString('');
    birthday = DateTime.now().obs;
    address = RxString('');
    numeroImmatricule = RxString('');
  }

  // Fonction pour récupérer les données de l'utilisateur
  Map<String, dynamic> getUserData() {
    return {
      'firstname': userData.read('firstname') ?? '',
      'lastname': userData.read('lastname') ?? '',
      'username': userData.read('username') ?? '',
      'phone_number': userData.read('phone_number') ?? '',
      'gender': userData.read('gender') ?? '',
      'birthday': userData.read('birthday') ?? DateTime.now(),
      'address': userData.read('address') ?? '',
      'numeroImmatricule': userData.read('numeroImmatricule') ?? '',
    };
  }

  void updateProfile(Map<String, dynamic> updatedUserData) {
    userData.write('firstname', updatedUserData['firstname']);
    userData.write('lastname', updatedUserData['lastname']);
    userData.write('username', updatedUserData['username']);
    userData.write('phone_number', updatedUserData['phone_number']);

    update();
  }

  //recuperer le reste des infos
  void updateProfileInfo(String updatedGender, DateTime updatedBirthday,
      String updatedAddress, String updatedNumeroImmatricule) {
    gender.value = updatedGender;
    birthday.value = updatedBirthday;
    address.value = updatedAddress;
    numeroImmatricule.value = updatedNumeroImmatricule;

    userData.write('gender', updatedGender);
    userData.write('birthday', updatedBirthday.toString());
    userData.write('address', updatedAddress);
    userData.write('numeroImmatricule', updatedNumeroImmatricule);
  }

  String getUserRole() {
    final roleId = userData.read('user_role') ?? '0';
   // int roleId = int.tryParse(roleIdString) ?? 0;
    return getRoleFromId(roleId);
  }

  String getRoleFromId(int roleId) {
    // Logique pour trouver le rôle correspondant à l'ID
    switch (roleId) {
      case 1:
        return 'Merchant';
      case 2:
        return 'Driver';
      case 3:
        return 'Passenger';
      case 4:
        return 'Society';
      default:
        return 'Unknown'; // Ou une valeur par défaut si nécessaire
    }
  }

  String getRole() {
    int roleId = storage.read('user_role') ?? 0;
    return getRoleFromId(roleId);
  }

  void navigateBack() => Get.back();
}
