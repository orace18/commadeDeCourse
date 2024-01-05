import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/pages/passager_demande_page/models/passager_demande.dart';
import 'package:http/http.dart' as http;

class PassagerDemandeController extends GetxController {
  List<PassagerDemande> listDemandes = [];
  final userData = GetStorage();
  Future<void> fetchAndDisplayDemandesParrainage(String marchandId) async {
    try {
      final response = await http.get(
        Uri.parse('$demandeParrainageUrl/$marchandId'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('demandes') &&
            responseData['demandes'] is List<dynamic>) {
          List<dynamic> demandesData = responseData['demandes'];

          for (dynamic demandeData in demandesData) {
            final conducteurInfo = demandeData['conducteur'];
            final passagerDemande = PassagerDemande(
              status: demandeData['status'],
              dateDemande: demandeData['created_at'],
              nom: conducteurInfo['name'],
              prenom: conducteurInfo['lastname'],
            );

            listDemandes.add(passagerDemande);
          }

          // Mettez à jour l'état pour déclencher le rebuild du widget associé
          update();
        } else {
          throw Exception(
              'Invalid response format. Missing or incorrect demandes key.');
        }
      } else {
        throw Exception(
            'Failed to load demandes de parrainage. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching demandes de parrainage: $error');
    }
  }

  Map<String, dynamic> getUserData() {
    return {
      'phoneNumber': userData.read('phone_number') ?? '',
    };
  }

  void annulerDemande(int index) {
    // Implémentez la logique pour annuler une demande ici
    // Utilisez listDemandes[index] pour accéder à la demande spécifique
  }

  void validerDemande(int index) {
    // Implémentez la logique pour valider une demande ici
    // Utilisez listDemandes[index] pour accéder à la demande spécifique
  }

  // Ajoutez d'autres méthodes et logique en fonction des besoins
}
