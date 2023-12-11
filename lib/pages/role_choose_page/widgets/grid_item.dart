import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RoleGridViewItem extends StatelessWidget {
  const RoleGridViewItem({super.key, required this.imagePath, required this.title, required this.details});
  final String imagePath;
  final String title;
  final Function details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.bottomSheet;
      },
      child: Card(
        elevation: 4.0,
        color: Colors.white,
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
