import 'dart:convert';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otrip/api/api_constants.dart';
import 'package:http/http.dart' as http;

class PassagerController extends GetxController {
  final userData = GetStorage();

  Map<String, dynamic> getUserData() {
    return {'phone_number': userData.read('phone_number')};
  }

//  Map<String, dynamic> userInfo = getUserInfoByPhone();
// double solde = userInfo['balance'];

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
          print('L\' de mon gar est $userId');
          // Retour d'un Map avec les valeurs extraites
          return {'id': userId, 'role_id': roleId, 'balance': solde};
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

  Future<List<Map<String, dynamic>>> getUsersByEnginType(String enginType) async {
  try {
    final response = await http.get(Uri.parse('$driverByEngin/$enginType'));

    if (response.statusCode == 200) {
      final dynamic responseData = json.decode(response.body);

      if (responseData is List<dynamic> && responseData.isNotEmpty) {
        List<Map<String, dynamic>> usersList = List<Map<String, dynamic>>.from(responseData);
        return usersList;
      } else {
        throw Exception('Invalid response format for users by engin type.');
      }
    } else {
      throw Exception(
          'Failed to load users by engin type. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching users by engin type: $error');
    throw Exception('Error fetching users by engin type: $error');
  }
}

}
