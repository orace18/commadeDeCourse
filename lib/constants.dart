import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

// Texts
const appName = "Otrip";
const google_api_key = "AIzaSyBbTebj7DVC2yJu0hDJPfqP63x9uz9GQ-8";
// const google_api_key = "AIzaSyD-8-htTPIegLQx40M2tseJ6yhf4wL1mHo";
const double earthRadius = 6371; // Rayon moyen de la Terre en kilomètres
//General Color
const warningColor = Colors.orange;
const errorColor = Colors.red;
const successColor = Colors.green;
const infoColor = Colors.indigo;
//Latlng _finalAddressPosition;
const otripOrange = Color(0xfff83600);
const otripYellow = Color(0xfffacc22);

// Double values
const defaultPadding = 12.0;
const circleAvatarRaduis = 75.0;
double prixDuKm = 100.0;
// Widgets
const defaultSizedBox = SizedBox(height: 10, width: 10,);
const default2xSizedBox = SizedBox(height: 20, width: 20,);

void navigateToHome(int roleId){
  switch (roleId) {
    case 1:
      Get.offAllNamed("/marchand");
      break;
    case 2:
      Get.offAllNamed("/driver");
      break;
    case 3:
      Get.offAllNamed("/passager");
      break;
    case 4:
      Get.offAllNamed("/");
      break;
    default:
      break;
  }
}

  void returnError(String error) {
    Get.snackbar(
      "error".tr,
      error,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  void returnSuccess(String success) {
    Get.snackbar(
      "success".tr,
      success,
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  double CalculateCourseCost(double distance, double kmprice){
    double totalPrice = distance * kmprice;
    return totalPrice;
  }


