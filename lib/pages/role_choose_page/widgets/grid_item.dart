import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/providers/theme/theme.dart';

import '../../../constants.dart';


class RoleGridViewItem extends StatelessWidget {
  const RoleGridViewItem({super.key, required this.imagePath, required this.title, required this.details, required this.description});
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: details,
      child: Card(
        elevation: 4.0,
        color: AppTheme.otripMaterialAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Image.asset(
                  imagePath
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  title
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
