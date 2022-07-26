import 'package:costumerform/DBHelper.dart';
import 'package:costumerform/viewpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


class First extends StatefulWidget {

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  bool hindi = false;
  bool gujarati = false;
  bool english = false;
  bool marathi = false;

  TextEditingController dob = TextEditingController();
  DateTime selectedDate = DateTime.now();

  var select;
  int radioValue = -1;

  List listitem = [
    "Surat",
    "Vadodara",
    "Ahmedabad",
    "Junagadh",
    "Navsari",
    "Bhuj"
  ];

  TextEditingController tpassword = TextEditingController();
  TextEditingController tconfirmpassword = TextEditingController();
  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tphone = TextEditingController();
  Database? db;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late bool _passwordVisible;

  get handleRadioValueChange => null;
  @override
  void initState() {
    super.initState();

    _passwordVisible = false;

    DBHelper().createDatabase().then((value) {
      db = value;
    },);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child:Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key:  _formkey,
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Login Page",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: tname,
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Full Name"),
                      validator: ( value){
                        if(value!.isEmpty){
                          return "Please Enter Name";
                        }
                        if(!RegExp( r'^[a-z A-Z,.\-]+$').hasMatch(value)){
                          return 'Please enter valid full name';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: temail,
                      onChanged: (value) {
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: "Email"),
                      validator:(value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter Email";
                        }
                        if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                          return "Please Enter Valid Email";
                        }
                        return null;
                      },

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: tphone,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone Number"),
                      validator:(value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter Phone Number";
                        }
                        if(value.length<9){
                          return "Please Enter Valid Phone Number";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      new RadioListTile<int>(
                          title: new Text('Male'),
                          value: 0,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChange),
                      new RadioListTile<int>(
                          title: new Text('Female'),
                          value: 1,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChange),
                      new RadioListTile<int>(
                          title: new Text('Transgender'),
                          value: 2,
                          groupValue: radioValue,
                          onChanged: handleRadioValueChange),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          "Language",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                            onChanged: (value) {
                              setState(() {
                                hindi = value!;
                              });
                            },
                            value: hindi),
                        Text("Hindi"),
                        SizedBox(
                          width: 20,
                        ),

                        Checkbox(
                            onChanged: (value) {
                              setState(() {
                                gujarati = value!;
                              });
                            },
                            value: gujarati),
                        Text("Gujarati"),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 84,
                      ),
                      Checkbox(
                          onChanged: (value) {
                            setState(() {
                              english = value!;
                            });
                          },
                          value: english),
                      Text("English"),
                      SizedBox(
                        width: 8,
                      ),
                      Checkbox(
                          onChanged: (value) {
                            setState(() {
                              marathi = value!;
                            });
                          },
                          value: marathi),
                      Text("Marathi"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("City",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 60,
                        ),
                        DropdownButton(
                          hint: Text("Select City: "),
                          underline: Container(
                            height: 2,
                            color: Colors.blue,
                          ),
                          value: select,
                          onChanged: (value) {
                            setState(() {
                              select = value as String;
                            });
                          },
                          items: listitem.map((valueitem) {
                            return DropdownMenuItem(
                              value: valueitem,
                              child: Text(valueitem),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: dob,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Date of Birth",
                        suffixIcon: IconButton(
                            onPressed: () {
                              _selectDate(context);
                              setState(() {

                              });
                            },
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "PassWord",
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),),
                      controller: tpassword,
                      validator: (PassCurrentValue){
                        RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        var passNonNullValue=PassCurrentValue??"";
                        if(passNonNullValue.isEmpty){
                          return ("Password is required");
                        }
                        else if(passNonNullValue.length<6){
                          return ("Password Must be more than 5 characters");
                        }
                        else if(!regex.hasMatch(passNonNullValue)){
                          return ("Password should contain upper,lower,digit and Special character ");
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: !_passwordVisible,
                      
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Confirm Password"),
                      controller: tconfirmpassword,
                      validator:(value){
                        if(value!.isEmpty)
                        {
                          return "Please Enter re-password";
                        }
                        if(tpassword.text!=tconfirmpassword.text){
                          return "Password Do Not Match";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: () async {
                    String name = tname.text;
                    String email = temail.text;
                    String phone = tphone.text ;
                    String password = tpassword.text;
                    String confirmpassword = tconfirmpassword.text;

                    if(_formkey.currentState!.validate())
                    {
                     if(widget.method=="Submit"){


                       String qry = "INSERT INTO Test(name,phone,email,password,confirmpassword)  VALUES('$name','$phone','$email','$password','$confirmpassword')";
                       int id = await db!.rawInsert(qry);

                       print(id);

                       Navigator.push(context, MaterialPageRoute(builder: (context) {
                         return ViewPage();
                       },
                       ));
                       if(id>0)
                         {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return ViewPage();
                            },));
                         }
                       else {
                         print("Not Submited! Try Again");
                       }
                     }else{
                          String q="update Test set name ='$name',contact='$phone',email='$email',password='$password',confirmpassword='$confirmpassword'where id=${widget.map!['id']}";
                          int id = await db!.rawUpdate(q);
                          print("id=$id");
                          if(id==1)
                            {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return ViewPage();
                              },));
                            }
                     }
                    }else{
                      print("unsuccessfull");
                    }
                  }, child: Text("${widget.method}"))
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(

      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
    dob.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  }

}
