import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
class Eventorder extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateEventorder();
  }
}
class StateEventorder extends State<Eventorder>{
  Homelogic homelogic;
  var downloador = true;
  List myorders = [];
  getdata()async{
    var datas = await homelogic.geteventorder();
    myorders = datas;
    downloador = false;
    setState(() {

    });
  }
  del(id)async{
    var status = await homelogic.deleteorder(id, "1");
    if(status){
      downloador = true;
      setState(() {});
      getdata();
    }
  }
  @override
  void initState() {
    homelogic = new Homelogic(context);
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.13,child :
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
              Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
              Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("طلبات الطهاة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
              Expanded(child: Container())
            ],),)    ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(
              child:  downloador
                  ?Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.7,child: Center(child: CircularProgressIndicator(),),) :myorders.length == 0 ?Container(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.7,
                child: Center(child: Text("لا توجد طلبات مسبقة")),)
                  :  Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.83,
                margin: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.01),
                child: ListView.builder(physics: BouncingScrollPhysics(),
                    itemCount: myorders.length, itemBuilder: (context, i) {
                      return Container(decoration: BoxDecoration(
                          color: Colors.white, boxShadow: [ BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3.0,
                        spreadRadius: 2.0,
                        offset: Offset(
                            22.0, 2.0), // shadow direction: bottom right
                      )
                      ]), margin: EdgeInsets.only(top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.01, bottom: MediaQuery
                          .of(context)
                          .size
                          .height * 0.01),
                        child: Column(
                          children: [
                            Container(margin: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02, bottom: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02),
                              child: Row(children: [
                                Expanded(flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.01),
                                    child: Column(children: [
                                      Container(
                                        child:  Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(children: [
                                              Expanded(child: Container(
                                                margin: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.01),
                                                padding: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.02,
                                                    left: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.02),
                                                child:  Text(
                                                      "نوع الطلب :",maxLines: 1,
                                                      style: TextStyle(
                                                          fontSize: 14),),)),
                                              Expanded(child: Container(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child: Directionality(
                                                      textDirection: TextDirection
                                                          .ltr,
                                                      child:  Text(
                                                            myorders[i]["EventType"]
                                                                .toString(),maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 14),))))
                                            ])),
                                      ),
                                      Container(
                                        child:  Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(children: [
                                              Expanded(child: Container(
                                                margin: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.01),
                                                padding: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.02,
                                                    left: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.02),
                                                child:  Text(
                                                      "العنوان  :",
                                                      style: TextStyle(
                                                          fontSize: 14),),)),
                                              Expanded(child: Container(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child: Directionality(
                                                      textDirection: TextDirection
                                                          .ltr,
                                                      child: FittedBox(
                                                          child: AutoSizeText(
                                                            myorders[i]["EventAddress"]
                                                                .toString(),maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: MediaQuery
                                                                    .of(context)
                                                                    .textScaleFactor *
                                                                    10),)))))
                                            ])),
                                      ),
                                      Container(
                                        child:  Container(
                                            alignment: Alignment.centerLeft,
                                            child: Row(children: [
                                              Expanded(child: Container(
                                                margin: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.01),
                                                padding: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.02,
                                                    left: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0.02),
                                                child:  AutoSizeText(
                                                      "التفاصيل :",maxLines: 1,
                                                maxFontSize: 14,
                                            minFontSize: 14,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .textScaleFactor *
                                                              10),),)),
                                              Expanded(child: Container(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child: Directionality(
                                                      textDirection: TextDirection
                                                          .ltr,
                                                      child:  Text(
                                                            myorders[i]["EventDetails"]
                                                                .toString(),overflow: TextOverflow.ellipsis ,
                                                            style: TextStyle(
                                                                fontSize: 13),))))
                                            ])),
                                      )
                                    ]),),),
                                Expanded(flex: 1,
                                    child: Container(
                                        padding: EdgeInsets.all(MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.01),
                                        margin: EdgeInsets.all(MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.01),
                                        child: Column(children: [
                                          Container(child: Row(children: [
                                            Expanded(child: Container(
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0),
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.02,
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.02),
                                              child: Directionality(
                                                  textDirection: TextDirection
                                                      .rtl,
                                                  child:  AutoSizeText(
                                                        "تاريخ الطلب :",maxLines: 1,
                                                  maxFontSize: 14,
                      minFontSize: 14,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery
                                                                .of(context)
                                                                .textScaleFactor *
                                                                10),)),)),
                                            Expanded(child: Container(
                                                margin: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0),
                                                alignment: Alignment.centerRight,
                                                child: Directionality(
                                                    textDirection: TextDirection
                                                        .ltr,
                                                    child:  AutoSizeText(
                                                          myorders[i]["EventDate"].toString(),maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 14),)))),
                                          ])),
                                          Container(child: Row(children: [
                                            Expanded(child: Container(
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0),
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.02,
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.02),
                                              child: Directionality(
                                                  textDirection: TextDirection
                                                      .rtl,
                                                  child:  AutoSizeText(
                                                        "التوقيت :",maxLines: 1,
                      maxFontSize: 14,
                      minFontSize: 14,
                                                        style: TextStyle(
                                                            fontSize: MediaQuery
                                                                .of(context)
                                                                .textScaleFactor *
                                                                10),)),)),
                                            Expanded(child: Container(
                                                margin: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0),
                                                alignment: Alignment.centerRight,
                                                child: Directionality(
                                                    textDirection: TextDirection
                                                        .ltr,
                                                    child: FittedBox(
                                                        child: AutoSizeText(
                                                          myorders[i]["EventTime"].toString(),maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .textScaleFactor *
                                                                  10),))))),
                                          ])),
                                          Container(child: Row(children: [
                                            Expanded(child: Container(
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0),
                                              padding: EdgeInsets.only(
                                                  right: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.02,
                                                  left: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width * 0.02),
                                              child: AutoSizeText("الحالة :",maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                        .of(context)
                                                        .textScaleFactor *
                                                        14),),)),
                                            Expanded(child: Container(
                                                margin: EdgeInsets.only(
                                                    right: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width * 0),
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.all(MediaQuery
                                                    .of(context)
                                                    .size
                                                    .width * 0.01),
                                                child:  AutoSizeText(
                                                      myorders[i]["EventStatusMessage"].toString(),maxLines: 1,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              244, 121, 27, 1),
                                                          fontSize: 14),)))
                                          ]),)
                                        ],)))
                              ]),
                            ),
                            Container(
                              child:myorders[i]["EventStatus"].toString()!="0"? Container():Container(alignment: Alignment.center,margin: EdgeInsets.only(bottom: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.01), child:
                                Container(child: InkWell(onTap: () {
                                  del(myorders[i]["ID"]);
                                },
                                    child: Container(width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.25,
                                      margin: EdgeInsets.only(left: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.01, right: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.01),
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height * 0.04,
                                      decoration: BoxDecoration(
                                          color: Color.fromRGBO(246, 7, 7, 1),
                                          borderRadius: BorderRadius.circular(5)),
                                      child: FittedBox(child: Row(children: [
                                        Icon(Icons.delete, color: Colors.white,
                                          size: 18,),
                                        Container(padding: EdgeInsets.all(MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.02),
                                            child: AutoSizeText("الغاء الطلب",
                                              style: TextStyle(
                                                  fontSize: 13, color: Colors
                                                  .white),)),
                                      ])))))
                              ),
                            ),
                            Container(
                              child:myorders[i]["EventStatus"].toString()=="1"? InkWell(onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return Chat(id: myorders[i]["ProviderID"],messags: [],providername: myorders[i]["ProviderName"],);
                                }));
                              },
                                  child: Container(width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.25,
                                    margin: EdgeInsets.only(left: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.01, right: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.01,bottom: 10),
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height * 0.04,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(12, 145, 190, 1),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(child: FittedBox(child: Row(
                                        children: [
                                          Icon(Icons.info, color: Colors.white,
                                            size: 18,),
                                          Container(
                                              padding: EdgeInsets.all(MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width * 0.02),
                                              child: AutoSizeText("محادثة",style: TextStyle(color: Colors.white,fontSize: 14),)),
                                        ]))),)):Container(),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          )
           ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}