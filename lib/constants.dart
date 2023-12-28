import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

// Texts
const appName = "Otrip";
const google_api_key = "AIzaSyBbTebj7DVC2yJu0hDJPfqP63x9uz9GQ-8";
// const google_api_key = "AIzaSyD-8-htTPIegLQx40M2tseJ6yhf4wL1mHo";

//General Color
const warningColor = Colors.orange;
const errorColor = Colors.red;
const successColor = Colors.green;
const infoColor = Colors.indigo;

const otripOrange = Color(0xfff83600);
const otripYellow = Color(0xfffacc22);

// Double values
const defaultPadding = 12.0;
const circleAvatarRaduis = 75.0;

// Widgets
const defaultSizedBox = SizedBox(height: 10, width: 10,);
const default2xSizedBox = SizedBox(height: 20, width: 20,);

void navigateToHome(int roleId){
  switch (roleId) {
    case 1:
      Get.toNamed("/");
      break;
    case 2:
      Get.toNamed("/marchand");
      break;
    case 3:
      Get.toNamed("/driver");
      break;
    case 4:
      Get.toNamed("/passager");
      break;
    default:
      break;
  }
}

