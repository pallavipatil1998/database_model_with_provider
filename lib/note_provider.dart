import 'package:flutter/material.dart';
import 'package:provider_modelclass_database/appdatabase.dart';

import 'note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> _prNoteList=[];
  AppDataBase pDB=AppDataBase.db;


  pAddNote(NoteModel newNote)async{
   var check=await pDB.addNote(newNote);
   if(check){
     _prNoteList.add(newNote);
   }
    notifyListeners();
  }


  pUpdateNote(NoteModel note)async{
   await pDB.updateNote(note);
    notifyListeners();
  }

  pDeleteNote(int id)async{
    await pDB.deleteNotes(id);
    _prNoteList.removeWhere((note) => note.note_id == id);
    notifyListeners();
  }

  pFetchInitialNote()async{
  _prNoteList = await pDB.fetchAllNotes();
   notifyListeners();
  }

  List<NoteModel>pGetNotes(){
    return _prNoteList;

  }


}