import 'dart:convert';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/codeconirmation.dart';
import 'package:ezzproject/screens/complete.dart';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:ezzproject/screens/users/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Loginlogic {
  var contexta;

  Loginlogic(BuildContext context) {
    contexta = context;
  }

  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }

  alertmessage(message) {
    return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content: Container(padding: EdgeInsets.all(MediaQuery
            .of(context)
            .size
            .width * 0.02), height: MediaQuery
            .of(context)
            .size
            .height * 0.2, child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery
                .of(context)
                .size
                .height * 0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(child: FittedBox(child: new Text(
                    message, style: TextStyle(fontSize: MediaQuery
                      .of(context)
                      .textScaleFactor * 20, fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.05),
              child: InkWell(onTap: () {
                Navigator.of(context).maybePop();
              }, child: Container(width: MediaQuery
                  .of(context)
                  .size
                  .width, padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.02), decoration: BoxDecoration(color: Colors
                  .green), child: Center(child: Text("حسنا",
                style: TextStyle(color: Colors.white, fontSize: MediaQuery
                    .of(context)
                    .size
                    .width * 0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }

  void savedata(token, name, phone, password, email, re1, re2, re3) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("phone", phone);
    sharedPreferences.setString("password", password);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("region1", re1);
    sharedPreferences.setString("region2", re2);
    sharedPreferences.setString("region3", re3);
  }

  void navigatetomain() {
    Navigator.of(contexta).pushReplacement(
        MaterialPageRoute(builder: (contexta) {
          return Home();
        }));
  }

  void navigatetosignup() {
    print("go");
    Navigator.of(contexta).push(
        MaterialPageRoute(builder: (contexta) {
          return Signup();
        }));
  }

  alertwait() {
    showDialog(
        barrierDismissible: false, context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(width: 30, height: 30,
            child: Center(child: SizedBox(
                width: 30, height: 30, child: CircularProgressIndicator()))),
      );
    });
  }
  void loginasguest() async {
    fire.getToken().then((value)async {
      print(value);
    });
    var guest_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXp6LWFwcC5jb21cL2FwaVwvbG9naW4iLCJpYXQiOjE2NjE3NzEzODgsIm5iZiI6MTY2MTc3MTM4OCwianRpIjoiZEtxblZ3UDhkakhWN3MzSCIsInN1YiI6MzA0LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.-7BfnCVk--47N9DuGfjkqD_pe0kU-9YJFIG-gpRe5Sc';
    SharedPreferences sharedPreferences = await SharedPreferences
        .getInstance();
    sharedPreferences.setString(
        "token", guest_token);
    Provider.of<Notifires>(contexta,listen: false).setguestmode();
    Navigator.of(contexta).push(
        MaterialPageRoute(builder: (contexta) {
          return Home();
        }));
  }


  final FirebaseMessaging fire = FirebaseMessaging.instance;
  void login(GlobalKey<FormState> key, email, password) async {
    if (key.currentState.validate()) {
     fire.getToken().then((value)async {
       alertwait();
       if (await InternetConnectionChecker().hasConnection) {
         var data = {
           "phone": email.toString(),
           "password": password.toString(),
           "fb_token": value.toString()
         };
         var url = Alertdialogazz.base_url+"login";
         var response = await http.post(Uri.parse(url), body: data);
         var body = jsonDecode(response.body);
         Navigator.of(contexta).pop();
         if (body["status"] == true) {
           await savedata(
               body["data"]["API_Key"],
               body["data"]["Name"],
               body["data"]["PhoneNumber"].toString(),
               password,
               email,
               body["data"]["Governorate"].toString(),
               body["data"]["City"].toString(),
               body["data"]["Region"].toString());
           if (body["data"]["Type"] == "تاجر") {
             SharedPreferences sharedPreferences = await SharedPreferences
                 .getInstance();
             sharedPreferences.setString(
                 "servicetype", body["data"]["StoreCat"]);
             if (body["data"]["StoreSubCatType"].toString() == "1") {
               sharedPreferences.setString("servicetypespec", "true");
             }
             sharedPreferences.setString("id", body["data"]["ID"].toString());
             if (body["data"]["AccountStatus"].toString().trim() == "2") {
               Navigator.of(contexta).popUntil((route) => route.isFirst);
               Navigator.of(contexta).pushReplacement(
                   MaterialPageRoute(builder: (contexta) {
                     return Codeconf(
                       phone: body["data"]["PhoneNumber"].toString(),
                       type: body["data"]["Type"],);
                   }));
             } else {
               Navigator.of(contexta).popUntil((route) => route.isFirst);
               Navigator.of(contexta).pushReplacement(
                   MaterialPageRoute(builder: (contexta) {
                     return Home2();
                   }));
             }
           }
           else {
             SharedPreferences sharedPreferences = await SharedPreferences
                 .getInstance();
             sharedPreferences.setString("id", body["data"]["ID"].toString());
             if (body["data"]["AccountStatus"].toString().trim() == "2") {
               Navigator.of(contexta).popUntil((route) => route.isFirst);
               Navigator.of(contexta).pushReplacement(
                   MaterialPageRoute(builder: (contexta) {
                     return Codeconf(
                       phone: body["data"]["PhoneNumber"].toString(),
                       type: body["data"]["Type"],);
                   }));
             } else {
               Navigator.of(contexta).popUntil((route) => route.isFirst);
               Navigator.of(contexta).pushReplacement(
                   MaterialPageRoute(builder: (contexta) {
                     return Home();
                   }));
             }
           }
         }
         else {
           alertmessage(body["msg"].toString());
         }
       }
       else{
         Navigator.of(contexta).pop("dialog");
         Alertdialogazz.alertconnection(contexta);
       }
     });
         }
  }
}