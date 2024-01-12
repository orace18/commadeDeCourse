import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';

class MotoDriversController extends GetxController {
  final userData = GetStorage();
  final String enginType;
  var isLoading = true.obs;
  RxList<Map<String, dynamic>> driverList = RxList<Map<String, dynamic>>([]);

  MotoDriversController({required this.enginType});

  Map<String, dynamic> getUserData() {
    return {'phone_number': userData.read('phone_number')};
  }

  @override
  void onInit() async {
    fetchUsers();
    super.onInit();
  

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
          double solde = user['balance'];
          Map<String, dynamic> positions = user['positions'];
          print('L\' de mon gar est $userId');
          // Retour d'un Map avec les valeurs extraites
          return {
            'id': userId,
            'role_id': roleId,
            'balance': solde,
            'positions': positions
          };
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

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      List<Map<String, dynamic>> users = await getUsersByEngin(enginType);
      driverList.assignAll(users);
    } catch (error) {
      print('Erreur lors de la récupération des utilisateurs: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<List<Map<String, dynamic>>> getUsersByEngin(String engin) async {
    try {
      final response = await http.get(Uri.parse('$driverByEngin/$engin'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List<dynamic> && responseData.isNotEmpty) {
          List<Map<String, dynamic>> driverList = List<Map<String, dynamic>>.from(responseData);
          return driverList;
        } else {
          throw Exception('Invalid response format for users by engin type.');
        }
      } else {
        throw Exception('Error loading user list: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

   Future<String?> getPlaceName(double? latitude, double? longitude) async {
    final response = await http.get(
      Uri.parse('$apiUrl?latlng=$latitude,$longitude&key=$google_api_key'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final addressComponents =
            results[0]['address_components'] as List<dynamic>;
        final formattedAddress = results[0]['formatted_address'];
        print('Adresse: $formattedAddress');
        // Vous pouvez extraire d'autres informations à partir de addressComponents si nécessaire
        return formattedAddress;
      }
    }

    return null;
  }


}
