import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/controllers/add_user_controller.dart';
import 'package:otrip/pages/add_user_page/forms/register_user_form.dart';
import 'package:otrip/pages/register_page/controllers/register_controller.dart';
import '../../providers/theme/theme.dart';
import '../profile_page/widgets/clipper.dart';


class AddUserPage extends GetWidget<AddUserController> {

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
                  icon: Icon(Icons.arrow_back,
                      color: Colors.white), // Icône de l'IconButton
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            )),
        body: GetBuilder<AddUserController>(
          builder: (_) => SafeArea(
              top: false,
              child: Stack(children: [
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: ClipPath(
                        clipper: DrawClip(),
                        child: Container(
                          color: AppTheme.otripMaterial,
                          width: Get.width,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 75.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "register_text".tr,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "register_info".tr,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: defaultPadding),
                            child: AddUserForm(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ])
              ),
        )
        );
  }
}