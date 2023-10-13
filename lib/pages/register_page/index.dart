import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/register_page/forms/register_form.dart';
import '../../providers/theme/theme.dart';
import 'controllers/register_controller.dart';

class RegisterPage extends GetWidget<RegisterController> {
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
        body: GetBuilder<RegisterController>(
          builder: (_) => SafeArea(
              top: false,
              child: Stack(
                  children: [
                    SizedBox(
                      height: Get.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height*0.45, left: 20, right: 20),
                          child: RegisterForm(),
                        ),
                      ),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height/2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.elliptical(
                                Get.width, 100.0)),
                        color: AppTheme.otripMaterial,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("register_text".tr, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: 10,
                            ),
                            Text("register_info".tr, style: TextStyle(color: Colors.white, fontSize: 14),)
                          ],
                        ),
                      ),
                    ),
                  ]
              )
          ),
        ));
  }
}
