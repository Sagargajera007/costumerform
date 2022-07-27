import 'package:costumerform/DBHelper.dart';
import 'package:costumerform/first.dart';
import 'package:costumerform/second.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List<Map<String, Object?>> l = List.empty(growable: true);

  bool status = false;
  Database? db;

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  getAllData() async {
    Database db = await DBHelper().createDatabase();

    String qry = "SELECT * FROM Test";
    List<Map<String,Object?>> x = await db.rawQuery(qry);
    l.addAll(x);
    l = await db.rawQuery(qry);

    print(l);

    status = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Data"),
      ),
      body: status?(l.length>0?ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        Map m = l[index];

        return ListTile(onLongPress:(){
          showDialog(builder: (context) {
            return AlertDialog(title: Text("Delete"),
              content: Text("are you sure want to delete this contact"),
              actions: [TextButton(onPressed: () {
                int id = m['id'];
                String q = "DELETE FROM Test WHERE id = '$id'";
                db!.rawDelete(q).then((value) {

                  setState((){
                    l.removeAt(index);
                  });
                },);
              }, child: Text("Yes")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("No"))
              ],
            );
          },context: context);
        } ,leading: Text("${m['id']}"),
        title: Text("${m['name']}"),
          trailing: IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Second("Update",map: m,);
            },));
          }, icon: Icon(Icons.edit)),
        );
      },):Center(child: Text("No Data Found")))
    :Center(child: CircularProgressIndicator(),));
  }
}
