import 'dart:io';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'notification.dart';

class Profile extends StatefulWidget{
  var logintype;
  Profile({this.logintype});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateprofile(logintype : logintype);
  }
}
class Stateprofile extends State<Profile>{
  Stateprofile({this.logintype});
  var logintype ;
  TextEditingController name;
  TextEditingController phone;
  TextEditingController email;
  Profilelogic profilelogic;
  List region1list =[];
  List region2list =[];
  List region3list =[];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  var value1 = "";
  var value2 ="";
  var value3 = "";
  var photo;
  var newphoto;
  chooseimage()async{
    var status =await Permission.camera.status;
    var takepermission =await Permission.camera.request();
    if(takepermission.isGranted) {
      var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 != null) {
        newphoto = File(image1.path);
        setState(() {});
      }
    }
  }
  getdata()async{
    var data = await profilelogic.getdata();
    photo =data["photo"];
    region1back = data["listre1"];
    region2back = data["listre2"];
    region3back = data["listre3"];
    for(int i =0 ; i<region1back.length ; i++){
      region1list.add(region1back[i]["name"].toString());
    }
    for(int a =0 ; a<region2back.length ; a++){
      region2list.add(region2back[a]["name"].toString());
    }
    for(int d =0 ; d<region3back.length ; d++){
      region3list.add(region3back[d]["name"].toString());
    }
    value1  = data["re1"];
    value2 = data["re2"];
    value3 = data["re3"];
    name.text = data["name"];
    phone.text = data["phone"].toString();
    email.text = data["email"];
    download = false;
    setState(() {});
  }
  var download = true;
  @override
  void initState() {
    profilelogic = new Profilelogic(context);
    getdata();
    name = new TextEditingController();
    phone = new TextEditingController();
    email = new TextEditingController();
    super.initState();
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  @override
  Widget build(BuildContext context) {
    var iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: download ?Container(child: Center(child: CircularProgressIndicator(),),): SingleChildScrollView(
        child:Column(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
            Container(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Row(children: [
                    Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text("الملف الشخصي",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                        :Container(margin: EdgeInsets.only(right: 15),child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                  ],),
            )),
          ),Container(alignment: Alignment.centerRight,margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.1),child: Text("الملف الشخصي" ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045),),)
           ,Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.06,top: MediaQuery.of(context).size.height*0.01) ,child: Row(children: [
                 Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.45) ,height: MediaQuery.of(context).size.height*0.1 ,alignment: Alignment.bottomCenter ,child : Container()),
                  Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05)  ,alignment: Alignment.bottomCenter ,height: MediaQuery.of(context).size.height*0.1 ,child : InkWell(onTap: (){chooseimage();},child: Text("تغيير",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.green),))),
                 Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),width: MediaQuery.of(context).size.width*0.22,height:MediaQuery.of(context).size.width*0.25  ,child: newphoto==null?
                   Container(child:photo==null ?Container(child: Image(image: AssetImage("images/logoaz.png"),fit: BoxFit.fill,)) : ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image:NetworkImage(photo),fit: BoxFit.fill,),)): ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image:FileImage( newphoto),fit: BoxFit.fill,),),),
           ],),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.02 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: name,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم المستخدم"),
            )),
          ),
           Directionality(textDirection: TextDirection.rtl,
             child: Container(margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.02 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),child:
               Row(
                 children:[ Directionality(textDirection: TextDirection.rtl,
                      child: Container(width: MediaQuery.of(context).size.width*0.75 ,padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: TextFormField(
                       validator: Alertdialogazz.validateMobile, controller: phone,inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم الهاتف"),
                      )),),
                 Container(width: 10,height: MediaQuery.of(context).size.height*0.05,child: VerticalDivider(color: Colors.black38,thickness: 1.5,),),
                 Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,child: Text("+966",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).size.width*0.03),),)],
               ),
              ),
           ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.02 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: email,enabled: logintype=="google"||logintype=="facebook"? false : true,keyboardType: TextInputType.emailAddress ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "البريد الالكتروني"),
            )),
          ),
      Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.07,top: 10 ),
            child: InkWell( onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return Location();
              }));
            },child:  Text(" لتعديل مكانك الحالي انقر هنا",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13,color: Colors.indigo,decoration: TextDecoration.underline))),
          ),
          Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap: ()=>profilelogic.update(name.text,phone.text,  email.text, value1, value2, value3, newphoto),
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                child:Text("حفظ ", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )
        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  deleteimage(){
   newphoto = null;
   setState(() {});
  }
}