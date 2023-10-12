import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../providers/theme/theme.dart';
import 'controllers/profile_controller.dart';

class ProfilePage extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileController>(
          builder: (_) => Stack(
            children: [
              Container(
                height: Get.height,
              ),
              Container(
                height: Get.height/4,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.vertical(
                      bottom: new Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0)),
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.otripMaterial.shade600,
                      AppTheme.otripMaterial.shade50,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(4)
                  ),
                )
              )
            ],
          )
        ));
  }
}
