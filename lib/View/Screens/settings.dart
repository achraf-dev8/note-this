import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_this/Controller/settings_controller.dart';
import 'package:note_this/Core/Functions/localization.dart';
import 'package:note_this/View/Widgets/icon_container.dart';
import 'package:note_this/View/Widgets/settingsItem.dart';
import 'package:note_this/View/Widgets/title_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:note_this/bindings.dart';
import 'package:note_this/main.dart';

class Settings extends GetView <SettingsController>{
  const Settings({super.key});

  @override
  Widget build(BuildContext context) { 
    Get.lazyPut(()=>SettingsController());
    return WillPopScope(
      onWillPop: () async {
       controller.onReturn();
      print("jdo");
      return false;
      },
      child: GetBuilder<SettingsController>(
         builder: (controller) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: Padding(
              padding: isEnglish() ? const EdgeInsets.only(right: 16) : const EdgeInsets.only(left: 16),
              child: AppBar(
               automaticallyImplyLeading: false, 
                title:   Row( 
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: 3),
                      child: IconContainer(icon : isEnglish() ? FontAwesomeIcons.arrowLeft : FontAwesomeIcons.arrowRight,onPressed: (){
                        controller.onReturn();
                      },),
                    ), SizedBox(width: 12,),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: TitleText(24, 'Settings'.tr),
                    ),
                  ],
                ),
                elevation: 0,
                
              ),
            ),
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8,),
                SettingsItem(
                  title: "Dark Mode".tr,
                  value: sharedPrefs.getBool("lightMode") != false ? "Off".tr : "On".tr,
                  onTap: () {controller.darkMode();},
                ),
                SettingsItem(
                  title: "Language".tr,
                  value: isEnglish() ? "English" : "عربية",
                  onTap: () {controller.language();},
                ),
              ],
            ),
          ),
      ),
      );
  }
}


