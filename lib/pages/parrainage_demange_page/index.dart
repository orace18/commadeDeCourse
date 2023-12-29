import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/pages/parrainage_demange_page/controllers/parrainage_demande_controller.dart';
import 'package:otrip/pages/parrainage_demange_page/models/demande_model.dart';
import 'package:otrip/providers/theme/theme.dart';

class DemandePage extends StatelessWidget {
  final DemandeController controller = Get.find<DemandeController>();
  final userData = GetStorage();

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
                controller.fetchAndDisplayDemandesParrainage();
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<DemandeController>(
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
                                  SizedBox(height: 10),
                                  Obx(() {
                                    // Afficher le message d'erreur s'il y en a un
                                    if (controller.resultMessage.isNotEmpty) {
                                      return Text(
                                        controller.resultMessage.value,
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                        ),
                                      );
                                    }
                                    return SizedBox.shrink();
                                  }),
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
                    child: GetBuilder<DemandeController>(
                      builder: (_) => ListView.builder(
                        itemCount: controller.listDemandes.length,
                        itemBuilder: (context, index) {
                          Demande demande =
                              controller.listDemandes[index];
                          return Card(
                            margin: EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${demande.dateDemande}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          '${demande.status} ${demande.driver}',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        // Ajoutez ici tout autre élément que vous souhaitez afficher
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.annulerDemande(index);
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
                                            controller.validerDemande(index);
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
