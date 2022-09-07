import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/shoppingcart.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

import 'notification.dart';

class Reservation extends StatefulWidget{
  var price;
  var price2;
  var id;
  var idprovider;
  Reservation({this.price,this.id,this.price2,this.idprovider});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statereser(price: price,id: id,price2: price2,idprovider: idprovider);
  }
}
class Statereser extends State<Reservation>{
  TextEditingController babiesnum;
  TextEditingController adultnum;
  TextEditingController discount;
  Signuplogic signuplogic;
  var price;
  var price2;
  var id;
  var idprovider;
  Statereser({this.price,this.id,this.price2,this.idprovider});
  var dateable1 = false;
  Shoppingcartlogic shoppingcartlogic;
  var dateable2 = false;
  var date1 ;
  var date2;
  int totalprice = 0;
  int discountre = 0;
  int numofday = 0;
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  void initState() {
    signuplogic = new Signuplogic(context);
    shoppingcartlogic = new Shoppingcartlogic(context);
    babiesnum = new TextEditingController();
    adultnum = new TextEditingController();
    discount = new TextEditingController();
    super.initState();
  }
  var value = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: SingleChildScrollView(physics: ClampingScrollPhysics(),
    child: Column(children: [
      Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
        Expanded(child: Container(alignment: Alignment.centerLeft ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){Navigator.of(context).pop();},))),
        Expanded(flex: 2,child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),child: Text("طلب الحجز ",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.04),))),
      ],),)
      ,Container(
        child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.05)),child:
          InkWell(onTap: (){
           showhist2();
          },
            child: ListTile(trailing:Transform.translate(
              offset: Offset(-8, 0),
              child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/calendarazz.png"),fit: BoxFit.scaleDown,)),
            ) ,title:  AutoSizeText(date2 ==null? 'تاريخ المغادرة':date2,maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38))),
          ),)),
          Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.05)),child:
          InkWell(onTap: (){
            showhist1();
          }, child: ListTile(trailing:Transform.translate(
              offset: Offset(-8, 0),
              child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/calendarazz.png"),fit: BoxFit.scaleDown,)),
            ) ,title:  AutoSizeText(date1==null? 'تاريخ الوصول':date1.toString(),maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38))),
          ),))],),),
      ),
      Container(
        child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [Expanded(child:Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.05)),child:
        ListTile(trailing:Transform.translate(
          offset: Offset(-8, 0),
          child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/babyazz.png"),fit: BoxFit.scaleDown,)),
        ) ,title:TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.blue),keyboardType: TextInputType.number,controller: babiesnum,decoration: InputDecoration(border: InputBorder.none,hintText: "عدد الأطفال",hintStyle:TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38) ),)),)),
          Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12.withOpacity(0.05)),child:
          ListTile(trailing:Transform.translate(
            offset: Offset(-8, 0),
            child: Container( child : Icon(Icons.people_alt,color: Colors.black12,)),
          ) ,title:  TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.blue),keyboardType: TextInputType.number,controller: adultnum,decoration: InputDecoration(border: InputBorder.none,hintText: "عدد البالغين",hintStyle:TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38) ),)),))],),),
      ),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.05) ,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black26,width: 2) ,color: Colors.white,borderRadius: BorderRadius.circular(20)),child: Row(children: [
        Expanded(child: InkWell(onTap: ()=>discounts(),child: Container(height: MediaQuery.of(context).size.height*0.06,width: MediaQuery.of(context).size.width*0.25,alignment: Alignment.center,child: Text("تطبيق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),),decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),)))
        ,Expanded(flex: 3,child: Container(child: Directionality(textDirection: ui.TextDirection.rtl,child: TextFormField(controller: discount,decoration: InputDecoration( hintText: "قسيمة الخصم",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),border: InputBorder.none),))))]),),
      Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05 ,right: MediaQuery.of(context).size.width*0.1,left: MediaQuery.of(context).size.width*0.1) ,child: Text("الدفع",style: TextStyle(fontSize: 15),),),
     Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1,top: 10)
        ,child: Row(children: [ Expanded(child:Container(child: Text(price.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
          Expanded(child:Container(alignment: Alignment.centerRight ,child: Directionality(textDirection: ui.TextDirection.rtl,child:Text("سعر الليلة داخل الاسبوع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),)))),],),)
        , Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.09)
          ,child: Row(children: [ Expanded(child:Container(child: Text(price2.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
            Expanded(child:Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Directionality(textDirection: ui.TextDirection.rtl,child:Text("سعر الليلة نهاية الاسبوع",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),)))),],),
      ),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
        ,child: Row(children: [ Expanded(child:Container(child: Text(numofday.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
          Expanded(child:Container(alignment: Alignment.centerRight ,child: Directionality(textDirection: ui.TextDirection.rtl,child:Text("عدد الليالي",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),)))),],),),
    Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
    ,child: Row(children: [ Expanded(child:Container(child: Text(discountre.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
    Expanded(child:Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Text(" خصم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),],),),
     // Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
       // ,child: Row(children: [ Expanded(child:Container(child: Text("200",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
       //   Expanded(child:Container(alignment: Alignment.centerRight ,child: Text("ضريبة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),],),),
      Container(margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01 ,right: MediaQuery.of(context).size.width*0.1,left: MediaQuery.of(context).size.width*0.4),child: Divider(thickness: 1.1,color: Colors.black,),),
      Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:  MediaQuery.of(context).size.width*0.1)
        ,child: Row(children: [ Expanded(child:Container(child: Text((int.parse(totalprice.toString()) - discountre ).toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
          Expanded(child:Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.centerRight ,child: Text("الاجمالي",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),))),],),),
      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03 ,right: MediaQuery.of(context).size.width*0.05),child: CheckboxListTile(activeColor: Colors.green ,value: value,onChanged: (val){setState(() {
        value = val;
      });},title:Transform.translate(
    offset: const Offset(100, 0),
    child: Container(alignment: Alignment.centerRight ,child:Row(children:[ InkWell(onTap: (){
    signuplogic.viewrules();
    },child: Text(" الشروط والأحكام" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.red,decoration: TextDecoration.underline),)),Text("أوافق على",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,),),])),
    ) ),),
       Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
         child: InkWell(onTap: (){
           if(numofday !=0) {
             shoppingcartlogic.reservation(
                 date1,
                 date2,
                 value,
                 discount.text,
                 id,
                 babiesnum.text,
                 adultnum.text,
                 (int.parse(totalprice.toString()) - discountre).toString());
           }
           else{
             Alertdialogazz.alert(context, "يجب تحديد التاريخ بالشكل الصحيح");
           }
    }
    ,child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
            child:Text("ارسال الطلب", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04)) ,),
         ),
       ),
    ],),),);
  }
  discounts()async{
    if(numofday !=0){
      var data = await shoppingcartlogic.addpromocodere(discount.text.toString(), totalprice.toString(),idprovider,numofday.toString());
      if(data["state"]){
        discountre = int.parse(data["value"].toString().split(".")[0]);
        setState(() {});
      }
    }
    else{
      Alertdialogazz.alert(context,"لا يمكن تطبيق القسيمة حتى تختار التاريخ" );
    }
  }
  showhist1(){
    var value = DateTime.now().toString().substring(0,10);
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                          child: CalendarDatePicker(initialDate:DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 10000)),onDateChanged: (val){
                            value= val.toString().substring(0,10);
                          },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
              Navigator.of(context).pop("dialog");
                setState(() {
                date1 = value;
                computenum();
              });
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
  computenum(){
    if(date1 !=null && date2 !=null) {
      if (!DateTime.parse(date1).isAfter(DateTime.parse(date2))) {
        double totalprice = 0;
        int daysBetween(DateTime from, DateTime to) {
          from = DateTime(from.year, from.month, from.day);
          to = DateTime(to.year, to.month, to.day);
          return (to
              .difference(from)
              .inHours / 24).round();
        }
        int days = daysBetween(DateTime.parse(date1), DateTime.parse(date2));
        for (int f = 0; f < days; f++) {
          var day = DateFormat('EEEE').format(DateTime.parse(date1).add(Duration(days: f)));
          if(day == "Thursday" ||day == "Friday" ){
             totalprice = totalprice + double.parse(price2.toString());
          }
          else{
            totalprice = totalprice + double.parse(price.toString());
          }
        }
        setState(() {
          numofday = days;
          this.totalprice = int.parse(totalprice.toString().split(".")[0].toString());
        });
      }
      else{
        Alertdialogazz.alert(context, "لا يمكن أن يكون يوم الوصول بعد المغادرة");
      }
    }
  }
  showhist2(){
    var value = DateTime.now().toString().substring(0,10);
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                          child: CalendarDatePicker(initialDate:DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 10000)),onDateChanged: (val){
                            value= val.toString().substring(0,10);
                          },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
              Navigator.of(context).pop("dialog");
                setState(() {
                date2 = value;
                computenum();
              });
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
}
