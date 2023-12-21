import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/carousel_widget.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/grid_view_widget.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/wallet_widget.dart';

class PassagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otrip'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Get.toNamed('/passager_menu');
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselWidget(),
          WalletCard(),
          Expanded(
            child: DashboardGridView(),
          ),
        ],
      ),
    );
  }
}
