import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/assistance_page/models/faq_model.dart';
import 'controllers/assistance_controller.dart';

class AssistancePage extends GetWidget<AssistanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: GetBuilder<AssistanceController>(
        builder: (_) => ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            FaqItem(
              question: "Qu'est-ce que l'assistance?",
              answer: "L'assistance fournit un support aux utilisateurs...",
            ),
            FaqItem(
              question: "Comment puis-je obtenir de l'aide?",
              answer: "Vous pouvez obtenir de l'aide en contactant notre équipe...",
            ),
            // Ajoutez d'autres éléments FAQ ici selon vos besoins
          ],
        ),
      ),
    );
  }
}


