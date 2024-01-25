import 'package:get/get.dart';
import 'package:otrip/pages/courses_page/models/course_model.dart';

class DoCourseController extends GetxController {
  // Liste des courses
  RxList<Course> courses = <Course>[].obs;

  @override
  void onInit() {
    // Vous pouvez initialiser la liste des cours ici
    courses.addAll([
      Course(id: 1, etat: 'En attente'),
      Course(id: 2, etat: 'Démarré'),
      Course(id: 3, etat: 'En attente'),
    ]);
    super.onInit();
  }

  // Méthode pour démarrer la course
  void startCourse(Course course) {
    // Implémentez la logique pour démarrer la course
    print('Démarrer la course ${course.id}');
    // Mettez à jour l'état de la course
    course.etat = 'Démarré';
    update();
  }

  // Méthode pour mettre en pause ou reprendre la course
  void pauseOrResumeCourse(Course course) {
    // Implémentez la logique pour mettre en pause ou reprendre la course
    print('Mettre en pause ou reprendre la course ${course.id}');
    // Mettez à jour l'état de la course
    course.etat = course.etat == 'Démarré' ? 'En pause' : 'Démarré';
    update();
  }

  // Méthode pour finir la course
  void finishCourse(Course course) {
    // Implémentez la logique pour finir la course
    print('Finir la course ${course.id}');
    // Mettez à jour l'état de la course
    course.etat = 'Terminé';
    update();
  }

  // Méthode pour annuler la course
  void cancelCourse(Course course) {
    // Implémentez la logique pour annuler la course
    print('Annuler la course ${course.id}');
    // Retirez la course de la liste
    courses.remove(course);
    update();
  }
}

