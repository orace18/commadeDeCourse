import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/models/passager_demande_model.dart';

class PassagerListController extends GetxController {
  
  Future<List<DemandeInfo>> fetchDemandes() async {
    final id = GetStorage().read('id');
    final response = await http.get(
      Uri.parse('$driverCourse/$id'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<dynamic> demandesData = data['demandes'];
      List<DemandeInfo> demandes = [];

      for (var demandeData in demandesData) {
        if (demandeData['status'] == 'accepte') {
          DemandeInfo demande = DemandeInfo(
            id: demandeData['id'],
            nom: demandeData['passager']['name'],
            prenom: demandeData['passager']['lastname'],
            telephone: demandeData['passager']['mobile_number'],
            depart: demandeData['depart'],
            arrivee: demandeData['arrivee'],
            heure: demandeData['created_at'],
            passagerId: demandeData['idPassager'],
          );

          demandes.add(demande);
        }
      }
      return demandes;
    } else {
      throw Exception('Erreur lors de la récupération des demandes');
    }
  }
}
