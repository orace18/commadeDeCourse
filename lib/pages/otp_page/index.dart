import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/otp_page/controllers/otp_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OtpPage extends GetWidget<OtpController> {

  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('verify_otp'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'enter_otp_code_sent_to_your_phone'.tr,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            PinCodeTextField(
              appContext: context,
              length: 6, // Longueur du code OTP
              controller: _otpController,
              onChanged: (value) {
                // Callback appelée lorsqu'un chiffre est saisi
                print(value);
              },
              onCompleted: (value) {
                // Callback appelée lorsque le code OTP est complété
                print("Completed: $value");
                // Vous pouvez ajouter ici la logique pour vérifier le code OTP
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
               
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}