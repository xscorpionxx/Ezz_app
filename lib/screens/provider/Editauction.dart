import 'dart:io';
import 'package:ezzproject/logic/addauction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Editauction extends StatefulWidget{
  var service ;
  Editauction({this.service});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddauction(service: service);
  }
}
class Stateaddauction extends State<Editauction>{
  TextEditingController name ;
  TextEditingController detail ;
  TextEditingController price ;
  GlobalKey<FormState> key;
  Addauctionlogic addauctionlogic;
  var service ;
  Stateaddauction({this.service});
  var photo;
  var typevalue;
  List typelist =["الابل" ,"رأس الأغنام"];
  @override
  void initState() {
    addauctionlogic = new Addauctionlogic(context);
    name = new TextEditingController();
    price = new TextEditingController();
    detail = new TextEditingController();
    key = new GlobalKey<FormState>();
    if(service["Name"] !=null){
      name.text = service["Name"].toString();
    }
    price.text = service["StartPrice"].toString();
    detail.text = service["Description"];
    photo = service["Photo"];
    typevalue = service["Type"];
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
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("تعديل مزاد",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*18),))),
                Expanded(child: Container())
              ],),) ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.05) ,child: Text("تعديل خدمة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)
          , Container(height: MediaQuery.of(context).size.height*0.15 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),child:image != null?Container(
            child: InkWell( onTap: ()=>chooseimage(),child: Image( fit: BoxFit.fill,image: FileImage(image),)),
          ) : InkWell( onTap: ()=>chooseimage(),child: Image( fit: BoxFit.fill,image: NetworkImage(photo))) )
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
          )),Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addauctionlogic.validate,controller: detail,onChanged: (val){
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
              validator: addauctionlogic.validate,maxLength: 6,keyboardType: TextInputType.number,textInputAction: TextInputAction.send,controller: price,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "يبدأ المزاد من "),
            )),
          ),
          Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap: ()=>addauctionlogic.editauction(service["ID"],key, detail.text, price.text,typevalue, image),
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
                child:Text("تعديل", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )

        ],),
      ),
    ),);
  }
}