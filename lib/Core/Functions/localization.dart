import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_this/main.dart';


 changeLang(String langcode){
  Locale local = Locale(langcode);
  sharedPrefs.setString("lang", langcode);
  Get.updateLocale(local);

}

  Locale getLang(){
  Locale languague;
  String? sharedPrefsLang = sharedPrefs.getString("lang");
  //String? sharedPrefsLang = "ar";
  if(sharedPrefsLang == "ar"){
    languague = const Locale("ar");
  }else if(sharedPrefsLang == "en"){
    languague = const Locale("en");
  }else{
    String languageCode = Get.deviceLocale!.languageCode;
    sharedPrefs.setString("lang", languageCode);
    languague = Locale(languageCode);
  }
  return languague;
}

bool isEnglish(){
  String? sharedPrefsLang = sharedPrefs.getString("lang");
  if(sharedPrefsLang == "en"){
    return true;
  }
  return false;
}