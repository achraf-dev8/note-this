


import 'package:note_this/sqldb.dart';

class AddNoteData{
  SqlDb sqldb = SqlDb();

  

 addNote(String heading, String body, int color) async {
  return await sqldb.insertData('''
    INSERT INTO notes (heading, body, color) 
    VALUES (?, ?, ?)
  ''', [heading, body, color]);
}

 getNote(int id) async {
    List<Map<String, dynamic>> response = await sqldb.showData(''' 
    SELECT * FROM notes 
    WHERE id = ?
  ''', [id]);

  return response.first;

}

Future<int> updateNote(int id, String heading, String body, int color) async {
  return await sqldb.updateData(''' 
    UPDATE notes 
    SET heading = ?, body = ?, color = ? 
    WHERE id = ?
  ''', [heading, body, color, id]);
}


  
} 