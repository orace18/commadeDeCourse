import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/pages/parrainage_demange_page/controllers/parrainage_demande_controller.dart';
import 'package:otrip/pages/parrainage_demange_page/models/parrainage_demande.dart';
import '../../../../constants.dart';
import '../../../../providers/theme/theme.dart';


class DemandePage extends GetWidget<DemandeController> {
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
            )),
        body: GetBuilder<DemandeController>(
          builder: (_) => SafeArea(
            top: false,
            child: Stack(
              children: [
                Column(children: [
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
                                        fontWeight: FontWeight.bold),
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
                    child: GetBuilder<DemandeController>(
                      builder: (_) => ListView.builder(
                        itemCount: controller.listDemandes.length,
                        itemBuilder: (context, index) {
                          DemandeParrainage demande = controller.listDemandes[index];
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
                                       // Text('${demande.message}'),
                                        SizedBox(height: 10),
                                        Text(
                                            '${demande.dateDemande.toString()}'),
                                        SizedBox(height: 10),
                                        Text(
                                           ''),
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
                                          )
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
                                          )
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
                ]),
              ],
            ),
          ),
        ));
  }
}
