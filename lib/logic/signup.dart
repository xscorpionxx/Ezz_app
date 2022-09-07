import 'dart:convert';
import 'dart:io';
import 'package:ezzproject/screens/codeconirmation.dart';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:ezzproject/screens/users/home.dart';
import 'package:ezzproject/screens/users/showimages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertdialog.dart';
class Signuplogic {
  var contexta;
  Signuplogic(BuildContext context) {
    contexta = context;
  }
  List subcategoreis = [];
  List categories = [];
  List region1 =[];
  List region2 =[];
  List region3 =[];
  var stringa;
  // هدول الدوال مشان التأكد من الاسم وكلمة السر وباقي المعلومات
  String validateemail(String value) {
    if (value.length>8) {
      return null;
    }
    else {
      return "البريد الالكتروني خاطئ";
    }
  }

  String validatepassword(String value) {
    stringa = value;
    if (value.length < 6) {
      return 'كلمة السر يجب أن تكون أكثر من 6 خانات';
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

  String validatename(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الاسم فارغ';
    }
    return null;
  }
  String validateid(String value) {
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي رقم الهوية فارغ';
    }
    if (value.length !=10){
      return 'يجب أن يكون رقم الهوية مكون من 10 خانات';
    }
    return null;
  }
  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يمكنك ترك الرقم فارغ!';
    }
    else if (!regExp.hasMatch("+966"+value)) {
      return 'هذا الرقم غير صالح!';
    }
    return null;
  }

  void navigate() {
    Navigator.of(contexta).pop();
  }
  viewrules()async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      var url1 = Alertdialogazz.base_url+"appInfo";
      var response1 = await http.get(Uri.parse(url1));
      var body1 = jsonDecode(response1.body);
      Navigator.of(contexta).pop("dialog");
      return showDialog(context: contexta, builder: (context) {
        return AlertDialog(insetPadding: EdgeInsets.all(20),
          //contentPadding: EdgeInsets.all(10),
          content: Container(padding: EdgeInsets.all(MediaQuery
              .of(context)
              .size
              .width * 0.02), height: MediaQuery
              .of(context)
              .size
              .height * 0.7,
            child: Column(children: [
              Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(child: FittedBox(child: new Text(
                      "الشروط والاحكام", style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),)))),
              ),
              Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Center(child: SingleChildScrollView(child: new Text(
                        body1["categories"]["terms_and_conditions"],
                        style: TextStyle(fontSize: 14))))),
              ), Spacer(),
              Container(margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05),
                child: InkWell(onTap: () {
                  Navigator.of(context).pop();
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
            ],),),
        );
      });
    }else{
      Navigator.of(contexta).pop();
      Alertdialogazz.alertconnection(contexta);
    }
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
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
  resendcode(phone)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      var url = Alertdialogazz.base_url+"resendCodeConfirm";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {"phone": phone});
      Navigator.of(contexta).pop("dialog");
      var body = jsonDecode(response.body);
      return body;
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  confirm(code, phone,GlobalKey<FormState> key,type)async{
    if(key.currentState.validate()) {
      alertwait();
      if (await InternetConnectionChecker().hasConnection) {
        var url = Alertdialogazz.base_url+"confirmPhone";
        SharedPreferences sharedPreferences = await SharedPreferences
            .getInstance();
        var token = sharedPreferences.getString("token");
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: {"phone": phone, "code": code});
        Navigator.of(contexta).pop("dialog");
        var body = jsonDecode(response.body);
        if (body["status"].toString() == "true") {
          if (type == "تاجر") {
            Navigator.of(contexta).popUntil((route) => route.isFirst);
            Navigator.of(contexta).pushReplacement(
                MaterialPageRoute(builder: (contexta) {
                  return Home2();
                }));
          }
          else {
            Navigator.of(contexta).popUntil((route) => route.isFirst);
            Navigator.of(contexta).pushReplacement(
                MaterialPageRoute(builder: (contexta) {
                  return Showimages();
                }));
          }
        }
        else {
          Alertdialogazz.alert(contexta, body["msg"]);
        }
      }else{
        Navigator.of(contexta).pop("dialog");
        Alertdialogazz.alertconnection(contexta);
      }
    }
}
signupproviderfinal(pledge,email ,password ,region11 ,region21,region31,type ,cat,subcat,idsubcat,phone,name
      ,id,stroename,photo,fbtoken,cooker,checkvalue,setState,text)async{
    if(checkvalue ==true){
      if(Navigator.canPop(contexta)){
        Navigator.of(contexta).pop("dialog");
      }
      alertwait();
      var url = Alertdialogazz.base_url+"register";
      var request = new http.MultipartRequest("POST", Uri.parse(url));
      request.fields["email"] = email.toString();
      request.fields["password"] = password.toString();
      request.fields["password_confirmation"] = password.toString();
      request.fields["governorate_id"] = region11.toString();
      request.fields["city_id"] = region21.toString();
      request.fields["region_id"] = region31.toString();
      request.fields["type"] = type.toString();
      request.fields["cat_id"] = cat.toString();
      if(subcat.toString() !="null"){
        request.fields["subcat_id"] = idsubcat.toString();
      }
      request.fields["fb_token"] =fbtoken.toString();
      request.fields["phone"] = phone.toString();
      request.fields["name"] = name.toString();
      request.fields["national_number"] = id.toString();
      request.fields["store_name"] = stroename.toString();
      request.files.add(await http.MultipartFile.fromPath("store_photo",
          photo.path));
    await request.send().then((value) async {
    value.stream.transform(utf8.decoder).listen((event) async {
    if(Navigator.canPop(contexta)){
    Navigator.of(contexta).pop("dialog");
    }
    var body = jsonDecode(event);
    if (body["status"] == true) {
    await savedata(
    body["data"]["API_Key"].toString(),
    name,
    phone,
    password,
    email,
    body["data"]["Governorate"],
    body["data"]["City"],
    body["data"]["Region"]);
    if (body["data"]["Type"] == "تاجر") {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("servicetype", body["data"]["StoreCat"]);
    sharedPreferences.setString("servicetypespec", cooker.toString());
    sharedPreferences.setString("id", body["data"]["ID"].toString());
    Navigator.of(contexta).popUntil((route) => route.isFirst);
    Navigator.of(contexta).pushReplacement(
    MaterialPageRoute(builder: (contexta) {
    return Codeconf(phone: body["data"]["PhoneNumber"].toString(),
    type:body["data"]["Type"] ,);
    }));
    }}
    else {
    alertmessage( body["msg"]);
    }
    });
    });}
    else{
    setState((){
    text =true;
    });
    }}
  alertswearing(pledge,email ,password ,region11 ,region21,region31,type ,cat,subcat,idsubcat,phone,name
      ,id,stroename,photo,fbtoken,cooker){
      var checkvalue = false;
      var text = false;
      return showDialog(context: contexta, builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(insetPadding: EdgeInsets.only(right: 50,left: 50),
              contentPadding: EdgeInsets.zero,
              content: Container(padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.02), height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.33,
                child: Column(children: [ Container(
                  child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: CheckboxListTile(activeColor: Colors.green,title: Container(
                          child: Directionality(textDirection: TextDirection.rtl,
                            child: SingleChildScrollView(
                              child: Text(
                                  pledge,maxLines: 8,
                                  style: TextStyle(fontSize: MediaQuery
                                      .of(context)
                                      .textScaleFactor * 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                      ),
                        value: checkvalue,
                        onChanged: (val) {
                          setState(() {
                            checkvalue = val;
                          });
                        },)),
                ),
                 Container(child: text?Container(child: FittedBox(child: Text("لا يمكنك الاكمال دون التعهد ",style: TextStyle(color: Colors.red,fontSize: MediaQuery.of(context).textScaleFactor*13),)),):Container(),),
                  Spacer(),Container(margin: EdgeInsets.only(bottom: 20),
                    child: InkWell(onTap: ()async =>signupproviderfinal(pledge, email, password, region11, region21, region31, type, cat, subcat, idsubcat, phone, name, id, stroename, photo, fbtoken, cooker, checkvalue, setState, text)
                        , child: Container(height: 40,width: MediaQuery
                        .of(context)
                        .size
                        .width,
                      margin: EdgeInsets.only(left: MediaQuery
                          .of(context)
                          .size
                          .width * 0.1,right:MediaQuery
                          .of(context)
                          .size
                          .width * 0.1 ),
                      decoration: BoxDecoration(color: Colors.green),
                      child: Center(child: Text("تم", style: TextStyle(
                          color: Colors.white, fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.03),),),)),
                  )
                ],),),
            );
          },
        );
      });
  }
  alertmessagereg(able,message) {
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
                if(able){
                 SystemNavigator.pop();
                }
                else {
                  Navigator.of(context).pop();
                }       },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  void savedata(token ,name ,phone, password, email,re1,re2,re3)async{
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
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
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
  getplaces()async{
    if(await InternetConnectionChecker().hasConnection) {
      var url = Alertdialogazz.base_url+"places";
      var response = await http.get(Uri.parse(url));
      var body = jsonDecode(response.body);
      var url2 = Alertdialogazz.base_url+"home";
      var response2 = await http.get(Uri.parse(url2));
      var body2 = jsonDecode(response2.body);
      List cats = [];
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
      categories = body2["categories"]["cats"];
      for (int g = 0; g < categories.length; g++) {
        if (categories[g]["Name"].toString() == "مزاد") {
          categories.removeAt(g);
        }
      }
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
      return {"1": body["data"], "cat": cats, "subcats": subcats};
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
   sendforget(GlobalKey<FormState> key,email,type)async{
     alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      if(type=="1") {
        var data = {
          "phone": email.toString(),
        };
        var url = Alertdialogazz.base_url+"sendForgetCode";
        var response = await http.post(Uri.parse(url), body: data);
        var body = jsonDecode(response.body);
        Navigator.of(contexta).pop("dialog");
        if (body["status"]) {
          return true;
        } else {
          Alertdialogazz.alert(contexta, body["msg"]);
          return false;
        }
      }
      else {
        if (key.currentState.validate()) {
          var data = {
            "phone": email.toString(),
          };
          var url = Alertdialogazz.base_url+"sendForgetCode";
          var response = await http.post(Uri.parse(url), body: data);
          var body = jsonDecode(response.body);
          Navigator.of(contexta).pop("dialog");
          if (body["status"]) {
            return true;
          } else {
            Alertdialogazz.alert(contexta, body["msg"]);
            return false;
          }
        }
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  reset(code,email,pass,GlobalKey<FormState> key)async{
    if(key.currentState.validate()) {
      alertwait();
      if (await InternetConnectionChecker().hasConnection) {
        var data = {
          "phone": email.toString(),
          "code": code.toString(),
          "password": pass
        };
        var url = Alertdialogazz.base_url+"resetPassword";
        alertwait();
        var response = await http.post(Uri.parse(url), body: data);
        var body = jsonDecode(response.body);
        Navigator.of(contexta).pop("dialog");
        if (body["status"]) {
          Alertdialogazz.alertgotologin(contexta, body["msg"]);
          return true;
        } else {
          Alertdialogazz.alert(contexta, body["msg"]);
          return false;
        }
      }
      else {
        Navigator.of(contexta).pop("dialog");
        Alertdialogazz.alertconnection(contexta);
      }
    }
  }
  final FirebaseMessaging fire = FirebaseMessaging.instance;
  void signup(type,GlobalKey<FormState> key, email, password, repassword, name,
      phone, region11, region21, region31, region1back , region2back,region3back ,stroename, id,File photo, fptoken , cat,subcat,accept ){
     if (key.currentState.validate()) {
       fire.getToken().then((value) async {
         if (await InternetConnectionChecker().hasConnection) {
           print(region11 + region21 + region31);
           if (region11 != "المحافظة" && region21 != "المدينة" &&
               region31 != "المنطقة") {
             if (accept) {
               print(region3);
               for (int f = 0; f < region1back.length; f++) {
                 if (region1back[f]["name"].toString() == region11) {
                   region11 = region1back[f]["ID"].toString();
                 }
               }
               for (int s = 0; s < region2back.length; s++) {
                 if (region2back[s]["name"].toString() == region21) {
                   region21 = region2back[s]["ID"].toString();
                 }
               }
               for (int f = 0; f < region3back.length; f++) {
                 if (region3back[f]["name"].toString() == region31) {
                   region31 = region3back[f]["ID"].toString();
                 }
               }
               var idsubcat;
               bool cooker = false;
               for (int f = 0; f < categories.length; f++) {
                 if (categories[f]["Name"].toString() == cat) {
                   cat = categories[f]["ID"].toString();
                   if (subcat.toString() != "null") {
                     for (int s = 0; s <
                         categories[f]["SubCategories"].length; s++) {
                       if (categories[f]["SubCategories"][s]["Name"]
                           .toString() ==
                           subcat.toString()) {
                         idsubcat =
                             categories[f]["SubCategories"][s]["ID"].toString();
                         if (categories[f]["SubCategories"][s]["Type"]
                             .toString() ==
                             "1") {
                           cooker = true;
                         }
                       }
                     }
                   }
                 }
               }
               var type = "1";
               if (stroename == "" && id == "" && photo == null) {
                 type = "0";
               }
               var data;
               if (type == "1") {
                 if (photo != null) {
                   alertwait();
                   var url2 = Alertdialogazz.base_url+"appInfo";
                   var response2 = await http.get(Uri.parse(url2));
                   var body2 = jsonDecode(response2.body);
                   Navigator.of(contexta).pop("dialog");
                   alertswearing(
                       body2["categories"]["pledge"],
                       email,
                       password,
                       region11,
                       region21,
                       region31,
                       type,
                       cat,
                       subcat,
                       idsubcat,
                       phone,
                       name,
                       id,
                       stroename,
                       photo,
                       value.toString(),
                       cooker);
                 }
                 else {
                   alertmessage("يجب اختيار صورة مناسبة للمتجر");
                 }
               }
               else {
                 alertwait();
                 data = {
                   "email": email.toString(),
                   "password": password.toString(),
                   "password_confirmation": password.toString(),
                   "name": name.toString(),
                   "phone": phone.toString(),
                   "governorate_id": region11.toString(),
                   "city_id": region21.toString(),
                   "region_id": region31.toString(),
                   "type": type.toString(),
                   "fb_token": value.toString(),
                 };
                 var url = Alertdialogazz.base_url+"register";
                 var response = await http.post(Uri.parse(url), body: data);
                 var body = jsonDecode(response.body);
                 Navigator.of(contexta).pop("dialog");
                 if (body["status"] == true) {
                   await savedata(
                       body["data"]["API_Key"].toString(),
                       name,
                       phone,
                       password,
                       email,
                       body["data"]["Governorate"],
                       body["data"]["City"],
                       body["data"]["Region"]);
                   SharedPreferences sharedPreferences = await SharedPreferences
                       .getInstance();
                   sharedPreferences.setString(
                       "id", body["data"]["ID"].toString());
                   if (body["data"]["AccountStatus"].toString().trim() == "2") {
                     Navigator.of(contexta).popUntil((route) => route.isFirst);
                     Navigator.of(contexta).pushReplacement(
                         MaterialPageRoute(builder: (contexta) {
                           return Codeconf(phone: body["data"]["PhoneNumber"]
                               .toString(),
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
                 else {
                   alertmessage(body["msg"]);
                 }
               }
             } else {
               Alertdialogazz.alert(
                   contexta, "يجب أن توافق على الشروط والاحكام");
             }
           }
           else {
             alertmessage(
                 "يجب اختيار المحافظة والمدينة والمنطقة بالشكل الملائم");
           }
         }else{
           Alertdialogazz.alertconnection(contexta);
         }
       });
           }
  }
}