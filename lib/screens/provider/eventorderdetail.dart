import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Eventdetail extends StatefulWidget {
  var data ;
  Eventdetail({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateEventdetail(data :data);
  }
}
class StateEventdetail extends State<Eventdetail> {
  var data ;
  StateEventdetail({ this.data});
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildr;
    return  Scaffold(body:
    Container(
      child:SingleChildScrollView(
        child:Column(
          children:[
            Container(margin: EdgeInsets.only(top: 40),child: Row(children: [
              Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.clear,size: 22,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},))),
              Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 40),child: Text("بيانات الطلب ",style: TextStyle(color: Color.fromRGBO(65, 65, 65, 1),fontSize: 16,fontWeight: FontWeight.bold),))),
            ],),),
            Directionality(textDirection: TextDirection.ltr,
              child: Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,top: MediaQuery.of(context).size.height*0.1,right: 35) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child: Text(data["User"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
                Expanded(child:Container(margin: EdgeInsets.only() ,alignment: Alignment.centerRight ,child: Directionality( textDirection: TextDirection.rtl,child: Text("اسم المستخدم",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),)))),]),),
            ),
            Directionality(textDirection: TextDirection.ltr,
              child: Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: 35) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["EventType"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
                Expanded(child:Container(margin: EdgeInsets.only() ,alignment: Alignment.centerRight ,child: Directionality( textDirection: TextDirection.rtl,child: Text("نوع الخدمة",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),)))),]),),
            ),
            Directionality(textDirection: TextDirection.ltr,
              child: Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: 35) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["EventStatusMessage"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
                Expanded(child:Container(margin: EdgeInsets.only() ,alignment: Alignment.centerRight ,child: Directionality( textDirection: TextDirection.rtl,child: Text("حالة الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),)))),]),),
            ),
            Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["EventDate"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
              Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("تاريخ الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),),
            Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ) ,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),child: Row(children: [
              Expanded(child: Container(alignment: Alignment.center ,child: AutoSizeText(data["EventAddress"],maxLines: 3,style: TextStyle(fontSize: 14,color: Color.fromRGBO(65, 65, 65, 1))),)),
              Expanded(child: Container(alignment: Alignment.centerRight ,child: Text("العنوان",style: TextStyle(fontSize: 15,color: Color.fromRGBO(42, 171, 227, 1),fontWeight: FontWeight.bold)),)),
            ],),),
            Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1,top: 20 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["EventTime"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
              Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("توقيت الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),)
, Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1,top: 10 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["EventDetails"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
              Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("تفاصيل الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),)
            ,],
        ),
      ),
    ));
  }
}