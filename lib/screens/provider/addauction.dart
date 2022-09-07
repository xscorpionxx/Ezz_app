import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/addauction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Addauction extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddauction();
  }
}
class Stateaddauction extends State<Addauction>{
  TextEditingController name ;
  TextEditingController detail ;
  TextEditingController price ;
  TextEditingController price2 ;
  GlobalKey<FormState> key;
  Addauctionlogic addauctionlogic;
  var typevalue;
  List typelist =["الابل" ,"رأس الأغنام"];
  @override
  void initState() {
    addauctionlogic = new Addauctionlogic(context);
    name = new TextEditingController();
    price = new TextEditingController();
    price2 = new TextEditingController();
    detail = new TextEditingController();
    key = new GlobalKey<FormState>();
    super.initState();
  }
  File image ;
  var date1 ;
  var date2;
  var dateable1 =false;
  var dateable2 = false;
  chooseimage()async{
    var status =await Permission.camera.status;
    var takepermission =await Permission.camera.request();
    if(takepermission.isGranted) {
      var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 != null) {
        image = File(image1.path);
        setState(() {});
      }
    }
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
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("اضافة مزاد",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*18),))),
                Expanded(child: Container())
              ],),) ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.05) ,child: Text("اضافة خدمة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)
          , Container(height: MediaQuery.of(context).size.height*0.15 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child:image != null?Container(
            child: InkWell(onTap: ()=>chooseimage(),child: Image( fit: BoxFit.fill,image: FileImage(image),)),
          ) : DottedBorder(color: Colors.red.withOpacity(0.2),
            child: InkWell(onTap: ()=>chooseimage(),
              child: Center(child: Column(children: [
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon( Icons.cloud_upload,size: MediaQuery.of(context).textScaleFactor*40,)),
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.02),child: Text("رفع صورة " , style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13,),),)
              ],),),
            ),
          ) )
          ,Directionality(textDirection: TextDirection.rtl, child: InkWell(
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child:
                ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text("المزاد"),
                        value: typevalue
                        ,items: typelist.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                        Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==typevalue?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                        onChanged: (_) {
                          typevalue =_;
                          setState(() {});
                        },
                      )),
                )),
          )) ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addauctionlogic.validate,textInputAction: TextInputAction.send,toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),controller: detail,onChanged: (val){
              if (val.contains("0") ||val.contains("2")||
                  val.contains("1")||val.contains("3")|val.contains("4")||
                  val.contains("5")||val.contains("6")||val.contains("7")||val.contains("8")
                  ||val.contains("9")||val.contains("٠") ||val.contains("١")||
                  val.contains("٢")||val.contains("٣")|val.contains("٤")||
                  val.contains("٥")||val.contains("٦")||val.contains("٧")||val.contains("٨")
                  ||val.contains("٩")) {
                setState(() {
                  detail.text ="";
                });
              }
            },style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "التفاصيل"),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addauctionlogic.validate,keyboardType: TextInputType.number,textInputAction: TextInputAction.send,maxLength: 6,controller: price,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "يبدأ المزاد من "),
            )),
          ),
          Container( child:!dateable1?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 365)) ,lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now(), onDateChanged: (val){
            setState(() {
              date1 = val.toString().substring(0,10);
            });
          },),)),
          Container( child:!dateable2?Container():  Container(width: MediaQuery.of(context).size.width,child: CalendarDatePicker(firstDate: DateTime.now().subtract(Duration(days: 365)) ,lastDate:DateTime.now().add(Duration(days: 356))  ,currentDate: DateTime.now(),initialDate:DateTime.now(), onDateChanged: (val){
            setState(() {
              date2 = val.toString().substring(0,10);
            });
          },),)),
          Container(child:dateable2||dateable1? Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.2,right:MediaQuery.of(context).size.width*0.2 ),child:InkWell( onTap: (){
            dateable1 = false;
            dateable2 =false ;
            setState(() {});
          },child: Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),color: Color.fromRGBO(69, 190, 0, 1) ,child: Center(child: Text("تم" ,style: TextStyle(color: Colors.white),)))),):Container()),
          Container(child: dateable1 || dateable2?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black38),color: Colors.white.withOpacity(0.1)),child:
            InkWell(onTap: (){
              setState(() {
                dateable2 = true;
              });
            },
              child: ListTile(trailing:Transform.translate(
                offset: Offset(-8, 0),
                child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/calendarazz.png"),fit: BoxFit.scaleDown,)),
              ) ,title:  Text(date2 ==null? 'تاريخ انتهاء':date2,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black))),
            ),)),
              Expanded(child: Container( padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.08,alignment: Alignment.center,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.black38),color: Colors.white.withOpacity(0.1)),child:
              InkWell(onTap: (){
                setState(() {
                  dateable1 = true;
                });
              },
                child: ListTile(trailing:Transform.translate(
                  offset: Offset(-8, 0),
                  child: Container(width: MediaQuery.of(context).size.width*0.06,height: MediaQuery.of(context).size.height*0.07 ,child : Image(image: AssetImage("images/calendarazz.png"),fit: BoxFit.scaleDown,)),
                ) ,title:  Text(date1==null? 'تاريخ البدء':date1.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black))),
              ),))],),),
          ),Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap:()=> addauctionlogic.addauction(key,detail.text,  image , date1,date2,typevalue,price.text),
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
                child:Text("اضافة", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )

        ],),
      ),
    ),);
  }
}