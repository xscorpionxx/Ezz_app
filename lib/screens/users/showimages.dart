import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/logic/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'home.dart';
class Showimages extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemain();
  }
}
class Statemain extends State<Showimages>with SingleTickerProviderStateMixin{
  var active = 0;
  TabController tabController;
  Loginlogic loginlogic;
  Homelogic homelogic ;
  var photos  ;
  getdata()async{
   photos = await homelogic.getintroimages();
   setState(() {});
  }
  @override
  void initState() {
    tabController = new TabController(vsync: this, length:3);
    loginlogic = new Loginlogic(context);
    homelogic = new Homelogic(context);
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(body: Container(child: TabBarView(controller: tabController,
     children:[ Stack(children: [
       Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
       child: FadeInImage( placeholder: AssetImage("images/emptyphoto.png"),fit: BoxFit.fill,image:photos !=null? NetworkImage(photos["1"]) : AssetImage("images/emptyphoto.png"),))
       ,Positioned(top: MediaQuery.of(context).size.height*0.7,child: Container(
         child:  Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),color: Colors.white.withOpacity(0.8),),width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3
               ,child: Column(children: [
                   Container(margin: EdgeInsets.all(50),alignment: Alignment.center ,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText("تبحث عن ذبائح وطهاة لعزائمك أو حتى طيور وأسماك نوفرها لك",maxLines: 3,style: TextStyle(color: Colors.indigo,fontSize: 20),)),)
                   ,Spacer(),Container(margin: EdgeInsets.only(bottom: 20),
                     child: Row(children:[ Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: AnimatedSmoothIndicator(count: 3,activeIndex: 0,),)),Expanded( child: InkWell(onTap: (){
                       Navigator.of(context).popUntil((route) => route.isFirst);
                       Navigator.of(context).pushReplacement(
                           MaterialPageRoute(builder: (contexta) {
                             return Home();
                           }));
                     },
                       child: Container( padding: EdgeInsets.all(10),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),color: Colors.white,alignment: Alignment.center,child:
                   FittedBox(child: Text("تخطي", style: TextStyle(fontSize: 14,color: Color.fromRGBO(56, 182, 245, 1)),))),
                     ),
                     )]),
                   )
                 ] ,),
           ),
       ) )
     ],),
       Stack(children: [
         Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
             child: FadeInImage(placeholder: AssetImage("images/emptyphoto.png"),fit: BoxFit.fill,image: photos !=null? NetworkImage(photos["2"]) : AssetImage("images/emptyphoto.png"),))
         ,Positioned(top: MediaQuery.of(context).size.height*0.7,child: Container(
           child:  Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),color: Colors.white.withOpacity(0.8),),width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3
             ,child: Column(children: [
               Container(margin: EdgeInsets.all(40),alignment: Alignment.center ,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText("نوفر خدمات الشاحنات والمعدات الثقيلة والدينات "+"بين مدن المملكة والخليج "+"وسيارات الطلبات والمشاوير الخفيفة",maxLines: 3,style: TextStyle(color: Colors.indigo,fontSize: 17),)),)
               ,Spacer(),Container(margin: EdgeInsets.only(bottom: 20),
                 child: Row(children:[ Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: AnimatedSmoothIndicator(count: 3,activeIndex: 1,),)),Expanded( child: InkWell(onTap: (){
                   Navigator.of(context).popUntil((route) => route.isFirst);
                   Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (contexta) {
                         return Home();
                       }));
                 },
                   child: Container( padding: EdgeInsets.all(10),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),color: Colors.white,alignment: Alignment.center,child:
                   FittedBox(child: Text("تخطي", style: TextStyle(fontSize: 14,color: Color.fromRGBO(56, 182, 245, 1)),))),
                 ),
                 )]),
               )
             ] ,),
           ),
         ) )
       ],),
       Stack(children: [
         Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
             child: FadeInImage(placeholder: AssetImage("images/emptyphoto.png"),fit: BoxFit.fill,image: photos !=null? NetworkImage(photos["3"]) : AssetImage("images/emptyphoto.png"),))
         ,Positioned(top: MediaQuery.of(context).size.height*0.7,child: Container(
           child:  Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),color: Colors.white.withOpacity(0.8),),width:MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3
             ,child: Column(children: [
               Container(margin: EdgeInsets.all(40),alignment: Alignment.center ,child: Directionality(textDirection: TextDirection.rtl,child: Center(child: Text("سهلنا لك الوصول الى الأسر المنتجة"+" و التعرف على منتجاتهم ",style: TextStyle(color: Colors.indigo,fontSize: 20),))),)
               ,Spacer(),Container(margin: EdgeInsets.only(bottom: 20),
                 child: Row(children:[ Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: AnimatedSmoothIndicator(count: 3,activeIndex: 2,),)),Expanded( child: InkWell(onTap: (){
                   Navigator.of(context).popUntil((route) => route.isFirst);
                   Navigator.of(context).pushReplacement(
                       MaterialPageRoute(builder: (contexta) {
                         return Home();
                       }));
                 },
                   child: Container( padding: EdgeInsets.all(10),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),color: Colors.white,alignment: Alignment.center,child:
                   FittedBox(child: Text("ابدأ", style: TextStyle(fontSize: 14,color: Color.fromRGBO(56, 182, 245, 1)),))),
                 ),
                 )]),
               )
             ] ,),
           ),
         ) )
       ],)],
   ),),);
  }
}