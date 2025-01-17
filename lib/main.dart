import 'package:flutter/material.dart';
import 'package:provider_modelclass_database/appdatabase.dart';
import 'package:provider_modelclass_database/note_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage()
    );
  }
}
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController= TextEditingController();

  var descController=TextEditingController();

  AppDataBase myDB=AppDataBase.db;

  List<NoteModel> notesList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showAllNotes();
    setState(() {

    });
  }

  void showAllNotes()async{
    notesList=await myDB.fetchAllNotes();
    setState(() {

    });
  }

  void inserNotes(String title,String desc)async{
    bool check=await myDB.addNote(NoteModel(title: title, desc: desc));
    if(check){
      notesList=await myDB.fetchAllNotes();
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Home page"),),
      body: ListView.builder(
        itemCount: notesList.length,
          itemBuilder: (ctx,index){
            return ListTile(
              title:Text("${notesList[index].title}"),
              subtitle: Text("${notesList[index].desc}"),
              trailing: InkWell(
                onTap: (){
                  myDB.deleteNotes(notesList[index].note_id!);
                  showAllNotes();

                },
                  child: Icon(Icons.delete)),

            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              builder: (ctx){
                return Container(
                  child: Column(
                    children: [
                      Text("ADD Notes"),
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(label: Text("Title")),
                      ),
                      TextField(
                        controller: descController,
                        decoration: InputDecoration(label: Text("desc")),
                      ),
                      ElevatedButton(
                          onPressed: (){
                            var nTitle=titleController.text.toString();
                            var nDesc=descController.text.toString();
                            inserNotes(nTitle, nDesc);
                            setState(() {

                            });
                            titleController.clear();
                            descController.clear();
                            Navigator.pop(context);

                          },
                          child: Text("Add")
                      )
                    ],
                  ),
                );
              }
          );
        },
        child: Icon(Icons.add)
      ),
    );
  }
}


