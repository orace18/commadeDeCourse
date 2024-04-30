import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/models/passager_demande_model.dart';
import 'package:otrip/pages/passager_demande_page/controllers/passager_demande_controller.dart';
import '../../../../providers/theme/theme.dart';

class PassagerDemandePage extends GetWidget<PassagerDemandeController> {

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
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<PassagerDemandeController>(
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
                                    "Liste des demandes en attente",
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
                    child: FutureBuilder<List<DemandeInfo>>(
                      future: controller.fetchDemandesEnAttente(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(color: Colors.deepOrange));
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Erreur: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('Aucune demande en attente trouvée.'));
                        } else {
                          List<DemandeInfo> demandeList = snapshot.data!;
                          return ListView.builder(
                            itemCount: demandeList.length,
                            itemBuilder: (context, index) {
                              DemandeInfo demande = demandeList[index];
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
                                            Text('${demande.nom} ${demande.prenom}', style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 10),
                                            Text('${demande.depart}', style: TextStyle(color: Colors.green)),
                                            SizedBox(height: 10),
                                            Text('${demande.arrivee}', style: TextStyle(color: Colors.red),),
                                            Text('${demande.heure.toString()}'),
                                            SizedBox(height: 10),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.annulerDemande(demande.id, index);
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.xmark,
                                                size: 20,
                                                color: Colors.red,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                              onPressed: () {
                                                controller.validerDemande(demande.id, index);
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.check,
                                                size: 20,
                                                color: Colors.green,
                                              ),
                                            ),
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
