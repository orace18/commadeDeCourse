import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WalletRechargeController extends GetxController {
  void navigateBack() => Get.back();
  final isButtonEnabled = false.obs;
  RxList recharge_phone_numbers = [].obs;
  final box = GetStorage('Otrip');

  // formulaire de recharge
  final formKey = GlobalKey<FormBuilderState>();
  final recharge_phone_number = GlobalKey<FormBuilderFieldState>();
  final recharge_way = GlobalKey<FormBuilderFieldState>();
  final recharge_amount = GlobalKey<FormBuilderFieldState>();

  // formulaire d"ajout moyen de paeiment
  final idFormKey = GlobalKey<FormBuilderState>();
  final phone_number = GlobalKey<FormBuilderFieldState>();
  final recharge_way_add = GlobalKey<FormBuilderFieldState>();

  void updateButtonEnabled(bool isEnabled) {
    isButtonEnabled.value = isEnabled;
  }

  void validateField(GlobalKey<FormBuilderFieldState> key){
    key.currentState?.validate();
    updateButtonEnabled(formKey.currentState?.isValid ?? false);
  }

  void updateRechargePhoneNumbers(){
    if(recharge_way.currentState?.value.toString() == "mtn") {
      List temp  = box.read<List<String>>('mtn_phone_numbers') ?? [];
      recharge_phone_numbers.value = temp.obs;
    } else {
      List temp = box.read<List<String>>('moov_phone_numbers') ?? [];
      recharge_phone_numbers.value = temp.obs;
    }
  }

}
