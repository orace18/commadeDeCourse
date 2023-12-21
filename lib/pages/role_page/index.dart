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
                onPressed: () {
                  // Ajoutez ici le code pour gérer le choix du rôle passager
                },
              ),
              RoleCard(
                roleName: "Marchand",
                onPressed: () {
                  // Ajoutez ici le code pour gérer le choix du rôle marchand
                },
              ),
              RoleCard(
                roleName: "Conducteur",
                onPressed: () {
                  // Ajoutez ici le code pour gérer le choix du rôle conducteur
                },
              ),
              RoleCard(
                roleName: "Société",
                onPressed: () {
                  // Ajoutez ici le code pour gérer le choix du rôle société
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

