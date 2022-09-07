import 'dart:convert';
import 'package:ezzproject/screens/signup.dart';
import 'package:ezzproject/screens/users/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertdialog.dart';
class Changepasslogic {
  var contexta;

  Changepasslogic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  var stringa ;
  var oldpassword;
  String validatepassword(String value) {
    stringa = value;
    if (value.length < 6) {
      return 'كلمة السر يجب أن تكون أكثر من 6 خانات!';
    }
    if (value.isEmpty) {
      return 'لا يمكن أن تكون كلمة السر فارغة';
    }
    return null;
  }

  String validatepasswordre(String value) {
    if (value != stringa) {
      return 'لا يوجد تطابق بين كلمتي السر';
    }
    return null;
  }

  String validatepasswordpast(String value) {
    if (value !=oldpassword ) {
      return 'كلمة السر خاطئة';
    }
    return null;
  }
  void updatepass(password,passwordre ,GlobalKey<FormState> key)async{
    if(key.currentState.validate()) {
      alertwait();
      if (await InternetConnectionChecker().hasConnection) {
        var url = Alertdialogazz.base_url+"updatePassword";
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var token = sharedPreferences.getString("token");
        var data =
        {"Password": password,
          "Password_confirmation": passwordre,
        };
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: data);
        var body = jsonDecode(response.body);
        Navigator.of(contexta).pop("dialog");
        if (body["status"] == true) {
          Navigator.of(contexta).pop();
          Alertdialogazz.alert(contexta, body["msg"]);
          sharedPreferences.setString("password", password.toString());
        }
        else {
          Alertdialogazz.alert(contexta, body["msg"]);
        }
      }else{
        Navigator.of(contexta).pop();
        Alertdialogazz.alertconnection(contexta);
      }
    }
  }
  void navigatetomain() {
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home();
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
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
}