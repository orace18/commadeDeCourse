import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/courses_page/models/course_model.dart';
import 'package:http/http.dart' as http;

class DoCourseController extends GetxController {
  // Liste des courses
  List<Course> coursesList = <Course>[].obs;

  @override
  void onInit() {
    // Vous pouvez initialiser la liste des cours ici
    fetchCourses();
    super.onInit();
  }

  Future<List<Course>> fetchCourses() async {
    final id = GetStorage().read('id');
    try {
      final response = await http.get(Uri.parse('$driverCourse/$id'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        List<dynamic> courseData = res['damandes'];

        for (var courses in courseData) {
          if (courses['statuts'] == 'accepte') {
            Course course = Course(
                id: courses['id'],
                etat: courses['etat'],
                placeArrivee: '',
                heureDepart: "heureDepart",
                placeDepart: "placeDepart",
                heureFin: "heureFin",
                auteurFName: courses['passager']['name'],
                auteurLName: courses['passager']['lastname']);
            coursesList.clear();
            coursesList.add(course);
          }
        }
        returnSuccess(res['message']);
        return coursesList;
      } else {
        final res = jsonDecode(response.body);
        returnError(res['message']);
        return [];
      }
    } catch (error) {
      throw Exception('Error durring load Course');
    }
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
    coursesList.remove(course);
    update();
  }
}
