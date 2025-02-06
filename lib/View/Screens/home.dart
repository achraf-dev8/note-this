import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:note_this/Controller/home_controller.dart';
import 'package:note_this/Core/Constant/colors.dart';
import 'package:note_this/Core/Constant/routes_names.dart';
import 'package:note_this/Core/Functions/localization.dart';
import 'package:note_this/Core/Services/themes.dart';
import 'package:note_this/View/Widgets/action_icon.dart';
import 'package:note_this/View/Widgets/icon_container.dart';
import 'package:note_this/View/Widgets/title_text.dart';

class Home extends GetView<HomeController> {

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
     Get.lazyPut(()=>  HomeController());
    return WillPopScope(  onWillPop: () async {
      controller.onReturn();
      return false;
      },
      child: GetBuilder<HomeController>(
        builder: (controller) => Scaffold(
          backgroundColor: themeColors["homeBackground"],
          appBar: !controller.searchingState ? PreferredSize(
            preferredSize: const Size.fromHeight(65),
            child: Padding(
              padding: isEnglish() ? const EdgeInsets.only(left: 8, right: 16) : const EdgeInsets.only(left: 16, right: 8),
              child:  AppBar(
                automaticallyImplyLeading: false, 
                title:  Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TitleText(28, 'Notes'.tr),
                ),
                actions: !controller.selectingState ? [
                  IconContainer(icon: FontAwesomeIcons.magnifyingGlass, onPressed: (){controller.enterSearch();},),
                  const SizedBox(width: 8,),
                  IconContainer(icon:  FontAwesomeIcons.gear, onPressed: (){Get.toNamed(AppRoutes.settings);},),
                ] : [
                  Text(controller.selectedNotes.length.toString(), style:  TextStyle(color: themeColors["text"], fontSize: 23, 
                  fontWeight: FontWeight.w600),),

                const SizedBox(width : 5),

                Container( height: 32, width: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: controller.allSelected() ? null : Border.all(color: Colors.black, width: 1.5),
                   color: controller.allSelected() ? AppColors.orangeYellow : Colors.white,
                  ), child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.check, color: Colors.white, size: 18,), 
                    onPressed: () { controller.selectAll();},),
                  ), 
                ],
                backgroundColor: themeColors["homeBackground"],
                surfaceTintColor: themeColors["homeBackground"],
                elevation: 0,
              ),
            ),
          ) : null,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, top: 8),
              child: ListView(
                children:[ 
                  if(controller.searchingState== true)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom:  8.0),
                          child: TextField(
                            cursorColor: themeColors["text"],
                          onChanged: (val){controller.search(val);},
                          style:  TextStyle(fontSize: 18, color: themeColors["text"], fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeColors["extra"]!, width: 3),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: themeColors["extra"]!, width: 2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  prefixIcon: Icon(Icons.search , size: 22, color: themeColors["extra"],),
                                  hintStyle: TextStyle(fontSize: 18, color: themeColors["extra"]),
                                  hintText: "Search".tr,
                                ),      ),
                        ),
                      ), const SizedBox(width: 8,),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: IconContainer(icon:  FontAwesomeIcons.xmark, onPressed: (){controller.noSearch();},),
                    ),
                    ],
                  ),
                  ListView.builder( shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.searchedNotes.length,
                    itemBuilder: (context, i) => NoteCard(
                      selectingState: controller.selectingState == false ? null : controller.selectedNotes.contains(i),
                      note: controller.searchedNotes[i], getTimeAgo: (val){return controller.getTimeAgo(val);},
                      edit: (val){controller.noteAddEdit(val);}, enterSelecting: (){controller.enterSelectingState(i);},
                      select: (){controller.select(i);},
                    ),
                  ),
              ]),
            ),
          ),
          floatingActionButton: !controller.selectingState ? SizedBox(
            height: 55, width: 55,
            child: FloatingActionButton( 
              onPressed: (){controller.noteAddEdit(null);},
              backgroundColor: AppColors.orangeYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 1.5,
              child: const Icon( size: 28,
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          ) : null, 
          bottomNavigationBar: controller.selectingState ? Container(
            decoration:  BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: themeColors["extra"]!, width: 0.5))
            ),
            height: 75, child: Row( mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [const SizedBox(), const Spacer(),
             
             ActionIcon(title: "Delete", onPressed: controller.enabled() ? (){controller.deleteNotes();} : null, icon: FontAwesomeIcons.trash, enabled: controller.enabled(), ), 
             const Spacer(), 
             ActionIcon(title: "Pin", onPressed: controller.enabled() ? (){controller.pinNotes();} : null, icon: FontAwesomeIcons.thumbtack, enabled: controller.enabled()), const Spacer(),
             const SizedBox()
             
             ],
            ), 
          ) : null,

        ),
    ),
    );
  }
}

class NoteCard extends StatelessWidget {

  final Map note;
  final String Function(String) getTimeAgo;
  final Function(int) edit;
  final Function() select;
  final Function() enterSelecting;
  final bool? selectingState;

  const NoteCard(
  {super.key, required this.note, required this.getTimeAgo, required this.edit, required this.selectingState, 
  required this.enterSelecting, required this.select});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Card(
        color: Color(note["color"]),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onLongPress: enterSelecting,
          onTap: selectingState == null ? (){edit(note["id"]);} : select,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:  16.0, vertical: 14),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note["heading"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                     const SizedBox(height: 1.5),
                      Text(
           maxLines: 3,  overflow: TextOverflow.ellipsis,
                        note["body"],
                        style:  TextStyle(
                          fontSize: 16.5, color: AppColors.extra),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        if(note["pin"] == 1)
                          Row(
                            children: [
                              Icon(FontAwesomeIcons.thumbtack, color: AppColors.extra, size: 14.5,),
                              const SizedBox(width: 5,),
                            ],
                          ),
                          Text(
                          getTimeAgo(note["date"]),
                            style:  TextStyle(color: AppColors.extra, fontSize: 14),
                          ),
                          
                        ],
                      ),
                    ],
                  ),
                ), 
                if(selectingState != null)
                Container( height: 32, width: 32,
                  
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selectingState! ? null : Border.all(color: Colors.black, width: 1.5),
                   color: selectingState! ? AppColors.orangeYellow : Colors.white,
                  ), child: const Icon(FontAwesomeIcons.check, color: Colors.white, size: 18,),
                  )
                  
              ],
            ),
          ),
        ),
      ),
    );
  }
}
