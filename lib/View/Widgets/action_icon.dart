import 'package:flutter/material.dart';
import 'package:note_this/Core/Constant/colors.dart';

class ActionIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool enabled;

  const ActionIcon({super.key, required this.title, required this.onPressed, required this.icon, required this.enabled});

  @override 
  Widget build(BuildContext context) {
    return  IconButton(
                onPressed: onPressed,
                icon: Icon(icon, color: enabled ? Colors.black : AppColors.extra2 , size: 21,),
              );
  }
}
