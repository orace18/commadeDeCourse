import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'api_client.dart';
import 'auth/auth_api_controller.dart';
import 'dart:developer';

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({required this.apiClient});

  Future<T> getObject<T>(
      {required String url,
      required T Function(Map<String, dynamic>) modelFromMap,
      bool isRefresh = false}) async {
    final response = await apiClient.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('access_token')}',
    });
    if (response.status.hasError) {
      if (response.status.code == 401) {
        if (!isRefresh) {
          final authController = Get.find<AuthController>();
          // Uncomment this line if refresh token is set
          // await authController.refreshToken();
          return getObject(
              url: url, modelFromMap: modelFromMap, isRefresh: true);
        } else {
          throw Exception('invalid_token'.tr);
        }
      } else {
        throw Exception('connection_error'.tr);
      }
    } else if (response.body is Map) {
      return modelFromMap(response.body);
    } else {
      throw Exception('Response is not a Map');
    }
  }

  //getObjects
  Future<List<T>> getObjects<T>(
      {required String url,
      required T Function(Map<String, dynamic>) modelFromMap,
      bool isRefresh = false}) async {
    final response = await apiClient.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('access_token')}',
    });
    print("Body :${response.body}");
    if (response.status.hasError) {
      if (response.status.code == 401) {
        print("Eya");
        print(isRefresh);
        if (!isRefresh) {
          final authController = Get.put(AuthController());
          // Uncomment this line if refresh token is set
          // await authController.refreshToken();
          return await getObjects(
              url: url, modelFromMap: modelFromMap, isRefresh: true);
        } else {
          throw Exception('invalid_token'.tr);
        }
      } else {
        throw Exception('connection_error'.tr);
      }
    } else if (response.body['results'] is List) {
      print("---------------Top--------------------");
      for (var e in response.body['results']) {
        try {
          print("--**-- ${modelFromMap(e)}");
          print("${e['name']}");
        } catch (ex) {
          print("Erreur");
          print("${e['display_name']}");
        }
      }
      print(response.body['results']);
      return (response.body['results'] as List)
          .map((e) => modelFromMap(e))
          .toList();
    } else {
      throw Exception('Response is not a List');
    }
  }

  //createObject
  Future<T> createObject<T>(
      {required String url,
      required T Function(Map<String, dynamic>) modelFromMap,
      required Map<String, dynamic> body,
      bool isRefresh = false}) async {
    // delete null values from body
    body.removeWhere((key, value) => value == null);

    //trim all values
    body.forEach((key, value) {
      if (value is String) {
        body[key] = value.trim();
      }
    });

    final response = await apiClient.post(url, body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('access_token')}',
    });

    // print some info
    print("body: ${body}}");
    print("response: ${response.body}}");
    if (response.body.runtimeType == String) {
      if (response.body.contains('IntegrityError')) {
        throw Exception("integrity_error".tr);
      }
    }
    if (response.status.hasError) {
      if (response.status.code == 401) {
        if (!isRefresh) {
          final authController = Get.find<AuthController>();
          // Uncomment this line if refresh token is set
          // await authController.refreshToken();
          return createObject(
              url: url,
              modelFromMap: modelFromMap,
              body: body,
              isRefresh: true);
        } else {
          throw Exception('invalid_token'.tr);
        }
      } else {
        if (response.body != null &&
            response.body['non_field_errors'] != null) {
          throw Exception(response.body['non_field_errors'][0]);
        }
        else
          throw Exception('connection_error'.tr);
      }
    } else if (response.body is Map) {
      return modelFromMap(response.body);
    } else {
      throw Exception('Response is not a Map');
    }
  }

  //updateObject
  Future<T> updateObject<T>(
      {required String url,
      required T Function(Map<String, dynamic>) modelFromMap,
      required Map<String, dynamic> body,
      bool isRefresh = false}) async {
    // delete null values from body
    body.removeWhere((key, value) => value == null);
    //trim all values
    body.forEach((key, value) {
      if (value is String) {
        body[key] = value.trim();
      }
    });

    final response = await apiClient.patch(url, body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('access_token')}',
    });
    print("(((((((GET IT)))))))))");
    print(response.body);
    try {
      print(response.body['non_field_errors'][0]);
    } catch (e) {
      print("no error");
    }
    if (response.status.hasError) {
      if (response.status.code == 401) {
        if (!isRefresh) {
          final authController = Get.find<AuthController>();
          // Uncomment this line if refresh token is set
          // await authController.refreshToken();
          return updateObject(
              url: url,
              body: body,
              modelFromMap: modelFromMap,
              isRefresh: true);
        } else {
          throw Exception('invalid_token'.tr);
        }
      } else {
        if (response.body['non_field_errors'] != null) {
          throw Exception(response.body['non_field_errors'][0]);
        } else
          throw Exception('connection_error'.tr);
      }
    } else if (response.body is Map) {
      print("Reponse : ${response.body}");
      return modelFromMap(response.body);
    } else {
      throw Exception('Response is not a Map');
    }
  }

  //deleteObject
  Future<void> deleteObject(
      {required String url, bool isRefresh = false}) async {
    final response = await apiClient.delete(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('access_token')}',
    });
    if (response.status.hasError) {
      if (response.status.code == 401) {
        if (!isRefresh) {
          final authController = Get.find<AuthController>();
          // Uncomment this line if refresh token is set
          // await authController.refreshToken();
          return deleteObject(url: url, isRefresh: true);
        } else {
          throw Exception('invalid_token'.tr);
        }
      } else {
        throw Exception('connection_error'.tr);
      }
    } else {
      print("deleted");
    }
  }
}
