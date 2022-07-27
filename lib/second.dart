import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class Second extends StatefulWidget {
  Map? map;
  String? method;

  Second(this.method, {this.map});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {

  TextEditingController tpassword = TextEditingController();
  TextEditingController tconfirmpassword = TextEditingController();
  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tphone = TextEditingController();
  Database? db;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    if(widget.method == "Update"){
      tname.text = widget.map!['name'];
      temail.text = widget.map!['email'];
      tphone.text = widget.map!['phone'];
      tpassword.text = widget.map!['password'];
      tconfirmpassword.text = widget.map!['confirmpassword'];
    }
    }
  @override
  Widget build(BuildContext context) {
    return
  }
}
