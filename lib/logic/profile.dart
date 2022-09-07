import 'dart:convert';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/orderdata2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:ezzproject/screens/users/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Profilelogic {
  var contexta;
  Profilelogic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
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
              child: InkWell(onTap: ()async{
                if(trues =="true"){
                  Provider.of<Notifires>(context,listen: false).getprofile(contexta,true);
                  Navigator.of(contexta).pop("dialog");
                  Navigator.of(contexta).pop();
                }
                else{
                  Navigator.of(context).pop("dialog");
                }
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  alertmessageprofile() {
    return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("سيتم تسجيل الخروج من الحساب ليتم تأكيده مرة اخرى",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: ()async{
                signout();
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  final googlesignin = GoogleSignIn();
  signout()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var type = sharedPreferences.getString("logintype");
      if (type == "google" || type == "facebook") {
        if (type == "google") {
          final googleusera = await googlesignin.currentUser;
          if (googleusera != null) {
            googleusera.clearAuthCache();
          }
        } else {
          final dataa = await FacebookAuth.instance..getUserData();
          await dataa.logOut();
          await FirebaseAuth.instance.signOut();
        }
        FirebaseAuth.instance.currentUser.delete();
        FirebaseAuth.instance.signOut();
      }
      sharedPreferences.clear();
      Provider.of<Notifires>(contexta, listen: false).dispose();
      FlutterRestart.restartApp();
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getnotypro()async{
   if(await InternetConnectionChecker().hasConnection) {
     SharedPreferences sharedPreferences = await SharedPreferences
         .getInstance();
     var url = Alertdialogazz.base_url+"provider_notifications";
     var token = sharedPreferences.getString("token");
     var response = await http.get(Uri.parse(url), headers: {
       'Authorization': 'Bearer $token',
     });
     var body = jsonDecode(response.body);
     return body["data"];
   }
   else{
     Alertdialogazz.alertconnection(contexta);
   }
  }
  delnotipro(id)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      var url;
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      if (id == null) {
        url = Alertdialogazz.base_url+"provider_delNotification";
      } else {
        url =
            Alertdialogazz.base_url+"provider_delNotification/" + id.toString();
      }
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (Navigator.canPop(contexta)) {
        Navigator.of(contexta).pop("dialog");
      }
      var body = jsonDecode(response.body);
      if (body["status"].toString() == "true") {
        Alertdialogazz.alert(contexta, body["msg"]);
        return "true";
      }
      else {
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getorderdetail(id)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      var url;
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
        url =
            Alertdialogazz.base_url+"orderDetails/$id";
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (Navigator.canPop(contexta)) {
        Navigator.of(contexta).pop("dialog");
      }
      var body = jsonDecode(response.body);
      if (body["status"].toString() == "true") {
        Navigator.of(contexta).push(
            MaterialPageRoute(builder: (contexta) {
              return Orderdata2(data: body["data"],);
            }));

      }
      else {
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getnoty()async{
    if(await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = Alertdialogazz.base_url+"notifications";
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      return body["data"];
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  delnoti(id)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      var url;
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      if (id == null) {
        url = Alertdialogazz.base_url+"delNotification";
      } else {
        url = Alertdialogazz.base_url+"delNotification/" + id.toString();
      }
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      if (Navigator.canPop(contexta)) {
        Navigator.of(contexta).pop("dialog");
      }
      var body = jsonDecode(response.body);
      if (body["status"].toString() == "true") {
        Alertdialogazz.alert(contexta, body["msg"]);
        return "true";
      }
      else {
        return "false";
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  List region1 = [];
  List region2 = [];
  List region3 = [];
  void update(name ,phone,  email,re1,re2,re3,photo)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      var id1;
      var id2;
      var id3;
      for (int f = 0; region1.length > f; f++) {
        if (region1[f]["name"].toString() == re1) {
          id1 = region1[f]["ID"];
        }
      }
      for (int f = 0; region2.length > f; f++) {
        if (region2[f]["name"].toString() == re2) {
          id2 = region2[f]["ID"];
        }
      }
      for (int f = 0; region3.length > f; f++) {
        if (region3[f]["name"].toString() == re3) {
          id3 = region3[f]["ID"];
        }
      }
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = Alertdialogazz.base_url+"Edit-Profile";
      var token = sharedPreferences.getString("token");
      var data;
      if (photo != null) {
        var request = new http.MultipartRequest("POST", Uri.parse(url));
        request.fields["Email"] = email.toString();
        request.fields["Governorate"] = id1.toString();
        request.fields["City"] = id2.toString();
        request.fields["Region"] = id3.toString();
        request.fields["PhoneNumber"] = phone.toString();
        request.fields["Name"] = name.toString();
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        });
        request.files.add(await http.MultipartFile.fromPath("ProfilePhoto",
            photo.path));
        await request.send().then((value) async {
          value.stream.transform(utf8.decoder).listen((event) async {
            Navigator.of(contexta).pop("dialog");
            var body = jsonDecode(event);
            if (body["status"] == true) {
              if(body["flag"].toString() =="1"){
                alertmessageprofile();
              }else {
                alertmessage("true", body["msg"]);
                sharedPreferences.setString("name", name);
                sharedPreferences.setString("phone", phone);
                sharedPreferences.setString("email", email);
                sharedPreferences.setString("region1", re1);
                sharedPreferences.setString("region2", re2);
                sharedPreferences.setString("region3", re3);
              }
            }
            else {
              alertmessage("false", body["msg"]);
            }
          });
        });
      }
      else {
        data = {
          "Name": name.toString(),
          "Email": email.toString(),
          "PhoneNumber": phone.toString(),
          "Governorate": id1,
          "City": id2,
          "Region": id3,
        };
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: data);
        var body = jsonDecode(response.body);
        Navigator.of(contexta).pop("dialog");
        if (body["status"] == true) {
          if(body["flag"].toString() =="1"){
            alertmessageprofile();
          }else {
            alertmessage("true", body["msg"]);
            sharedPreferences.setString("name", name);
            sharedPreferences.setString("phone", phone);
            sharedPreferences.setString("email", email);
            sharedPreferences.setString("region1", re1);
            sharedPreferences.setString("region2", re2);
            sharedPreferences.setString("region3", re3);
          } }
        else {
          alertmessage("false", body["msg"]);
        }
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  void complete(name ,phone,  email,re1,re2,re3,res1,res2,res3,key,type,token,pass,userid,tokenso)async{
    if (key.currentState.validate()) {
        fire.getToken().then((value)async {
          if(re1 !="المنطقة" &&re2 !="المدينة"&&re3 !="المحافظة"){
            alertwait();
            if(await InternetConnectionChecker().hasConnection) {
          var id1;
          var id2;
          var id3;
          for (int f = 0; res1.length > f; f++) {
            if (res1[f]["name"].toString() == re1) {
              id1 = res1[f]["ID"];
            }
          }
          for (int f = 0; res2.length > f; f++) {
            if (res2[f]["name"].toString() == re2) {
              id2 = res2[f]["ID"];
            }
          }
          for (int f = 0; res3.length > f; f++) {
            if (res3[f]["name"].toString() == re3) {
              id3 = res3[f]["ID"];
            }
          }
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          var url = Alertdialogazz.base_url+"Edit-Profile";
          var data;
          data = {
            "Name": name.toString(),
            "Email": email.toString(),
            "PhoneNumber": phone.toString(),
            "Governorate": id1,
            "City": id2,
            "Region": id3,
            "fb_token" : value.toString()
          };
          var response = await http.post(Uri.parse(url), headers: {
            'Authorization': 'Bearer $token',
          }, body: data);
          var body = jsonDecode(response.body);
          Navigator.of(contexta).pop("dialog");
          if (body["status"] == true) {
            sharedPreferences.setString("name", name);
            sharedPreferences.setString("phone", phone);
            sharedPreferences.setString("email", email);
            sharedPreferences.setString("re1", re1);
            sharedPreferences.setString("id", userid);
            sharedPreferences.setString("re2", re2);
            sharedPreferences.setString("re3", re3);
            sharedPreferences.setString("logintype", type);
            sharedPreferences.setString("token", token);
            sharedPreferences.setString("tokenso", tokenso);
            sharedPreferences.setString("password", pass);
            Navigator.of(contexta).popUntil((route) => route.isFirst);
            Navigator.of(contexta).pushReplacement(
                MaterialPageRoute(builder: (contexta) {
                  return Home();
                }));
          }
          else {
            Alertdialogazz.alert(contexta,body["msg"].toString() );
          }}else{
              Navigator.of(contexta).pop("dialog");
              Alertdialogazz.alertconnection(contexta);
            }
            }else{
            Alertdialogazz.alert(contexta,"يجب اختيار المكان بالشكل المناسب" );
          }
        });
        }
  }
  void update2(nationid,GlobalKey<FormState> key ,name ,phone,  email,storename,storecat,storesubcat,re1,re2,re3,region1back,region2back,region3back,photo,time11,time12,time21,time22,desc)async{
    if(key.currentState.validate()) {
      var id1;
      var id2;
      var id3;
      var idcat;
      var idsubcat;
      var workfrom;
      var workto;
      if (re1 != "المحافظة" && re2 != "المدينة" &&
          re3 != "المنطقة") {
        alertwait();
        if(await InternetConnectionChecker().hasConnection) {
          if (time12 != null && time22 != null ) {
            if(time12 != time22) {
              workfrom =time12 ;
              workto = time22 ;
              for (int f = 0; region1back.length > f; f++) {
                if (region1back[f]["name"].toString() == re1) {
                  id1 = region1back[f]["ID"];
                }
              }
              for (int f = 0; region2back.length > f; f++) {
                if (region2back[f]["name"].toString() == re2) {
                  id2 = region2back[f]["ID"];
                }
              }
              for (int f = 0; region3back.length > f; f++) {
                if (region3back[f]["name"].toString() == re3) {
                  id3 = region3back[f]["ID"];
                }
              }
              for (int f = 0; categories.length > f; f++) {
                if (categories[f]["Name"].toString() == storecat.toString()) {
                  idcat = categories[f]["ID"].toString();
                  if (storesubcat.toString() != "null") {
                    for (int s = 0; s <
                        categories[f]["SubCategories"].length; s++) {
                      if (categories[f]["SubCategories"][s]["Name"]
                          .toString() ==
                          storesubcat.toString()) {
                        idsubcat =
                            categories[f]["SubCategories"][s]["ID"].toString();
                      }
                    }
                  }
                }
              }
              SharedPreferences sharedPreferences = await SharedPreferences
                  .getInstance();
              var url = Alertdialogazz.base_url+"updateProviderProfile";
              var token = sharedPreferences.getString("token");
              var request = new http.MultipartRequest("POST", Uri.parse(url));
              request.fields["Email"] = email.toString();
              request.fields["Governorate"] = id1.toString();
              request.fields["City"] = id2.toString();
              request.fields["Region"] = id3.toString();
              if (photo != null) {
                request.files.add(
                    await http.MultipartFile.fromPath("StorePhoto",
                        photo.path));
              }
              request.fields["PhoneNumber"] = phone.toString();
              request.fields["desc"] = desc.toString();
              request.fields["Name"] = name.toString();
              request.fields["StoreName"] = storename.toString();
              if (workfrom
                  .toString()
                  .length == 5) {} else {
                workfrom = "0" + workfrom;
              }
              if (workto
                  .toString()
                  .length == 5) {} else {
                workto = "0" + workto;
              }
              request.fields["StoreWorkTo"] = workto.toString() + ":00";
              request.fields["StoreWorkFrom"] = workfrom.toString() + ":00";
              request.headers.addAll({
                'Authorization': 'Bearer $token',
              });
              await request.send().then((value) async {
                value.stream.transform(utf8.decoder).listen((event) async {
                  if (Navigator.canPop(contexta)) {
                    Navigator.of(contexta).pop("dialog");
                  }
                  var body = jsonDecode(event);
                  if (body["status"] == true) {
                    if(body["flag"].toString() =="1"){
                      alertmessageprofile();
                    }else {
                      alertmessage("true", body["msg"]);
                      sharedPreferences.setString("servicetype", storecat);
                      sharedPreferences.setString("name", name);
                      sharedPreferences.setString("phone", phone);
                      sharedPreferences.setString("email", email);
                      sharedPreferences.setString("region1", re1);
                      sharedPreferences.setString("region2", re2);
                      sharedPreferences.setString("region3", re3);
                    }
                  }
                  else {
                    Alertdialogazz.alert(contexta, body["msg"]);
                  }
                });
              });
            }else{
              Navigator.of(contexta).pop("dialog");
              Alertdialogazz.alert(contexta, "لا يمكن أن تكون الأوقات متماثلة");
            }
          }
          else {
            Navigator.of(contexta).pop("dialog");
            Alertdialogazz.alert(contexta, "يجب اختيار الوقت بالشكل الصحيح");
          }
        }else{
          Navigator.of(contexta).pop("dialog");
          Alertdialogazz.alertconnection(contexta);
        }
      }
      else {
        Alertdialogazz.alert( contexta,"يجب اختيار المحافظة والمدينة والمنطقة بالشكل الملائم");
      }
    }
    }
  getdata()async {
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = Alertdialogazz.base_url+"places";
      var response = await http.get(Uri.parse(url));
      var body = jsonDecode(response.body);
      for (int f = 0; f < body["data"].length; f++) {
        region1.add({
          "name": body["data"][f]["Name"],
          "ID": body["data"][f]["ID"].toString()
        });
        for (int g = 0; g < body["data"][f]["Cities"].length; g++) {
          region2.add({
            "name": body["data"][f]["Cities"][g]["Name"],
            "ID": body["data"][f]["Cities"][g]["ID"].toString()
          });
          for (int k = 0; k <
              body["data"][f]["Cities"][g]["Regions"].length; k++) {
            region3.add({
              "name": body["data"][f]["Cities"][g]["Regions"][k]["Name"],
              "ID": body["data"][f]["Cities"][g]["Regions"][k]["ID"].toString()
            });
          }
        }
      }
      var url2 = Alertdialogazz.base_url+"Data-Edit-User";
      var token = sharedPreferences.getString("token");
      var response2 = await http.get(Uri.parse(url2), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response2.body);
      return {
        "photo": body2["data"]["ProfilePhoto"],
        "name": body2["data"]["Name"],
        "phone": body2["data"]["PhoneNumber"],
        "email": body2["data"]["Email"],
        "re1": body2["data"]["Governorate"],
        "re2": body2["data"]["City"],
        "re3": body2["data"]["Region"],
        "listre1": region1,
        "listre2": region2,
        "listre3": region3
      };
    }else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  List categories =[];
  List subcatego = [
    {"1": []},
    {"2": []},
    {"3": []},
    {"4": []},
    {"5": []},
    {"6": []},
    {"7": []},
    {"8": []},
    {"9": []},
    {"10": []}
  ];
  getdata2()async {
    if(await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = Alertdialogazz.base_url+"places";
      var response = await http.get(Uri.parse(url));
      var body = jsonDecode(response.body);
      var url2 = Alertdialogazz.base_url+"home";
      var response2 = await http.get(Uri.parse(url2));
      var body2 = jsonDecode(response2.body);
      List subcats = [
        {"1": []},
        {"2": []},
        {"3": []},
        {"4": []},
        {"5": []},
        {"6": []},
        {"7": []},
        {"8": []},
        {"9": []},
        {"10": []}
      ];
      List cats = [];
      categories = body2["categories"]["cats"];
      for (int g = 0; g < categories.length; g++) {
        cats.add(categories[g]["Name"]);
        if (categories[g]["SubCategories"].toString() != "null") {
          for (int s = 0; s < categories[g]["SubCategories"].length; s++) {
            subcatego[g][(g + 1).toString()].add(
                categories[g]["SubCategories"][s]);
            subcats[g][(g + 1).toString()].add(
                categories[g]["SubCategories"][s]["Name"]);
          }
        }
      }
      return {
        "cat": cats,
        "subcats": subcats,
        "listre1": body["data"],
      };
    }
    else{
      Alertdialogazz.alertconnection(contexta);
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