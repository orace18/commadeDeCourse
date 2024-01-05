import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';

class ListConducteurController extends GetxController {
  List<Driver> driversList = [];
  final userData = GetStorage();

  Map<String, dynamic> getUserData() {
    return {
      'phoneNumber': userData.read('phone_number') ?? '',
    };
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

  Future<List<Driver>> fetchMarchandDrivers() async {
    try {
      Map<String, dynamic> userData = await getUserInfoByPhone();
      int id = userData['id'];
      print('L\'id du marchand est: $id');

      final response = await http.get(
        Uri.parse('$demandeParrainageUrl/$id'),
      );
      driversList.clear();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('demandes') &&
            responseData['demandes'] is List<dynamic>) {
          List<dynamic> demandesData = responseData['demandes'];

          // Filtrer les demandes avec le statut "en_attente"
          demandesData
              .where((demandeData) => demandeData['status'] == 'accepte')
              .forEach((demandeData) {
            final conducteurInfo = demandeData['conducteur'];
            final conducteurNom = conducteurInfo['name'];
            final conducteurPrenom = conducteurInfo['lastname'];
            final idDemande = demandeData['id'];
            final position = conducteurInfo['positions'];
            final phone = conducteurInfo['mobile_number'];
            driversList.clear();
            driversList.add(Driver(
              id: idDemande,
              lastname: conducteurNom,
              firstname: conducteurPrenom,
              phoneNumber: phone,
              localisation: position,
            ));
          });

          return driversList;
        } else {
          throw Exception(
              'Format invalide. Absence de clé ou clé incorrecte dans la demandes.');
        }
      }
      return driversList;
    } catch (error) {
      print(
          'Erreur lors de la récupération des demandes de parrainage: $error');
      return [];
    }
  }
}
