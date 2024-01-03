import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/api/marchands/controllers/api_marchand_client.dart';
import 'package:otrip/pages/dashboard_page/dashboards/marchand_page/controller/marchand_controller.dart';
import 'package:otrip/providers/theme/theme.dart';
import '../../../liste_page/conducteur_liste_page/controllers/parrainage_list_conducteur_controller.dart';

class MarchandPage extends GetWidget<MarchandController> {
  final ListConducteurController listController =
      Get.put(ListConducteurController());
  //final MarchandService service = MarchandService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Otrip"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Get.toNamed('/marchand_menu');
          },
        ),
      ),
      body: GetBuilder<ListConducteurController>(
        builder: (_) => Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed('/wallet');
                },
                child: Card(
                  elevation: 16.0,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text("balance".tr),
                            SizedBox(
                              width: 10.0,
                            ),
                          ],
                        ),
                        Text("O FCFA"),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  elevation: 12.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "conductor_number".tr,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '${listController.driversList.length.toInt().toString()}',
                          style: TextStyle(
                            color: AppTheme.otripMaterial,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                            Get.toNamed('/demande_conducteur');
                          },
                          icon: Icon(Icons.message),
                          label: Text(
                            "tasks".tr,
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
      ),
    );
  }
}
