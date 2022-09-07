import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chat.dart';

class Showmarsol extends StatefulWidget{
  var id;
  Showmarsol({this.id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateShowmarsol(id:id);
  }
}
class StateShowmarsol extends State<Showmarsol>{
  var id;
  StateShowmarsol({this.id});
  TextEditingController cuponame ;
  TextEditingController price ;
  GlobalKey<FormState> key;
  Homelogic homelogic;
  var download = true;
  var selected = false;
  var slectedindex ;
  List offers =[];
  getdata(id)async{
    var data = await homelogic.getmarsoloffers(id);
    offers = data;
    for(int i = 0; i <offers.length ; i++){
      if(offers[i]["status"].toString()=="1"){
        selected = true;
        slectedindex = i;
      }
    }
    download = false;
    setState(() {});
  }
  @override
  void initState() {
    homelogic = new Homelogic(context);
    cuponame = new TextEditingController();
    price = new TextEditingController();
    key = new GlobalKey<FormState>();
    super.initState();
    getdata(id);
  }
  List selectservice =[];
  navigateback(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
          child:ListView(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("عروض مراسيل",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
                Expanded(child: Container())
              ],),) ),
            Container(child:!selected? Container():
            Directionality(textDirection: TextDirection.rtl
                ,child: Container(margin: EdgeInsets.only(top: 25,right: 20),alignment: Alignment.centerRight,child:
            Text("تم اختيار المرسول حسب طلبك يمكنك بدء المحادثة معه",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.indigo,fontSize: 13),),)))
            ,Container(margin: EdgeInsets.only(top: 5),child:download?Container(height: MediaQuery.of(context).size.height*0.8 ,child: Center(child: CircularProgressIndicator(),),): offers.length==0?Container(height: MediaQuery.of(context).size.height*0.8 ,child: Center(child: Container(child: Text("لا يوجد عروض بعد"),),)):
            selected ?Container(height: MediaQuery.of(context).size.height*0.2,decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 1.0,
                spreadRadius: 7.0,
                offset: Offset(3.0, 3.0),
              )
            ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "قيمة العرض :  "+offers[slectedindex]["offer"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),),
              Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText( "الشرح  :  "+offers[slectedindex]["desc"].toString(),maxLines: 1,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),)),),
              Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
                child: Row(children: [
                  Expanded(child: Container(
                    child:InkWell(onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Chat(id: offers[slectedindex]["provider_id"],messags: [],providername: offers[slectedindex]["name"],);
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
                              ]))),)),
                  )),
                  Expanded(child: Container(//margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.red),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.clear,color: Colors.red,)),Text("رفض الطلب",style: TextStyle(color: Colors.red),) ],)
                  )),
                  Expanded(child: Container())
                ]),
              ))
            ],),) :Container(height: MediaQuery.of(context).size.height*0.8 ,
              child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: offers.length,itemBuilder: (context,i){
                return Container(decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 1.0,
                    spreadRadius: 7.0,
                    offset: Offset(3.0, 3.0), // shadow direction: bottom right
                  )
                ],color: Colors.white ,),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Column(children: [
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text( "قيمة العرض :  "+offers[i]["offer"].toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),),
                  Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,right: MediaQuery.of(context).size.width*0.08),alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText( "الشرح  :  "+offers[i]["desc"].toString(),maxLines: 1,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),)),),
                  Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.03,right:MediaQuery.of(context).size.width*0.03 ),
                    child: Row(children: [
                      Expanded(child: Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),child: InkWell( onTap: (){
                        homelogic.selectmarsoloffer(offers[i]["order_id"],offers[i]["provider_id"]);
                      },child: Container(height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.green),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.check,color: Colors.green,)),Text("قبول العرض",style: TextStyle(color: Colors.green),) ],),)))),
                      Expanded(child: Container(//margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.02 ),height: MediaQuery.of(context).size.height*0.05 ,alignment: Alignment.centerRight ,decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.red),borderRadius: BorderRadius.circular(7)) ,child:  Row(children: [Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Icon(Icons.clear,color: Colors.red,)),Text("رفض الطلب",style: TextStyle(color: Colors.red),) ],)
                      )),
                      Expanded(child: Container())
                    ]),
                  ))
                ],),);;
              }),
            ),)
          ],)
      ),
    ),);
  }
}