import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:otrip/api/conduteur/controllers/driver_list_controller.dart';
import 'package:otrip/api/conduteur/models/driver_list.dart';
import 'package:otrip/pages/parrainage_demange_page/controllers/parrainage_demande_controller.dart';
import 'package:otrip/pages/parrainage_demange_page/models/parrainage_demande.dart';

class ListConducteurController extends GetxController {
  var drivers = <Driver>[].obs;
  final DriverService _driverService = DriverService();
  DemandeController demandeController = DemandeController();
  @override
  void onInit() {
    super.onInit();
    fetchDrivers();
  }

  void fetchDrivers() async {
    try {
      List<Driver> fetchedDrivers = await _driverService.getAllDrivers();
      drivers.assignAll(fetchedDrivers);
    } catch (e) {
      print('Erreur lors de la récupération des conducteurs: $e');
    }
  }
    //52366788 

  Future<void> getMarchandDrivers() async{
    try{
      Map<String, dynamic> userData = await demandeController.getUserData();
      String marchandId = userData['id'];

    }catch(error){

    }
  }
}

/* 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/pages/parrainage_demange_page/models/parrainage_demande.dart';

class DemandeController extends GetxController {
  List<DemandeParrainage> listDemandes = [];
  final userData = GetStorage();
  final String resultMessage = '';

  Map<String, dynamic> getUserData() {
    return {
      'phoneNumber': userData.read('phone_number') ?? '',
    };
  }

  List<DemandeParrainage> getDemandesByStatus(String status) {
    return listDemandes.where((demande) => demande.status == status).toList();
  }

  Future<void> fetchAndDisplayDemandesParrainage(String marchandId, String status) async {
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

          // Filtrer les demandes en fonction du statut
          List<DemandeParrainage> demandesFiltrees = getDemandesByStatus(status);

          resultMessage.value = ''; // Réinitialise le message d'erreur
          listDemandes.assignAll(demandesFiltrees); // Met à jour la liste des demandes
          update(); // Notifie les observateurs
        } else {
          throw Exception(
              'Format invalid. Absence de clé ou clé incorrecte dans la demandes.');
        }
      }
    } catch (error) {
      print('Erreur lors de la récupération des demandes de parrainage: $error');
      resultMessage.value = 'Erreur lors de la récupération des demandes.';
      update(); // Notifie les observateurs
    }
  }

  Future<Map<String, dynamic>> getUserInfoByPhone() async {
    try {
      Map<String, dynamic> userData = getUserData();
      String phoneNumber = userData['phoneNumber'];

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


controller.fetchAndDisplayDemandesParrainage(marchandId, 'accepté');

 */