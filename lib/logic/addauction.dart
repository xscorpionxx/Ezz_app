import 'dart:convert';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Addauctionlogic {
  var contexta;

  Addauctionlogic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  void navigatetomain() {
    Navigator.of(contexta).popUntil((route) => route.isFirst);
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home2();
        }));
  }
  void navigatetosignup() {
    Navigator.of(contexta).push(
        MaterialPageRoute(builder: (contexta) {
          return Signup();
        }));
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  editauction(id,GlobalKey<FormState> key, desc , price,type ,photoa)async{
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        if(type !=null) {
          alertwait();
          if (await InternetConnectionChecker().hasConnection) {
            var url = Alertdialogazz.base_url+"updateAuction/" + id.toString();
            var token = sharedPreferences.getString("token");
            var request = new http.MultipartRequest("POST", Uri.parse(url));
            request.fields["desc"] = desc.toString();
            request.fields["type"] = type.toString();
            request.fields["start_price"] = price.toString();
            if (photoa != null) {
              request.files.add(await http.MultipartFile.fromPath("photo",
                  photoa.path));
            }
            request.headers.addAll({
              'Authorization': 'Bearer $token',
            });
            var response = await request.send().then((value) {
              value.stream.transform(utf8.decoder).listen((event) async {
                var body = jsonDecode(event);
                print(body);
                Navigator.of(contexta).pop("dialog");
                if (body["status"] == true) {
                  Alertdialogazz.alertservices(contexta, body["msg"]);
                }
                else {
                  Alertdialogazz.alert(contexta, body["msg"]);
                }
              });
            });
          }else{
            Navigator.of(contexta).pop("dialog");
            Alertdialogazz.alertconnection(contexta);
          }
        }else{
          Alertdialogazz.alert(contexta, "يجب اختيار نمط المزاد");
        }
      }
  addauction(GlobalKey<FormState> key, desc ,photoa , start ,end,type,price)async{
    if(key.currentState.validate()) {
      if(photoa ==null){
        Alertdialogazz.alert(contexta,"يجب اختيار الصورة للمناسبة");
      }
      else {
        if (type != null) {
          if (start != null && end != null) {
            alertwait();
            if (await InternetConnectionChecker().hasConnection) {
              SharedPreferences sharedPreferences = await SharedPreferences
                  .getInstance();
              var url = Alertdialogazz.base_url+"addAuction";
              var token = sharedPreferences.getString("token");
              var request = new http.MultipartRequest("POST", Uri.parse(url));
              request.fields["desc"] = desc.toString();
              request.fields["type"] = type.toString();
              request.fields["start_price"] = price.toString();
              request.fields["start_date"] =
                  start.toString().replaceAll("-", "/");
              request.fields["end_date"] = end.toString().replaceAll("-", "/");
              request.fields["status"] = "1";
              request.files.add(await http.MultipartFile.fromPath("photo",
                  photoa.path));
              request.headers.addAll({
                'Authorization': 'Bearer $token',
              });
              var response = await request.send().then((value) {
                value.stream.transform(utf8.decoder).listen((event) async {
                  var body = jsonDecode(event);
                  Navigator.of(contexta).pop("dialog");
                  if (body["status"] == true) {
                    Alertdialogazz.alertservices(contexta, body["msg"]);
                  }
                  else {
                    Alertdialogazz.alert(contexta, body["msg"]);
                  }
                });
              });
            }else{
              Navigator.of(contexta).pop("dialog");
              Alertdialogazz.alertconnection(contexta);
            }
          } else {
            Alertdialogazz.alert(
                contexta, "يجب اختيار تاريخ البدء والانتهاء للمزاد");
          }
        }
        else{
             Alertdialogazz.alert(contexta, "يجب اختيار عنوان المزاد");
        }
      }
    }
  }
}