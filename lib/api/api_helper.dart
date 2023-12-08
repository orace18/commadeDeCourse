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

  // Future<List<Category>> getAllCategories() async {
  //   var box = await Hive.openBox<Category>(categoryBox);
  //   box.values.toList().forEach((element) {
  //     if (box.values.toList().where((e) => e.name == element.name).length > 1){
  //       box.delete(element.id);
  //     }
  //   });
  //   try {
  //     print("Odje");
  //     var categories= await apiRepository.getObjects(url: categoriesUrl, modelFromMap: (e) => Category.fromJson(e));
  //     print("Ici 229");
  //     await box.clear();
  //     if (categories.length > 0){
  //       categories.forEach((element) {
  //         print('Ici 1: ${element.toJson()}');
  //         box.put(element.id, element);
  //       });
  //     }
  //     print("categories: $categories");
  //     return categories;
  //   }catch(e){
  //     Get.snackbar("error".tr, e.toString(), backgroundColor: errorColor, colorText: Colors.white);
  //     print("ceci ne s'éxécute pas");
  //     print(e);
  //     return box.values.toList().reversed.toList();
  //   }
  // }
  //
  // // create category
  // Future<void>createCategory(Category category) async{
  //   try {
  //     await apiRepository.createObject(url: categoriesUrl, modelFromMap: Category.fromJson, body: category.toJson());
  //     print("Category created");
  //     Get.back();
  //     Get.forceAppUpdate();
  //     Get.snackbar("success".tr, "category_created".tr, backgroundColor: successColor, colorText: Colors.white);
  //   }catch(e){
  //     Get.snackbar("error".tr, e.toString(), backgroundColor: errorColor, colorText: Colors.white);
  //   }
  //
  // }

}
