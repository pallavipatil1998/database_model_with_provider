import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_modelclass_database/note_model.dart';
import 'package:provider_modelclass_database/note_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => NoteProvider(),
      child:const MyApp(),
    )
  );
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
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController= TextEditingController();
  var descController=TextEditingController();

  // AppDataBase myDB=AppDataBase.db;

  // List<NoteModel> notesList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInitialNotes(context);
  }

  //provider Functions
  void getInitialNotes(BuildContext context){
    context.read<NoteProvider>().pFetchInitialNote();
  }

  //provider function
  void aDDPrNote(String ptitle,String pdesc,BuildContext context)async{
    context.read<NoteProvider>().pAddNote(NoteModel(title: ptitle, desc: pdesc));
  }

  //model fun
  /*void showAllNotes()async{
    notesList=await myDB.fetchAllNotes();
    setState(() {

    });
  }*/

  //model fun
  /*void inserNotes(String title,String desc)async{
    bool check=await myDB.addNote(NoteModel(title: title, desc: desc));
    if(check){
      notesList=await myDB.fetchAllNotes();
      setState(() {

      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    getInitialNotes(context);
    return Scaffold(
      appBar: AppBar(title:Text("Home page"),),
      body: Consumer<NoteProvider>(
        builder: (_,provider,___){
          return ListView.builder(
            itemCount: provider.pGetNotes().length,
              itemBuilder: (ctx,index){
              var currData=provider.pGetNotes()[index];
                return ListTile(
                  title:  Text(currData.title),
                  subtitle: Text(currData.desc),
                  trailing: InkWell(
                     onTap: (){
                       provider.pDeleteNote(currData.note_id!);

                     },
                      child: Icon(Icons.delete)
                  ),
                );
              }
          );
        },
        /*child: ListView.builder(
          itemCount: notesList.length,
            itemBuilder: (ctx,index){
              return InkWell(
                onTap: (){
                  titleController.text=notesList[index].title;
                  descController.text= notesList[index].desc;
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx){
                        return Container(
                          child: Column(
                            children: [
                              Text("Update Notes"),
                              TextField(
                                controller: titleController,
                                decoration: InputDecoration(label: Text("Title")),
                              ),
                              TextField(
                                controller: descController,
                                decoration: InputDecoration(label: Text("desc")),
                              ),
                              ElevatedButton(
                                  onPressed: ()async{
                                    var nTitle=titleController.text.toString();
                                    var nDesc=descController.text.toString();
                                    await myDB.updateNote(NoteModel(note_id: notesList[index].note_id,title: nTitle, desc: nDesc));
                                    showAllNotes();
                                    Navigator.pop(context);

                                  },
                                  child: Text("Update")
                              )
                            ],
                          ),
                        );
                      }
                  );

                },



                child: ListTile(
                  title:Text("${notesList[index].title}"),
                  subtitle: Text("${notesList[index].desc}"),
                  trailing: InkWell(
                    onTap: (){
                      myDB.deleteNotes(notesList[index].note_id!);
                      showAllNotes();

                    },
                      child: Icon(Icons.delete)),

                ),
              );
            }
        ),*/
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
                            //provider fun
                           aDDPrNote(nTitle, nDesc, context);
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


