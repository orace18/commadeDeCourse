import 'package:get/get.dart';
import '../models/course_models.dart';

class MyCourseController extends GetxController {
  // Une liste de toutes les courses de l'utilisateur
  var myCourses = <Course>[].obs;

  // Méthode pour démarrer une course
  void startCourse(Course course) {
    // Marquer la course comme ayant commencé
    course.started = true;
    // Mettre à jour l'état de la liste
    myCourses.refresh();
  }

  // Méthode pour terminer une course
  void finishCourse(Course course) {
    // Marquer la course comme terminée
    course.finished = true;
    // Mettre à jour l'état de la liste
    myCourses.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    // Simulons l'obtention des cours de l'utilisateur à partir d'une source de données
    // Ici, nous ajoutons simplement quelques cours factices pour la démonstration
    myCourses.assignAll([
      Course(id: 1, departure: 'Départ 1', destination: 'Destination 1'),
      Course(id: 2, departure: 'Départ 2', destination: 'Destination 2'),
      Course(id: 3, departure: 'Départ 3', destination: 'Destination 3'),
    ]);
  }
}
