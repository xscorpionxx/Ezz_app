import 'package:ezzproject/logic/recommend.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recommend extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateRecommend();
  }
}
class StateRecommend extends State<Recommend>{
  TextEditingController name ;
  TextEditingController email ;
  TextEditingController detail ;
  Recommendlogic recommendlogic;
  GlobalKey<FormState> key;
  @override
  void initState() {
    key = new GlobalKey();
    recommendlogic = new Recommendlogic(context);
    name= new TextEditingController();
    email = new TextEditingController();
    detail = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
              decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الاقتراحات والشكاوى",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                Expanded(child: Container())
              ],),)),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.1 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: name,validator: recommendlogic.validate,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "الاسم"),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: email,validator: recommendlogic.validateemail,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "البريد الالكتروني"),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              controller: detail,validator: recommendlogic.validate,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 5,maxLines: 5 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015 ) ,hintText: "تفاصيل"),
            )),
          ),
          Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap: ()=>recommendlogic.sendcomplaints(name.text, email.text, detail.text, key),
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                child:Text("ارسال", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )
        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).maybePop();
  }
}