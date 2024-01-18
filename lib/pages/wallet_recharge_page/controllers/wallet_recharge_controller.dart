import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/fedapay/feda.dart';

class WalletRechargeController extends GetxController {
  void navigateBack() => Get.back();
  final isButtonEnabled = false.obs;
  RxList recharge_phone_numbers = [].obs;
  final box = GetStorage();

  // formulaire de recharge
  final formKey = GlobalKey<FormBuilderState>();
  final recharge_phone_number = GlobalKey<FormBuilderFieldState>();
  final recharge_way = GlobalKey<FormBuilderFieldState>();
  final recharge_amount = GlobalKey<FormBuilderFieldState>();

  // formulaire d"ajout moyen de paeiment
  final idFormKey = GlobalKey<FormBuilderState>();
  final phone_number = GlobalKey<FormBuilderFieldState>();
  final recharge_way_add = GlobalKey<FormBuilderFieldState>();

  @override
  void onInit() {
    List<dynamic> temp  = box.read<List<dynamic>>('mtn_phone_numbers') ?? [];
    recharge_phone_numbers.value = temp.obs;
    super.onInit();
  }

  void updateButtonEnabled(bool isEnabled) {
    isButtonEnabled.value = isEnabled;
  }

  void validateField(GlobalKey<FormBuilderFieldState> key){
    key.currentState?.validate();
    updateButtonEnabled(formKey.currentState?.isValid ?? false);
  }

  void updateRechargePhoneNumbers(){
    if(recharge_way.currentState?.value.toString() == "mtn") {
      print(box.read<List<dynamic>>('mtn_phone_numbers').runtimeType);
      List<dynamic> temp  = box.read<List<dynamic>>('mtn_phone_numbers') ?? [];
      recharge_phone_numbers.value = temp.obs;
    } else {
      List<dynamic> temp = box.read<List<dynamic>>('moov_phone_numbers') ?? [];
      recharge_phone_numbers.value = temp.obs;
    }
  }

  void rechargeWallet(){
    String email = "makandjou3000@gmail.com";
    String country = "bj";
    String? network = recharge_way.currentState?.value.toString();
    String? phoneNumber = recharge_phone_number.currentState?.value.toString();
    double amount = double.parse(recharge_amount.currentState!.value.toString());
    // FedaApi().createRedirectTransaction(email, country, network!, phoneNumber!, amount);
  }

}
