import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otrip/constants.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({Key? key, required this.amount, required this.currency}) : super(key: key);
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
                Icon(Icons.arrow_upward, color: Colors.red, size: 40,),
                Text('ride'.tr, style: TextStyle(fontSize: 16),),
              ],
            ),
            Text(
              "-$amount $currency",
              style: TextStyle(
                color: Colors.red,
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
