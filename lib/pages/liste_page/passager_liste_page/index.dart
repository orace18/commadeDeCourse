import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/controllers/specific_drivers_controller.dart';
import 'package:otrip/providers/theme/theme.dart';

class SpecificDriverPage extends StatelessWidget {
  late String type;
  SpecificDriverPage(this.type);
  final SpecificDriverController controller = Get.find<SpecificDriverController>();

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
              color: AppTheme.otripMaterial[600],
              shape: CircleBorder(),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 187, 106, 106)),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<SpecificDriverController>(
        builder: (_) => SafeArea(
          top: false,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ClipPath(
                      clipper: DrawClip(),
                      child: Container(
                        color: AppTheme.otripMaterial,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 60.0),
                            child: Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Liste des demandes reçues",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: GetBuilder<SpecificDriverController>(
                      builder: (_) {
                        return FutureBuilder<List<Map<String, dynamic>>>(
                          future: controller.fetchSpecificDriver(this.type),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Erreur: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('Aucune demande trouvée.'));
                            } else {
                              List<Map<String, dynamic>> driverList = snapshot.data!;
                              return ListView.builder(
                                itemCount: driverList.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> driver = driverList[index];
                                  String name = '${driver['user']['name']} ${driver['user']['lastname']}';
                                  String phoneNumber = driver['user']['mobile_number'];
                                  return Card(
                                    margin: EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  phoneNumber,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        );
                      },
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
