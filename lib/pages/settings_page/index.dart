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
                        Expanded(
                          flex: 4,
                          child: Switch(
                            value: controller.isLightMode ? false : true,
                            onChanged: (value){
                                controller.changeThemeMode();
                            },
                          )
                        )
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
