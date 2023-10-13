import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();
  final isButtonEnabled = false.obs;
  void updateButtonEnabled(bool isEnabled) {
    isButtonEnabled.value = isEnabled;
  }
  void navigateBack() => Get.back();
}
