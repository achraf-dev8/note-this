import 'package:get/get.dart';
import 'package:note_this/Core/Constant/routes_names.dart';
import 'package:note_this/Data/home.dart';
import 'package:note_this/View/Widgets/Functions/dialogs.dart';

class HomeController extends GetxController{

  HomeData homeData = HomeData();

  List<Map> notes = [];

  List<Map> searchedNotes = [];

  List<int> selectedNotes = [];

  String searchVal = "";

  bool selectingState= false;

  bool searchingState= false;

    @override
    void onInit() async{
    await getData();
    super.onInit();
  }

  noteAddEdit(int? id){
    Get.toNamed(AppRoutes.addNote, arguments: {"id" : id, "update" : (){getData();}});
  }

  enterSelectingState(int i){
    selectedNotes = [i];
    selectingState = true;
    update();
  }

    select(int i){
      if(selectedNotes.contains(i)){
        selectedNotes.remove(i);
      }else{
        selectedNotes.add(i);
      }
    
    update();
  }

      selectAll(){
        
      if(!allSelected()){
        int i =-1;
        selectedNotes = notes.map((note){i++;
          return i;}).toList();
      }else{
        selectedNotes = [];
      }
    
    update();
  }


String getTimeAgo(String date) {

  DateTime inputDate = DateTime.parse(date);
  DateTime now = DateTime.now();
  Duration difference = now.difference(inputDate);

  if (difference.inSeconds < 10) {
    return 'just now'.tr;
  } else if (difference.inSeconds < 60) {
    return '${difference.inSeconds} ${"seconds ago".tr}';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} ${"minutes ago".tr}';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} ${"hours ago".tr}';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} ${"days ago".tr}';
  } else if (difference.inDays < 30) {
    return '${(difference.inDays / 7).floor()} ${"weeks ago".tr}';
  } else if (difference.inDays < 365) {
    return '${(difference.inDays / 30).floor()} ${"months ago".tr}';
  } else {
    return '${(difference.inDays / 365).floor()} ${"years ago".tr}';
  }
}

getData() async{
  List<Map> notes = await homeData.getNotes();

  this.notes = List.from(notes);

  this.notes.sort((a, b) {
    // Determine pin status for sorting
    int pinA = a['pin'] is String && a['pin'] == '&' ? 1 : a['pin'];
    int pinB = b['pin'] is String && b['pin'] == '&' ? 1 : b['pin'];

    // First, compare the pinned status
    int pinComparison = pinB.compareTo(pinA);
    if (pinComparison != 0) {
      return pinComparison; // Sort by pin status
    }

    // If both are pinned or both are not, compare by date
    DateTime dateA = DateTime.parse(a['date']);
    DateTime dateB = DateTime.parse(b['date']);
    return dateB.compareTo(dateA); // Sort dates in descending order
  });

  search(searchVal);

}

onReturn(){
  if(selectingState){
    selectingState = false;
    update();
  }else if(searchingState){
    noSearch();
  }
}

deleteNotes(){
  deleteDialog(selectedNotes.length, (){confirmDeleteNotes();});
}

confirmDeleteNotes()async{
  await homeData.deleteNotes(selectedNotes.map((i)=> notes[i]["id"] as int).toList());
  Get.back();
  selectingState = false;
  getData();
}

pinNotes()async{
  await homeData.pinNotes(selectedNotes.map((i)=> notes[i]["id"] as int).toList());
  Get.back();
  selectingState = false;
  getData();
}

bool enabled(){
  return selectedNotes.isNotEmpty;
}

bool allSelected(){
  return selectedNotes.length == notes.length;
}

enterSearch(){
  searchingState = true;
  update();
}

noSearch(){
  searchingState = false;
  searchedNotes = notes;
  searchVal = "";
  update();
}

search(String val){
  searchVal = val;
searchedNotes = notes.where((note)=>note["heading"].toString().toLowerCase().contains(val.toLowerCase())).toList();
update();
}





  
}