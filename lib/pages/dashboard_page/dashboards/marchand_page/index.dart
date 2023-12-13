import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/dashboard_page/dashboards/marchand_page/controller/marchand_controller.dart';
import 'package:otrip/providers/theme/theme.dart';

import '../../../role_page/controllers/listconducteur_controller.dart';
class MarchandPage extends GetWidget<MarchandController> {
  final ListConducteurController listController =
      Get.put(ListConducteurController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ListConducteurController>(
      builder: (_) => Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Text("welcome".tr, style: Theme.of(context).textTheme.headline6,),
            GestureDetector(
              onTap: () {
                Get.toNamed('/wallet');
              },
              child: Card(
                elevation: 12.0,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.monetization_on),
                          SizedBox(
                            width: 10,
                          ),
                          Text("wallet".tr)
                        ],
                      ),
                      const Icon(Icons.remove_red_eye,
                          color: AppTheme.otripMaterial),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Conducteur",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Obx(() => Text(
                        _.people.length
                            .toString(), // Utilisation du contrôleur ListConducteurController
                        style: TextStyle(
                          color: AppTheme.otripMaterial,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed('/listConducteur');
                        },
                        icon: Icon(Icons.people),
                        label: Text(
                          "list".tr,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 5,
                    child: OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed('/demande');
                        },
                        icon: Icon(Icons.message),
                        label: Text(
                          "Demande".tr,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Card(
              color: Colors.white,
              child: Container(
                height: Get.height * 0.22,
                child: Center(
                  child: Text("statistics".tr),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
