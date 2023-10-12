import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/login_controller.dart';
import '../../providers/theme/theme.dart';

class LoginPage extends GetWidget<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LoginController>(
          builder: (_) => SafeArea(
            child: Stack(
              children: [
                Container(
                  height: Get.height,
                  width: Get.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height*0.55, left: 40, right: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder()
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: (){},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 80.0),
                            child: Text('continue'.tr, style: AppTheme.lightTheme.textTheme.titleLarge,),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                    height: Get.height/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              Get.width, 100.0)),
                      color: AppTheme.otripMaterial,
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("welcome".tr, style: Theme.of(context).textTheme.titleMedium,),
                        SizedBox(
                          height: 10,
                        ),
                        Text("phone_request".tr, style: Theme.of(context).textTheme.titleSmall,)
                      ],
                    ),
                  ),
                )
              ]
            )
          ),
        ));
  }
}
