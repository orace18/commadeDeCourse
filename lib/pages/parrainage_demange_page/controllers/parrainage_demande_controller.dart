import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/pages/parrainage_demange_page/models/demande_model.dart';

class DemandeController extends GetxController {
  List<Demande> demandesList = [];
  final userData = GetStorage();
  final RxString resultMessage = RxString('');
  final RxString successMessage = RxString('');

  Map<String, dynamic> getUserData() {
    return {
      'phoneNumber': userData.read('phone_number') ?? '',
    };
  }

  Future<List<Demande>> fetchAndDisplayDemandesEnAttente() async {
    try {
      Map<String, dynamic> userData = await getUserInfoByPhone();
      int id = userData['id'];
      print('L\'id du marchand est: $id');

      final response = await http.get(
        Uri.parse('$demandeParrainageUrl/$id'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('demandes') &&
            responseData['demandes'] is List<dynamic>) {
          List<dynamic> demandesData = responseData['demandes'];

          // Filtrer les demandes avec le statut "en_attente"
          demandesData
              .where((demandeData) => demandeData['status'] == 'en_attente')
              .forEach((demandeData) {
            final conducteurInfo = demandeData['conducteur'];
            final conducteurNom = conducteurInfo['name'];
            final conducteurPrenom = conducteurInfo['lastname'];
            final idDemande = demandeData['id'];
            demandesList.clear();
            demandesList.add(Demande(
              id: idDemande,
              dateDemande: demandeData['created_at'],
              status: demandeData['status'],
              driver: conducteurNom + ' ' + conducteurPrenom,
            ));
          });

          return demandesList;
        } else {
          throw Exception(
              'Format invalide. Absence de clé ou clé incorrecte dans la demandes.');
        }
      }
      return demandesList;
    } catch (error) {
      print(
          'Erreur lors de la récupération des demandes de parrainage: $error');
      return [];
    }
  }

  Future<Map<String, dynamic>> getUserInfoByPhone() async {
    try {
      Map<String, dynamic> userData = getUserData();
      String phoneNumber = userData['phoneNumber'];
      print('Le numero de telephone est : $phoneNumber');

      final response =
          await http.get(Uri.parse('$userInfoByPhoneUrl/$phoneNumber'));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data') &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data'].containsKey('users') &&
            responseData['data']['users'] is List<dynamic> &&
            responseData['data']['users'].isNotEmpty) {
          Map<String, dynamic> user = responseData['data']['users'][0];

          // Extraction des valeurs nécessaires
          int userId = user['id'];
          int roleId = user['role_id'];
          print('L\' de mon gar est $userId');
          // Retour d'un Map avec les valeurs extraites
          return {'id': userId, 'role_id': roleId};
        } else {
          throw Exception('Invalid response format for user info.');
        }
      } else {
        throw Exception(
            'Failed to load user info. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching user info: $error');
      throw Exception('Error fetching user info: $error');
    }
  }

  // Méthode pour annuler une demande spécifique
  Future<void> annulerDemande(int id, int index) async {
    try {
      final response = await http.post(
        Uri.parse('$parrainage/$id/refuser'),
        // Vous pouvez ajouter des paramètres, des en-têtes, etc., si nécessaire
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        successMessage.value = 'Request successfully validated';
        // Retirer la demande de la liste
        demandesList.removeAt(index);
        update();
      } else {
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
        Uri.parse('$parrainage/$id/accepter'),
        // Vous pouvez ajouter des paramètres, des en-têtes, etc., si nécessaire
      );
      print('Le code statut de la demande accepté: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        successMessage.value = 'Request successfully validated';
        // Retirer la demande de la liste
        demandesList.removeAt(index);
        update();
      } else {
        throw Exception(
            'Failed to validate request. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error validating request: $error');
      throw Exception('Error validating request: $error');
    }
  }
}
