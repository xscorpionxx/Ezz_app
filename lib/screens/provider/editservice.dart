import 'dart:io';
import 'package:ezzproject/logic/addservice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Editservice extends StatefulWidget{
  var service;
  Editservice({this.service});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateeditservices(service:  service);
  }
}
class Stateeditservices extends State<Editservice>{
  TextEditingController name ;
  TextEditingController detail ;
  TextEditingController price ;
  TextEditingController priceafter;
  GlobalKey<FormState> key ;
  Addservicelogic addServices;
  var service;
  var photo;
  Stateeditservices({this.service});
  @override
  void initState() {
    addServices = new Addservicelogic(context);
    key = new GlobalKey<FormState>();
    name = new TextEditingController();
    detail = new TextEditingController();
    price = new TextEditingController();
    priceafter = new TextEditingController();
    name.text = service["Name"];
    detail.text = service["Description"].toString();
    price.text = service["Price"].toString();
    priceafter.text = service["SalePrice"].toString();
    photo = service["Photo"];
    super.initState();
  }
  File image ;
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
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("تعديل الخدمة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
                Expanded(child: Container())
              ],),) ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.05) ,child: Text("تعديل خدمة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)
          , InkWell(onTap: ()=>chooseimage(),
            child: Container(height: MediaQuery.of(context).size.height*0.15 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child:image != null?Container(
              child: Image( fit: BoxFit.fill,image: FileImage(image),),
            ) : Image( fit: BoxFit.fill,image: NetworkImage(photo),) ),
          )
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addServices.validate, controller: name,toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),onChanged: (val) {
              if (val.contains("0") ||val.contains("2")||
                  val.contains("1")||val.contains("3")|val.contains("4")||
                  val.contains("5")||val.contains("6")||val.contains("7")||val.contains("8")
                  ||val.contains("9")||val.contains("٠") ||val.contains("١")||
                  val.contains("٢")||val.contains("٣")|val.contains("٤")||
                  val.contains("٥")||val.contains("٦")||val.contains("٧")||val.contains("٨")
                  ||val.contains("٩")) {
                setState(() {
                  name.text ="";
                });
              }
            },style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم الخدمة "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addServices.validate, onChanged: (val){
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
            },controller: detail,toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "تفاصيل "),
            )),
          ),
          Row(
            children:[ Expanded(
              child: Directionality(textDirection: TextDirection.rtl,
                child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                 validator: addServices.validate,maxLength: 6, controller: priceafter,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "السعر بعد الخصم"),
                )),
              ),
            ),
              Expanded(
                child: Directionality(textDirection: TextDirection.rtl,
                  child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                    validator: addServices.validate,maxLength: 6,  controller: price,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015), keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "السعر"),
                  )),
                ),
              )],
          ),
          Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap: ()=>addServices.editservice(service["ID"], key, name.text, detail.text, price.text, priceafter.text, image),
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
                child:Text("تعديل", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )

        ],),
      ),
    ),);
  }
}