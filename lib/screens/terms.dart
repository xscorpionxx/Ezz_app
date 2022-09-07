import 'package:ezzproject/logic/apoutapp.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'users/notification.dart';

class Terms extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateterms();
  }
}
class Stateterms extends State<Terms>{
  var terms;
  Aboutapplogic applogic;
  var download =true;
  @override
  void initState() {
    applogic = new Aboutapplogic(context);
    getdata();
    super.initState();
  }
  getdata()async{
    terms = await applogic.getterms();
    download = false;
    setState(() {});
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
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:download? Container(child: Center(child: CircularProgressIndicator(),),):ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
          decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
          Container(child:
              Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text("الشروط والاحكام",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(flex: 2,child: Container())
                ],),
              )
          ),
        ),
         Directionality(textDirection: TextDirection.rtl,
           child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(boxShadow: [
             BoxShadow(
               color: Colors.black26,
               blurRadius: 1.0,
               spreadRadius: 0.0,
               offset: Offset(2.0, 2.0), // shadow direction: bottom right
             )
           ] ,color: Colors.white ,borderRadius: BorderRadius.circular(10)) ,child: Column(children:[
             Container(child: Text("الشروط والأحكام",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,bottom: MediaQuery.of(context).size.height*0.02),)
             ,Container(margin: EdgeInsets.only(bottom: 30),child: Text(terms.toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.033),))]),),
         )
      ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).maybePop();
  }
}