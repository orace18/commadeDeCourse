import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
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
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween,
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
                  "${GetStorage().read('balance')} FCFA",
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
               Get.toNamed('/wallet_recharge');
              },
              child: Text("recharge".tr,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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
