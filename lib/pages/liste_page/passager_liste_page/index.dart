// Importations nécessaires
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/controllers/passager_list_controller.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/models/passager_demande_model.dart';
import 'package:otrip/pages/start_course_process_page/move_to_startplace_page/index.dart';
import 'package:otrip/providers/theme/theme.dart';

class PassagerListPage extends GetWidget<PassagerListController> {

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
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<PassagerListController>(
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
                    child: GetBuilder<PassagerListController>(
                      builder: (_) {
                        return FutureBuilder<List<DemandeInfo>>(
                          future: controller.fetchDemandes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Erreur: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('Aucune demande trouvée.'));
                            } else {
                              List<DemandeInfo> demandeList = snapshot.data!;
                              return ListView.builder(
                                itemCount: demandeList.length,
                                itemBuilder: (context, index) {
                                  DemandeInfo demande = demandeList[index];
                                  String name = '${demande.nom} ${demande.prenom}';
                                  String phoneNumber = demande.telephone;
                                  String depart = demande.depart;
                                  String arrivee = demande.arrivee;
                                  String passerId = demande.passagerId.toString();
                                  return InkWell(
                                    onTap: (){
                                      Get.to(MoveToStartPlacePage(departPlace: depart, destinationPlace: arrivee,passagerId: passerId));
                                    },
                                    child: Card(
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

                                                  Text(
                                                    depart,
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    arrivee,
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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
