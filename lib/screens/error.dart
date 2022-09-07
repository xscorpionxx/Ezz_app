import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Loginpage.dart';
class Erroralert extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statealert();
  }
}
class Statealert extends State<Erroralert>{
  void Navigatetologin(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
      return Loginpage();
    }));
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Center(child: Container(height: MediaQuery.of(context).size.height*0.2,
      child: Column(children: [
        Container(child: Text("تأكد من الاتصال بالانترنت وأعد التسجيل مرة أخرى",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),),),
        Container(child: ElevatedButton(onPressed: Navigatetologin,child: Text("تسجيل الدخول",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025))),)
      ],),
    ),),);
  }
}