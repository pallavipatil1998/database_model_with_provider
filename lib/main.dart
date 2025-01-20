import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_modelclass_database/add_update_note.dart';
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


  //provider Functions
  void getInitialNotes(BuildContext context){
    context.read<NoteProvider>().pFetchInitialNote();
  }

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
              print(currData);
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>AddUpdateNote(isUpdate: true,note_id: currData.note_id,title: currData.title,desc: currData.desc,),));
                  },
                  child: ListTile(
                    title:  Text(currData.title),
                    subtitle: Text(currData.desc),
                    trailing: InkWell(
                       onTap: (){
                         provider.pDeleteNote(currData.note_id!);

                       },
                        child: Icon(Icons.delete)
                    ),
                  ),
                );
              }
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) => AddUpdateNote(isUpdate: false,),));

        },
        child: Icon(Icons.add)
      ),
    );
  }
}


