import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/orderdata2.dart';
import 'package:ezzproject/screens/users/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'eventsorders.dart';
import 'revieworder.dart';
import 'showmarsol.dart';
Widget requests(context,homelogic){
  List myorders = Provider.of<Notifires>(context).myorders;
  var downloador = Provider.of<Notifires>(context).dwonloador;
  return
    Directionality(textDirection: TextDirection.ltr, child:
    Container(
      child: ListView(children: [
        Container(width: MediaQuery
            .of(context)
            .size
            .width, height: MediaQuery
            .of(context)
            .size
            .height * 0.12, child:
        Container(width: MediaQuery
            .of(context)
            .size
            .width,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.12,
          decoration: BoxDecoration(
              color: Color.fromRGBO(42, 171, 227, 1),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70))),
          child: Row(children: [
            Expanded(flex: 5, child: Container(
                alignment: Alignment.center,
                child: Text("طلباتي", style: TextStyle(
                    color: Colors.white, fontSize: MediaQuery
                    .of(context)
                    .size
                    .height * 0.02),))),
          ],),)),
        Container(
          child: Row(
            children:[Expanded(child: Container(alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,top: 15),
              child: InkWell(onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder:(context){
                  return Eventorder();
                }));
              },
                child: Text("طلبات الطهاة", style: TextStyle(fontSize: MediaQuery
                    .of(context)
                    .textScaleFactor * 12, color: Colors.red, fontWeight: FontWeight.bold),),
              ),)),Expanded(child: Container(alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: MediaQuery
                  .of(context)
                  .size
                  .width * 0.1, top: 15),
              child: Text("جميع الطلبات", style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .textScaleFactor * 12, fontWeight: FontWeight.bold),),)),],
          ),
        )
        , Directionality(textDirection: TextDirection.rtl,
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
                  .height * 0.75,
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
                                    Container(child: Row(children: [
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
                                                .width * 0.02, left: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.02),
                                        child: FittedBox(child: AutoSizeText(
                                          "رقم الطلب :", maxFontSize: MediaQuery
                                            .of(context)
                                            .textScaleFactor * 10,
                                          minFontSize: MediaQuery
                                              .of(context)
                                              .textScaleFactor * 10,
                                          style: TextStyle(fontSize: MediaQuery
                                              .of(context)
                                              .textScaleFactor * 10),)),)),
                                      Expanded(child: Container(
                                          alignment: Alignment.centerRight,
                                          child: FittedBox(child: AutoSizeText(
                                            myorders[i]["OrderCode"].toString(),
                                            style: TextStyle(
                                                fontSize: MediaQuery
                                                    .of(context)
                                                    .textScaleFactor * 10,
                                                color: Color.fromRGBO(
                                                    41, 45, 43, 1)),))))
                                    ])),
                                    Container(alignment: Alignment.centerLeft,
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
                                            child: FittedBox(
                                                child: AutoSizeText(
                                                  "نوع الخدمة :",
                                                  maxFontSize: MediaQuery
                                                      .of(context)
                                                      .textScaleFactor * 10,
                                                  minFontSize: MediaQuery
                                                      .of(context)
                                                      .textScaleFactor * 10,
                                                  style: TextStyle(
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .textScaleFactor *
                                                          10),)),)),
                                          Expanded(child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Directionality(
                                                  textDirection: TextDirection
                                                      .ltr,
                                                  child: FittedBox(
                                                      child: AutoSizeText(
                                                        myorders[i]["Type"],
                                                        style: TextStyle(
                                                            fontSize: MediaQuery
                                                                .of(context)
                                                                .textScaleFactor *
                                                                10),)))))
                                        ])),
                                    Container(
                                      child: myorders[i]["Amount"] == null
                                          ? Container()
                                          : Container(
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
                                              child: FittedBox(
                                                  child: AutoSizeText(
                                                    "قيمة الطلب :",
                                                    maxFontSize: MediaQuery
                                                        .of(context)
                                                        .textScaleFactor * 10,
                                                    minFontSize: MediaQuery
                                                        .of(context)
                                                        .textScaleFactor * 10,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery
                                                            .of(context)
                                                            .textScaleFactor *
                                                            10),)),)),
                                            Expanded(child: Container(
                                                alignment: Alignment
                                                    .centerRight,
                                                child: Directionality(
                                                    textDirection: TextDirection
                                                        .ltr,
                                                    child: FittedBox(
                                                        child: AutoSizeText(
                                                          myorders[i]["Amount"]
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: MediaQuery
                                                                  .of(context)
                                                                  .textScaleFactor *
                                                                  10),)))))
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
                                                child: FittedBox(
                                                    child: AutoSizeText(
                                                      "تاريخ الطلب :",
                                                      maxFontSize: MediaQuery
                                                          .of(context)
                                                          .textScaleFactor * 10,
                                                      minFontSize: MediaQuery
                                                          .of(context)
                                                          .textScaleFactor * 10,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .textScaleFactor *
                                                              10),))),)),
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
                                                        myorders[i]["OrderDate"],
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
                                            child: Directionality(
                                                textDirection: TextDirection
                                                    .rtl,
                                                child: FittedBox(
                                                    child: AutoSizeText(
                                                      "اسم التاجر : ",
                                                      maxFontSize: MediaQuery
                                                          .of(context)
                                                          .textScaleFactor * 10,
                                                      minFontSize: MediaQuery
                                                          .of(context)
                                                          .textScaleFactor * 10,
                                                      style: TextStyle(
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .textScaleFactor *
                                                              10),))),)),
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
                                                        myorders[i]["StoreName"],
                                                        style: TextStyle(
                                                            fontSize: MediaQuery
                                                                .of(context)
                                                                .textScaleFactor *
                                                                10),))))),
                                        ])),
                                        Container(
                                          child: Row(children: [
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
                                              child: AutoSizeText("الحالة :",
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                        .of(context)
                                                        .textScaleFactor *
                                                        13),),)),
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
                                                child: FittedBox(
                                                    child: AutoSizeText(
                                                      myorders[i]["OrderStatus"],
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(
                                                              244, 121, 27, 1),
                                                          fontSize: MediaQuery
                                                              .of(context)
                                                              .textScaleFactor *
                                                              10),))))
                                          ]),
                                        ),
                                      ],)))
                            ]),
                          ),
                          Container(margin: EdgeInsets.only(bottom: MediaQuery
                              .of(context)
                              .size
                              .height * 0.01), child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                child: Row(children: [
                            InkWell(onTap: () =>
                                  gotodetail(myorders[i]["ID"], myorders[i],context),
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
                                              child: AutoSizeText("التفاصيل",
                                                  style: TextStyle(
                                                      fontSize: 13, color: Colors
                                                      .white))),
                                        ]))),))
                            ,
                            Container(child: myorders[i]["OrderKeyStatus"].toString() ==
                                  "0" ? InkWell(onTap: () {
                                homelogic.deleteorder(myorders[i]["ID"],"0");
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
                                    ])),))
                                  : myorders[i]["Reviews"].length ==0 ? InkWell(onTap: () {
                                if( myorders[i]["OrderKeyStatus"].toString() == "3"){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                    return Revieworder(id: myorders[i]["ID"],);
                                  }));
                                }
                                else{
                                  if(myorders[i]["OrderKeyStatus"].toString() == "4" || myorders[i]["OrderKeyStatus"].toString() =="5"){
                                    Alertdialogazz.alert(context,"لا يمكنك التقييم لانه تم رفضه" );
                                  }else {
                                    Alertdialogazz.alert(context,
                                        "لا يمكنك التقييم حتى وصول الطلب");
                                  }
                                }
                            }, child: Container(width: MediaQuery
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
                                    color: Colors.yellow.withGreen(200),
                                    borderRadius: BorderRadius.circular(5)),
                                child: FittedBox(child: Row(children: [
                                  Icon(Icons.rate_review, color: Colors.white,
                                    size: 18,),
                                  Container(padding: EdgeInsets.all(MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.02),
                                      child: AutoSizeText("قيم الطلب",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors
                                            .white),)),
                                ])),)) :InkWell(onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return Revieworder(id: myorders[i]["ID"],review :myorders[i]["Reviews"]);
                              }));
                            }, child: Container(width: MediaQuery
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
                                    color: Colors.yellow.withGreen(200),
                                    borderRadius: BorderRadius.circular(5)),
                                child: FittedBox(child: Row(children: [
                                  Icon(Icons.rate_review, color: Colors.white,
                                    size: 18,),
                                  Container(padding: EdgeInsets.all(MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.02),
                                      child: AutoSizeText("رؤية التقييم",
                                        style: TextStyle(
                                            fontSize: 13, color: Colors
                                            .white),)),
                                ])),)) ),Container(
                                child:myorders[i]["OrderKeyStatus"].toString()=="3" ||myorders[i]["OrderKeyStatus"].toString()=="4"
                                    ||myorders[i]["OrderKeyStatus"].toString()=="5" ?Container(): myorders[i]["Type"] !="اماكن"? InkWell(onTap: () {
                                  if(myorders[i]["DeliveryStatus"].toString()=="2"||myorders[i]["DeliveryStatus"].toString()=="1"){
                                    print(myorders[i]["ID"]);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return Showmarsol(id:myorders[i]["ID"]);
                                    }));
                                  }
                                  else{
                                    if(myorders[i]["DeliveryStatus"].toString()=="0") {
                                      makemarsolorder(myorders[i]["ID"],context,homelogic);
                                    }
                                  }},
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
                                                child: AutoSizeText(myorders[i]["DeliveryStatus"].toString()=="1"?"رؤية العروض" :
                                                myorders[i]["DeliveryStatus"].toString()=="2"?"تم اختيار مرسول" : "طلب مرسول",
                                                    style: TextStyle(
                                                        fontSize: 13, color: Colors
                                                        .white))),
                                          ]))),)):Container(),
                            ),
                            Container(
                              child:myorders[i]["OrderKeyStatus"].toString()=="1"? InkWell(onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return Chat(id: myorders[i]["ProviderID"],messags: [],providername: myorders[i]["StoreName"],);
                                }));
                                }, child: Container(width: MediaQuery
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
                          ]),
                              ))
                        ],
                      ),
                    );
                  }),
            ),
          ),
        )
      ],),
    ));
}
makemarsolorder(id,context,homelogic){
  return showDialog(
    barrierDismissible: false, context: context, builder: (context) {
    return StatefulBuilder(
        builder: (contexta, setState) {
          return AlertDialog(      insetPadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            content: Container(
              child: SingleChildScrollView(child:
              Column(
                children: [ Form(
                  child: Container(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1, width: MediaQuery
                      .of(context)
                      .size
                      .width,
                      child:Container(height: MediaQuery.of(context).size.height*0.6,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Container(margin: EdgeInsets.only(bottom: 20),child: Text("طلب مرسول",style: TextStyle(color: Colors.indigo,fontSize: 20,fontWeight: FontWeight.bold),),alignment: Alignment.center,),
                          ],),
                        ),
                      ) ),
                ),
                ],
              )),
            ),actions: [
              ElevatedButton(
                child: Text("ارسال"), onPressed: () {
                Navigator.of(context).pop("dialog");
                homelogic.makeordermarsol(id);
              },),
              ElevatedButton(
                child: Text("الغاء"), onPressed: () {
                Navigator.of(context).pop("dialog");
              },),
            ],
          );
        });},
  );
}
gotodetail(id ,data,context){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Orderdata2(data: data,);
  }));
}