import 'package:flutter/material.dart';
import 'package:otrip/constants.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding/2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(icon,
                  color: Colors.grey,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
