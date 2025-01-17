import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'note_model.dart';
import 'note_provider.dart';

class AddUpdateNote extends StatelessWidget {
  String? title;
  String? desc;
  int? note_id;
  bool isUpdate=false;
  AddUpdateNote({required this.isUpdate,this.title,this.desc,this.note_id});
  var titleController= TextEditingController();
  var descController=TextEditingController();
  var operationTitle="Add Note";

  initControllers(){
    titleController.text=title!;
    descController.text=desc!;
  }

  void aDDPrNote(String ptitle,String pdesc,BuildContext context)async{
    context.read<NoteProvider>().pAddNote(NoteModel(title: ptitle, desc: pdesc));
  }

  void updateNote(int id,String uTitile,String uDesc,BuildContext context)async{
    context.read<NoteProvider>().pUpdateNote(NoteModel(note_id: id,title: uTitile, desc: uDesc));
  }

  @override
  Widget build(BuildContext context) {
    if(isUpdate){
      initControllers();
      operationTitle="Upadte Note";
    }
    return Scaffold(

      appBar: AppBar(title: Text(""),),
      body: Container(
        height: 400,
        child: Column(
          children: [
            Text(operationTitle,style: TextStyle(fontSize: 30),),
            TextField( controller: titleController,decoration: InputDecoration(
              hintText: "Enter Title"
            ),),
            TextField( controller: descController,decoration: InputDecoration(
              hintText: "Enter desc"
            ),),
            ElevatedButton(
                onPressed: (){
                  var nTitle=titleController.text.toString();
                  var nDesc=descController.text.toString();
                  if(isUpdate){
                    updateNote(note_id!, nTitle, nDesc, context);

                  }else{
                    aDDPrNote(nTitle, nDesc, context);
                  }
                  Navigator.pop(context);
            },
                child: Text(operationTitle))


          ],
        ),
      ),
    );
  }
}
