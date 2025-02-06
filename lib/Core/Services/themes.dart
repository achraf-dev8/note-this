import 'package:flutter/material.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/main.dart';


setThemeColors(){
  themeColors= {
  "background" : islightMode() ? AppColors.lightBackground : AppColors.darkBackgorund,
  "homeBackground" : islightMode() ? AppColors.homeLightBackground : AppColors.darkBackgorund,
  "text" : islightMode() ? Colors.black : Colors.white,
  "icon" : islightMode() ? Colors.black : Colors.white,
  "container" : islightMode() ? AppColors.lightIconButton : AppColors.darkIconButton,
  "extra" : islightMode() ? AppColors.extra : AppColors.extraNight,
  "extra2" : islightMode() ? AppColors.extra2 : AppColors.extra2Night,
};
}

Map<String, Color> themeColors = {
  "background" : islightMode() ? AppColors.lightBackground : AppColors.darkBackgorund,
  "homeBackground" : islightMode() ? AppColors.homeLightBackground : AppColors.darkBackgorund,
  "text" : islightMode() ? Colors.black : Colors.white,
  "icon" : islightMode() ? Colors.black : Colors.white,
  "container" : islightMode() ? AppColors.lightIconButton : AppColors.darkIconButton,
  "button" : islightMode() ? Colors.red : Colors.blue,
  "extra" : islightMode() ? AppColors.extra : AppColors.extraNight,
  "extra2" : islightMode() ? AppColors.extra2 : AppColors.extra2Night,
};


final lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.lightBackground,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.lightBackground, surfaceTintColor: AppColors.lightBackground)
);

final darkTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: AppColors.darkBackgorund,
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  appBarTheme: const AppBarTheme(backgroundColor: AppColors.darkBackgorund, surfaceTintColor: AppColors.darkBackgorund,
  )
);



bool islightMode(){
  return sharedPrefs.getBool("lightMode") != false;
} 

ThemeMode themeMode(){
  return islightMode() ? ThemeMode.light : ThemeMode.dark;
} 