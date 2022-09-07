import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:ezzproject/logic/addservice3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class EditServices3 extends StatefulWidget{
  var service;
 EditServices3({this.service});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservices3(service: service);
  }
}
class Stateaddservices3 extends State<EditServices3>{
  var service;
  Stateaddservices3({this.service});
  TextEditingController name ;
  TextEditingController detail ;
  TextEditingController price1 ;
  TextEditingController licence ;
  TextEditingController locationurl;
  TextEditingController price2 ;
  TextEditingController id ;
  TextEditingController wcs ;
  TextEditingController numofroom ;
  TextEditingController fornum ;
  TextEditingController phone ;
  TextEditingController masaha ;
  TextEditingController name2 ;
  TextEditingController address ;
  TextEditingController ketchins ;
  TextEditingController numofroof ;
  GlobalKey<FormState> key ;
  var region1 = "المنطقة" ;
  var region2 = "المحافظة" ;
  var region3 = "المدينة";
  var type ="نوع المكان";
  List types =["نوع المكان"];
  File image1 ;
  File image2 ;
  File image3 ;
  File image4 ;
  File image5 ;
  File image6 ;
  List typesbackup =[];
  List region1list =["المنطقة"];
  List region2list =["المحافظة"];
  List region3list = ["المدينة"];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  List photos = [];
  var mainphoto;
  List regions =[];
  List citites =[];
  Addservice3logic addservice3logic;
  getdata()async{
    Future.delayed(Duration(seconds: 1) , ()async{
      var dataa = await addservice3logic.getplaces();
      regions = dataa["1"];
      for(int f = 0 ; f<regions.length;f++){
        region1back.add({"name" :regions[f]["Name"],"ID" : regions[f]["ID"].toString()});
      }
      for(int i =0 ; i<region1back.length ; i++){
        region1list.add(region1back[i]["name"].toString());
      }
      typesbackup = dataa["types"];
      for(int g =0 ; g<typesbackup.length; g++){
        types.add(typesbackup[g]["name"].toString());
      }
      types.add("نوع المكان");
      name.text = service["Name"];
      detail.text = service["Desc"];
      price1.text = service["DayRental"].toString();
      price2.text = service["WeeklyRental"].toString();
      wcs.text = service["BathroomCount"].toString();
      numofroom.text = service["RoomCount"].toString();
      fornum.text = service["SpaceCount"].toString();
      ketchins.text = service["KitchenRoomCount"].toString();
      masaha.text = service["Area"].toString();
      numofroof.text = service["LevelCount"].toString();
      address.text = service["Address"];
      locationurl.text = service["address_link"];
      type = service["Type"];
      await slecetcity(dataa["govern"]);
      await selectgovern(service["City"]);
      region2 = service["City"];
      region3 = service["Region"];
      for(int g =0 ; g<service["Photos"].length ; g++){
        if(g==0) {
          mainphoto = service["Photos"][g];
        }else{
          photos[g-1] =service["Photos"][g];
        }
      }
      List feautre =service["Feature"].toString().substring(1,service["Feature"].toString().length-1).split(",");
      for(int f = 0 ; f<features.length;f++ ){
        for(int g =0 ; g<feautre.length ; g++){
          if(feautre[g].toString().trim() ==features[f]["name"].toString().trim() ){
            features[f]["state"] =true;
          }
        }
      }
      download = false;
      setState(() {});
    });
  }
  slecetcity(name){
    region2back.clear();
    region2list.clear();
    region3back.clear();
    region3list.clear();
    for (int f = 0; f < regions.length; f++) {
      if (regions[f]["Name"].toString() == name.toString()) {
        citites = regions[f]["Cities"];
        for (int g = 0; g < regions[f]["Cities"].length; g++) {
          region2back.add({
            "name": regions[f]["Cities"][g]["Name"],
            "ID": regions[f]["Cities"][g]["ID"].toString()
          });
        }
      }
    }
    region2 = "المحافظة" ;
    region3 = "المدينة";
    region2list.add("المحافظة");
    region3list.add("المدينة");
    for (int i = 0; i < region2back.length; i++) {
      region2list.add(region2back[i]["name"].toString());
    }
    setState((){

    });
  }
  selectgovern(name){
    region3back.clear();
    region3list.clear();
    for(int f =0 ; f<citites.length ; f++){
      if(citites[f]["Name"].toString() ==name.toString()) {
        for (int g = 0; g < citites[f]["Regions"].length; g++) {
          region3back.add({
            "name": citites[f]["Regions"][g]["Name"],
            "ID": citites[f]["Regions"][g]["ID"].toString()
          });
        }
      }
    }
    region3 ="المدينة";
    region3list.add("المدينة");
    for(int i =0 ; i<region3back.length ; i++){
      region3list.add(region3back[i]["name"].toString());
    }
    setState(() {
    });
  }
  List features =[
    {"state" : false,"name" :"مسبح مفلتر"  },
    {"state" : false,"name" :"متاح للشباب"  }
    ,{"state" : false,"name" :"اقامة حفلات"  }
    ,{"state" : false,"name" :"خدمة فندقية" }
    ,{"state" : false,"name" :"يوجد حاجز"  }
    ,{"state" : false,"name" :"متاح للعوائل"  }
    ,{"state" : false,"name" :"متاح "  }
    ,{"state" : false,"name" :"مساحات خضراء"  }
  ];
  var download = true;
  @override
  void initState() {
    addservice3logic = new Addservice3logic(context);
    photos = [null,null,null,null,null];
    key = new GlobalKey<FormState>();
    name = new TextEditingController();
    detail = new TextEditingController();
    numofroof = new TextEditingController();
    price1 = new TextEditingController();
    price2 = new TextEditingController();
    licence= new TextEditingController();
    id = new TextEditingController();
    locationurl = new TextEditingController();
    phone = new TextEditingController();
    masaha = new TextEditingController();
    address= new TextEditingController();
    wcs = new TextEditingController();
    numofroom = new TextEditingController();
    fornum= new TextEditingController();
    ketchins= new TextEditingController();
    super.initState();
    getdata();
  }
  chooseimage(i) async {
    var status =await Permission.camera.status;
    var takepermission =await Permission.camera.request();
    if(takepermission.isGranted) {
      if (i == 1) {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          image1 = File(image.path);
          setState(() {});
        }
      }
      if (i == 2) {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          image2 = File(image.path);
          setState(() {});
        }
      }
      if (i == 3) {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          image3 = File(image.path);
          setState(() {});
        }
      }
      if (i == 4) {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          image4 = File(image.path);
          setState(() {});
        }
      }
      if (i == 5) {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          image5 = File(image.path);
          setState(() {});
        }
      }
      if (i == 6) {
        var image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          image6 = File(image.path);
          setState(() {});
        }
      }
    }
  }
  List selectservice =[];
  var accept=false;
  navigateback(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child:download?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("تعديل خدمة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*18),))),
                Expanded(child: Container())
              ],),) ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container( decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.05 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1)
                ,child:ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(hint: Text("نوع المكان",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),),
                        value: type
                        ,items: types.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                        Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==type?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                        onChanged: (_) {
                           type =_;
                          setState(() {});
                        },
                      )),
                )),
          )
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
               validator: addservice3logic.validate,controller: name,toolbarOptions: ToolbarOptions(
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
            },textInputAction: TextInputAction.send,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*13),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم المكان "),
            )),
          ),
        Container(child: Row(children: [
          Expanded(child: Directionality(textDirection: TextDirection.rtl,
            child: Container(height: MediaQuery.of(context).size.height*0.075, decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                ,child:ListTile(
                  title: DropdownButtonHideUnderline(
                      child: Container(height: MediaQuery.of(context).size.height*0.1,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),
                        child: DropdownButton(hint: Text("المدينة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),),
                          value: region3
                          ,items: region3list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                          Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==region3?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                          onChanged: (_) {
    if(_ !="المدينة") {
      region3 = _;
      setState(() {});
    }},
                        ),
                      )),
                )),
          )),Expanded(child: Directionality(textDirection: TextDirection.rtl,
            child: Container(height: MediaQuery.of(context).size.height*0.075, decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                ,child:ListTile(
                  title: DropdownButtonHideUnderline(
                      child: Container(height: MediaQuery.of(context).size.height*0.1,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.01),
                        child: DropdownButton(hint: Text("المحافظة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),),
                          value: region2
                          ,items: region2list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                          Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==region2?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                          onChanged: (_) {
                          if(_ !="المحافظة") {
                            region2 = _;
                            selectgovern(region2);
                            setState(() {});
                          }
                          },
                        ),
                      )),
                )),
          ))
        ],),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
              validator: addservice3logic.validate,textInputAction: TextInputAction.send,controller: address,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),maxLines: 2,minLines: 2 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "العنوان بالتفصيل "),
            )),
          ),
          Container(child: Row(children: [
            Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                  ,child:TextFormField(
                    validator: addservice3logic.validate,controller: numofroof,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد الادوار"),
                  )),
            ))
            ,Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                  ,child:TextFormField(
                    validator: addservice3logic.validate, controller: masaha,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "المساحة"),
                  )),
            )),
          ],),),
          Container(child: Row(children: [
            Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                  ,child:TextFormField(
                    validator: addservice3logic.validate,controller: fornum,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "متاح لعدد"),
                  )),
            ))
            ,Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                  ,child:TextFormField(
                    validator: addservice3logic.validate, controller: numofroom,keyboardType: TextInputType.number,inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ] ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد الغرف"),
                  )),
            )),
          ],),),
          Container(child: Row(children: [
            Expanded(child: Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) , decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.05)
                  ,child:TextFormField(
                    validator: addservice3logic.validate, controller: ketchins,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد المطابخ"),
                  )),
            ) )
            ,Expanded(child:Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02) , decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1)
                  ,child:TextFormField(
                    validator: addservice3logic.validate,controller: wcs,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "عدد دورات المياه"),
                  )),
            )),
          ],),)
        ,Container(child: Divider(color: Colors.black54,),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,left:MediaQuery.of(context).size.width*0.1)),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.14,top:MediaQuery.of(context).size.height*0.001) ,child: Text("مميزات أخرى",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.022),),)
          ,Container(height: MediaQuery.of(context).size.height*0.05,child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[0]["state"]=val;});} ,value:features[0]["state"] ,title:Container( alignment: Alignment.centerRight,child: Text(features[0]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[1]["state"]=val;});} ,value:features[1]["state"] ,title:Container( alignment: Alignment.centerRight,child: Text(features[1]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.05,child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[2]["state"]=val;});} ,value:features[2]["state"] ,title:Container( alignment: Alignment.centerRight,child: Text(features[2]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[3]["state"]=val;});} ,value:features[3]["state"] ,title:Container( alignment: Alignment.centerRight,child: Text(features[3]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.05,child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[4]["state"]=val;});} ,value:features[4]["state"] ,title:Container( alignment: Alignment.centerRight,child: Text(features[4]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[5]["state"]=val;});} ,value:features[5]["state"] ,title:Container(alignment: Alignment.centerRight,child: Text(features[5]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.05,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[6]["state"]=val;});} ,value:features[6]["state"] ,title:Container( alignment: Alignment.centerRight,child: Text(features[6]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
            ,Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: CheckboxListTile(activeColor: Colors.green,onChanged: (val){setState(() {features[7]["state"]=val;});} ,value:features[7]["state"] ,title:Container( alignment: Alignment.centerRight,child: Text(features[7]["name"],style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).textScaleFactor*11),)),),))
          ],),)
          ,Container(child: Divider(color: Colors.black54,),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,left:MediaQuery.of(context).size.width*0.1))
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.01) ,child: Text("الأسعار",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.022),),)
          ,Container(height: MediaQuery.of(context).size.height*0.08 ,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),child:Row(children: [
            Expanded(child: Container(alignment: Alignment.centerRight,child: Text("ريال",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)),
            Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,
              child: Container( padding:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03,bottom:MediaQuery.of(context).size.height*0.015 ),decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(50)),margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.03,left: MediaQuery.of(context).size.width*0.05 ),child: Center(
                child: TextFormField(
                   keyboardType: TextInputType.number,maxLength: 6,controller: price1,textDirection: TextDirection.ltr,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.blue),decoration: InputDecoration(border: InputBorder.none),
                ),
              )),
            ))
            ,Expanded(flex: 5,child: Container(alignment: Alignment.centerRight,child: Text("سعر التأجير في الأيام العادية",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*11),),))
          ],)),
          Container(height: MediaQuery.of(context).size.height*0.08 ,margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,right: MediaQuery.of(context).size.width*0.1),child:Row(children: [
            Expanded(child: Container(alignment: Alignment.centerRight,child: Text("ريال",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)),
            Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,
              child: Container( padding:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03,bottom:MediaQuery.of(context).size.height*0.015 ),decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(50)),margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.03,left: MediaQuery.of(context).size.width*0.05 ),child: Center(
                child: TextFormField(
                  keyboardType: TextInputType.number,maxLength: 6,controller: price2,textDirection: TextDirection.ltr,style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.blue),decoration: InputDecoration(border: InputBorder.none),
                ),
              )),
            ))
            ,Expanded(flex: 5,child: Container(alignment: Alignment.centerRight,child: Text("سعر التأجير في نهاية الاسبوع",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*11),),))
          ],))

          ,Container(child: Divider(color: Colors.black54,),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,left:MediaQuery.of(context).size.width*0.1))
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12,top:MediaQuery.of(context).size.height*0.001) ,child: Text("وصف المكان",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).textScaleFactor*15),),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
              validator: addservice3logic.validate,controller: detail,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3,toolbarOptions: ToolbarOptions(
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
            detail.text ="";
            });
            }
            },textInputAction: TextInputAction.send,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),hintText: "وصف المكان "),
            )),
          )
          ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.01) ,child: Text("رفع صور للمكان",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).textScaleFactor*15),),)
          , InkWell(onTap: ()=>chooseimage(1),
            child: Container(height: MediaQuery.of(context).size.height*0.18 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09,top: MediaQuery.of(context).size.height*0.02,right:MediaQuery.of(context).size.width*0.09 ),child:image1 != null?Container(
              child: Image( fit: BoxFit.fill,image: FileImage(image1),),
            ) : mainphoto==null?
            DottedBorder(color: Colors.black.withOpacity(0.2),
              child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
            ):InkWell(onTap: ()=>chooseimage(1),child: Image(fit: BoxFit.fill,image: NetworkImage(mainphoto),))) ),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01 ,left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),height: MediaQuery.of(context).size.height*0.09,child: Row(children: [
           Expanded(child:InkWell(onTap: ()=>chooseimage(2),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: image2 != null?Container(
               child:InkWell(onTap: ()=>chooseimage(0),child: Image( fit: BoxFit.fill,image: FileImage(image2),)),
              ) :photos.length ==0 ?DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ) :photos[0] ==null?
              DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ):InkWell( onTap: ()=>chooseimage(2),child: Image(fit: BoxFit.fill,image: NetworkImage(photos[0]),)) ),
            )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(3),
             child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: image3 != null?Container(
                child:InkWell( onTap: ()=>chooseimage(3),child: Image( fit: BoxFit.fill,image: FileImage(image3),)),
              ) : photos.length ==0?DottedBorder(color: Colors.black.withOpacity(0.2),
               child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
             ) :photos[1] ==null?
              DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ):InkWell( onTap: ()=>chooseimage(3),child: Image(fit: BoxFit.fill,image: NetworkImage(photos[1]),))),
           )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(4),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: image4 != null?Container(
                child:InkWell( onTap: ()=>chooseimage(4),child: Image( fit: BoxFit.fill,image: FileImage(image4),)),
              ) :photos.length ==0?DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ) : photos[2] ==null?
              DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ):InkWell(onTap: ()=>chooseimage(4),child: Image(fit: BoxFit.fill,image: NetworkImage(photos[2]),)) ),
            )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(5),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: image5 != null?Container(
                child:InkWell(onTap: ()=>chooseimage(5),child: Image( fit: BoxFit.fill,image: FileImage(image5),)),
              ):photos.length ==0?DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ) : photos[3] ==null?
              DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ):InkWell(onTap: ()=>chooseimage(5),child: Image(fit: BoxFit.fill,image: NetworkImage(photos[3]),)) ),
            )),
            Expanded(child:InkWell(onTap: ()=>chooseimage(6),
              child: Container(margin: EdgeInsets.all( MediaQuery.of(context).size.width*0.01 ),child: image6 != null?Container(
                child:InkWell(onTap: ()=>chooseimage(6),child: Image( fit: BoxFit.fill,image: FileImage(image6),)),
              ) :photos.length ==0? DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ):photos[4] ==null?
              DottedBorder(color: Colors.black.withOpacity(0.2),
                child: Center(child: Container(child:  Icon(Icons.add,color: Colors.blue,)),),
              ):InkWell(onTap: ()=>chooseimage(6),child: Image(fit: BoxFit.fill,image: NetworkImage(photos[4]),)) ),
            ))
          ],),),Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child:Row(children:[ Expanded(child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12,top:MediaQuery.of(context).size.height*0.01) ,child: InkWell( onTap: ()async{
            if (await canLaunch("https://www.google.com/maps/")) {
              await launch("https://www.google.com/maps/");
            } else {
              throw 'Could not launch ';
            }
          },child: Text("للحصول علر رابط خاص",style: TextStyle(decoration: TextDecoration.underline,color: Colors.red,fontSize: MediaQuery.of(context).textScaleFactor*12),)),)) ,
            Expanded(child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12,top:MediaQuery.of(context).size.height*0.01) ,child: Text("رابط موقع المكان",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).textScaleFactor*15),),)) ])),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.1),child: TextFormField(
              validator: addservice3logic.validate,controller: locationurl,textInputAction: TextInputAction.send,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12),hintText: "رابط المكان "),
            )),
          ),
          Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap:(){
              List realfeats =[];
              for(int g = 0 ; g<features.length ; g++){
                if(features[g]["state"] ==true){
                  realfeats.add(features[g]["name"]);
                }
              }addservice3logic
                .editservice3(service["ID"], key, type.toString(), name.text, region2, region3,region3back,region2back, address.text, masaha.text, numofroof.text, numofroom.text, fornum.text, wcs.text, ketchins.text, price1.text, price2.text, detail.text, realfeats, image1 , image2,image3,image4,image5,image6, true ,locationurl.text);
            },
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
                child:Text("تعديل", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )

        ],),
      ),
    ),);
  }
}