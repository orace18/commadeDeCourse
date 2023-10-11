import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../providers/theme/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        
      ),
      appBar: AppBar(
        title: Text(appName, style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [

        ],
      ),
      body: Padding(
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 5,
                  child: OutlinedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.people,),
                    label: Text("list".tr,style: TextStyle(color: Colors.black),),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                    )
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  flex: 5,
                  child: OutlinedButton.icon(
                    onPressed: (){},
                    icon: Icon(Icons.add_circle_outlined,),
                    label: Text("add".tr,style: TextStyle(color: Colors.black),),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                      )
                  ),
                ),
              ],
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
      // bottomNavigationBar: Obx(() => BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'home'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.insert_chart_rounded),
      //         label: 'my business'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.people),
      //         label: 'customers'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person),
      //         label: 'profile'
      //     ),
      //   ],
      // )),
    );
  }
}
