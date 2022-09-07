import 'dart:convert';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/screens/users/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Recommendlogic {
  var contexta;
  Recommendlogic(BuildContext context) {
    contexta = context;
  }
  String validateemail(String value) {
    RegExp exp = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (exp.hasMatch(value)) {
      return null;
    }
    else {
      return "البريد الالكتروني خاطئ";
    }
  }
  String validate(String value){
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  alertmessage(trues,message) {
    return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text(message,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: (){
                Navigator.of(context).pop("dialog");
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
    sendcomplaints(name,email,msg,GlobalKey<FormState> key)async {
      if (key.currentState.validate()) {
        alertwait();
        if (await InternetConnectionChecker().hasConnection) {
          var url = Alertdialogazz.base_url+"support";
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          var token = sharedPreferences.getString("token");
          var data = {
            "Name": name.toString(),
            "Email": email.toString(),
            "Message": msg.toString()
          };
          var response = await http.post(Uri.parse(url), headers: {
            'Authorization': 'Bearer $token',
          }, body: data);
          var body = jsonDecode(response.body);
          Navigator.of(contexta).pop("dialog");
          if (body["status"] == true) {
            alertmessage("true", body["msg"]);
          }
          else {
            alertmessage("false", body["msg"]);
          }
        }
        else{
          Navigator.of(contexta).pop("dialog");
          Alertdialogazz.alertconnection(contexta);
        }
      }
    }

}