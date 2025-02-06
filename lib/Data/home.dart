


import 'package:note_this/sqldb.dart';

class HomeData{
  SqlDb sqldb = SqlDb();

  getNotes() async{
    List<Map> response = await sqldb.showData("SELECT * FROM notes", []);
    return response;
  }

  Future<int> deleteNotes(List<int> ids) async {
  String placeholders = ids.map((id) => '?').join(', ');
  return await sqldb.deleteData(''' 
    DELETE FROM notes 
    WHERE id IN ($placeholders)
  ''', ids);
}

Future<int> pinNotes(List<int> ids) async {
  String placeholders = ids.map((id) => '?').join(', ');
  return await sqldb.updateData(''' 
    UPDATE notes 
    SET pin = CASE 
                WHEN pin = 1 THEN 0 
                ELSE 1 
              END
    WHERE id IN ($placeholders)
  ''', ids);
}

  
  
}