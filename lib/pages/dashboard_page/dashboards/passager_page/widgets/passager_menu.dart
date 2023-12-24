import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/providers/theme/theme.dart';

class PassagerMenu extends StatelessWidget {
  const PassagerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: AppTheme.otripMaterial,
            ),
          ),
          buildMenuItem('settings'.tr, Icons.settings, () {
            Get.toNamed('/settings');
          }),
          buildMenuItem('assistance'.tr, Icons.help, () {
            Get.toNamed('/assistance');
          }),
          buildMenuItem('role'.tr, Icons.group, () {
            Get.toNamed('/role');
          }),
          buildMenuItem('profil'.tr, Icons.person, () {
            Get.toNamed('/profile');
          }),
        ],
      ),
    );
  }

  Widget buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return Card(
      child: ListTile(
        title: Text(title),
        leading: Icon(icon),
        onTap: onTap,
      ),
    );
  }
}
