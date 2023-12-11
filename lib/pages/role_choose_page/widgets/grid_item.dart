import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/providers/theme/theme.dart';

import '../../../constants.dart';


class RoleGridViewItem extends StatelessWidget {
  const RoleGridViewItem({super.key, required this.imagePath, required this.title, required this.details, required this.description});
  final String imagePath;
  final String title;
  final String description;
  final Function details;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.bottomSheet(
            Container(
              height: Get.height *0.4,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                )
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding*2, defaultPadding, 0),
                      child: Column(
                        children: [
                          Text(
                              title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                          Text(
                              description
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(defaultPadding*2, defaultPadding, defaultPadding*2, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        elevation: 0,
                        backgroundColor: AppTheme.otripMaterial,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                      onPressed: (){
                        Get.toNamed("/register",arguments: {"role" : title});
                      },
                      child: Text('continue'.tr, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            )
        );
      },
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
