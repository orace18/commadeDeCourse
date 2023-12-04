import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/login_page/forms/login_form.dart';
import 'controllers/login_controller.dart';
import '../../providers/theme/theme.dart';

class LoginPage extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Ink(
            decoration: ShapeDecoration(
              color: AppTheme.otripMaterial[200], // Couleur du bouton
              shape: CircleBorder(), // Forme ronde
            ),
            child: IconButton(
              enableFeedback: false,
              icon: Icon(Icons.arrow_back, color: Colors.white), // Icône de l'IconButton
              onPressed: (){ Get.back(); },
            ),
          ),
        )
      ),
        body: GetBuilder<LoginController>(
          builder: (_) => SafeArea(
            top: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  Get.width, 100.0)),
                          color: AppTheme.otripMaterial,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("welcome".tr, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("phone_request".tr, style: TextStyle(color: Colors.white, fontSize: 14),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                            child: LoginForm(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]
            )
          ),
        ));
  }
}
