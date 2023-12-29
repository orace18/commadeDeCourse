import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:otrip/pages/course_page/models/conducteur.dart';
import 'package:otrip/pages/parrainage_demange_page/models/demande_model.dart';
import 'package:otrip/pages/parrainage_demange_page/models/parrainage_demande.dart';

class DemandeController extends GetxController {
  List<Demande> listDemandes = [];
  final userData = GetStorage();
  final RxString resultMessage = RxString('');

  Map<String, dynamic> getUserData() {
    return {
      'phoneNumber': userData.read('phone_number') ?? '',
    };
  }

 /*  Future<void> fetchAndDisplayDemandesParrainage() async {
    try {
      Map<String, dynamic> userData = await getUserInfoByPhone();
      String marchandid = userData['id'];

      final response = await http.get(
        Uri.parse('$demandeParrainageUrl/$marchandid'),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('demandes') &&
            responseData['demandes'] is List<dynamic>) {
          List<dynamic> demandesData = responseData['demandes'];

          listDemandes.clear(); 

          for (dynamic demandeData in demandesData) {
            final conducteurInfo = demandeData['conducteur'];
            final demandeParrainage = DemandeParrainage(
              status: demandeData['status'],
              dateDemande: demandeData['created_at'],
              conducteurNom: conducteurInfo['name'],
              conducteurPrenom: conducteurInfo['lastname'],
              conducteurPhone: conducteurInfo['mobile_number']
            );

            listDemandes.add(demandeParrainage);
          }

          
          update();
        } else {
          throw Exception(
              'Format invalid. Absence de clé ou clé incorrecte dans la demandes.');
        }
      }
    }catch(error) {
      print('Erreur lors de la récupération des demandes de parrainage: $error');
    }
  }
 */
/* 
Future<void> fetchAndDisplayDemandesParrainage() async {
  try {
    Map<String, dynamic> userData = await getUserInfoByPhone();
    String id = userData['id'];

    final response = await http.get(
      Uri.parse('$demandeParrainageUrl/$id'),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseData = json.decode(response.body);

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('demandes') &&
          responseData['demandes'] is List<dynamic>) {
        List<dynamic> demandesData = responseData['demandes'];

        listDemandes.clear();

        for (dynamic demandeData in demandesData) {
          final conducteurInfo = demandeData['conducteur'];
          final demandeParrainage = DemandeParrainage(
            status: demandeData['status'],
            dateDemande: demandeData['created_at'],
            conducteurNom: conducteurInfo['name'],
            conducteurPrenom: conducteurInfo['lastname'],
            conducteurPhone: conducteurInfo['mobile_number']
          );

          listDemandes.add(demandeParrainage);
        }

        update();
      } else {
        throw Exception(
            'Format invalid. Absence de clé ou clé incorrecte dans la demandes.');
      }
    }
  } catch (error) {
    print('Erreur lors de la récupération des demandes de parrainage: $error');
    // Gérer l'erreur selon vos besoins, par exemple, afficher un message à l'utilisateur.
    // Vous pouvez également utiliser Get.snackbar pour afficher une notification à l'utilisateur.
  }
} */


/* Future<void> fetchAndDisplayDemandesParrainage() async {
  try {
    Map<String, dynamic> userData = await getUserInfoByPhone();
    int id = userData['id'];
    print('L\ id du marchand est: $id');

    final response = await http.get(
      Uri.parse('http://192.168.1.7:5000/api/users/$id'),
    );
        print('La list des demande${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseData = json.decode(response.body);
      print('Données de la réponse : $responseData');
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('demandes') &&
          responseData['demandes'] is Map<String,dynamic>) {
       // Map<String,dynamic> demandesData = responseData['demandes'];

        listDemandes.clear();
        print("=====================");
        print("=====================");
        print('La liste de la demande ${responseData['demandes']}');
        /* for (dynamic demandeData in demandesData) {
          final conducteurInfo = demandeData['conducteur'];
          final demandeParrainage = DemandeParrainage(
            status: demandeData['status'],
            dateDemande: demandeData['created_at'],
            conducteurNom: conducteurInfo['name'],
            conducteurPrenom: conducteurInfo['lastname'],
            conducteurPhone: conducteurInfo['mobile_number']
          );

          listDemandes.add(demandeParrainage);
        } */

      print('La liste des demande  $listDemandes');
        resultMessage.value = '.....'; // Réinitialise le message d'erreur
        update(); // Notifie les observateurs
      } else {
        throw Exception(
            'Format invalid. Absence de clé ou clé incorrecte dans la demandes.');
      }
    }
  } catch (error) {
    print('Erreur lors de la récupération des demandes de parrainage: $error');
    resultMessage.value = 'Erreur lors de la récupération des demandes.';
    update();
  }
}
 */

Future<void> fetchAndDisplayDemandesParrainage() async {
  try {
    Map<String, dynamic> userData = await getUserInfoByPhone();
    int id = userData['id'];
    print('L\'id du marchand est: $id');

    final response = await http.get(
      Uri.parse('http://192.168.1.7:5000/api/users/$id'),
    );

    print('La liste des demandes ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic responseData = json.decode(response.body);
      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('demandes') &&
          responseData['demandes'] is List<dynamic>) {
        List<dynamic> demandesData = responseData['demandes'];

        listDemandes.clear();

        for (dynamic demandeData in demandesData) {
          final conducteurInfo = demandeData['conducteur'];
          final conducteur = Driver(
            id: conducteurInfo['id'],
            firstname: conducteurInfo['name'],
            lastname: conducteurInfo['lastname'],
            phoneNumber: conducteurInfo['mobile_number'],
            // Ajoutez les autres champs selon vos besoins
            localisation: {'':''}
          );

          final demandeParrainage = Demande(
            status: demandeData['status'],
            dateDemande: demandeData['created_at'],
            driver: conducteur,
          );

          listDemandes.add(demandeParrainage);
        }

        print('La liste des demandes $listDemandes');
        resultMessage.value = '.....'; // Réinitialise le message d'erreur
        update(); // Notifie les observateurs
      } else {
        throw Exception(
            'Format invalide. Absence de clé ou clé incorrecte dans la demandes.');
      }
    }
  } catch (error) {
    print('Erreur lors de la récupération des demandes de parrainage: $error');
    resultMessage.value = 'Erreur lors de la récupération des demandes.';
    update();
  }
}


  Future<Map<String, dynamic>> getUserInfoByPhone() async {
    try {
      Map<String, dynamic> userData = getUserData();
      String phoneNumber = userData['phoneNumber'];
      print('Le numero de telephone est : $phoneNumber');

      final response = await http.get(Uri.parse('http://192.168.1.7:5000/api/user/$phoneNumber'));

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
  void annulerDemande(int index) {
    listDemandes.removeAt(index);
    update();
  }

  // Méthode pour valider une demande spécifique
  void validerDemande(int index) {
    update();
  }
}