import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants.dart';
import '../api_helper.dart';
import 'auth_api_client.dart';

ApiHelper apiHelper = ApiHelper();

class AuthController extends GetxController {
  final AuthApiClient apiClient = AuthApiClient();
  final loginClicked = false.obs;
  final registerClicked = false.obs;
  RxBool isLoggedIn = false.obs;

  void setLoginClicked(bool value) {
    loginClicked.value = value;
  }

  void setRegisterClicked(bool value) {
    registerClicked.value = value;
  }

  void checkLoginStatus() {
    String? accessToken = GetStorage().read<String>('access_token');
    if (accessToken != null) {
      isLoggedIn.value = true;
    }
  }

  // For login using apiClient Login
  // Future<void> login(String email, String password) async {
  //   try {
  //     var box = GetStorage();
  //     print('login');
  //     var response = await apiClient.login(email, password);
  //     print(response);
  //     box.write('access_token', response['access']);
  //     box.write('refresh_token', response['refresh']);
  //     isLoggedIn.value = true;
  //     Get.offNamed('/');
  //   } catch (e) {
  //     Get.snackbar('error'.tr, e.toString().substring(11, e.toString().length), backgroundColor: errorColor, colorText: Colors.white);
  //   }
  //   setLoginClicked(false);
  // }

  // For register using apiClient
  // Future<void> register(String email, String password) async {
  //   //List<Category> category= await apiHelper.getAllCategories();
  //   try {
  //     Map<String, dynamic> response = await apiClient.register(email, password);
  //     if (response != null) {
  //       Get.snackbar('success'.tr, 'inscription'.tr,
  //           backgroundColor: successColor, colorText: Colors.white);
  //       var box = GetStorage();
  //       print('login');
  //       var response = await apiClient.login(email, password);
  //       print(response);
  //       box.write('access_token', response['access']);
  //       box.write('refresh_token', response['refresh']);
  //       Get.offNamed('/step1');
  //     }
  //   } catch (e) {
  //     if (e.toString().contains('400')) {
  //       Get.snackbar('Erreur d\'inscription', 'Email déjà utilisé', backgroundColor: warningColor, colorText: Colors.white);
  //     } else
  //       Get.snackbar('Erreur d\'inscription', e.toString(), backgroundColor: errorColor, colorText: Colors.white);
  //   } setRegisterClicked(false);
  // }

  Future<void> logout() async {
    GetStorage().remove('access_token');
    GetStorage().remove('refresh_token');
    isLoggedIn.value = false;
    Get.offAllNamed('/signin');
  }

  // Future<void> refreshToken() async {
  //   String? refreshToken = GetStorage().read<String>('refresh_token');
  //   print('Ewo');
  //   print(refreshToken);
  //   if (refreshToken == null) {
  //     isLoggedIn.value = false;
  //     Get.offAllNamed('/signin');
  //   } else {
  //     try {
  //       dynamic body = {'refresh': refreshToken};
  //       Map<String, dynamic>  response = await apiClient.refreshToken(body);
  //       GetStorage().write('access_token', response['access']);
  //       isLoggedIn.value = true;
  //     } catch (e) {
  //       isLoggedIn.value = false;
  //       Get.offAllNamed('/signin');
  //     }
  //   }
  // }

  //send otp code
  // Future<void> sendOtpCode(String email) async {
  //   try {
  //     print("Avant");
  //     var response = await apiClient.sentOtpCode(email);
  //     print("Quand meme");
  //     print(response);
  //     if (response['otp'] == null) {
  //       // Get.snackbar('error'.tr, 'us'.tr, backgroundColor: errorColor, colorText: Colors.white);
  //       return;
  //     }
  //     Get.snackbar('success'.tr, 'otp_code_sent'.tr,
  //         backgroundColor: successColor, colorText: Colors.white);
  //     // save otp code in storage
  //     GetStorage().write('otp', response['otp']);
  //     // save email in storage
  //     GetStorage().write('otp_email', email);
  //     Get.offNamed('/forget_password_otp');
  //   } catch (e) {
  //     Get.snackbar('error'.tr, e.toString().substring(11, e.toString().length), backgroundColor: errorColor, colorText: Colors.white);
  //   }
  // }

  // For reset password after otp
  // Future<void> resetOtpPassword(String password) async {
  //   try {
  //     var box = GetStorage();
  //     var response = await apiClient.resetOtpPassword(password);
  //     print(response);
  //     if( response['success'] == null){
  //       Get.snackbar('error'.tr, 'password_reset_error'.tr, backgroundColor: errorColor, colorText: Colors.white);
  //       return;
  //     }
  //     Get.snackbar('success'.tr, 'password_reset'.tr,
  //         backgroundColor: successColor, colorText: Colors.white);
  //     Get.offAllNamed('/signin');
  //   } catch (e) {
  //     Get.snackbar('error'.tr, e.toString().substring(11, e.toString().length), backgroundColor: errorColor, colorText: Colors.white);
  //   }
  // }
}


