import 'package:flutter/material.dart';

import 'model.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<user>userslist=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userslist=Users;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("ReOrderableList"),),
      body: ReorderableListView.builder(
        physics:const  NeverScrollableScrollPhysics(),
        onReorder: (oldIndex,newIndex){
          final index = newIndex > oldIndex ? newIndex - 1 : newIndex;

          final user = userslist.removeAt(oldIndex);
          userslist.insert(index, user);

        },
        itemCount: userslist.length,
          itemBuilder: (context,index){
        return Padding(
          key: ValueKey(index),
          padding: const EdgeInsets.all(8.0),
          child: ListTile(

            leading: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(userslist[index].image),
            ),
            title: Text(userslist[index].name),
          subtitle: Text(index.toString()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(onPressed: (){
                edit(index);

              }, icon: Icon(Icons.edit)),
              IconButton(onPressed: (){
                remove(index);
              }, icon: Icon(Icons.delete))
            ],
          ),
          ),

        );
      }),
      );

  }
  void edit(int index) => showDialog(
    context: context,
    builder: (context) {
      final user =
      userslist[index];

      return AlertDialog(
        content: TextFormField(
          initialValue: user.name,
          onFieldSubmitted: (_) => Navigator.of(context).pop(),
          onChanged: (name) => setState(() => user.name = name),
        ),
      );
    },
  );

  void remove(int index){
    setState(() {
      userslist.removeAt(index);
    });
  }
}
