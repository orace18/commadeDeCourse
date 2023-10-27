import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';

class RechargeTile extends StatelessWidget {
  const RechargeTile({Key? key, required this.amount, required this.currency}) : super(key: key);
  final int amount;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_downward, color: Colors.green, size: 40,),
                Text('deposit'.tr, style: TextStyle(fontSize: 16),),
              ],
            ),
            Text(
              "+$amount $currency",
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }
}
