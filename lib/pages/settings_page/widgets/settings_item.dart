import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:otrip/constants.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.title, required this.icon, required this.initialValue, required this.onChanged});
  final String title;
  final IconData icon;
  final bool initialValue;
  final VoidCallback onChanged;

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
            ),
            Expanded(
              flex: 4,
              child: FormBuilderSwitch(
                name: "language_switch",
                title: Text(
                  ""
                ),
                initialValue: initialValue,
                onChanged: (value){
                  onChanged;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
