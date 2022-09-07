import 'dart:async';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:ezzproject/screens/users/showpage.dart';
import 'package:ezzproject/screens/users/subcats.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ezzproject/screens/users/favo.dart';
import 'package:ezzproject/screens/users/more.dart';
import 'package:ezzproject/screens/users/orders.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mazadshow.dart';
import 'notification.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(42, 171, 227, 1),
    ));
    // TODO: implement createState
    return Statehome();
  }
}
class Statehome extends State<Home> with TickerProviderStateMixin{
  List homedata =[];
  List banner =[];
  TextEditingController query ;
  var downloadhome;
  getdata1()async{
     homelogic =  new Homelogic(context);
     homelogic.initializesnotification();
     Future.delayed(const Duration(milliseconds: 1), ()async {
       await Provider.of<Notifires>(context,listen: false).reset();
       await Provider.of<Notifires>(context, listen: false).getdatahomecats(context);
       Future.delayed(const Duration(milliseconds: 1), ()async {
         if (go) {
           Provider.of<Notifires>(context,listen: false).setads();
           homelogic.showadd(banner, adtime, homedata,tabController);
         }
       });
     });
  }
  var go ;
  var timer;
  double valuea =0;
  Showpagelogic showpagelogic;
  AnimationController controller;
  bool stop = false;
  var active ;
  List fav=[];
  TabController tabController;
  Homelogic homelogic;
  var profiledata;
  List myorders =[];
  var adtime;
  List ads =[];
  var downloadfav;
  var downloador;
  var downloadpro;
  Notifires notifires ;
  var iconofshop;
  var logintype;
  set()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    logintype = sharedPreferences.getString("logintype");
  }
  @override
  void initState() {
    set();
    notifires = new Notifires(maincontext:context);
    tabController = new TabController(vsync: this, length:4);
    query = new TextEditingController();
    controller = new AnimationController(vsync: this);
    showpagelogic = new Showpagelogic(context);
    super.initState();
    getdata1();
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
  List searchresult = [];
  var searchable ;
  @override
  Widget build(BuildContext context) {
    homedata =  Provider.of<Notifires>(context).homedata;
    banner = Provider.of<Notifires>(context).banner;
    fav = Provider.of<Notifires>(context).favdata;
    active = Provider.of<Notifires>(context).active;
    profiledata = Provider.of<Notifires>(context).profiledata;
    myorders = Provider.of<Notifires>(context).myorders;
    iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    searchresult = Provider.of<Notifires>(context).searchresult;
    adtime = Provider.of<Notifires>(context).adtime;
    searchable = Provider.of<Notifires>(context).searchable;
    ads=  Provider.of<Notifires>(context).ads;
    go = Provider.of<Notifires>(context).adsable;
    downloadfav = Provider.of<Notifires>(context).downloadfav;
    downloador = Provider.of<Notifires>(context).dwonloador;
    downloadhome  = Provider.of<Notifires>(context).downloadhome;
    downloadpro  = Provider.of<Notifires>(context).dwonloadpro;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:  SingleChildScrollView(physics: ClampingScrollPhysics(),
        child: Column(children: [
         // Container(width: 100,height: 100,child: VideoPlayer(_controller)),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(width: MediaQuery.of(context).size.width,height:Provider.of<Notifires>(context).guestmode?MediaQuery.of(context).size.height : MediaQuery.of(context).size.height*0.954 ,child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController,children:[
              active=="home"? Homescreen1():Homescreen1(),
              active == "favo"? favourite(context,showpagelogic):favourite(context,showpagelogic),
              active=="req"? requests(context,homelogic):requests(context,homelogic),
              active=="more"? more(context,tabController,homelogic,logintype):more(context,tabController,homelogic,logintype)
            ])),
          ),
            Container(
              child: Container(height: MediaQuery.of(context).size.height*0.046,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white),child:
                 Row(children: [
                   Provider.of<Notifires>(context).guestmode?Container() : Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="more"?  Container(
                       decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                       child: FittedBox(
                         child: Column(children:[
                            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("images/Vector.svg",fit: BoxFit.scaleDown,)),
                           Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                       ),
                     ):Container(
                       child: InkWell(onTap: ()async{
                         if(active !="more") {
                          await Provider.of<Notifires>(context, listen: false).getindex(
                               tabController, "more", 3, context);
                           Future.delayed(const Duration(milliseconds: 300), () {
                             //setState(() {});
                             Provider.of<Notifires>(context, listen: false)
                                 .getprofile(context, false);
                           });
                         }
                         },
                         child: FittedBox(
                           child: Column(children:[
                             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("images/Vector.svg",fit: BoxFit.scaleDown,)),
                             Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                         ),
                       ),
                     )))
                  ,Provider.of<Notifires>(context).guestmode?Container() : Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="req"?  Container(
                     decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                     child: Container(
                       child:FittedBox(child: Column(children:[
                         Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar31.png"),fit: BoxFit.scaleDown,)),
                         Container(height: MediaQuery.of(context).size.height*0.02,child : FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
                     ),
                   ) :Container(
                     child: InkWell(onTap: ()async{
                       if(active !="req") {
                        await Provider.of<Notifires>(context, listen: false).getindex(
                             tabController, "req", 2, context);
                         Future.delayed(const Duration(milliseconds: 300), () {
                           //setState(() {});
                           Provider.of<Notifires>(context, listen: false)
                               .getmyorders(context);
                         });
                       }},
                       child: Container(
                         child: FittedBox(
                           child: Column(children:[
                             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar2.png"),fit: BoxFit.scaleDown,)),
                             Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                         ),
                       ),
                     ),
                   )))
                   ,Provider.of<Notifires>(context).guestmode?Container() : Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="favo"?  Container(
                     decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                     child:FittedBox(child: Column(children:[
                       Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar21.png"),fit: BoxFit.scaleDown)),
                      Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
                   ) :Container(
                     child: InkWell(onTap: ()async{
                       if(active!="favo") {
                        await Provider.of<Notifires>(context, listen: false).getindex(
                             tabController, "favo", 1, context);
                         Future.delayed(Duration(milliseconds: 400),(){
                           //setState(() {});
                           Provider.of<Notifires>(context, listen: false).getfav(
                               context);
                         });
                       }
                     },
                       child: FittedBox(
                         child: Column(children:[
                           Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar3.png"),fit: BoxFit.scaleDown)),
                           Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                       ),
                     ),
                   ))),
                   Provider.of<Notifires>(context).guestmode?Container() : Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:active=="home"?  Container(
                     decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.green,Colors.blueAccent])) ,
                     child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                       child:FittedBox(child: Column(children:[
                         Container(height: MediaQuery.of(context).size.height*0.025,child: SvgPicture.asset("images/home2azz.svg",fit: BoxFit.scaleDown,semanticsLabel: "dacasceqd",))
                         ,Container(height: MediaQuery.of(context).size.height*0.02 ,child: FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*10),)))])),
                     ),
                   ) :Container(
                     child: InkWell(onTap: ()async{
                        if(active !="home") {
                        await Provider.of<Notifires>(context, listen: false).getindex(
                              tabController, "home", 0, context);
                    Future.delayed(Duration(milliseconds: 300),()
                        {
                          Provider.of<Notifires>(context, listen: false)
                              .getdatahomecats(context);
                        });
                    }
                       },child:Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                       child: FittedBox(
                         child: Column(children:[
                           Container(height: MediaQuery.of(context).size.height*0.025,child: SvgPicture.asset("images/home1azz.svg",fit: BoxFit.scaleDown,semanticsLabel: "dacadadwsceqd",)),
                         Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                       ),
                     ),
                     ),
                   ))),
          ],),),
            )]),
      ),
    ),);
  }
  var ind = 0;
  List databannerimages =[];
  Widget Homescreen1(){
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(child: ListView(children: [
        Container(
          child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.11,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40))),child:
            Container(child:
                Container(
                  child:Column(children:[ Container(
                    child:searchable?Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,bottom: MediaQuery.of(context).size.height*0.0),
                      child: Row(children: [
                        Expanded(flex: 4,child:InkWell(onTap: (){Provider.of<Notifires>(context,listen: false).setsearch();},child: Container( alignment: Alignment.center,margin: EdgeInsets.only(left: MediaQuery.of(context).textScaleFactor*20),child: Icon(Icons.search,color: Colors.white,size: MediaQuery.of(context).size.width*0.06,))) ),
                        Expanded(flex:Provider.of<Notifires>(context).guestmode? 30:16,child: Container(alignment: Alignment.center,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),height: MediaQuery.of(context).size.height*0.05,width: MediaQuery.of(context).size.width*0.05,child:Image(image: AssetImage("images/logoaz.png"),fit: BoxFit.fill,) //Text("الرئيسية",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor * 13),)
                        )),
                         Expanded(flex:4 ,child: Provider.of<Notifires>(context).guestmode?Container():InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                         Expanded(flex: 3,child:Provider.of<Notifires>(context).guestmode?Container():InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),
                          Positioned(top: 3,left: 19 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                            :Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) ),
                         Expanded(flex:3 ,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetolocation(),child: Icon(Icons.settings,color: Colors.white,))),
                      ],),
                    ),
                  ), Container(
                    child:!searchable?Container(): Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.15,right:MediaQuery.of(context).size.width*0.15 ),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                      ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                        Provider.of<Notifires>(context ,listen: false).search(homedata, val);
                      }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: InkWell( onTap: (){
                        query.text = "";
                        Provider.of<Notifires>(context,listen: false).setsearch();
                      },child: Icon(Icons.close,color: Colors.black26,))),)),),
                  )
                  ]),
                )),
          ),
        )
        ,Container(
          child: Container( margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),height:MediaQuery.of(context).size.height*0.15,child: ads.length==0? Container():
          CarouselSlider.builder(options: CarouselOptions(height: MediaQuery.of(context).size.height*0.43,viewportFraction: 1,
              onPageChanged: (indq,reason){
            setState(() {
              ind = indq;
            });
              }
              ,autoPlay: true),
            itemBuilder: (context,index , real){
              return Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child://ads[index]["Photo"].toString().substring(ads[index]["Photo"].toString().length-3,ads[index]["Photo"].toString().length)=="svg"?
               //FadeInImage(image:SvgPicture.network(ads[index]["Photo"],fit: BoxFit.fill,))
                  FadeInImage(fit:BoxFit.fill,image:NetworkImage(ads[ind]["Photo"])
                ,placeholder: AssetImage("images/logoaz.png"),));
            },itemCount: ads.length,)
            ,),
        ),
        Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight,child: Text("خدماتنا",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).textScaleFactor*14)),)
        ,Container(
          child:downloadhome? Container(height: MediaQuery.of(context).size.height*0.61,child: Center(child: CircularProgressIndicator(),),):homedata.length==0? Container(height: MediaQuery.of(context).size.height*0.61,child: Center(child: Text("لا يوجد خدمات حاليا"),),):
          Container(height:  MediaQuery.of(context).size.height*0.61,width: MediaQuery.of(context).size.width,child:homedata.length==0?Container(
            child: Center(child: Text("لا يوجد خدمات حاليا",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14),)),
          ):query.text == ""||!searchable?GridView.builder(physics: BouncingScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height*1.62),),itemCount: homedata.length,itemBuilder: (context,i){
            return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
              child: InkWell(onTap: ()=>showtoshowpage(i,homedata[i]["Name"] , homedata[i]["SubCategories"],false),
                child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 3.0,
                  offset: Offset(0,0), // shadow direction: bottom right
                )]),child: Column(children: [
                    Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child: Image(fit: BoxFit.fill,image: NetworkImage(homedata[i]["Photo"]),),),
                    Container( height: MediaQuery.of(context).size.height*0.017,alignment: Alignment.center,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child:Center(child:  FittedBox(
                      child: AutoSizeText(homedata[i]["Name"],//,maxFontSize: MediaQuery.of(context).textScaleFactor*9,minFontSize:MediaQuery.of(context).textScaleFactor*9,
                        style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold),),
                    ))),
                    Container(height: MediaQuery.of(context).size.height*0.017,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Center(child: FittedBox(child: AutoSizeText(homedata[i]["Description"], style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*8,color: Colors.black54),)))),),
                  ],)
                  ,),
              ),
            );
          }) :Directionality(textDirection: TextDirection.rtl,
            child: Container(
              child:searchresult.length==0?Container(child: Center(child: Text("لا يوجد نتيجة متوافقة مع البحث"),),) :GridView.builder(physics: BouncingScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                childAspectRatio: (MediaQuery.of(context).size.width*1.5/MediaQuery.of(context).size.height*1.62),),itemCount: searchresult.length,itemBuilder: (context,i){
                return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),
                  child: InkWell(onTap: ()=>showtoshowpage(i,searchresult[i]["Name"] , searchresult[i]["SubCategories"],true),
                    child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,boxShadow: [BoxShadow(
                      color: Colors.black12.withOpacity(0.2),
                      blurRadius: 1.0,
                      spreadRadius: 3.0,
                      offset: Offset(0,0), // shadow direction: bottom right
                    )]),child: Column(children: [
                      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                      Container( height: MediaQuery.of(context).size.height*0.017,alignment: Alignment.center,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child:Center(child:  FittedBox(
                        child: AutoSizeText(searchresult[i]["Name"],//,maxFontSize: MediaQuery.of(context).textScaleFactor*9,minFontSize:MediaQuery.of(context).textScaleFactor*9,
                          style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold),),
                      ))),
                      Container(height: MediaQuery.of(context).size.height*0.017,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: Center(child: FittedBox(child: AutoSizeText(searchresult[i]["Description"], style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*8,color: Colors.black54),)))),),
                    ],)
                      ,),
                  ),
                );
              }),
            ),
          ) ,)  ,
        ),
       ],),),
    );
  }
    var favdone = false;
  showtoshowpage(i,name,sub,sea)async{
     if(!sea){
      if(name == "مزاد"){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Mazadshow(mazads: homedata[i]["Auctions"],);
        }));
      }
      else {
            if(homedata[i]["SubCategories"] !=null) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Subcats(name:homedata[i]["Name"],data:homedata[i]["SubCategories"], tabcontroller: tabController,maincontext: context,);
              }));
            }else {
              await Provider.of<Notifires>(context,listen: false).resetshowpagevalues();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Showpage(
                  id: homedata[i]["ID"], name: name, subcategories: sub,tabcontroller: tabController,maincontext: context,navigate : true);
              }));
             }
        }
      }
     else{
       if(name == "مزاد"){
         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
           return Mazadshow(mazads: searchresult[i]["Auctions"],);
         }));
       }
       else {
             if(searchresult[i]["SubCategories"] !=null){
               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                 return Subcats(name:searchresult[i]["Name"],data:searchresult[i]["SubCategories"], tabcontroller: tabController,maincontext: context,);
               }));
             }else{
               await Provider.of<Notifires>(context,listen: false).resetshowpagevalues();
               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                 return Showpage(
                   id: searchresult[i]["ID"], name: name, subcategories: sub,tabcontroller: tabController,maincontext: context,navigate : true);
               }));
         }
       }
     }
}
  navigatetolocation(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Location();
    }));
  }}