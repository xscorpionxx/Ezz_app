import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/users/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Showpagelogic {
  var contexta;
  Showpagelogic(BuildContext context) {
    contexta = context;
  }
 void navigate() {
    Navigator.of(contexta).pop();
  }
  alertwait(){
   return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  alertmessage(message) {
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
                Navigator.of(context).pop();
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
  getshowpage(id,subcategories)async{
    if (await InternetConnectionChecker().hasConnection) {
      var url;
      if (subcategories != null) {
        url = Alertdialogazz.base_url+"providers/" + "$id" + "/1";
      }
      else {
        url = Alertdialogazz.base_url+"providers/" + "$id" + "/0";
      }
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      return body["providers"];
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  addtofav(id,Id,subcategories,context,ketchi,status)async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      var url;
      if(status=="1"){
        url = Alertdialogazz.base_url+"deleteFromfav";
      }else{
        url = Alertdialogazz.base_url+"addTofav";
      }
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {"product_id": id.toString()});
      var body = jsonDecode(response.body);
      Navigator.of(context).pop("dialog");
      if (body["status"].toString() == "true") {
        alertmessage(body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).getdatashowpage(
            Id, subcategories, contexta);
      }
      else {
        alertmessage(body["msg"]);
      }
    }else{
      Navigator.of(context).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  addtofavp(id,Id,subcategories,context,ketchi,status)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      var url;
      if(status=="1"){
        url = Alertdialogazz.base_url+"deleteFromfav";
      }else{
        url = Alertdialogazz.base_url+"addTofav";
      }
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {"product_id": id.toString()});
      var body = jsonDecode(response.body);
      Navigator.of(context).pop("dialog");
      if (body["status"].toString() == "true") {
        alertmessage(body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).updatepalce(
            context);
      }
      else {
        alertmessage(body["msg"]);
      }
    }
    else{
      Navigator.of(context).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  cancelfav(id, context,type)async{
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      var url = Alertdialogazz.base_url+"deleteFromfav";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response;
      if (type == "اماكن") {
        response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: {"place_id": id.toString()});
      } else {
        response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: {"product_id": id.toString()});
      }
      var body = jsonDecode(response.body);
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop("dialog");
      }
      if (body["status"].toString() == "true") {
        alertmessage(body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).getfav(
            context);
      }
      else {
        alertmessage(body["msg"]);
      }
    } else{
      Navigator.of(context).pop("dialog");
    Alertdialogazz.alertconnection(contexta);
    }}
  addtofavpalces(id,context,status)async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      var url;
      if(status=="1"){
        url = Alertdialogazz.base_url+"deleteFromfav";
      }else{
        url = Alertdialogazz.base_url+"addTofav";
      }
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {"place_id": id.toString()});
      var body = jsonDecode(response.body);
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop("dialog");
      }
      if (body["status"].toString() == "true") {
        alertmessage(body["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).updatepalce(
            context);
      }
      else {
        alertmessage(body["msg"]);
      }
    }else{
      Navigator.of(context).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
}