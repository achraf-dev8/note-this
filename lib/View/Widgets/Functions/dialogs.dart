

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_this/Controller/dark_mode_controller.dart';
import 'package:note_this/Controller/language_controller.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Functions/localization.dart';
import 'package:note_this/Core/Services/themes.dart';
import 'package:note_this/View/Widgets/selecting_tile.dart';

darkModeDialog(Function(bool) changeVal){

  Get.lazyPut(()=>DarkModeController(!islightMode(), changeVal));

    Get.defaultDialog(backgroundColor: Colors.white,
      title: "Dark Mode".tr, titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600
    ), 
    content: GetBuilder<DarkModeController>(
      builder: (controller) =>  Switch(
        activeTrackColor: AppColors.blue,
                  value: controller.val,
                  onChanged: (value) {
                    controller.change(value);
                  },
                ),
    ),
    contentPadding: EdgeInsetsDirectional.zero,
     );

}

languageDialog(Function(String) changeVal){

  Get.lazyPut(()=>LanguageController(changeVal));

    Get.defaultDialog(backgroundColor: Colors.white,
      title: "Language".tr, titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600
    ), 
    content: GetBuilder<LanguageController>(
      builder: (controller) =>  Column(
        children: [
          SelectingTile(title: controller.english, val: isEnglish(), onTap:  (){controller.changeVal("en");}, isEnglish: controller.isEnglishVar,),
          SelectingTile(title: controller.arabic, val: !isEnglish(), onTap:  (){controller.changeVal("ar");}, isEnglish: controller.isEnglishVar,),
        ],
      )
    ),
    contentPadding: EdgeInsetsDirectional.zero,
     );


}

deleteDialog(int count, Function() confirm){


    Get.defaultDialog(titlePadding: EdgeInsets.only(top: 10),
      backgroundColor: Colors.white,
      title: "${"Delete".tr} $count ${"notes".tr}", titleStyle: const TextStyle(color: Colors.black, fontSize: 20 
    ), 
    content: Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
      TextButton(onPressed: (){Get.back();}, child: Text("Cancel".tr, style : TextStyle(color: AppColors.blue, fontSize: 15))),
      Spacer(),
            TextButton(onPressed: confirm, child: Text("Confirm".tr, style : TextStyle(color: AppColors.red, fontSize: 15))),
      Spacer(),
    ],),
    contentPadding: EdgeInsetsDirectional.zero,
     );
     
     }