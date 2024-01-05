import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/course_page/controllers/course_controller.dart';
import 'package:otrip/pages/course_page/widgets/conducteur_map.dart';
import 'package:otrip/pages/map_page/widgets/map_view.dart';

class CoursePage extends GetWidget<CourseController>{
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Commande de Zem'),
      ),
      
    );
  }
}
