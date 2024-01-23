// Importez les packages nécessaires
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/api/marchands/controllers/api_marchand_client.dart';
import 'package:otrip/pages/dashboard_page/dashboards/driver_page/controllers/driver_controller.dart';
import 'package:otrip/pages/dashboard_page/dashboards/driver_page/widgets/driver_menu.dart';
import 'package:otrip/pages/parrainage_demange_page/controllers/parrainage_demande_controller.dart';
import 'package:otrip/providers/theme/theme.dart';

class DriverPage extends GetWidget<DriverController> {
  MarchandService parrainage = MarchandService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otrip"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Get.toNamed('/driver_menu');
          },
        ),
      ),
      body: GetBuilder<DriverController>(
        builder: (_) => Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
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
                            SizedBox(width: 10,),
                            Text("wallet".tr)
                          ],
                        ),
                        Icon(Icons.remove_red_eye, color: AppTheme.otripMaterial),
                      ],
                    ),
                  ),
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
                          Get.toNamed('/passager_list');
                        },
                        icon: Icon(Icons.ac_unit_rounded),
                        label: Text("driver_list".tr, style: TextStyle(color: Colors.black, fontSize: 14),),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed('/demande_passager');
                        },
                        icon: Icon(Icons.person_2_rounded,),
                        label: Text("tasks".tr, style: TextStyle(color: Colors.black, fontSize: 14),),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        // Action pour la première carte horizontale
                        Get.toNamed('/parrainage'); // Exemple : navigation vers une page dédiée
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          height: Get.height * 0.22,
                          child: Center(
                            child: Text("parrainage".tr,
                             style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/do_course'); 
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          height: Get.height * 0.22,
                          child: Center(
                            child: Text("start_course".tr, style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                   SizedBox(width: 10),
                  Expanded(
                    flex: 5,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/activities'); 
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          height: Get.height * 0.22,
                          child: Center(
                            child: Text("activities".tr, style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed('/statistic'); 
                },
                child: Card(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  child: Container(
                    height: Get.height*0.22,
                    child: Center(
                      child: Text("statistics".tr),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
