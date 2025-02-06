import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_this/Controller/home_controller.dart';
import 'package:note_this/Controller/main_controller.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Constant/routes_names.dart';
import 'package:note_this/Core/Functions/localization.dart';
import 'package:note_this/Core/Services/themes.dart';
import 'package:note_this/View/Widgets/Functions/dialogs.dart';
import 'package:note_this/main.dart';

class SettingsController extends GetxController{

  darkMode(){
    darkModeDialog((val){changeDarkMode(val);});
  }

  changeDarkMode(bool val){
    sharedPrefs.setBool("lightMode", !val);
    MainController mainController = Get.find();
    mainController.changeThemeMode();
    update();
  }

    language(){
    languageDialog((val){changeLanguage(val);});
  }

    changeLanguage(String langcode){
    changeLang(langcode);
    MainController mainController = Get.find();
    mainController.changeLanguage();
    update();
  }

  onReturn(){
    
    HomeController homeController = Get.find();
    homeController.update();
    Get.back();
    
  }
}