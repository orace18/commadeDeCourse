import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import 'widgets/bottom_tabs_navigator.dart';
import 'widgets/tab_page_switcher.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          title: Text(appName, style: TextStyle(fontWeight: FontWeight.bold),),
          actions: [
            badges.Badge(
              badgeContent: Text("1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              position: badges.BadgePosition.topEnd(top: 5, end: 5),
              child: IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () => Get.toNamed('/login'),
              ),
            ),
          ]
      ),
      body: TabPageSwitcher(),
      bottomNavigationBar: BottomTabsNavigator(),
      drawer: Drawer(

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
