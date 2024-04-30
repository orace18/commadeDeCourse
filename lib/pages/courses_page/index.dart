// Importations nécessaires
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/add_user_page/widgets/clipper.dart';
import 'package:otrip/pages/courses_page/controllers/do_course_controller.dart';
import 'package:otrip/pages/courses_page/models/course_model.dart';
import 'package:otrip/providers/theme/theme.dart';

class DoCoursePage extends GetWidget<DoCourseController> {
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
              icon: Icon(Icons.arrow_back,
                  color: const Color.fromARGB(255, 187, 106, 106)),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<DoCourseController>(
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
                    child: GetBuilder<DoCourseController>(
                      builder: (_) {
                        return FutureBuilder<List<Course>>(
                          future: controller.fetchCourses(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(color: Colors.deepOrange));
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Erreur: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('Aucune course trouvée.'));
                            } else {
                              List<Course> demandeList = snapshot.data!;
                              return ListView.builder(
                                itemCount: demandeList.length,
                                itemBuilder: (context, index) {
                                  Course course = demandeList[index];
                                  String name =
                                      '${course.auteurFName} ${course.auteurLName}';
                                  String etat = course.etat;
                                  String depart = course.placeDepart;
                                  String arrivee = course.placeArrivee;
                                  return Card(
                                    margin: EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  etat,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Lieu de départ: $depart - Lieu d'arrivée: $arrivee",
                                                  style: TextStyle(
                                                    color: Colors.black,
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