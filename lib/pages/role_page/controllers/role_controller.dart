import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:otrip/api/api_constants.dart';
import 'package:otrip/constants.dart';

class RoleController extends GetxController {
  void navigateBack() => Get.back();
  final id = GetStorage().read('id');
  Future<bool> updateRole(String role) async {
    try {
      String changeRoleUrl = '${baseUrl}users/$id/change-role';
      final body = jsonEncode({'role_id': role});
      final request = await http.post(
        Uri.parse(changeRoleUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (request.statusCode == 200) {
        final res = jsonDecode(request.body);
        returnSuccess(res["message"]);
        return true;
      } else if (request.statusCode == 400) {
        final res = jsonDecode(request.body);
        returnError(res['message']);
        return false;
      } else {
        debugPrint('Error: ${request.statusCode}');
        return false;
      }
    } catch (error) {
      throw Exception('Error durring role update');
    }
  }

  final marchandRole = 1;
  final driverRole = 2;
  final passagerRole = 3;
  final societeRole = 4;
}
