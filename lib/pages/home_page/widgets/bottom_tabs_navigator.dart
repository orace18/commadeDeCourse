import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../../../constants.dart';
import '../controllers/home_controller.dart';


class BottomTabsNavigator extends GetWidget<HomeController> {
  const BottomTabsNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        SlidingClippedNavBar(
            barItems: [
              BarItem(
                icon: Icons.home,
                title: "home".tr,
              ),
              BarItem(
                icon: Icons.stacked_bar_chart,
                title: "activities".tr,
              ),
              BarItem(
                icon: Icons.group,
                title: "customers".tr,
              ),
              BarItem(
                icon: Icons.person,
                title: "profil".tr
              ),
            ],
            selectedIndex: controller.tabIndex.value,
            onButtonPressed: (index) => controller.setTabIndex(index),
            activeColor: otripOrange,
            inactiveColor: Colors.grey,
        )

    );
  }
}
