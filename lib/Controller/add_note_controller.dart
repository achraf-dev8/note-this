import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:note_this/Core/Functions/localization.dart';
import 'package:note_this/Data/add_note.dart';
import 'package:note_this/View/Widgets/colors_bottom_sheet.dart';
import 'package:intl/intl.dart';

class AddNoteController extends GetxController{

  AddNoteData addNoteData = AddNoteData();

  TextEditingController heading = TextEditingController();

  TextEditingController body = TextEditingController();

  String title = "Add Note".tr;

  String date = "";

  int letters = 0;

  int words = 0;

  Map oldNote = {"heading" : "", "body" : "", "color" : 0xFFFFFFFF};

  Color test = Color(0xFFFFEF95);
  List<int> colorCodes = [  0xFFFFFFFF, 0xFFEA8AFF, 0xFF6BF2AA, 0xFF65BFFF, 0xFFFFEF95, 0xFFFF9F9F];

  int color = 0xFFFFFFFF;

  bool valid = false;

      @override
    void onReady() async{

if(Get.arguments != null){

      if(Get.arguments["id"] != null){
      title = "Edit Note".tr;
      oldNote = await addNoteData.getNote(Get.arguments["id"]);
      heading.text = oldNote["heading"];
      body.text = oldNote["body"];
      color = oldNote["color"];
      date = oldNote["date"];
      countLetters();
    }else{
    if(isEnglish()){
  date = DateFormat('M/d/yyyy, HH:mm').format(DateTime.now());
    }else{
      date = DateFormat('HH:mm، M/d/yyyy').format(DateTime.now());
    }

  
    }

}


    update();

    super.onReady();
  }

  saveNote() async{

    if(oldNote["id"] != null){
      await addNoteData.updateNote(oldNote["id"], heading.text, body.text, color);
      print(oldNote["id"]);
      oldNote = await addNoteData.getNote(oldNote["id"]);
    }else{
   int id = await addNoteData.addNote(heading.text, body.text, color);
   print(id);
   oldNote = await addNoteData.getNote(id);
    }
    valid = false;
    update();
  /*
  SqlDb sqlDb = SqlDb();
  sqlDb.onDelete(); 
*/
  }

  textChanged(){
    valid = body.text.isEmpty || (body.text == oldNote["body"] && heading.text == oldNote["heading"] && color == oldNote["color"]);
    valid = !valid;
    countLetters();
    update();
  }

  changeColor(){
    Get.bottomSheet(ColorsBottomSheet(colors: colorCodes, color: color, onPressed: (int color){selectColor(color);}),);
  }

    selectColor(int color){
    this.color = color;
    update();
    Get.back();
    textChanged();
  }

  countLetters(){
     letters = body.text.replaceAll(RegExp(r'\s+'), '').length;
     words =  body.text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  onReturn() async{
    await Get.arguments["update"]();
    Get.back();
  }


  
}