import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/settings_page/widgets/settings_item.dart';
import '../../constants.dart';
import 'controllers/settings_controller.dart';

class SettingsPage extends GetWidget<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("settings".tr),
      ),
        body: GetBuilder<SettingsController>(
          builder: (_) => Container(
            child: Column(
              children: [
                // Menu Parametres Theme
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding/2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.dark_mode,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "dark_theme".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Expanded(
                              flex: 4,
                              child: Switch(
                                value: controller.isLightMode.value ? false : true,
                                onChanged: (value){
                                  controller.changeThemeMode();
                                },
                              )
                          );
                        })
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding/2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.language,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "language".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        Obx((){
                          return Expanded(
                              flex: 4,
                              child: DropdownButton(
                                key: controller.languageKey,
                                value: controller.language.value,
                                isExpanded: true,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                                alignment: Alignment.center,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5)
                                ),
                                items: [
                                  DropdownMenuItem(child: Text("fr"), value: Locale("fr","FR"),),
                                  DropdownMenuItem(child: Text("en"), value: Locale("en","US"),)
                                ], onChanged: (value) {
                                controller.changeAppLanguage(value!);
                              },
                              )
                          );
                        }
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Get.defaultDialog(
                      title: "logout_alert".tr,
                      content: Text("logout_confirm"),
                      cancel: ElevatedButton(
                        child: Text("cancel".tr),
                        onPressed: (){

                        },
                      ),
                      confirm: ElevatedButton(
                        child: Text("confirm".tr),
                        onPressed: (){},
                      )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding/2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.logout,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 14,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "logout".tr,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SettingsItem(title: "dark_theme".tr, icon: Icons.dark_mode),
              ],
            ),
          ),
        ));
  }
}
