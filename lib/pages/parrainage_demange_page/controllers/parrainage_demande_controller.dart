import 'dart:convert';
import 'package:get/get.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/pages/parrainage_demange_page/models/parrainage_demande.dart';
import 'package:http/http.dart' as http;

class DemandeController extends GetxController {

  // Getter pour obtenir la liste des demandes
  List<DemandeParrainage> get listDemandes => listDemandes;

  // Méthode pour ajouter une nouvelle demande
  // void ajouterDemande(String nom, String prenom) {
  //   DateTime now = DateTime.now();
  //   Demande nouvelleDemande = Demande(
  //     nom: nom,
  //     prenom: prenom,
  //     dateDemande: now,
  //     message: message,
  //   );
  //   _listDemandes.add(nouvelleDemande);

  //   // Mettre à jour les observateurs
  //   update();
  // }

  // Méthode pour annuler une demande spécifique
  void annulerDemande(int index) {
    listDemandes.removeAt(index);
    update();
  }

  // Méthode pour valider une demande spécifique
  void validerDemande(int index) {
    // Logique de validation de la demande
    // ...
    update();
  }

 


}
