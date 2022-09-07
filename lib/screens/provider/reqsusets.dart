import 'package:ezzproject/screens/orderdata2.dart';
import 'package:flutter/material.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'eventorderdetail.dart';
import '../orderdata2.dart';
makemarsolorder(id,context,keymarsol,home2logic,offermarsol,descmarsol,setState){
  return showDialog(
    barrierDismissible: false, context: context, builder: (context) {
    return StatefulBuilder(
        builder: (contexta, setStatea) {
          return AlertDialog(      insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Container(
              child: SingleChildScrollView(child:
              Column(
                children: [ Form(key: keymarsol,
                  child: Container(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.35, width: MediaQuery
                      .of(context)
                      .size
                      .width,
                      child:Container(height: MediaQuery.of(context).size.height*0.35,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Container(margin: EdgeInsets.only(bottom: 20),child: Text("طلب مرسول",style: TextStyle(color: Color.fromRGBO(42, 171, 227, 1),fontSize: 20,fontWeight: FontWeight.bold),),alignment: Alignment.center,),
                            Directionality(textDirection: TextDirection.rtl, child: Container(color: Color.fromRGBO(42, 171, 227, 1),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                              width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(keyboardType: TextInputType.number,controller: offermarsol,validator: home2logic.validate ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.white),decoration: InputDecoration(hintText: "قيمة العرض",hintStyle: TextStyle(color: Colors.white),border: InputBorder.none),),)),
                            Directionality(textDirection: TextDirection.rtl, child: Container(color: Color.fromRGBO(42, 171, 227, 1),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                              width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(controller: descmarsol,validator: home2logic.validate ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.white),decoration: InputDecoration(hintText: "شرح عن العرض",hintStyle: TextStyle(color: Colors.white),border: InputBorder.none),),))
                          ],),
                        ),
                      ) ),
                ),
                ],
              )),
            ),actions: [
              ElevatedButton(
                child: Text("ارسال"), onPressed: () {
                if(keymarsol.currentState.validate()) {
                  home2logic.makeordermarsol(id, offermarsol.text, descmarsol.text);
                  Navigator.of(context).pop("dialog");
                  offermarsol.text = "";
                  descmarsol.text="";
                  setState(() {

                  });
                }
              },),
              ElevatedButton(
                child: Text("الغاء"), onPressed: () {
                Navigator.of(context).pop("dialog");
                offermarsol.text = "";
                descmarsol.text="";
                setState(() {
                });
              },),
            ],
          );
        });},
  );
}
Widget newRequestcooker(context,home2logic){
  List reqs = Provider.of<Notifires>(context).reqs;
  var downloadreqs = Provider.of<Notifires>(context).downloadreqs;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child:downloadreqs?Container(child:Center(child: CircularProgressIndicator(),),):reqs.length==0?Center(
    child: Container(
      child: Text("لا يوجد طلبات جديدة"),),
  ): ListView.builder( physics: BouncingScrollPhysics(),itemCount: reqs.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12.withOpacity(0.05),
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "اسم المستخدم :  "+reqs[i]["User"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+reqs[i]["EventDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
        child: Row(children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),
          child: InkWell(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return Eventdetail(data: reqs[i],);
            }));
          },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),)),
        )),
          Expanded(child: Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),child: InkWell( onTap: (){
            home2logic.acceptreq(reqs[i]["ID"],"1");
          },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.check,color: Colors.green,size: 20,)),Text("قبول الطلب",style: TextStyle(color: Colors.green,fontSize: 13),) ],),)))),
          Expanded(child: InkWell(onTap: (){
            home2logic.cancelreq(reqs[i]["ID"],"1");
          },
            child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.red),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.clear,color: Colors.red,size: 20,)),Text("رفض الطلب",style: TextStyle(color: Colors.red,fontSize: 13),) ],)
            ),
          )),
        ]),
      ))
    ],),);
  }));
}
Widget newRequest(context,servicetype,home2logic){
  List reqs = Provider.of<Notifires>(context).reqs;
  var downloadreqs = Provider.of<Notifires>(context).downloadreqs;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child:downloadreqs?Container(child:Center(child: CircularProgressIndicator(),),):reqs.length==0?Center(
    child: Container(
      child: Text("لا يوجد طلبات جديدة"),),
  ): ListView.builder( physics: BouncingScrollPhysics(),itemCount: reqs.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12.withOpacity(0.05),
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+reqs[i]["OrderCode"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+reqs[i]["OrderDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
        child: Row(children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),
          child: InkWell(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return Orderdata2(data: reqs[i],);
            }));
          },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),)),
        )),
          Expanded(child: Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),child: InkWell( onTap: (){
              home2logic.acceptreq(reqs[i]["ID"],"0");
          },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.check,color: Colors.green,size: 20,)),Text("قبول الطلب",style: TextStyle(color: Colors.green,fontSize: 13),) ],),)))),
          Expanded(child:servicetype.toString() == "مراسيل"?Container() :  InkWell(onTap: (){
            home2logic.cancelreq(reqs[i]["ID"],"0");
          },
            child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.red),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.clear,color: Colors.red,size: 20,)),Text("رفض الطلب",style: TextStyle(color: Colors.red,fontSize: 13),) ],)
            ),
          )),
        ]),
      ))
    ],),);
  })) ;
}
Widget newRequestmarsol(context,servicetype,home2logic,keymarsol,offermarsol,descmarsol,setState){
  List reqs = Provider.of<Notifires>(context).reqs;
  var downloadreqs = Provider.of<Notifires>(context).downloadreqs;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child:downloadreqs?Container(child:Center(child: CircularProgressIndicator(),),):reqs.length==0?Center(
    child: Container(
      child: Text("لا يوجد طلبات جديدة"),),
  ): ListView.builder( physics: BouncingScrollPhysics(),itemCount: reqs.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12.withOpacity(0.05),
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+reqs[i]["OrderCode"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+reqs[i]["OrderDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
        child: Row(children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),
          child: InkWell(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return Orderdata2(data: reqs[i],);
            }));
          },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),)),
        )),
          Expanded(child: Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),child: InkWell( onTap: (){
            if(servicetype == "مراسيل") {
              makemarsolorder(reqs[i]["ID"],context,keymarsol,home2logic,offermarsol,descmarsol,setState);
            }else{
              home2logic.acceptreq(reqs[i]["ID"],"0");
            }
          },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.check,color: Colors.green,size: 20,)),Text("قبول الطلب",style: TextStyle(color: Colors.green,fontSize: 13),) ],),)))),
          Expanded(child:servicetype.toString() == "مراسيل"?Container() :  InkWell(onTap: (){
            home2logic.cancelreq(reqs[i]["ID"],"0");
          },
            child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.red),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.clear,color: Colors.red,size: 20,)),Text("رفض الطلب",style: TextStyle(color: Colors.red,fontSize: 13),) ],)
            ),
          )),
        ]),
      ))
    ],),);
  })) ;
}
Widget onwork(context,servicetype,home2logic){
  List onworklist = Provider.of<Notifires>(context).onworklist;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: onworklist.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+onworklist[i]["OrderCode"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+onworklist[i]["OrderDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: 15,right: 10),
        child:Row(children :[ Expanded(child:
        InkWell( onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Orderdata2(data: onworklist[i],);
          }));
        },child: Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),))),
        ),Expanded(child:servicetype.toString()=="اماكن"?Container() :Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),child: InkWell( onTap: (){
          print(onworklist);
          home2logic.completereq(onworklist[i]["ID"]);
        },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.check,color: Colors.green,size: 20,)),Text("اكتمال الطلب",style: TextStyle(color: Colors.green,fontSize: 12),) ],),)))),Expanded(child: Container())]),
      )
    ],),);
  })) ;
}
Widget onworkcooker(context){
  List onworklist = Provider.of<Notifires>(context).onworklist;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: onworklist.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "اسم المستخدم :  "+onworklist[i]["User"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+onworklist[i]["EventDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: 15,right: 10),
        child:Row(children :[ Expanded(child:
        InkWell( onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Eventdetail(data: onworklist[i],);
          }));
        },child: Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),))),
        ),Expanded(child:Container()),Expanded(child: Container())]),
      )
    ],),);
  })) ;
}
Widget done(context,homelogic){
  List donelist = Provider.of<Notifires>(context).donelist;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: donelist.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+donelist[i]["OrderCode"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+donelist[i]["OrderDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
        child: Row(children: [Expanded(child: InkWell(onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return Orderdata2(data: donelist[i],);
          }));
        },child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),))),
          Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Text("التقيم:",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017,color: Colors.yellowAccent.withGreen(1000)),)),Icon(Icons.star,color: Colors.yellowAccent.withGreen(1000),size: MediaQuery.of(context).size.height*0.02,),Text("") ],),)),
          Expanded(child:donelist[i]["Reviews"].length ==0?Container(): Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white) ,child:  InkWell(onTap: ()=>homelogic.showreview(donelist[i]["Reviews"]),child: Text("مشاهدة التقييم",style: TextStyle(color: Colors.blue),)),)),
        ]),
      ))
    ],),);
  })) ;
}
Widget canceld(context,){
  List canceldlist = Provider.of<Notifires>(context).canceldlist;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: canceldlist.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "رقم الطلب :  "+canceldlist[i]["OrderCode"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+canceldlist[i]["OrderDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      InkWell(onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return Orderdata2(data: canceldlist[i],);
        }));
      },child: Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.6) ,width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),)))
    ],),);
  })) ;
}
Widget canceldcooker(context){
  List canceldlist = Provider.of<Notifires>(context).canceldlist;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),height: MediaQuery.of(context).size.height*0.7 ,child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: canceldlist.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 1.0,
        spreadRadius: 7.0,
        offset: Offset(3.0, 3.0), // shadow direction: bottom right
      )
    ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "اسم المستخدم :  "+canceldlist[i]["User"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "تاريخ الطلب :  "+canceldlist[i]["EventDate"].toString(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)),),
      InkWell(onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return Eventdetail(data: canceldlist[i],);
        }));
      },child: Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.6) ,width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.info_outlined,color: Colors.white,)),Text("التفاصيل",style: TextStyle(color: Colors.white),) ],),)))
    ],),);
  })) ;
}
showreview(i,context){
  return showDialog( context: context, builder: (context) {
    return StatefulBuilder(builder: (Context , setState){
      return AlertDialog(
          content:Container(height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03) ,child: Row(children: [
                  Expanded(child: Container(alignment: Alignment.centerLeft,child: IconButton(icon: Icon(Icons.clear,size: MediaQuery.of(context).size.height*0.03,color: Colors.black,),onPressed: (){},))),
                  Expanded(child: Container(alignment: Alignment.centerLeft,child: Text("تقييم الطلب",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.height*0.025),))),
                ],),),
                Container(height: MediaQuery.of(context).size.height*0.06,
                  child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                    return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,));
                  }),
                  ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("سرعة الاستجاية",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),) ],),
                ),
                Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),
                  child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                    return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,color: Colors.yellow.withGreen(1000),));
                  }),
                  ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("وقت الوصول",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),) ],),
                ),
                Container(height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),
                  child: Row(children: [ Expanded(flex: 1,child:Container(alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                    return Container(alignment: Alignment.center ,child: Icon(Icons.star,size: MediaQuery.of(context).size.height*0.04,));
                  }),
                  ))) ,Expanded(child:Container(alignment: Alignment.centerRight,child: Text("مستوى اللحوم ونضافتها",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),) ],),
                ),
                Container(width: MediaQuery.of(context).size.width,alignment: Alignment.topRight,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,margin:EdgeInsets.all(MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.1 ,child: Text("وصل بالوقت",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),decoration: BoxDecoration(border: Border.all(color: Colors.lightBlueAccent),borderRadius: BorderRadius.circular(5)),)

              ])));
    },
    );
  });
}
Widget req(context,tabController2,servicetype,home2logic,homelogic){
  List canceldlist = Provider.of<Notifires>(context).canceldlist;
  List donelist = Provider.of<Notifires>(context).donelist;
  List onworklist = Provider.of<Notifires>(context).onworklist;
  List reqs = Provider.of<Notifires>(context).reqs;
  var downloadreqs = Provider.of<Notifires>(context).downloadreqs;
  return Container(child: Directionality(textDirection: TextDirection.ltr,child: ListView(children: [
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
      decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
        Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الطلب",style: TextStyle(color: Colors.white,fontSize: 17),))),
      ],),)) ,
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,color: Colors.white ,child: Row(children: [
      Expanded(child: Container(child: Column(children:[InkWell( onTap: (){if(!downloadreqs){ tabController2.animateTo(3);}},child: Container(child: tabController2.index ==3?Text("("+canceldlist.length.toString()+")"+"ملغي ") :Text("ملغي",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08,right: MediaQuery.of(context).size.width*0.06),child:tabController2.index ==3? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(child: Column(children:[ InkWell( onTap: (){if(!downloadreqs){tabController2.animateTo(2);}},child:Container(child: tabController2.index ==2?Text("("+donelist.length.toString()+")"+"تم التنفيذ") :Text("تم التنفيذ",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.06),child:tabController2.index ==2? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(child: Column(children:[InkWell( onTap: (){if(!downloadreqs){tabController2.animateTo(1);}},child: Container(child: tabController2.index ==1?Text("("+onworklist.length.toString()+")"+"جاري العمل ") :Text("جاري العمل",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController2.index ==1? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(child: Column(children:[ InkWell( onTap: (){if(!downloadreqs){tabController2.animateTo(0);}},child: Container(child: tabController2.index ==0?Text("("+reqs.length.toString()+")"+"طلب جديد ") :Text("طلب جديد",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController2.index ==0? Divider(color: Colors.blue,thickness: 3,):Container(),)])))],),)
    ,Directionality(textDirection: TextDirection.rtl,
      child: Container(height: MediaQuery.of(context).size.height*0.7 ,child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController2,children:[
        newRequest(context,servicetype,home2logic),
        onwork(context,servicetype,home2logic),
        done(context,homelogic),
        canceld(context)
      ]),),
    )
    ,
  ],),),);
}
Widget reqmkan(context,tabController2p,servicetype,home2logic){
  List canceldlist = Provider.of<Notifires>(context).canceldlist;
  List donelist = Provider.of<Notifires>(context).donelist;
  List onworklist = Provider.of<Notifires>(context).onworklist;
  List reqs = Provider.of<Notifires>(context).reqs;
  var downloadreqs = Provider.of<Notifires>(context).downloadreqs;
  return Container(child: Directionality(textDirection: TextDirection.ltr,child: ListView(children: [
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
      decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
        Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الطلب",style: TextStyle(color: Colors.white,fontSize: 17),))),
      ],),)) ,
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,color: Colors.white ,child: Row(children: [
      Expanded(child: Container(child: Column(children:[InkWell( onTap: (){if(!downloadreqs){ tabController2p.animateTo(2);}},child: Container(child: tabController2p.index ==2?Text("("+canceldlist.length.toString()+")"+"ملغي ") :Text("ملغي",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08,right: MediaQuery.of(context).size.width*0.06),child:tabController2p.index ==2? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(child: Column(children:[ InkWell( onTap: (){if(!downloadreqs){tabController2p.animateTo(1);}},child:Container(child: tabController2p.index ==1?Text("("+donelist.length.toString()+")"+"تم الحجز") :Text("تم الحجز",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.06),child:tabController2p.index ==1? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(child: Column(children:[ InkWell( onTap: (){if(!downloadreqs){tabController2p.animateTo(0);}},child: Container(child: tabController2p.index ==0?Text("("+reqs.length.toString()+")"+"طلب جديد ") :Text("طلب جديد",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController2p.index ==0? Divider(color: Colors.blue,thickness: 3,):Container(),)])))],),)
    ,Directionality(textDirection: TextDirection.rtl,
      child: Container(height: MediaQuery.of(context).size.height*0.7 ,child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController2p,children:[
        newRequest(context,servicetype,home2logic),
        onwork(context,servicetype,home2logic),
        canceld(context)
      ]),),
    )
    ,
  ],),),);
}
Widget reqcooker(context,tabController3p,home2logic){
  var downloadreqs = Provider.of<Notifires>(context).downloadreqs;
  List canceldlist = Provider.of<Notifires>(context).canceldlist;
  List donelist = Provider.of<Notifires>(context).donelist;
  List onworklist = Provider.of<Notifires>(context).onworklist;
  List reqs = Provider.of<Notifires>(context).reqs;
  return Container(child: Directionality(textDirection: TextDirection.ltr,child: ListView(children: [
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
      decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
        Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الطلب",style: TextStyle(color: Colors.white,fontSize: 17),))),
      ],),)) ,
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,color: Colors.white ,child: Row(children: [
      Expanded(child: Container(child: Column(children:[InkWell( onTap: (){if(!downloadreqs){ tabController3p.animateTo(2);}},child: Container(child: tabController3p.index ==2?Text("("+canceldlist.length.toString()+")"+"ملغي ") :Text("ملغي",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.08,right: MediaQuery.of(context).size.width*0.06),child:tabController3p.index ==2? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(child: Column(children:[ InkWell( onTap: (){if(!downloadreqs){tabController3p.animateTo(1);}},child:Container(child: tabController3p.index ==1?Text("("+onworklist.length.toString()+")"+"تم القبول") :Text("تم القبول",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.06),child:tabController3p.index ==1? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(child: Column(children:[ InkWell( onTap: (){if(!downloadreqs){tabController3p.animateTo(0);}},child: Container(child: tabController3p.index ==0?Text("("+reqs.length.toString()+")"+"طلب جديد ") :Text("طلب جديد",style: TextStyle(),)))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController3p.index ==0? Divider(color: Colors.blue,thickness: 3,):Container(),)])))],),)
    ,Directionality(textDirection: TextDirection.rtl,
      child: Container(height: MediaQuery.of(context).size.height*0.7 ,child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController3p,children:[
        newRequestcooker(context,home2logic),
        onworkcooker(context),
        canceldcooker(context)
      ]),),
    )
    ,
  ],),),);
}
Widget reqmarsol(context,tabController2p,servicetype,home2logic,keymarsol,offermarsol,descmarsol,setState){
  List reqs = Provider.of<Notifires>(context).reqs;
  return Container(child: Directionality(textDirection: TextDirection.ltr,child: ListView(children: [
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
      decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
        Expanded(child: Container(),),
        Expanded(child: Container(alignment: Alignment.center,child: Text("الطلب",style: TextStyle(color: Colors.white,fontSize: 17),))),
        Expanded(child: Container())
      ],),)) ,
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),padding:EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,color: Colors.white ,child: Row(children: [
      Expanded(child: Container(),),
      Expanded(child: Container(child: Column(children:[ InkWell( child: Container(child: Text("("+reqs.length.toString()+")"+"طلب يجب توصيله ") ))
        ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.03),child:tabController2p.index ==0? Divider(color: Colors.blue,thickness: 3,):Container(),)]))),
      Expanded(child: Container(),),],),)
    ,Directionality(textDirection: TextDirection.rtl,
        child: Container(height: MediaQuery.of(context).size.height*0.7 ,child:
        newRequestmarsol(context,servicetype,home2logic,keymarsol,offermarsol,descmarsol,setState),)
    )
    ,
  ],),),);
}

