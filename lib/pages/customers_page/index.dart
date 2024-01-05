import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';
import 'controllers/customers_controller.dart';

class CustomersPage extends GetWidget<CustomersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<CustomersController>(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("customers".tr),
                        Text("0", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                      ],
                    ),
                    ElevatedButton(
                      child: Text('add_user'.tr),
                      onPressed: (){
                        Get.toNamed('/add_user');
                      },
                    )
                  ],
                ),
              ),
              defaultSizedBox,
            ],
          )
        ));
  }
}
