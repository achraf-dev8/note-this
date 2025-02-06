import 'package:flutter/material.dart';
import 'package:note_this/Core/Services/themes.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double size;
  const TitleText(this.size, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: size,
        color: themeColors["text"],
      ),
      textAlign: TextAlign.left,
    );
  }
}
