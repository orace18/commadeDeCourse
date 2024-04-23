import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/dashboard_page/dashboards/driver_page/controllers/driver_controller.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/controllers/passager_list_controller.dart';
import 'package:otrip/providers/theme/theme.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../api/api_constants.dart';
import '../../../../web_socket_and _Location_services.dart';

class DriverPage extends StatefulWidget {
  @override
  DriverStatePage createState() => DriverStatePage();
}

class DriverStatePage extends State<DriverPage>{

PassagerListController passagerListController = PassagerListController();
late final LocationService _locationService;

  @override
  void initState() {
    super.initState();
    _locationService = LocationService(
        WebSocketChannel.connect(Uri.parse('ws://$baseUrlSocket/')));
   // _checkLocationPermission();
  }



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
              SizedBox(height: 16.0,),
              Text("Complètez votre profil pour avoir de client",
                style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0,),
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
                            SizedBox(width: 10),
                            Text("wallet".tr),
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
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          Get.toNamed('/passager_list');
                        },
                        icon: Icon(Icons.list_rounded),
                        label: Text(
                          "client_list".tr,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed('/demande_passager');
                        },
                        icon: Icon(Icons.person_add_alt_1_sharp),
                        label: Text(
                          "tasks".tr,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/passager_list');
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          height: Get.height * 0.22,
                          child: Center(
                            child: Text("start_course".tr,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/parrainage');
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
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/activities');
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          height: Get.height * 0.22,
                          child: Center(
                            child: Text("activities".tr,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/statistic');
                      },
                      child: Card(
                        color: Colors.white,
                        child: Container(
                          height: Get.height * 0.22,
                          child: Center(
                            child: Text("statistic".tr,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
