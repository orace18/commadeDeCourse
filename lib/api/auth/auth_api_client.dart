import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

import '../../constants.dart';



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

  // For login
  // Future<Map<String, dynamic>> login(String email, String password) async {
  //
  // }

  // For Register
  // Future<Map<String, dynamic>> register( String email, String password) async {
  //
  // }

  // For Refresh Token if token is expired
  // Future <Map<String, dynamic>> refreshToken(String refreshToken) async {
  //
  // }

  // For Send Otp
  // Future <Map<String, dynamic>> sentOtpCode(String email) async {
  //
  // }

  // For reset password
  // Future <Map<String, dynamic>> resetOtpPassword(String password) async{
  //
  // }

  // For Logout
  Future<void> logout() async{
    final box = GetStorage();
    box.remove('access_token');
    box.remove('refresh_token');
    Get.snackbar('disconnection'.tr, 'disconnection_message'.tr, backgroundColor: successColor, colorText: Colors.white);
    Get.offAllNamed('/connexion');
  }

}
