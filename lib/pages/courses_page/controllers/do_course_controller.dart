import 'dart:convert';

import 'package:get/get.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/courses_page/models/course_model.dart';
import 'package:http/http.dart' as http;

class DoCourseController extends GetxController {
  // Liste des courses
  List<Course> courses = <Course>[].obs;

  @override
  void onInit() {
    // Vous pouvez initialiser la liste des cours ici
    getAllCourse();
    super.onInit();
  }

  Future<List<Course>> getAllCourse() async {
    try {
      final response = await http.get(Uri.parse(''));
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        List<dynamic> courseData = res['courses'];
        for(var course in courseData){
          
        }
        returnSuccess(res['message']);
        return courses;
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
    courses.remove(course);
    update();
  }
}
