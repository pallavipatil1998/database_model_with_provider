import 'package:provider_modelclass_database/appdatabase.dart';

class NoteModel{

  int? note_id;
  String title;
  String desc;

  NoteModel({this.note_id,required this.title,required this.desc});


  factory NoteModel.fromap(Map<String,dynamic> map){

    return NoteModel(
      note_id: map[AppDataBase.NOTES_COLUMN_ID],
      title: map[AppDataBase.NOTES_COLUMN_TITLE],
      desc: map[AppDataBase.NOTES_COLUMN_DESC]
    );

  }


  Map<String,dynamic> tomap(){
    return{
      AppDataBase.NOTES_COLUMN_ID:note_id,
      AppDataBase.NOTES_COLUMN_TITLE:title,
      AppDataBase.NOTES_COLUMN_DESC:desc

    };

  }


}