import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ProfileEditInfoController extends GetxController {
  final formKey = GlobalKey<FormBuilderState>();

  final imagePath = ''.obs;

  void navigateBack() => Get.back();
}
