import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:otrip/api/marchands/models/marchand_model.dart';
import 'package:otrip/pages/parrainage_demange_page/models/parrainage_demande.dart';

class MarchandService {

  final userData = GetStorage();

  Future<List<Marchand>> getAllMarchand() async {
    try {
      final response = await http.get(Uri.parse(marchandUrl));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data') &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data'].containsKey('users')) {

          List<Marchand> marchands = (responseData['data']['users'] as List)
              .map<Marchand>((json) => Marchand.fromJson(json))
              .where((marchand) =>
                  marchand.id != null &&
                  marchand.firstname != null &&
                  marchand.lastname != null &&
                  marchand.phoneNumber != null)
              .toList();

          print('Fetched marchands: $marchands');

          return marchands;
        } else {
          throw Exception('Invalid response format. Missing or incorrect list key.');
        }
      } else {
        throw Exception('Failed to load marchands. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching marchands: $error');
      throw Exception('Error fetching marchands: $error');
    }
  }

  Map<String, dynamic> getUserData() {
    return {
      'firstname': userData.read('firstname') ?? '',
      'lastname': userData.read('lastname') ?? '',
      'username': userData.read('username') ?? '',
      'phoneNumber': userData.read('phone_number') ?? '',
    };
  }

Future<void> makeParrainage(String marchandId, String driverId) async {
    Map<String, dynamic> body = {
          'marchand_id': marchandId, 
          'conducteur_id': driverId, 
        };
      try {
        final response = await http.post(Uri.parse(parrainageUrl),
          headers: {'Content-Type': 'application/json'},
          body:  jsonEncode(body),
        );
        print('Le body: ${body}');
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Parrainage effectué');
        } else {
          print('Le code status est ${response.statusCode}');
          throw Exception('Erreur lors de la demande de parrainage: ${response.statusCode}');
        }
      } catch (error) {
        throw Exception('Erreur lors de la communication vers le serveur ${error}');
      }
}


  Future<Map<String, dynamic>> getUserInfoByPhone(String phoneNumber) async {
  try {
    final response = await http.get(Uri.parse('$userInfoByPhoneUrl$phoneNumber'));

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data') &&
          responseData['data'] is Map<String, dynamic> &&
          responseData['data'].containsKey('users') &&
          responseData['data']['users'] is List<dynamic> &&
          responseData['data']['users'].isNotEmpty) {

        Map<String, dynamic> user = responseData['data']['users'][0];

        // Extraire les valeurs nécessaires
        int userId = user['id'];
        int roleId = user['role_id'];

        // Retourner un Map avec les valeurs extraites
        return {'id': userId, 'role_id': roleId};
      } else {
        throw Exception('Invalid response format for user info.');
      }
    } else {
      throw Exception('Failed to load user info. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching user info: $error');
    throw Exception('Error fetching user info: $error');
  }
}

  Future<List<DemandeParrainage>> getDemandesParrainage(String marchandId) async {
    try {
      final response = await http.get(
        Uri.parse('$parrainageUrl$marchandId'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data') &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data'].containsKey('demandes')) {

          List<DemandeParrainage> demandes = (responseData['data']['demandes'] as List)
              .map<DemandeParrainage>((json) => DemandeParrainage.fromJson(json))
              .toList();

          print('Fetched demandes de parrainage: $demandes');

          return demandes;
        } else {
          throw Exception('Invalid response format. Missing or incorrect list key.');
        }
      } else {
        throw Exception('Failed to load demandes de parrainage. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching demandes de parrainage: $error');
      throw Exception('Error fetching demandes de parrainage: $error');
    }
  }

  Future<Map<String, dynamic>> getConducteurInfoById(String conducteurId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user/$conducteurId'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Erreur lors de la récupération des informations du conducteur: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la communication avec le serveur');
    }
  }

  Future<List<Driver>> getConducteurs(List<int> conducteurIds) async {
  try {
    final response = await http.get(Uri.parse(driverUrl));
    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('data') &&
          responseData['data'] is List<dynamic>) {

        List<dynamic> conducteursData = responseData['data'];
        
        List<Driver> conducteurs = conducteursData.map<Driver>((json) {
          return Driver.fromJson({
            'id': json['id'],
            'username': json['username'],
            'name': json['name'],
            'lastname': json['lastname'],
          });
        }).toList();

        // Filtrer les conducteurs en fonction des IDs fournis
        List<Driver> conducteursFiltres = conducteurs.where((conducteur) {
          return conducteurIds.contains(conducteur.id);
        }).toList();

        return conducteursFiltres;
      } else {
        throw Exception('Invalid response format. Missing or incorrect keys.');
      }
    } else {
      throw Exception('Failed to load conducteurs. Status code: ${response.statusCode}');
    }
  } catch (error) {
    throw Exception('Error fetching conducteurs: $error');
  }
}


}