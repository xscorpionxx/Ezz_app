import 'dart:io';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:ezzproject/screens/decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Complete extends StatefulWidget{
  var typevalue ;
  var emailvalue;
  var namevalue;
  var tokenvalue;
  var tokenso;
  var id;
  Complete({this.typevalue,this.emailvalue,this.namevalue,this.tokenvalue,this.id ,this.tokenso});
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    // TODO: implement createState
    return StateComplete(userid:id,tokenvalue: tokenvalue,typevalue: typevalue,namevalue: namevalue,emailvalue: emailvalue,tokenso: tokenso);
  }
}
class StateComplete extends State<Complete>{
  var typevalue ;
  var emailvalue;
  var namevalue;
  var tokenvalue;
  var userid;
  var tokenso;
  StateComplete({ this.userid,this.typevalue,this.emailvalue,this.namevalue,this.tokenvalue,this.tokenso});
  TextEditingController name ;
  TextEditingController storename ;
  TextEditingController id ;
  TextEditingController phone ;
  TextEditingController email ;
  TextEditingController password ;
  TextEditingController repassword ;
  GlobalKey<FormState> key;
  Signuplogic signuplogic;
  var region1 = "المنطقة" ;
  var region2 = "المحافظة" ;
  var region3 ="المدينة";
  List region1list =["المنطقة"];
  List region2list =["المحافظة"];
  var cat  ;
  var subcat;
  List cats  =[];
  List subcats =[];
  List region3list =["المدينة"];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  File photo;
  List regions =[];
  List citites = [];
  List subtypevalues = [];
  List subtypelist =[];
  var subtypevalue;
  chooseimage()async{
    Future.delayed(Duration(seconds: 2));
    var status =await Permission.camera.status;
    var takepermission =await Permission.camera.request();
    if(takepermission.isGranted) {
      var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 != null) {
        photo = File(image1.path);
        setState(() {});
      }
    }
  }
  changevaluetype(ind){
    setState(() {
      subtypelist = subtypevalues[ind][(ind + 1).toString()];
    });
  }
  getdata()async{
    var dataa = await signuplogic.getplaces();
    regions = dataa["1"];
    for(int f = 0 ; f<regions.length;f++){
      region1back.add({"name" :regions[f]["Name"],"ID" : regions[f]["ID"].toString()});
    }
    for(int i =0 ; i<region1back.length ; i++){
      region1list.add(region1back[i]["name"].toString());
    }
    cats = dataa["cat"];
    subtypevalues = dataa["subcats"];
    setState(() {});
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
    region3 ="المدينة";
    region2list.add("المحافظة");
    region3list.add("المدينة");
    for (int i = 0; i < region2back.length; i++) {
      region2list.add(region2back[i]["name"].toString());
    }
    setState(() {

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
  Profilelogic profilelogic;
  @override
  void initState() {
    profilelogic = new Profilelogic(context);
    signuplogic = new Signuplogic(context);
    getdata();
    key = new GlobalKey<FormState>();
    name = new TextEditingController();
    storename = new TextEditingController();
    id = new TextEditingController();
    phone = new TextEditingController();
    email = new TextEditingController();
    password = new TextEditingController();
    repassword = new TextEditingController();
    email.text = emailvalue;
    name.text = namevalue;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Form(key: key,
      child: SingleChildScrollView(
        child: Column(
          children:[ Container(color: Colors.greenAccent.withOpacity(0.5),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
            child:  Stack(children: [
              Positioned(top: -MediaQuery.of(context).size.height*0.1,left: MediaQuery.of(context).size.width*0.4,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(300),color: Colors.blueAccent.withOpacity(0.4)),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.width,)),
              Positioned(top: MediaQuery.of(context).size.height*0.05,child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(200),topLeft: Radius.circular(200)),color: Colors.white.withOpacity(0.95)),height: MediaQuery.of(context).size.height*0.4,width: MediaQuery.of(context).size.width,
                  child:  Column(children: [
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),width: MediaQuery.of(context).size.width*0.15,height:MediaQuery.of(context).size.height*0.1 ,child: Image(image: AssetImage("images/logoaz.png"),),),
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Text("اكمال البيانات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),)
                  ],)
              )),
              Positioned(top: MediaQuery.of(context).size.height*0.3,child: Container(decoration: BoxDecoration( boxShadow: [ BoxShadow(
                color: Colors.black,
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5), // shadow direction: bottom right
              )],borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),color: Colors.white),height: MediaQuery.of(context).size.height*0.7,width: MediaQuery.of(context).size.width,
                  child:   SingleChildScrollView(reverse: true,
                    child: Column(children: [
                        Container(child: Row(children: [Expanded(child: InkWell(child: Container(decoration:BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight: Radius.circular(20))),height: MediaQuery.of(context).size.height*0.07,child:Center(child: Text("",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),)),)))
                          ,Expanded(child:!false?Container(decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))),height: MediaQuery.of(context).size.height*0.07 ,child:Center(child: Text("مستخدم",style: TextStyle(color: Colors.black))),): InkWell(child: Container(decoration:BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20))),height: MediaQuery.of(context).size.height*0.07 ,child:Center(child: Text("مستخدم",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.white),)),) ))],),)
                        ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
                          decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(controller: name,validator: signuplogic.validatename ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),decoration: InputDecoration(hintText: "اسم المستخدم",border: InputBorder.none),),)),
                        Directionality(textDirection: TextDirection.ltr, child: Container(height: MediaQuery.of(context).size.height*0.08,
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                          decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,
                          child: Row(
                            children:[Expanded(child:Container(height: MediaQuery.of(context).size.height*0.08, decoration: BoxDecoration(color: Colors.black38,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) )) ,
                              child: FittedBox(child: Container(child:
                              Row(children: [
                                Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,width:MediaQuery.of(context).size.width*0.08,height: MediaQuery.of(context).size.height*0.03,child: Image(fit: BoxFit.fill,image: AssetImage("images/flagicon.jpg"),),),
                                Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),child: Text("+966",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),)
                              ]),)),
                            )) ,Expanded(flex: 3,
                              child: Directionality(textDirection: TextDirection.rtl,
                                child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),keyboardType: TextInputType.phone,controller: phone,validator: Alertdialogazz.validateMobile,decoration: InputDecoration(hintText: "رقم الجوال",border: InputBorder.none),),),
                              ),
                            )],
                          ),
                        ))
                        ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                          decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(enabled: false,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),controller: email,validator: signuplogic.validateemail ,decoration: InputDecoration(hintText: "البريد الالكتروني",border: InputBorder.none),),)),
                        Directionality(textDirection: TextDirection.rtl, child: InkWell(
                          child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                              decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                              ListTile(
                                title: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: region1
                                      ,items: region1list.map((e) => DropdownMenuItem(child: Container( alignment: Alignment.centerRight,child:
                                    Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==region1?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                                      onChanged: (_) {
                                        if(_.toString() != "المنطقة") {
                                          region1 = _;
                                          slecetcity(region1);
                                          setState(() {});
                                        }
                                      },
                                    )),
                              )),
                        )),
                        Directionality(textDirection: TextDirection.rtl, child: InkWell(
                          child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                            decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                            ListTile(
                              title: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: region2
                                    ,items: region2list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                                  Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==region2?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                                    onChanged: (_) {
                                      if(_.toString() != "المحافظة") {
                                        region2 = _;
                                        selectgovern(region2);
                                        setState(() {});
                                      }
                                    },
                                  )),
                            ),),
                        )),
                        Directionality(textDirection: TextDirection.rtl, child: InkWell(
                          child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                              decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                              ListTile(
                                title: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: region3
                                      ,items: region3list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                                    Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==region3?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                                      onChanged: (_) {
                                        if(_.toString() != "المدينة") {
                                          region3 = _;
                                          setState(() {});
                                        }
                                      },
                                    )),
                              )),
                        ))
                        ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                          decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(obscureText: true,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),controller: password,validator: signuplogic.validatepassword ,decoration: InputDecoration(hintText: "كلمة السر",border: InputBorder.none),),))
                        ,Directionality(textDirection: TextDirection.rtl, child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                          decoration: Decorationezz.boxdeco,width: MediaQuery.of(context).size.width*0.9,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(obscureText: true,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),controller: repassword,validator: signuplogic.validatepasswordre ,decoration: InputDecoration(hintText: "تأكيد كلمة السر",border: InputBorder.none),),))
                        ,InkWell(onTap: ()=>profilelogic.complete(name.text, phone.text, email.text, region1, region2, region3, region1back, region2back, region3back,key,typevalue,tokenvalue,password.text,userid,tokenso) ,
                          child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02,top: MediaQuery.of(context).size.height*0.05),decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),height: MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.width*0.9,child: Center(child: Text("تأكيد",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.025),),),),
                        ),
                      ],),
                  ),
              ))
            ],
            ),)],
        ),
      ),
    ),);
  }
}