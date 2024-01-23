import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:otrip/api/marchands/models/marchand_model.dart';
import 'package:otrip/constants.dart';

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
          throw Exception(
              'Invalid response format. Missing or incorrect list key.');
        }
      } else {
        throw Exception(
            'Failed to load marchands. Status code: ${response.statusCode}');
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

  Future<bool> makeParrainage(String marchandId, String driverId) async {
    Map<String, dynamic> body = {
      'marchand_id': marchandId,
      'conducteur_id': driverId,
    };
    try {
      final response = await http.post(
        Uri.parse(parrainageUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );
      print('Le body: ${body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final res = jsonDecode(response.body);
        print('Parrainage effectué');
        returnSuccess(res['message']);
        return true;
      } else {
        final res = jsonDecode(response.body);
        print('Le code status est ${response.statusCode}');
        returnError(res['message']);
        throw Exception(
            'Erreur lors de la demande de parrainage: ${response.statusCode}');
      }
    } catch (error) {
      returnError("Vérifiez votre connexion");
      throw Exception(
          'Erreur lors de la communication vers le serveur ${error}');
    }
  }

  Future<Map<String, dynamic>> getUserInfoByPhone(String phoneNumber) async {
    try {
      final response =
          await http.get(Uri.parse('$userInfoByPhoneUrl/$phoneNumber'));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data') &&
            responseData['data'] is Map<String, dynamic> &&
            responseData['data'].containsKey('user') &&
            responseData['data']['user'] is List<dynamic> &&
            responseData['data']['user'].isNotEmpty) {
          Map<String, dynamic> user = responseData['data']['user'][0];

          // Extraire les valeurs nécessaires
          int userId = user['id'];
          int roleId = user['role_id'];

          // Retourner un Map avec les valeurs extraites
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

            print('Nom: ${conducteurInfo['name']}');
            print('Prénom: ${conducteurInfo['lastname']}');
            print('Numéro de téléphone: ${conducteurInfo['mobile_number']}');
            print('------------------');
          }
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

/* 

Future<List<ConducteurInfo>> getConducteursInfo(List<DemandeParrainage> demandes) async {
  List<ConducteurInfo> conducteursInfo = [];

  for (var demande in demandes) {
    try {
      Map<String, dynamic> conducteurInfo = await getUserInfoById(demande.conducteurId.toString());

      if (conducteurInfo.containsKey('name') && conducteurInfo.containsKey('lastname') && conducteurInfo.containsKey('mobile_number')) {
        conducteursInfo.add(ConducteurInfo(
          name: conducteurInfo['name'],
          lastname: conducteurInfo['lastname'],
          mobileNumber: conducteurInfo['mobile_number'],
        ));
      } else {
        print('Incomplete conducteur info: $conducteurInfo');
      }
    } catch (error) {
      print('Error fetching conducteur info: $error');
    }
  }

  return conducteursInfo;
}

 */

  Future<Map<String, String>> getUserInfoById(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.7:5000/api/users/$userId'),
      );
      print("Pour la récupération des infos: ${response.body}");
      print("Pour la récupération des infos: ${response.statusCode}");

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        // Assurez-vous que les clés existent dans la structure des données
        if (responseData.containsKey('data') &&
            responseData['data'].containsKey('user')) {
          final Map<String, dynamic> userData = responseData['data']['user'];

          // Vérifiez si les clés nécessaires existent
          if (userData.containsKey('name') &&
              userData.containsKey('lastname') &&
              userData.containsKey('mobile_number')) {
            // Extrayez les informations nécessaires
            final String nom = userData['name'];
            final String prenom = userData['lastname'];
            final String numeroTelephone = userData['mobile_number'];

            // Retournez les informations dans une map
            return {
              'nom': nom,
              'prenom': prenom,
              'numeroTelephone': numeroTelephone,
            };
          }
        }
      }

      // Gérez le cas où les données ne sont pas dans le format attendu
      throw Exception('Invalid response format. Missing or incorrect keys.');
    } catch (error) {
      print('Error fetching user info: $error');
      throw Exception('Error fetching user info: $error');
    }
  }

/* 
Future<UserInfo> getUserInfoById(String userId) async {
  try {
    final response = await http.get(Uri.parse('http://192.168.1.7:5000/api/users/$userId'));

    if (response.statusCode == 200) {
      final dynamic userData = json.decode(response.body);
      return UserInfo.fromJson(userData);
    } else {
      throw Exception('Failed to load user info. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching user info: $error');
    throw Exception('Error fetching user info: $error');
  }
} */

  Future<Map<String, dynamic>> getConducteurInfoById(
      String conducteurId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/user/$conducteurId'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Erreur lors de la récupération des informations du conducteur: ${response.statusCode}');
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

          List<Driver> conducteursFiltres = conducteurs.where((conducteur) {
            return conducteurIds.contains(conducteur.id);
          }).toList();

          return conducteursFiltres;
        } else {
          throw Exception(
              'Invalid response format. Missing or incorrect keys.');
        }
      } else {
        throw Exception(
            'Failed to load conducteurs. Status code: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching conducteurs: $error');
    }
  }
}
