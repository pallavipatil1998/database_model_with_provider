import 'package:flutter/material.dart';
import 'package:provider_modelclass_database/appdatabase.dart';

import 'note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> _prNoteList=[];
  AppDataBase pDB=AppDataBase.db;



  pFetchInitialNote()async{
    _prNoteList = await pDB.fetchAllNotes();
    notifyListeners();
  }

  List<NoteModel>pGetNotes(){
    return _prNoteList;

  }

  pAddNote(NoteModel newNote)async{
   var check=await pDB.addNote(newNote);
   if(check){
     // _prNoteList.add(newNote);
     // notifyListeners();
     pFetchInitialNote();
   }

  }


  pUpdateNote(NoteModel note)async{
   var cheks = await pDB.updateNote(note);
   if(cheks){
     pFetchInitialNote();
   }
  }

  pDeleteNote(int id)async{
    var result=await pDB.deleteNotes(id);
    if(result){
      pFetchInitialNote();
    }
  }




}