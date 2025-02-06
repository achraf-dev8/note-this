import 'package:flutter/material.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Functions/localization.dart';

class SelectingTile extends StatelessWidget {
  final String title;
  final bool val;
  final bool isEnglish;
  final Function() onTap;

  const SelectingTile({super.key, required this.title, required this.val, required this.onTap, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isEnglish ? TextDirection.ltr : TextDirection.rtl,
      child: ListTile(
          title: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: val
                    ? Container(
                  margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue,
                ),
                )
                    : null,
              ),
              SizedBox(width: 10),
              Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
            ],
          ),
          onTap: onTap,
        ),
    );
  }
}