import 'dart:convert';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:ezzproject/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertdialog.dart';
class Addservice3logic {
  var contexta;

  Addservice3logic(BuildContext context) {
    contexta = context;
  }
  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  getplaces()async {
    if (await InternetConnectionChecker().hasConnection) {
      var url = Alertdialogazz.base_url+"places";
      var response = await http.get(Uri.parse(url));
      var body = jsonDecode(response.body);
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url2 = Alertdialogazz.base_url+"getPlacesType";
      var response2 = await http.get(Uri.parse(url2), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response2.body);
      var url3 = Alertdialogazz.base_url+"Data-Edit-User";
      var response3 = await http.get(Uri.parse(url3), headers: {
        'Authorization': 'Bearer $token',
      });
      var body3 = jsonDecode(response3.body);
      return {
        "1": body["data"],
        "types": body2["data"],
        "govern": body3["data"]["Governorate"]
      };
    }else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  List region1 = [];
  List region2 = [];
  List region3 = [];
  getdata()async {
    alertwait();
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
      var re1 = sharedPreferences.getString("region1");
      var re2 = sharedPreferences.getString("region2");
      var re3 = sharedPreferences.getString("region3");
      Navigator.of(contexta).pop("dialog");
      return {
        "re1": re1,
        "re2": re2,
        "re3": re3,
        "listre1": region1,
        "listre2": region2,
        "listre3": region3
      };
    }else{
      Navigator.of(contexta).maybePop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
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
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  addservice3(GlobalKey<FormState> key , placetype,name,re1,re2,res1,res2 ,address,masaha , numofroof,numofroom , fornum , wcs , ketchins,price, sale_price , desc,features  ,photos,photoa , accept,locationurl)async{
    if(key.currentState.validate()) {
      if(photoa ==null){
        Alertdialogazz.alert(contexta,"يجب اختيار الصورة للمناسبة" );
      }
      else {
        if (accept) {
          if (re2 != "المدينة" && re1 != "المحافظة" &&
              placetype != "نوع المكان") {
            alertwait();
            if(await InternetConnectionChecker().hasConnection) {
            var id1;
            var id2;
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
            SharedPreferences sharedPreferences = await SharedPreferences
                .getInstance();
            var url = Alertdialogazz.base_url+"addPlace";
            var token = sharedPreferences.getString("token");
            var request = new http.MultipartRequest("POST", Uri.parse(url));
            request.fields["desc"] = desc.toString();
            request.fields["type"] = placetype.toString();
            request.fields["city_id"] = id2.toString();
            request.fields["region_id"] = id1.toString();
            request.fields["address"] = address.toString();
            request.fields["address_link"] = locationurl.toString();
            request.fields["area"] = masaha.toString();
            request.fields["level_count"] = numofroof.toString();
            request.fields["room_count"] = numofroom.toString();
            request.fields["space_count"] = fornum.toString();
            request.fields["accept_rules"] = "1".toString();
            request.fields["bathroom_count"] = wcs.toString();
            request.fields["kitchen_room_count"] = ketchins.toString();
            request.fields["day_rental"] = price.toString();
            request.fields["weekly_rental"] = sale_price.toString();
            request.fields["name"] = name.toString();
            request.fields["feature"] =
                features.toString().substring(1, features
                    .toString()
                    .length - 1);
            request.files.add(await http.MultipartFile.fromPath("photo1",
                photoa.path));
            for (int g = 0; g < photos.length; g++) {
              if (photos[g] != null) {
                request.files.add(await http.MultipartFile.fromPath(
                    "photo" + (g + 2).toString(),
                    photos[g].path));
              }
            }
            request.headers.addAll({
              'Authorization': 'Bearer $token',
            });
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
          }
          else{
            Alertdialogazz.alert(contexta,"يجب اختيار نوع المكان والمدينة والمنطقة بالطريقة المناسبة" );
          }
        }else {
          Alertdialogazz.alert(contexta,"يجب عليك أن توافق على الشروط المطلوية");
        }
      }

    }
  }
  editservice3( id,GlobalKey<FormState> key , placetype,name,re2,re1,res1,res2 ,address,masaha , numofroof,numofroom , fornum , wcs , ketchins,price, sale_price , desc,features  ,image1 , image2,image3,image4,image5,image6 , accept,locationurl)async{
    if(key.currentState.validate()) {
        if (accept) {
          if (re2 != "المدينة" && re1 != "المنطقة" &&
              placetype != "نوع المكان") {
            alertwait();
            if (await InternetConnectionChecker().hasConnection) {
              var id2;
              var id3;
              for (int f = 0; res2.length > f; f++) {
                if (res2[f]["name"].toString() == re2) {
                  id2 = res2[f]["ID"];
                }
              }
              for (int f = 0; res1.length > f; f++) {
                if (res1[f]["name"].toString() == re1) {
                  id3 = res1[f]["ID"];
                }
              }
              SharedPreferences sharedPreferences = await SharedPreferences
                  .getInstance();
              var url = Alertdialogazz.base_url+"updatePlace/" + id.toString();
              var token = sharedPreferences.getString("token");
              var request = new http.MultipartRequest("POST", Uri.parse(url));
              request.fields["desc"] = desc.toString();
              request.fields["type"] = placetype.toString();
              request.fields["city_id"] = id2.toString();
              request.fields["region_id"] = id3.toString();
              request.fields["address"] = address.toString();
              request.fields["address_link"] = locationurl.toString();
              request.fields["area"] = masaha.toString();
              request.fields["accept_rules"] = "1".toString();
              request.fields["level_count"] = numofroof.toString();
              request.fields["room_count"] = numofroom.toString();
              request.fields["space_count"] = fornum.toString();
              request.fields["bathroom_count"] = wcs.toString();
              request.fields["kitchen_room_count"] = ketchins.toString();
              request.fields["day_rental"] = price.toString();
              request.fields["feature"] =
                  features.toString().substring(1, features
                      .toString()
                      .length - 1);
              request.fields["weekly_rental"] = sale_price.toString();
              request.fields["name"] = name.toString();
              if (image1 != null) {
                request.files.add(await http.MultipartFile.fromPath("photo1",
                    image1.path));
              }
              if (image2 != null) {
                request.files.add(await http.MultipartFile.fromPath("photo2",
                    image2.path));
              }
              if (image3 != null) {
                request.files.add(await http.MultipartFile.fromPath("photo3",
                    image3.path));
              }
              if (image4 != null) {
                request.files.add(await http.MultipartFile.fromPath("photo4",
                    image4.path));
              }
              if (image5 != null) {
                request.files.add(await http.MultipartFile.fromPath("photo5",
                    image5.path));
              }
              if (image6 != null) {
                request.files.add(await http.MultipartFile.fromPath("photo6",
                    image6.path));
              }
              request.headers.addAll({
                'Authorization': 'Bearer $token',
              });
              request.headers.addAll({
                'Authorization': 'Bearer $token',
              });
              var response = await request.send().then((value) {
                value.stream.transform(utf8.decoder).listen((event) async {
                  Navigator.of(contexta).pop();
                  var body = jsonDecode(event);
                  if (body["status"] == true) {
                    Alertdialogazz.alertservices(contexta, body["msg"]);
                  }
                  else {
                    Alertdialogazz.alert(contexta, body["msg"]);
                  }
                });
              });
            }else{
              Navigator.of(contexta).pop();
              Alertdialogazz.alertconnection(contexta);
            }
          }
          else{
            Alertdialogazz.alert(contexta,"يجب اختيار نوع المكان والمدينة والمنطقة بالطريقة المناسبة");
          }
        }else {
          Alertdialogazz.alert(contexta,"يجب عليك أن توافق على الشروط المطلوية");
        }
    }
  }
}