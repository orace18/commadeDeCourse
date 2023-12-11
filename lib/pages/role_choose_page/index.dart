import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../providers/theme/theme.dart';
import '../add_user_page/widgets/clipper.dart';
import 'controllers/role_choose_controller.dart';

class RoleChoosePage extends GetWidget<RoleChooseController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<RoleChooseController>(
          builder: (_) => SafeArea(
              top: false,
              child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: ClipPath(
                            clipper: DrawClip(),
                            child: Container(
                              color: AppTheme.otripMaterial,
                              width: Get.width,
                              child: Padding(
                                padding: const EdgeInsets.all(defaultPadding),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom:75.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("register_text".tr, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("register_info".tr, style: TextStyle(color: Colors.white, fontSize: 14),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),

                  ]
              )
          ),
        ));
  }
}
