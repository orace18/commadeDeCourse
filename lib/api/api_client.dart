import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';

class ApiClient extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = '';
    httpClient.addRequestModifier((Request request) async {
      final prefs = GetStorage();
      String accessToken = prefs.read('access_token') ?? '';
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      return request;
    });
  }

}
