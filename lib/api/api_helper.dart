import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'api_client.dart';
import 'api_constants.dart';
import 'api_repository.dart';
import 'auth/auth_api_controller.dart';

class ApiHelper{
  final ApiRepository apiRepository = ApiRepository(apiClient: ApiClient());

  Future initHiveDb() async{
    await Hive.initFlutter();

    //For Adapters
    //Hive.registerAdapter(UserAdapter());
  }

  // Other functions for Api

}
