import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/passager_course_page/controllers/passager_controller.dart';

class MyCoursePage extends GetWidget<MyCourseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes Courses'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.myCourses.length,
          itemBuilder: (context, index) {
            var course = controller.myCourses[index];
            return GestureDetector(
              onTap: () {
                // Démarrer la course lorsque la carte est cliquée
                controller.startCourse(course);
              },
              child: Card(
                child: ListTile(
                  title: Text('Course #${course.id}'),
                  subtitle: Text('Destination: ${course.destination}'),
                  trailing: course.started
                      ? IconButton(
                          icon: Icon(Icons.check),
                          onPressed: () {
                            // Terminer la course
                            controller.finishCourse(course);
                          },
                        )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
