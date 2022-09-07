import 'dart:convert';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/users/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'alertdialog.dart';
class Addreviewlogic {
  var contexta;
  Addreviewlogic(BuildContext context) {
    contexta = context;
  }

  void navigate() {
    Navigator.of(contexta).pop();
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  void navigatetomain(){
    Navigator.of(contexta).pushReplacement(MaterialPageRoute(builder: (contexta){
      return Showimages();
    }));
  }
  send(id,comment,GlobalKey<FormState> key,star_num, levelofstar1,levelofstar2,levelofstar3,List qs)async {
    if(star_num.toString() !="0") {
      if (key.currentState.validate()) {
        alertwait();
        if (await InternetConnectionChecker().hasConnection) {
          var url = Alertdialogazz.base_url+"addReview";
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          var token = sharedPreferences.getString("token");
          var data = {
            "sub_review1": levelofstar1.toString(),
            "sub_review2": levelofstar2.toString(),
            "sub_review3": levelofstar3.toString(),
            "desc": comment.toString(),
            "star_num": star_num.toString(),
            "store_id": id.toString()
          };
          var response = await http.post(Uri.parse(url), headers: {
            'Authorization': 'Bearer $token',
          }, body: data);
          var body = jsonDecode(response.body);
          Navigator.of(contexta).pop("dialog");
          Navigator.of(contexta).pop();
          if (body["status"] == true) {
            Provider.of<Notifires>(contexta, listen: false).updatedetail(
                contexta);
            Provider.of<Notifires>(contexta, listen: false).getallreview(
                id, contexta);
            Alertdialogazz.alert(contexta, body["msg"]);
          }
          else {
            Alertdialogazz.alert(contexta, body["msg"]);
          }
        } else {
          Navigator.of(contexta).pop("dialog");
          Alertdialogazz.alertconnection(contexta);
        }
      }
    }
    else{
      Alertdialogazz.alert(contexta, " يجب اضافة تقييم بالشكل الصحيح في الاعلى");
    }
  }
  sendplaces(idplace,provider_id,comment,GlobalKey<FormState> key,star_num, levelofstar1,levelofstar2,levelofstar3,List qs)async {
    if(star_num.toString() !="0") {
      if (key.currentState.validate()) {
        alertwait();
        if (await InternetConnectionChecker().hasConnection) {
          var url = Alertdialogazz.base_url+"addReview";
          SharedPreferences sharedPreferences = await SharedPreferences
              .getInstance();
          var token = sharedPreferences.getString("token");
          var data = {"sub_review1": levelofstar1.toString(),
            "sub_review2": levelofstar2.toString(),
            "sub_review3": levelofstar3.toString(),
            "desc" : comment.toString(),
            "star_num": star_num.toString(),
            "place_id": idplace.toString(),
            "store_id" : provider_id.toString()
          };
          var response = await http.post(Uri.parse(url), headers: {
            'Authorization': 'Bearer $token',
          }, body: data);
          var body = jsonDecode(response.body);
          Navigator.of(contexta).pop("dialog");
          if (body["status"] == true) {
            Provider.of<Notifires>(contexta, listen: false).updatepalce(
                contexta);
            Navigator.of(contexta).pop();
            Alertdialogazz.alert(contexta, body["msg"]);
          }
          else {
            Navigator.of(contexta).pop();
            Alertdialogazz.alert(contexta, body["msg"]);
          }
        }
        else {
          Navigator.of(contexta).pop("dialog");
          Alertdialogazz.alertconnection(contexta);
        }
      }
    }
    else{
      Alertdialogazz.alert(contexta, " يجب اضافة تقييم بالشكل الصحيح في الاعلى");
    }
  }
  getqsreviews()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"get_review_qs";
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
}