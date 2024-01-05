import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../providers/theme/theme.dart';
import 'controllers/connexion_controller.dart';

class ConnexionPage extends GetWidget<ConnexionController> {
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
                  color: AppTheme.otripMaterial[600], // Couleur du bouton
                  shape: CircleBorder(), // Forme ronde
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white), // Icône de l'IconButton
                  onPressed: (){ Get.back(); },
                ),
              ),
            )
        ),
        body: GetBuilder<ConnexionController>(
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
                              color: AppTheme.otripMaterial[200],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 40),
                              child: Column(
                                children: [
                                  Text(
                                    'welcome'.tr,
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 50,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                          onPressed: (){ Get.toNamed('/role_choose'); },
                                          child: Text('register'.tr, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: const Size.fromHeight(50),
                                            elevation: 0,
                                            backgroundColor: AppTheme.otripMaterial,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0)
                                            ),
                                          )
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Divider(
                                              height: 2,
                                              color: Colors.grey,
                                            ),
                                            Container(color: Colors.white,child: Text('or'.tr, style: Theme.of(context).textTheme.titleMedium,))
                                          ],
                                        ),
                                      ),
                                      OutlinedButton(
                                        child: Text('login'.tr, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),),
                                        style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                            side: BorderSide(
                                                width: 1.0,
                                                color: Colors.grey
                                            )
                                        ),
                                        onPressed: () { Get.toNamed('/login'); },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ]
              )
          ),
        ));
  }
}
