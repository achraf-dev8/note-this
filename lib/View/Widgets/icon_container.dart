import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Services/themes.dart';

class IconContainer extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool? enabled;

  const IconContainer({super.key, required this.icon, required this.onPressed, this.enabled});

  @override 
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: 42,
      height: 42,
      decoration: BoxDecoration(
          color: themeColors["container"], borderRadius: BorderRadius.circular(15)),
      child: IconButton(
        icon: FaIcon( 
          size: 18,
          icon,
          color: enabled != false ? themeColors["icon"] : themeColors["extra2"],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
