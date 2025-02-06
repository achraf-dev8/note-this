import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_this/Controller/add_note_controller.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Functions/localization.dart';
import 'package:note_this/Core/Services/themes.dart';
import 'package:note_this/View/Widgets/color_picker.dart';
import 'package:note_this/View/Widgets/icon_container.dart';
import 'package:note_this/View/Widgets/title_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNote extends GetView {
  const AddNote({super.key});
  @override
  Widget build(BuildContext context) {
    AddNoteController controller = AddNoteController();
    Get.lazyPut(()=>  controller);

    return WillPopScope( onWillPop: () async {
      await controller.onReturn();
      return false;
    },
      child: GetBuilder<AddNoteController>(
        builder: (controller) => Scaffold(
            appBar:  PreferredSize(
              preferredSize: const Size.fromHeight(65),
              child: Padding(
                padding: isEnglish() ? const EdgeInsets.only(right: 16) : const EdgeInsets.only(left: 16),
                child: AppBar(
                 automaticallyImplyLeading: false, 
                  title:  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: IconContainer(icon: isEnglish() ? FontAwesomeIcons.arrowLeft : FontAwesomeIcons.arrowRight, 
                        onPressed: (){controller.onReturn();},),
                      ), SizedBox(width: 12,),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TitleText(25, controller.title),
                      ),
                    ],
                  ),
                  actions: [
                    ColorPicker(color: controller.color, onPressed: (){controller.changeColor();}, selected: true, small: true,),
                        const   SizedBox(width: 12,),
                       
                      IconContainer(icon: FontAwesomeIcons.check, onPressed: controller.valid ? (){controller.saveNote();} : null, 
                      enabled: controller.valid,)
          
                  ],
                  elevation: 0,
                  
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:  16.0),
                  child: Row(
                    children: [
                      Text(controller.date, style:  TextStyle(color: themeColors["extra"]!,),),
                      const Spacer(),
                      Text("${controller.letters} ${"letters".tr} | ${controller.words} ${"words".tr}", 
                      style:  TextStyle(color: themeColors["extra"]!,),)
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                 Divider(
                  color: themeColors["extra"]!,
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView(
                      children: [
                        TextField(
                          onChanged: (val){controller.textChanged();},
                          controller: controller.heading,
                          cursorColor: themeColors["text"]!,
                          decoration: InputDecoration(
                            hintText: 'Heading'.tr,
                            hintStyle: TextStyle(
                                color: themeColors["extra2"],
                                ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 25.5, fontWeight: FontWeight.bold, color: themeColors["text"]!),
                          maxLines: 1,
                        ),           
      
                        TextField(
                          onChanged: (val){controller.textChanged();},
                          controller: controller.body,
                          cursorColor: themeColors["text"]!,
                          decoration: InputDecoration(
                            hintText: 'Text'.tr,
                            hintStyle: TextStyle(color: themeColors["extra2"],),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 21, color: themeColors["text"]!),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                        ),
                      ],
                    ),
                  ),
             
            )],
              
            ),
      
          )
        
      ),
    );
  }

  
}
