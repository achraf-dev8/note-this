import 'package:flutter/material.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Services/themes.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const SettingsItem({super.key, required this.title, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontSize: 22,
                      color: themeColors["extra2"],
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}