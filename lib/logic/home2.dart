import 'dart:convert';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:ezzproject/screens/users/showimages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'alertdialog.dart';
import 'mainlogic.dart';
class Home2logic {
  var contexta;
  Home2logic(BuildContext context) {
    contexta = context;
  }
  var stringa;

  String validate(String value) {
    if (value.isEmpty) {
      return 'لا يجب ترك الحقل';
    }
    return null;
  }
  String validatemobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يجب ترك الحقل';
    }
    else if (!regExp.hasMatch(value)) {
      return 'هذا الرقم غير صالح!';
    }
    return null;
  }
  deleteservice(id) async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var servicetype = sharedPreferences.getString("servicetype");
      var url;
      if (servicetype == "مراسيل") {
        url = Alertdialogazz.base_url+"deleteCar/" + id.toString();
      }
      if (servicetype != "اماكن" && servicetype != "مزاد" &&
          servicetype != "مراسيل") {
        url = Alertdialogazz.base_url+"deleteService/" + id.toString();
      }
      if (servicetype == "اماكن") {
        url = Alertdialogazz.base_url+"deletePlace/" + id.toString();
      }
      if (servicetype == "مزاد") {
        url = Alertdialogazz.base_url+"deleteAuction/" + id.toString();
      }
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body2["status"] == true) {
        Provider.of<Notifires>(contexta, listen: false).getservices(contexta);
      }
    }else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  deleteservicem(id) async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = Alertdialogazz.base_url+"deleteAuction/" + id.toString();
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body2["status"] == true) {
        Provider.of<Notifires>(contexta, listen: false).getmazads(contexta);
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  deletecupon(id) async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var url = Alertdialogazz.base_url+"deleteCoupon/" + id.toString();
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body2["status"] == true) {
        alertmessagedelete(body2["msg"].toString());
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  alertwait(){
    showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(backgroundColor: Colors.transparent,elevation: 0,content: Container(width: 30,height:30,
          child: Center(child :SizedBox( width: 30,height: 30, child: CircularProgressIndicator()))),
      );});
  }
  alertmessagedelete(message){
    return showDialog(context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.2,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.05,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child: FittedBox(child: new Text("تم الامر بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: (){
                Navigator.of(context).pop("dialog");
                Provider.of<Notifires>(context,listen: false).getcupon(contexta);
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
  alertmessagego(message){
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
                Navigator.of(contexta).popUntil((route) => route.isFirst);
                Navigator.of(contexta).push(MaterialPageRoute(builder: (context){
                  return Home2();
                }));
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
  sendinfocommesion( photo ,collection,date,note) async{
      if(photo ==null){
        Alertdialogazz.alert(contexta,"يجب اختيار صورة التحويل للمناسبة" );
      }
      else {
        if(collection.toString() !=""){
          if(date !=null){
            if(note.toString() != "") {
              alertwait();
              if (await InternetConnectionChecker().hasConnection) {
                SharedPreferences sharedPreferences = await SharedPreferences
                    .getInstance();
                var url = Alertdialogazz.base_url+"add_collect";
                var token = sharedPreferences.getString("token");
                var request = new http.MultipartRequest("POST", Uri.parse(url));
                request.fields["collection"] = collection.toString();
                request.fields["date"] = date.toString();
                request.fields["note"] = note.toString();
                request.files.add(await http.MultipartFile.fromPath("photo",
                    photo.path));
                request.headers.addAll({
                  'Authorization': 'Bearer $token',
                });
                var response = await request.send().then((value) {
                  value.stream.transform(utf8.decoder).listen((event) async {
                    var body = jsonDecode(event);
                    Navigator.of(contexta).pop("dialog");
                    if (body["status"] == true) {
                      alertmessagego(body["msg"]);
                    }
                    else {
                      Alertdialogazz.alert(contexta, body["msg"]);
                    }
                  });
                });
              } else {
                Navigator.of(contexta).pop("dialog");
                Alertdialogazz.alertconnection(contexta);
              }
            }
            else{
              Alertdialogazz.alert(contexta,"يجب كتابة رقم التحويل" );
            }
  }else{
            Alertdialogazz.alert(contexta,"يجب اختيار تاريخ التحويل" );
            }
        }else{
          Alertdialogazz.alert(contexta,"يجب كتابة قيمة التحويل" );

    }
      }

  }
  getprofiledata()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      alertwait();
      var url2 = Alertdialogazz.base_url+"Data-Edit-User";
      var response2 = await http.get(Uri.parse(url2), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response2.body);
      Navigator.of(contexta).pop("dialog");
      var profiledata = body2["data"];
      return {"profiledata": profiledata};
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getservices()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url;
      var servicetype = sharedPreferences.getString("servicetype");
      if (servicetype == "مراسيل") {
        url = Alertdialogazz.base_url+"getCars";
      }
      if (servicetype != "اماكن" && servicetype != "مزاد" &&
          servicetype != "مراسيل") {
        url = Alertdialogazz.base_url+"getServices";
      }
      if (servicetype == "اماكن") {
        url = Alertdialogazz.base_url+"getPlaces";
      }
      if (servicetype == "مزاد") {
        url = Alertdialogazz.base_url+"getAuctions";
      }
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      var services = body["data"];
      return services;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getmazads()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"getAuctions";
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      var services = body["data"];
      return services;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getcupons()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"getCoupons";
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      var cupons = body["data"];
      return cupons;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  makeordermarsol(id,offer,desc)async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url2 = Alertdialogazz.base_url+"makeMarsolOrder";
      var response2 = await http.post(Uri.parse(url2), headers: {
        'Authorization': 'Bearer $token',
      },
          body: {
            "order_id": id.toString(),
            "offer": offer.toString(),
            "desc": desc.toString()
          });
      var body2 = jsonDecode(response2.body);
      Navigator.of(contexta).pop("dialog");
      if (body2["status"] == true) {
        Alertdialogazz.alert(contexta, body2["msg"]);
        await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
      }
    }else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getreqsmarasil()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"marsolOrders";
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      var data = body["data"];
      return data;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getreqs()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"provider_orders";
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      var data = body["data"];
      return data;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getreqsevents()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"eventsOrder";
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      var data = body["data"];
      return data;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  acceptreq(id,type)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      if (type == "1") {
        var url = Alertdialogazz.base_url+"provider_acceptOrder";
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: { "eventId": id.toString(), "orderType": "1"});
        var body = jsonDecode(response.body);
        if (Navigator.canPop(contexta)) {
          Navigator.of(contexta).pop("dialog");
        }
        if (body["status"].toString() == "true") {
          Alertdialogazz.alert(contexta, body["msg"]);
          await Provider.of<Notifires>(contexta, listen: false).getreqs(
              contexta);
        }
        else {
          Alertdialogazz.alert(contexta, body["msg"]);
        }
      }
      else {
        var url = Alertdialogazz.base_url+"provider_acceptOrder";
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: {"order_id": id.toString(), "orderType": "0"});
        var body = jsonDecode(response.body);
        if (Navigator.canPop(contexta)) {
          Navigator.of(contexta).pop("dialog");
        }
        if (body["status"].toString() == "true") {
          Alertdialogazz.alert(contexta, body["msg"]);
          Provider.of<Notifires>(contexta, listen: false).gethome_provider(contexta);
          await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
        }
        else {
          Alertdialogazz.alert(contexta, body["msg"]);
        }
      }
    }
    else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  completereq(id)async{
    alertwait();
    if(await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"deliveryOrder";
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {"order_id": id.toString()});
      var body = jsonDecode(response.body);
      if (Navigator.canPop(contexta)) {
        Navigator.of(contexta).pop("dialog");
      }
      if (body["status"].toString() == "true") {
        Alertdialogazz.alert(contexta, body["msg"]);
        Provider.of<Notifires>(contexta, listen: false).gethome_provider(contexta);
        await Provider.of<Notifires>(contexta, listen: false).getreqs(contexta);
      }
      else {
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  cancelreq(id,type)async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      if (type == "1") {
        var url = Alertdialogazz.base_url+"provider_cancelOrder";
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: {"eventId": id.toString(), "orderType": "1"});
        var body = jsonDecode(response.body);
        if (Navigator.canPop(contexta)) {
          Navigator.of(contexta).pop("dialog");
        }
        if (body["status"].toString() == "true") {
          Alertdialogazz.alert(contexta, body["msg"]);
          Provider.of<Notifires>(contexta, listen: false).gethome_provider(contexta);
          await Provider.of<Notifires>(contexta, listen: false).getreqs(
              contexta);
        }
        else {
          Alertdialogazz.alert(contexta, body["msg"]);
        }
      } else {
        var url = Alertdialogazz.base_url+"provider_cancelOrder";
        var response = await http.post(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        }, body: {"order_id": id.toString(), "orderType": "0"});
        var body = jsonDecode(response.body);
        if (Navigator.canPop(contexta)) {
          Navigator.of(contexta).pop("dialog");
        }
        if (body["status"].toString() == "true") {
          Alertdialogazz.alert(contexta, body["msg"]);
          Provider.of<Notifires>(contexta, listen: false).gethome_provider(contexta);
          await Provider.of<Notifires>(contexta, listen: false).getreqs(
              contexta);
        }
        else {
          Alertdialogazz.alert(contexta, body["msg"]);
        }
      }
    }else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  productstatus(status,id,contexta)async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      var url = Alertdialogazz.base_url+"productStatus";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      },
          body: {
            "product_id": id.toString(),
            "status": status.toString() == "1" ? "0" : "1"
          });
      var body = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body["status"].toString() == "true") {
        Provider.of<Notifires>(contexta, listen: false).getservices(contexta);
      }
      else {
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  providerstatus(status,contexta)async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      var url = Alertdialogazz.base_url+"storeStatus";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {"status": status.toString() == "1" ? "0" : "1"});
      var body = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if (body["status"].toString() == "true") {
        Provider.of<Notifires>(contexta, listen: false).gethome_provider(
            contexta);
      }
      else {
        Alertdialogazz.alert(contexta, body["msg"]);
      }
    }else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getrewards(histto,histfrom)async {
    alertwait();
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url = Alertdialogazz.base_url+"rewards";
      var response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }, body: {
        "start": histfrom.toString(),
        "end": histto.toString()
      });
      var body = jsonDecode(response.body);
      Navigator.of(contexta).pop("dialog");
      if(body['status'] ==true){
        var data = body["data"];
        return data;
      }else{
        Alertdialogazz.alert(contexta, body["msg"].toString());
      }
    }else{
      Navigator.of(contexta).pop("dialog");
      Alertdialogazz.alertconnection(contexta);
    }
  }
  showhist(type){
    var value = DateTime.now().toString().substring(0,10);
    return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                          child: CalendarDatePicker(initialDate:DateTime.now(), firstDate: DateTime.now().subtract(Duration(days: 100000)), lastDate: DateTime.now().add(Duration(days: 10000)),onDateChanged: (val){
                            value= val.toString().substring(0,10);
                          },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
                Provider.of<Notifires>(context,listen: false).homeproviderhist(type, value);
              Navigator.of(context).pop("dialog");
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
  getmyorders()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      alertwait();
      var url2 = Alertdialogazz.base_url+"myOrder";
      var response2 = await http.get(Uri.parse(url2), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response2.body);
      Navigator.of(contexta).pop("dialog");
      var profiledata = body2["data"];
      return profiledata;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  gethomeprovider()async{
    if (await InternetConnectionChecker().hasConnection) {
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var url2 = Alertdialogazz.base_url+"provider_home";
      var response2 = await http.get(Uri.parse(url2), headers: {
        'Authorization': 'Bearer $token',
      });
      var body2 = jsonDecode(response2.body);
      var url3 = "https://azz-app.com/api/appInfo";
      var response3 = await http.get(Uri.parse(url3));
      var body3 = jsonDecode(response3.body);
      var data = {"1": body2["data"], "2": body3["categories"]["pledge"]};
      return data;
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
  getfav(context)async{
    if (await InternetConnectionChecker().hasConnection) {
      var url = Alertdialogazz.base_url+"fav";
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      alertwait();
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      Navigator.of(context).pop("dialog");
      var body = jsonDecode(response.body);
      return body["fav"];
    }
    else{
      Alertdialogazz.alertconnection(contexta);
    }
  }
}