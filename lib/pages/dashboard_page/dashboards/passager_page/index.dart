// passenger_dashboard.dart
import 'package:flutter/material.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/carousel_widget.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/grid_view_widget.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/wallet_widget.dart';

class PassagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passenger Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Changez cette ligne
        children: [
          CarouselWidget(),
          WalletCard(),
          Flexible(
            child: DashboardGridView(),
          ),
        ],
      ),
    );
  }
}
