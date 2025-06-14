/* import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import '../../constants.dart';
import '../api_constants.dart';
import 'package:http/http.dart' as http;

class AuthApiClient extends GetConnect {
  @override
  void onInit() {

    httpClient.baseUrl = baseUrl;
    httpClient.addRequestModifier<dynamic>((request) async {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      return request;
    });
  }

  void returnError(String error){
    Get.snackbar(
      "error".tr,
      error,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  void returnSuccess(String success){
    Get.snackbar(
      "success".tr,
      success,
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    // final cBox = await Hive.openBox<Contact>(contactBox);
    Map<String, String> body = {'mobile_number': phone, 'password': password};
    final response = await post(loginUrl, body);

    print(response.statusCode);
    if (response.status.hasError) {
      if (response.status.code == 401) {
        returnError(response.body['message']);
        throw Exception("invalid_credentials".tr);
      } else {
        returnError(response.body['message']);
        throw Exception('connection_error'.tr);
      }
    } else if (response.body is Map) {
      try {
        // await cBox.clear();
      } catch (e) {
        print("error: $e");
      }
      returnSuccess(response.body['message']);
      return response.body;
    } else {
      returnError(response.body['message']);
      throw Exception('Response is not a Map');
    }
  }

  Future<Map<String, dynamic>> register(
      int role,
      String username,
      String name,
      String lastname,
      String mobileNumber,
      String phoneCode,
      int countryId,
      String password) async {
    // final cBox = await Hive.openBox<Contact>(contactBox);
    Map<String, dynamic> body = {
      'role_id': role,
      'username': username,
      'name': name,
      'lastname': lastname,
      'mobile_number': mobileNumber,
      'phone_code' : phoneCode,
      'country_id' : countryId,
      'password': password
    };
    final response = await post(registerUrl, body);
    print(response.statusCode);
    if (response.status.hasError) {
      if (response.status.code == 401) {
        throw Exception("invalid_credentials".tr);
      } else if (response.status.code == 400) {
        throw Exception("400");
      } else {
        throw Exception('connection_error'.tr);
      }
      //throw Exception('Response has error');
    } else if (response.body is Map) {
      try {
        // delete all contacts
        // await cBox.clear();
      } catch (e) {
        print("error: $e");
      }
      return response.body;
    } else {
      throw Exception('Response is not a Map');
    }
  }

/*   Future<bool> signUp(
  int role,
  String username,
  String name,
  String lastname,
  String mobileNumber,
  String password,
  Map<String, double?> positions,
) async {
  String registerUrl = "http://192.168.1.10:5000/api/register";

  try {
    String body = jsonEncode(User(
      roleId: role,
      username: username,
      name: name,
      lastname: lastname,
      mobileNumber: mobileNumber,
      password: password,
      positions: positions,
    ).toJson());

    print("Le body: ${body}");

    final response = await http.post(
      Uri.parse(registerUrl),
      body: body,
      headers: {'Content-Type': 'application/json'},
    );

    print("code status: ${response.statusCode}");

    if (response.statusCode == 401) {
      throw Exception("invalid_credentials".tr);
    } else if (response.statusCode == 400) {
      throw Exception("400");
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      print("Enregistré avec succès!");
      return true;
    } else {
      throw Exception('connection_error'.tr);
    }
  } catch (e) {
    if (e is http.ClientException) {
      print("Erreur HTTP : ${e.message}");
      // Vous pouvez extraire le corps de la réponse ici
    } else {
      print("Erreur inattendue : $e");
    }
    throw Exception('Une erreur inattendue s\'est produite');
  }
} */




  Future<bool> signUp(
      int role,
      String username,
      String name,
      String lastname,
      String mobileNumber,
      String phoneCode,
      String password,
      Map<String, double> positions,

      ) async {
/*     String registerUrl = baseUrl + "register";
    if (role == 1){

    } else if (role == 2) {
      registerUrl = baseUrl + "marchand/create";
    } else if (role == 3) {
      registerUrl = baseUrl + "conducteur/create";
    } */

    String body = jsonEncode({
      'role_id': role,
      'username': username,
      'name': name,
      'lastname': lastname,
      'mobile_number': mobileNumber,
      'password': password,
      'phone_code': phoneCode,
      'positions': positions
    });

    print("Le body: ${body}");

    try {
      final response = await post(
        registerUrl,
        body,
      );

      print("code status: ${response.statusCode}");

      if (response.statusCode == 401) {
        returnError(response.body['message']);
        throw Exception("invalid_credentials".tr);

      } else if (response.statusCode == 400) {
        returnError(response.body['message']);
        throw Exception("400");
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        print("Enregistré avec succès!");
        print(response.body);
        GetStorage('user_infos').write('access_token', response.body['data']['token']);
        returnSuccess(response.body['message']);
        var userData = await getUserData(mobileNumber);

        navigateToHome(userData['role_id']);
        return true;
      } else {
        returnError(response.body['message']);
        throw Exception('connection_error'.tr);
      }
    } catch (e) {
      print("error: $e");
      throw Exception('Une erreur inattendue s\'est produite');
    }
  }

  Future<Map<String, dynamic>> getUserData(String phoneNumber) async {
    try {
      final response = await get('${baseUrl}user/$phoneNumber');

      if (response.statusCode == 200) {
        Map<String, dynamic> userData = response.body['data']['user'];
        print('L\'utilisateur est : ${userData}');
        return userData;
      } else {
        throw Exception('Erreur lors de la récupération des données utilisateur');
      }
    } catch (e) {
      throw Exception('Erreur réseau: $e');
    }
  }


  /*  Future<void> signIn(String phoneNumber, String password) async {
    final String apiUrl = 'http://192.168.1.10:5000/api/login';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {'mobile_Number': phoneNumber, 'password': password},
    );

    if (response.statusCode == 200) {
      // Analysez la réponse JSON pour déterminer si l'authentification a réussi
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success'] == true) {
        // Authentification réussie, effectuez les actions nécessaires ici.
        print("Connecté avec succès!");
      } else {
        // Authentification échouée, affichez un message d'erreur ou gérez l'échec de connexion.
        print("Échec de la connexion. Veuillez vérifier vos informations d'identification.");
      }
    } else {
      // Gérez les erreurs HTTP, par exemple, en affichant un message d'erreur.
      print("Erreur lors de la communication avec le serveur");
    }
  }
 */


  Future<void> signIn(String phoneNumber, String password) async {
    final String apiUrl = baseUrl+'login';

    final response = await post(
      apiUrl,
      {'mobile_number': phoneNumber, 'password': password},
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> responseData = response.body;
      // Affichez le contenu de la réponse dans la console de débogage
      print("Réponse du serveur: $responseData");

      if (responseData['success'] == true) {

        var user = response.body['data']['user'];
        final userData = GetStorage('user_infos');
        userData.write('firstname', user['name']);
        userData.write('lastname', user['lastname']);
        userData.write('username', user['username']);
        userData.write('phone_number', user['phone_number']);
        userData.write('user_role', user['role_id']);
        userData.write('access_token', response.body['data']['token']);
        returnSuccess(response.body['message']);
        navigateToHome(user['role_id']);
        print("Connecté avec succès!");
      } else {
        print("Échec de la connexion. Veuillez vérifier vos informations d'identification.");
      }
    } else {
      print("Erreur lors de la communication avec le serveur. Code d'erreur: ${response.statusCode}");
      print("Contenu de la réponse: ${response.body}");
      returnError(response.body['message']);
    }
  }



  // Future <Map<String, dynamic>> refreshToken(String refreshToken) async {
  //   Map<String, String> body = {'refresh': refreshToken};
  //   final response = await post(refreshTokenUrl, body, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   if (response.status.hasError) {
  //     throw Exception('Response has error');
  //   } else if (response.body is Map) {
  //     return response.body;
  //   } else {
  //     throw Exception('Response is not a Map');
  //   }
  // }
  //
  // //sent otp code
  // Future <Map<String, dynamic>> sentOtpCode(String email) async {
  //   Map<String, String> body = {'email': email};
  //   final response = await post(sentOtpUrl, body, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   print(response.statusCode);
  //
  //   if (response.status.code == 400) {
  //     if (response.body is Map){
  //       // check if response.body have error key with value EMAIL_REQUIRED
  //       if(response.body.containsKey('error') && response.body['error'] == 'EMAIL_REQUIRED') {
  //         Get.snackbar('error'.tr, 'email_required'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
  //       }else if (response.body.containsKey('error') && response.body['error'] == 'GOOGLE_AUTH_REQUIRED') {
  //         Get.snackbar('error'.tr, 'google_auth_required'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.orange, colorText: Colors.white);
  //       }else{
  //         Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
  //       }
  //     }else{
  //       Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   }else if (response.statusCode == 404){
  //     if (response.body is Map) {
  //       // check if response.body have error key with value USER_NOT_FOUND
  //       if (response.body.containsKey('error') &&
  //           response.body['error'] == 'USER_NOT_FOUND') {
  //         Get.snackbar(
  //             'error'.tr, 'user_not_found'.tr, snackPosition: SnackPosition.TOP,
  //             backgroundColor: Colors.red,
  //             colorText: Colors.white);
  //       } else {
  //         Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP,
  //             backgroundColor: Colors.red,
  //             colorText: Colors.white);
  //       }
  //     }else {
  //       Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   }
  //   if (response.status.hasError) {
  //     throw Exception('Response has error');
  //   } else if (response.body is Map) {
  //     print(response.body);
  //     return response.body;
  //   } else {
  //     throw Exception('Response is not a Map');
  //   }
  // }
  //
  // Future <Map<String, dynamic>> resetOtpPassword(String password) async{
  //   print("resetOtpPassword");
  //   String otpEmail = "${GetStorage().read('otp_email')}";
  //   String otpCode = "${GetStorage().read('otp')}";
  //   Map<String, String> body = {'password': password, 'email': otpEmail, 'otp': otpCode};
  //   final response = await post(resetPasswordOtpUrl, body, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   print(response.statusCode);
  //   print(response.body);
  //   if (response.status.code == 400) {
  //     if (response.body is Map){
  //       // check if response.body have error key with value EMAIL_REQUIRED
  //       if(response.body.containsKey('error') && response.body['error'] == 'EMAIL_REQUIRED') {
  //         Get.snackbar('error'.tr, 'email_required'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
  //       }else if (response.body.containsKey('error') && response.body['error'] == 'OTP_REQUIRED') {
  //         Get.snackbar('error'.tr, 'otp_required'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.orange, colorText: Colors.white);
  //       }else if (response.body.containsKey('error') && response.body['error'] == 'PASSWORD_REQUIRED') {
  //         Get.snackbar('error'.tr, 'password_required'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.orange, colorText: Colors.white);
  //       }else if (response.body.containsKey('error') && response.body['error'] == 'INVALID_OTP') {
  //         Get.snackbar('error'.tr, 'invalid_otp'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.orange, colorText: Colors.white);
  //       }else{
  //         Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
  //       }
  //     }else{
  //       Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, colorText: Colors.white);
  //     }
  //   }else if (response.statusCode == 404){
  //     if (response.body is Map) {
  //       // check if response.body have error key with value USER_NOT_FOUND
  //       if (response.body.containsKey('error') &&
  //           response.body['error'] == 'USER_NOT_FOUND') {
  //         Get.snackbar(
  //             'error'.tr, 'user_not_found'.tr, snackPosition: SnackPosition.TOP,
  //             backgroundColor: Colors.red,
  //             colorText: Colors.white);
  //       } else {
  //         Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP,
  //             backgroundColor: Colors.red,
  //             colorText: Colors.white);
  //       }
  //     }else {
  //       Get.snackbar('error'.tr, 'connection_error'.tr, snackPosition: SnackPosition.TOP,
  //           backgroundColor: Colors.red,
  //           colorText: Colors.white);
  //     }
  //   }
  //   if (response.status.hasError) {
  //     throw Exception('Response has error');
  //   } else if (response.body is Map) {
  //     return response.body;
  //   } else {
  //     throw Exception('Response is not a Map');
  //   }
  // }
  //
  // Future<Map<String, dynamic>> loginWithGoogleOAuth2() async{
  //   final response = await get(loginWithGoogleUrl, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //   });
  //   print(response.statusCode);
  //   print('response.body: ${response.body}');
  //   if (response.status.hasError) {
  //     throw Exception('Response has error');
  //   } else if (response.body is Map) {
  //     if(!response.body.containsKey('authorization_url')){
  //       throw Exception('Response has error');
  //     }
  //     Uri authorizationUrl = Uri.parse(response.body['authorization_url']);
  //     String? clientId = authorizationUrl.queryParameters['client_id'];
  //     String? state = authorizationUrl.queryParameters['state'];
  //     if (clientId == null || clientId.isEmpty) {
  //       throw Exception('Response has error');
  //     }
  //
  //     GoogleSignIn googleSignIn = GoogleSignIn(
  //       clientId: clientId,
  //       serverClientId: "743856921616-regflp3jc5925b5pq1plht03ocjc32p9.apps.googleusercontent.com",
  //       scopes: [
  //         'email',
  //         'openid',
  //         'profile',
  //
  //       ],
  //     );
  //
  //     try{
  //       final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //       String email = await googleSignInAccount!.email;
  //       await googleSignIn.signOut();
  //       Map<String, String> body = {'email': email};
  //       final response = await post(loginWithGoogleAccessUrl,body, headers: {
  //         'content-type': 'application/json',
  //       });
  //       print(response);
  //       if (response.statusCode==201){
  //         Get.snackbar("google_auth_started".tr, "google_auth_started_message".tr, backgroundColor: successColor, colorText: Colors.white);
  //         return {};
  //       }else if(response.statusCode==401){
  //         if(response.body["error"]== "UNAUTHORIZED"){
  //           Get.snackbar("google_auth_started".tr, "google_auth_unauthorized".tr, backgroundColor: errorColor, colorText: Colors.white);
  //           return {};
  //         }
  //       }else if (response.statusCode== 200){
  //         print("reponse ${response.body}");
  //         return response.body;
  //       }else {
  //         Get.snackbar("google_auth_started".tr, "connection_error".tr, backgroundColor: errorColor, colorText: Colors.white);
  //         return {};
  //       }
  //     }catch(e){
  //       print("---------------------*********************************---------------------");
  //       print('error: $e');// // logout
  //       await googleSignIn.signOut();
  //     }
  //     return {};
  //   } else {
  //     throw Exception('Response is not a Map');
  //   }
  // }

  // For Logout
  Future<void> logout() async {
    String token = GetStorage('user_infos').read('access_token') ?? '';
    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final response = await post(logoutUrl, {}, headers: headers);
    print(response.body);
    if (response.status.hasError) {
      if (response.status.code == 401) {
        returnError(response.body['message']);
        throw Exception("invalid_credentials".tr);
      } else {
        returnError(response.body['message']);
        throw Exception('connection_error'.tr);
      }
    } else if (response.status.code == 200) {
      try {
        // await cBox.clear();
      } catch (e) {
        print("error: $e");
      }

      final box = GetStorage('user_infos');
      box.remove('access_token');
      box.remove('refresh_token');
      box.remove('firstname');
      box.remove('lastname');
      box.remove('username');
      box.remove('phone_number');
      box.remove('user_role');
      box.remove('access_token');

      returnSuccess(response.body['message']);
      Get.offAllNamed('/connexion');
      return response.body;
    } else {
      returnError(response.body['message']);
      throw Exception('Response is not a Map');
    }
  }
}
 */