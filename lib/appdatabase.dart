
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider_modelclass_database/note_model.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase{
  
  AppDataBase._();
  
  static final AppDataBase db=AppDataBase._();
  Database? _database;
  static final NOTES_TABLE="note";
  static final NOTES_COLUMN_ID="note_id";
  static final NOTES_COLUMN_TITLE="note_title";
  static final NOTES_COLUMN_DESC="note_desc";
  
  Future<Database> getDb()async{
    if(_database!= null){
      return _database!;
    }else{
      _database= await initDb();
      return _database!;
    }
  }
  
  
  Future<Database> initDb()async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(documentDirectory.path, "noteDB.db");
    return openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) {
          db.execute("create table $NOTES_TABLE($NOTES_COLUMN_ID integer primary key autoincrement, $NOTES_COLUMN_TITLE text, $NOTES_COLUMN_DESC text)");

          // db.execute(
          //     "create table $NOTES_TABLE($NOTES_COLUMN_ID integer primary key autoincrement, $NOTES_COLUMN_TITLE text,$NOTES_COLUMN_DESC)");
        }
    );
  }


  //add note
    Future<bool> addNote( NoteModel note)async{
    var d1=await getDb();

    int rowsaffected= await d1.insert(NOTES_TABLE,note.tomap());

    return rowsaffected>0;

    }

    Future<bool> updateNote(NoteModel note)async{
    var d3=await getDb();
   int rowsUpdated=await d3.update(NOTES_TABLE,note.tomap(),where: "$NOTES_COLUMN_ID=${note.note_id}");
    return rowsUpdated>0;
    }


    Future<bool>deleteNotes(int id)async {
    var d4=await getDb();
    int deletedRows=await d4.delete(NOTES_TABLE,where: "$NOTES_COLUMN_ID=?", whereArgs:[id] );
    return deletedRows>0;
    }




    //fetch all notes
    Future<List<NoteModel>>fetchAllNotes()async{
    var d2=await getDb();
    List<Map<String,dynamic>> notesList=await d2.query(NOTES_TABLE);
    List<NoteModel> mNOTEList=[];

    for(Map<String,dynamic>note in notesList){
      NoteModel model = NoteModel.fromap(note);
      mNOTEList.add(model);
    }

    return mNOTEList;
    }

  
  
  
  
  
  
}
