import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../providers/theme/theme.dart';
import 'controllers/dashboard_controller.dart';

class DashboardPage extends GetWidget<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<DashboardController>(
          builder: (_) => Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Text("welcome".tr, style: Theme.of(context).textTheme.headline6,),
                Card(
                  elevation: 12.0,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.monetization_on),
                            SizedBox(width: 10,),
                            Text("wallet".tr)
                          ],
                        ),
                        Icon(Icons.remove_red_eye, color: AppTheme.otripMaterial),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("customers".tr, style: Theme.of(context).textTheme.titleLarge,),
                      Text("0", style: TextStyle(color: AppTheme.otripMaterial, fontSize: 14, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 5,
                        child: OutlinedButton.icon(
                            onPressed: (){},
                            icon: Icon(Icons.people),
                            label: Text("list".tr, style: TextStyle(color: Colors.black, fontSize: 14),)
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 5,
                        child: OutlinedButton.icon(
                            onPressed: (){},
                            icon: Icon(Icons.add_circle_outlined,),
                            label: Text("add".tr, style: TextStyle(color: Colors.black, fontSize: 14),)
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Card(
                  color: Colors.white,
                  child: Container(
                    height: Get.height*0.22,
                    child: Center(
                      child: Text("statistics".tr),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
