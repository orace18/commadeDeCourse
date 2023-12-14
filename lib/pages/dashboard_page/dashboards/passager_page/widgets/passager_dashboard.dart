import 'package:flutter/material.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/carousel_widget.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/grid_view_widget.dart';
import 'package:otrip/pages/dashboard_page/dashboards/passager_page/widgets/wallet_widget.dart';

class PassagerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselWidget(),
          WalletCard(),
          DashboardGridView(),
        ],
      ),
    );
  }
}



