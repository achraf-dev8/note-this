import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_this/Core/Services/themes.dart';

class MainController extends GetxController{
  ThemeMode theme = themeMode();
  changeThemeMode(){
    setThemeColors();
    theme = themeMode();
    update();
  }
    changeLanguage(){
    update();
  }
}