import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_this/Core/Services/themes.dart';

class ColorPicker extends StatelessWidget {
  final int color;
  final VoidCallback? onPressed;
  final bool selected;
  final bool? small;

  const ColorPicker({super.key, required this.color, required this.onPressed, required this.selected, this.small});

  @override 
  Widget build(BuildContext context) {
    return    Container( margin: const EdgeInsets.only(top: 8),
  width: small == true ? 36  : 40,
      height: small == true ? 36 : 40,
    decoration: BoxDecoration(
    border: selected || color == 0xFFFFFFFF ? Border.all(
      color: themeColors["text"]!, 
      width: selected ? 2 : 0.5, 
    ) : null,
   color: Color(color),
    borderRadius: BorderRadius.circular(15)),
     child: IconButton(onPressed: onPressed, icon: const FaIcon(null),
                          ),
                          );
  }
}
