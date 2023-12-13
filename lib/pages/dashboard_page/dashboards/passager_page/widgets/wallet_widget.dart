import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:otrip/constants.dart';
import 'package:otrip/providers/theme/theme.dart';



class WalletCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          // Changez cette ligne
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Ajustez cela selon vos préférences
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "balance".tr,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "500 FCFA",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.otripMaterial[500],
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
               
              },
              child: Text("recharge".tr),
              style: ElevatedButton.styleFrom(
                primary: AppTheme.otripMaterial[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
