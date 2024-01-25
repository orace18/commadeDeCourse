import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/courses_page/controllers/do_course_controller.dart';
import 'package:otrip/pages/courses_page/models/course_model.dart';

class DoCoursePage extends StatelessWidget {
  final DoCourseController doCourseController = Get.put(DoCourseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Courses'),
      ),
      body: GetBuilder<DoCourseController>(
        builder: (_) => ListView.builder(
          itemCount: _.courses.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Course ${index + 1}'),
              subtitle: Text('État: ${_.courses[index].etat}'),
              onTap: () {
                showCourseDialog(context, _.courses[index]);
              },
            );
          },
        ),
      ),
    );
  }

  void showCourseDialog(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Course ${course.id}'),
          content: Text('État: ${course.etat}'),
          actions: [
            if (course.etat == 'En attente')
              ElevatedButton(
                onPressed: () {
                  // Démarrer la course
                  doCourseController.startCourse(course);
                  Navigator.of(context).pop();
                },
                child: Text('Démarrer'),
              ),
            if (course.etat == 'Démarré')
              ElevatedButton(
                onPressed: () {
                  // Mettre en pause la course
                  doCourseController.pauseOrResumeCourse(course);
                  Navigator.of(context).pop();
                },
                child: Text('Mettre en pause'),
              ),
            if (course.etat == 'Démarré')
              ElevatedButton(
                onPressed: () {
                  // Finir la course
                  doCourseController.finishCourse(course);
                  Navigator.of(context).pop();
                },
                child: Text('Finir'),
              ),
            ElevatedButton(
              onPressed: () {
                // Annuler la course
                doCourseController.cancelCourse(course);
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }
}
