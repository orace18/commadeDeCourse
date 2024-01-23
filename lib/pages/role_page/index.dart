import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/role_page/models/role_model.dart';
import 'controllers/role_controller.dart';

class RolePage extends GetWidget<RoleController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choisissez votre rôle"),
      ),
      body: GetBuilder<RoleController>(
        builder: (_) => Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              RoleCard(
                roleName: "Passager",
                onPressed: () async{
                      bool isValid = await controller
                      .updateRole(controller.passagerRole.toString());
                  if (isValid == true)
                  Get.toNamed('/passager');
                },
              ),
              RoleCard(
                roleName: "Marchand",
                onPressed: () async {
                  bool isValid = await controller
                      .updateRole(controller.marchandRole.toString());
                  if (isValid == true) {
                    Get.toNamed('/marchand');
                  }
                },
              ),
              RoleCard(
                roleName: "Conducteur",
                onPressed: () async {
                  bool isValid = await controller
                      .updateRole(controller.driverRole.toString());
                  if (isValid == true) Get.toNamed('/driver');
                },
              ),
              RoleCard(
                roleName: "Société",
                onPressed: () async {
                  bool isValid = await controller
                      .updateRole(controller.societeRole.toString());
                  if (isValid == true) Get.toNamed('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
