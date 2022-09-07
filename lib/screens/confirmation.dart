
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'users/home.dart';

class Confirmation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statecom();
  }
}
class Statecom extends State<Confirmation>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: SingleChildScrollView(physics: ClampingScrollPhysics(),
      child: Column(children: [
        Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child: Row(children: [
          Expanded(child: Container()),
          Expanded(flex: 5,child: Container()),
          Expanded(child: Container())
        ],),),
        Container(height:MediaQuery.of(context).size.height*0.3  ,width: MediaQuery.of(context).size.width*0.5 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15) ,child: Image(fit: BoxFit.fill,image: AssetImage("images/comfirmation.png"),),)
        ,Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,child: Text("تم ارسال الطلب بنجاح" ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)),
        Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Text("نتمنى لك اقامة ممتعة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017)),)),
   Directionality(textDirection: TextDirection.rtl,child: InkWell( onTap: (){
     Navigator.of(context).popUntil((route) => route.isFirst);
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
       return Home();
     }));
   },child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Text("العودة للرئيسية",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.height*0.022)),)))

      ],),),);
  }
}