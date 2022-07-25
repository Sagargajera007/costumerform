import 'package:costumerform/DBHelper.dart';
import 'package:costumerform/first.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({Key? key}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  List<Map<String, Object?>> l = [];

  bool status = false;

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  getAllData() async {
    Database db = await DBHelper().createDatabase();

    String qry = "SELECT * FROM Test";
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

        return ListTile(leading: Text("${m['id']}"),
        title: Text("${m['name']}"),
          trailing: IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return First("Update");
            },));
          }, icon: Icon(Icons.edit)),
        );
      },):Center(child: Text("No Data Found")))
    :Center(child: CircularProgressIndicator(),));
  }
}
