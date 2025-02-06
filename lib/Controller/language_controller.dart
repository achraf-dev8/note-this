import 'package:get/get.dart';
import 'package:note_this/Core/Functions/localization.dart';


class LanguageController extends GetxController{

String english = "English";
String arabic = "Arabic";
bool  isEnglishVar = true;
final Function(String) changeVal;

LanguageController(this.changeVal);

@override
onInit(){
  if(!isEnglish()){
    english = "إنجليزية";
    arabic = "عربية";
    isEnglishVar = false;
  }
  super.onInit();
}

change(String val){
changeVal(val);
}



}