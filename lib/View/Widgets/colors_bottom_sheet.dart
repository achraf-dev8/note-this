import 'package:flutter/material.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Services/themes.dart';
import 'package:note_this/View/Widgets/color_picker.dart';

class ColorsBottomSheet extends StatelessWidget {
  final List<int> colors;
  final int color;
  final Function(int) onPressed;

  const ColorsBottomSheet({super.key, required this.colors, required this.color, required this.onPressed});

  @override 
  Widget build(BuildContext context) {
    return    Container(
      decoration:  BoxDecoration(
      color: themeColors["background"],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(colors.length, (i)=> Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: ColorPicker(color: colors[i], onPressed: (){onPressed(colors[i]);}, selected: colors[i] == color,),
      )),
      
      )
      );
  }
}
