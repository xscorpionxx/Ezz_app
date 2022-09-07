import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Orderdata2 extends StatefulWidget {
  var data ;
  Orderdata2({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateorderdata2(data :data);
  }
}
class Stateorderdata2 extends State<Orderdata2> {
  var data ;
  Stateorderdata2({ this.data});
  @override
  void initState() {
    getdata(data["ID"]);
    super.initState();
  }
  getdata(id)async{
   if(data["Products"].length ==0) {
      var url = "https://azz-app.com/api/order_details/" + id.toString();
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      var token = sharedPreferences.getString("token");
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      });
      var body = jsonDecode(response.body);
      if (body["status"] == true) {
        data["Products"] = body["details"];
        print(data);
        setState(() {});
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement buildr;
    return  Scaffold(body:
    Container(
      child:SingleChildScrollView(
        child:data["Reservation"] !=null?Reservation() :Column(
          children:[
            Container(margin: EdgeInsets.only(top: 40),child: Row(children: [
              Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.clear,size: 22,color: Colors.black,),onPressed: (){Navigator.of(context).maybePop();},))),
              Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 40),child: Text("بيانات الطلب ",style: TextStyle(color: Color.fromRGBO(65, 65, 65, 1),fontSize: 16,fontWeight: FontWeight.bold),))),
            ],),),
            Directionality(textDirection: TextDirection.ltr,
              child: Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,top: MediaQuery.of(context).size.height*0.02,right: 40) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child: Text(data["OrderCode"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
                Expanded(child:Container(margin: EdgeInsets.only() ,alignment: Alignment.centerRight ,child: Text("رقم الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),),
            ),
            Directionality(textDirection: TextDirection.ltr,
              child: Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: 35) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["Type"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
                Expanded(child:Container(margin: EdgeInsets.only() ,alignment: Alignment.centerRight ,child: Directionality( textDirection: TextDirection.rtl,child: Text("نوع الخدمة",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),)))),]),),
            ), Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["StoreName"],style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
              Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("اسم التاجر",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),),
            Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["OrderDate"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
              Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("تاريخ الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),),
            Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Text(data["PromoCode"].toString() =="null"?"لا يوجد" :data["PromoCode"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold)))),
              Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("كوبون الخصم",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),)
            ,Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ) ,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),child: Row(children: [
              Expanded(child: Container(alignment: Alignment.center ,child: Text(data["Address"],style: TextStyle(fontSize: 14,color: Color.fromRGBO(65, 65, 65, 1))),)),
              Expanded(child: Container(alignment: Alignment.centerRight ,child: Text("العنوان",style: TextStyle(fontSize: 15,color: Color.fromRGBO(42, 171, 227, 1),fontWeight: FontWeight.bold)),)),
            ],),),
            Container(height: MediaQuery.of(context).size.height*0.25,child: ListView.builder(physics: BouncingScrollPhysics() ,itemCount: data["Products"].length ,itemBuilder: (context,i){
              return Container(decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),
                margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.01,left:MediaQuery.of(context).size.width*0.05 ,right: MediaQuery.of(context).size.width*0.05) ,child: Row(children: [
                  Expanded(child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child: Text(data["Products"][i]["SalePrice"].toString() + 'ريال',style: TextStyle(fontSize:13,color: Color.fromRGBO(12, 145, 190, 1),fontWeight: FontWeight.bold))),) ),
                  Expanded(flex: 3,child:Container( margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Column(children: [
                    Container(child: Text(data["Products"][i]["Name"],style: TextStyle(fontSize: 15,color: Color.fromRGBO(30, 22, 14, 1))),),
                    Directionality(textDirection: TextDirection.rtl,child: Container(child: Text("العدد :" +data["Products"][i]["quantity"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13)),))
                  ],),) ),
                  Expanded(child:Container(height: MediaQuery.of(context).size.height*0.08,child: Image(fit: BoxFit.fill,image: NetworkImage(data["Products"][i]["Photo"]),),) )
                ],),);
            }),),
            Container( height: MediaQuery.of(context).size.height*0.25,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),margin: EdgeInsets.only( bottom:MediaQuery.of(context).size.height*0.1 ,top: MediaQuery.of(context).size.height*0.01,left:MediaQuery.of(context).size.width*0.05 ,right: MediaQuery.of(context).size.width*0.05)
              ,child: Column(children: [
                Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: 10,right: 20),child: Text("بيانات الطلب ",style: TextStyle(color: Color.fromRGBO(65, 65, 65, 1),fontSize: 16,fontWeight: FontWeight.bold),))
                ,Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),child: Row(children: [
                  Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child:Directionality(textDirection: TextDirection.rtl,child: Text(data["Amount"].toString()+"ريال",style: TextStyle(color: Colors.black38,fontSize: 16),)))),
                  Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20),child: Text("سعر الطلب ",style: TextStyle(color: Colors.black38,fontSize: 16),))),
                ],),),
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                  Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child:Text(data["PromoCode"] !=null ? data["PromoCode"].toString() : "لا يوجد قسيمة",style: TextStyle(color: Colors.black38,fontSize: 16),) )),
                  Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20),child: Text("كوبون الخصم",style: TextStyle(color: Colors.black38,fontSize: 16),))),
                ],),),
                Divider(color: Color.fromRGBO(240, 240, 240, 1)),
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                  Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: Directionality(textDirection: TextDirection.rtl,child:Text(data["Amount"].toString()+"ريال",style: TextStyle(color: Color.fromRGBO(42, 171, 227, 1),fontSize: 16,fontWeight: FontWeight.bold),)))),
                  Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),child: Text("الاجمالي ",style: TextStyle(color: Color.fromRGBO(42, 171, 227, 1),fontSize: 16,fontWeight: FontWeight.bold),))),
                ],),)
              ],),)

            ,],
        ),
      ),
    ));
  }
 Widget Reservation(){
    return Column(
      children:[
        Container(margin: EdgeInsets.only(top: 40),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.clear,size: 22,color: Colors.black,),onPressed: (){Navigator.of(context).maybePop();},))),
          Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 40),child: Text("بيانات الطلب ",style: TextStyle(color: Color.fromRGBO(65, 65, 65, 1),fontSize: 16,fontWeight: FontWeight.bold),))),
        ],),),
        Directionality(textDirection: TextDirection.ltr,
          child: Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,top: MediaQuery.of(context).size.height*0.02,right: 40) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child: Text(data["OrderCode"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
            Expanded(child:Container(margin: EdgeInsets.only() ,alignment: Alignment.centerRight ,child: Text("رقم الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),),
        ),
        Directionality(textDirection: TextDirection.ltr,
          child: Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ,right: 35) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["Type"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
            Expanded(child:Container(margin: EdgeInsets.only() ,alignment: Alignment.centerRight ,child: Directionality( textDirection: TextDirection.rtl,child: Text("نوع الخدمة",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),)))),]),),
        ),
        Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Directionality( textDirection: TextDirection.rtl,child:Text(data["OrderDate"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold))))),
          Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("تاريخ الطلب",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),),
        Container(margin: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.1 ) ,child: Row(children:[ Expanded(child:Container(alignment: Alignment.centerLeft ,child: Text(data["PromoCode"].toString() =="null"?"لا يوجد" :data["PromoCode"].toString(),style: TextStyle(color: Color.fromRGBO(12, 145, 190, 1),fontSize: 13,fontWeight: FontWeight.bold)))),
          Expanded(child:Container(margin: EdgeInsets.only(right: 35),alignment: Alignment.centerRight ,child: Text("كوبون الخصم",style: TextStyle(fontSize: 13,color: Color.fromRGBO(41, 45, 43, 1)),))),]),)
        ,Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: 60,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ) ,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center ,child: Text(data["Reservation"]["Name"].toString(),style: TextStyle(fontSize: 14,color: Color.fromRGBO(65, 65, 65, 1))),)),
          Expanded(child: Container(alignment: Alignment.centerRight ,child: Text("اسم المكان",style: TextStyle(fontSize: 15,color: Color.fromRGBO(42, 171, 227, 1),fontWeight: FontWeight.bold)),)),
        ],),),
        Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ) ,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center ,child: Text(data["Reservation"]["StartDate"].toString(),style: TextStyle(fontSize: 14,color: Color.fromRGBO(65, 65, 65, 1))),)),
          Expanded(child: Container(alignment: Alignment.centerRight ,child: Text("تاريخ الاقامة من",style: TextStyle(fontSize: 15,color: Color.fromRGBO(42, 171, 227, 1),fontWeight: FontWeight.bold)),)),
        ],),),
        Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ) ,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center ,child: Text(data["Reservation"]["EndDate"].toString(),style: TextStyle(fontSize: 14,color: Color.fromRGBO(65, 65, 65, 1))),)),
          Expanded(child: Container(alignment: Alignment.centerRight ,child: Text("تاريخ الاقامة الى",style: TextStyle(fontSize: 15,color: Color.fromRGBO(42, 171, 227, 1),fontWeight: FontWeight.bold)),)),
        ],),),
        Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ) ,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(240, 240, 240, 1))),child: Row(children: [
          Expanded(child: Container(alignment: Alignment.center ,child: Text(data["Amount"].toString(),style: TextStyle(fontSize: 14,color: Color.fromRGBO(65, 65, 65, 1))),)),
          Expanded(child: Container(alignment: Alignment.centerRight ,child: Text("قيمة الاقامة",style: TextStyle(fontSize: 15,color: Color.fromRGBO(42, 171, 227, 1),fontWeight: FontWeight.bold)),)),
        ],),)


        ,],
    );
  }
}