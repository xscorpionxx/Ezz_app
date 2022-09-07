import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mainlogic.dart';

class Alertdialogazz{
  static String base_url = 'https://ezz.active4web.com/api/';
  static void alert(contexta,msg)async{
    return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.4,
          child: Column(children: [
            Container(margin: EdgeInsets.only(right: 10),child: InkWell(onTap: (){
              Navigator.of(context).pop("dialog");
            },child: Icon(Icons.close,color: Colors.indigo),),alignment: Alignment.centerRight,),
            Container(margin: EdgeInsets.only(right: 20,top: 20),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl
                ,child: Text("تنبيه :",style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold),)),),
            Container(margin: EdgeInsets.only(right: 20),alignment: Alignment.centerRight,height: MediaQuery.of(context).size.height*0.2,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child:  SingleChildScrollView(child: new Text(msg,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)))),
            ),Spacer(),
            Container(margin: EdgeInsets.only(bottom: 10),
              child: InkWell(onTap: (){
                Navigator.of(context).pop("dialog");
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,
                  fontSize: 15,fontWeight: FontWeight.bold),),),)),
            )
          ],),
        ),
      );
    });
  }
  static void alertgotologin(contexta,msg)async{
    return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.4,
          child: Column(children: [
            Container(margin: EdgeInsets.only(right: 10),child: InkWell(onTap: (){
              Navigator.of(context).pop("dialog");
            },child: Icon(Icons.close,color: Colors.indigo),),alignment: Alignment.centerRight,),
            Container(margin: EdgeInsets.only(right: 20,top: 20),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl
                ,child: Text("تنبيه :",style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold),)),),
            Container(margin: EdgeInsets.only(right: 20),alignment: Alignment.centerRight,height: MediaQuery.of(context).size.height*0.2,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child:  SingleChildScrollView(child: new Text(msg,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)))),
            ),Spacer(),
            Container(margin: EdgeInsets.only(bottom: 10),
              child: InkWell(onTap: (){
                Navigator.of(contexta).popUntil((route) => route.isFirst);
                Navigator.of(contexta).pushReplacement(
                    MaterialPageRoute(builder: (contexta) {
                      return Loginpage();
                    }));
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,
                  fontSize: 15,fontWeight: FontWeight.bold),),),)),
            )
          ],),
        ),
      );
    });
  }
  static void alertcupons(contexta , msg)async{
    return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.25,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.1,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child:  SingleChildScrollView(child: new Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: (){
                Navigator.of(context).pop("dialog");
                Navigator.of(contexta).popUntil((route) => route.isFirst);
                Provider.of<Notifires>(context,listen: false).getcupon(context);
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });
  }
 static void alertservices(contexta , msg)async{
   return showDialog(barrierDismissible: false,context: contexta, builder: (context) {
     return AlertDialog(
       content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.25,child: SingleChildScrollView(
         child: Column(children: [
           Container(height: MediaQuery.of(context).size.height*0.1,
             child: Directionality(
                 textDirection: TextDirection.rtl ,child: Center(child:  SingleChildScrollView(child: new Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*20,fontWeight: FontWeight.bold),)))),
           ),
           Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
             child: InkWell(onTap: (){
               Navigator.of(context).pop("dialog");
               Navigator.of(contexta).popUntil((route) => route.isFirst);
           Provider.of<Notifires>(context,listen: false).getservices(context);
           Provider.of<Notifires>(context, listen: false)
         .getmazads(context);
             },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("حسنا",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
           )
         ],),
       ),),
     );
   });
 }
 static String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'لا يمكنك ترك الرقم فارغ!';
    }
    else if (!regExp.hasMatch("+966"+value)) {
      return 'هذا الرقم غير صالح!';
    }
    else if (value.length !=9){
      return 'يجب أن يكون الرقم مكون من 9 أرقام!';
    }
    else if(!value.startsWith('5')){
      return 'يجب أن يبدأ الرقم ب 5';
    }
    return null;
  }

  static void alertconnection(context){
     showDialog(barrierDismissible: false,context: context, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.3,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.1,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: Center(child:  Text("لا يوجد اتصال بالانترنت الرجاء التأكد من الاتصال واعادة المحاولة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13,fontWeight: FontWeight.bold),))),
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
}