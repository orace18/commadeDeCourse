import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otrip/pages/home_page/widgets/tab_page_switcher.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../controllers/menu_controller.dart' as menu;
import '../controllers/menu_controller.dart';
import '../index.dart';
import 'bottom_tabs_navigator.dart';
import 'package:badges/badges.dart' as badges;

class ScreenHomePage extends StatefulWidget {
  final Widget? menuScreen;
  final Layout? contentScreen;

  ScreenHomePage({
    this.menuScreen,
    this.contentScreen,
  });

  @override
  _ScreenHomePageState createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage> {
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  createContentDisplay() {
    return zoomAndSlideContent(Container(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
            title: Text(appName, style: TextStyle(fontWeight: FontWeight.bold),),
            leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Provider.of<menu.MenuController>(context, listen: false).toggle();
                }),
            actions: [
              badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Colors.pinkAccent
                ),
                badgeContent: Text("1", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                position: badges.BadgePosition.topEnd(top: 5, end: 5),
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () => Get.toNamed('/connexion'),
                ),
              ),
            ]
        ),
        body: TabPageSwitcher(),
        bottomNavigationBar: BottomTabsNavigator(),


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
      ),
    ));
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;

    if(Provider.of<menu.MenuController>(context, listen: true).state == MenuState.closed){
      slidePercent = 0.0;
      scalePercent = 0.0;
    } else if(Provider.of<menu.MenuController>(context, listen: true).state == MenuState.open){
      slidePercent = 1.0;
      scalePercent = 1.0;
    } else if(Provider.of<menu.MenuController>(context, listen: true).state == MenuState.opening){
      slidePercent = slideOutCurve.transform(
          Provider.of<menu.MenuController>(context, listen: true).percentOpen);
      scalePercent = scaleDownCurve.transform(
          Provider.of<menu.MenuController>(context, listen: true).percentOpen);
    } else if(Provider.of<menu.MenuController>(context, listen: true).state == MenuState.closing){
      slidePercent = slideInCurve.transform(
          Provider.of<menu.MenuController>(context, listen: true).percentOpen);
      scalePercent = scaleUpCurve.transform(
          Provider.of<menu.MenuController>(context, listen: true).percentOpen);
    }

    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius =
        16.0 * Provider.of<menu.MenuController>(context, listen: true).percentOpen;

    return new Transform(
      transform: new Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              offset: const Offset(0.0, 5.0),
              blurRadius: 15.0,
              spreadRadius: 10.0,
            ),
          ],
        ),
        child: new ClipRRect(
            borderRadius: new BorderRadius.circular(cornerRadius),
            child: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Scaffold(
            body: widget.menuScreen,
          ),
        ),
        createContentDisplay()
      ],
    );
  }
}