import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/pages/liste_page/passager_liste_page/models/passager_demande_model.dart';
import 'package:otrip/pages/passager_demande_page/models/passager_demande.dart';
import 'package:http/http.dart' as http;

class PassagerDemandeController extends GetxController {
  List<PassagerDemande> listDemandes = [];
  List<DemandeInfo> demandes = [];

  final userData = GetStorage();

  Future<List<DemandeInfo>> fetchDemandesEnAttente() async {
    final id = GetStorage().read('id');
    final response = await http.get(
      Uri.parse('$driverCourse/$id'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<dynamic> demandesData = data['demandes'];

      for (var demandeData in demandesData) {
        if (demandeData['status'] == 'en_attente') {
          DemandeInfo demande = DemandeInfo(
            id: demandeData['id'],
            nom: demandeData['passager']['name'],
            prenom: demandeData['passager']['lastname'],
            telephone: demandeData['passager']['mobile_number'],
            depart: demandeData['depart'],
            arrivee: demandeData['arrivee'],
            heure: demandeData['created_at'],
          );
          demandes.clear();
          demandes.add(demande);
        }
      }
      return demandes;
    } else {
      throw Exception('Erreur lors de la récupération des demandes');
    }
  }

  Map<String, dynamic> getUserData() {
    return {
      'phoneNumber': userData.read('phone_number') ?? '',
    };
  }

  Future<void> annulerDemande(int id, int index) async {
    try {
      final response = await http.post(
        Uri.parse('$makeCourseUrl/$id/refuser'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        demandes.removeAt(index);
        update();
      } else {
         final res = jsonDecode(response.body);
        returnError(res['message']);
        throw Exception(
            'Failed to validate request. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error validating request: $error');
      throw Exception('Error validating request: $error');
    }
  }

  // Méthode pour valider une demande spécifique
  Future<void> validerDemande(int id, int index) async {
    try {
      final response = await http.post(
        Uri.parse('$makeCourseUrl/$id/accepter'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        returnSuccess(res['message']);
        demandes.removeAt(index);
        update();
      } else {
        final res = jsonDecode(response.body);
        returnError(res['message']);
        throw Exception(
            'Failed to validate request. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error validating request: $error');
      throw Exception('Error validating request: $error');
    }
  }
}