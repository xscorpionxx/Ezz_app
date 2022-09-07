import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/users/places.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'cookersdetail.dart';
import 'detailpage.dart';
import 'marasil_detail.dart';
import 'notification.dart';

class Showpage extends StatefulWidget{
  var id;
  var name;
  List subcategories;
  var tabcontroller;
  var maincontext;
  var navigate ;
  var cat;
  var ketchintype;
  Showpage({this.ketchintype,this.id ,this.name ,this.subcategories,this.cat,this.tabcontroller,this.maincontext,this.navigate});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateshowpage(ketchintype: ketchintype,id : id , name:name,subcategories: subcategories,cat:cat,tabController: tabcontroller,maincontext: maincontext,navigate: navigate );
  }
}
class Stateshowpage extends State<Showpage> with SingleTickerProviderStateMixin{
  var index =1;
  var tabController;
  var index2;
  var navigate ;
  TextEditingController query ;
  var id;
  var name;
  var maincontext;
  List providers =[];
  List providerp =[];
  var downloadp;
  List searchresult =[];
  List subcategories = [];
  var cat;
  var ketchintype;
  Stateshowpage({this.ketchintype,this.id ,this.name ,this.subcategories ,this.cat ,this.tabController,this.maincontext,this.navigate});
  var section ="1";
  Showpagelogic showpagelogic;
  var downloadshowpage ;
  @override
  void initState() {
    showpagelogic = new Showpagelogic(context);
    query = new TextEditingController();
    super.initState();
    getdata(id);
  }
  @override
  Widget build(BuildContext context) {
    providers = Provider.of<Notifires>(context).providers;
    providerp = Provider.of<Notifires>(context).providerp;
    searchresult = Provider.of<Notifires>(context).searchresult2;
    downloadp = Provider.of<Notifires>(context).downloadp1;
    downloadshowpage = Provider.of<Notifires>(context).downloadshowpage;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:ListView(children: [
        Directionality(textDirection: TextDirection.rtl,
          child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height ,child:
            cat=="اماكن" || name == "اماكن"? places():Homescreen1()
          ),
        ),
        ]),
    ),);
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
  Widget Homescreen1(){
    var iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.182,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
          Container(child: Container(
                child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Row(children: [
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigateback(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: AutoSizeText(name.toString(),style: TextStyle(color: Colors.white,fontSize:17),))),
                    Expanded(flex:2,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                        :Container(margin: EdgeInsets.only(right: 15),child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                  ],),
                ),Spacer(), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(left: 26,right:20,bottom: 23),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                  ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                    if(val !="") {
                      Provider.of<Notifires>(context, listen: false).search2(
                          providers, val);
                    }
                  }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
          )),
        ),
        Directionality(textDirection: TextDirection.rtl,
          child: Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.0  ,top: MediaQuery.of(context).size.height*0.03 ,left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04),height:
          navigate==false?
          MediaQuery.of(context).size.height*0.75
              :MediaQuery.of(context).size.height*0.71,width: MediaQuery.of(context).size.width,child:downloadshowpage?Container(child: Center(child: CircularProgressIndicator(),),): providers.length==0?Container(
            child: Center(child: Text("لا يوجد تجار حاليا",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
          )
       : query.text==""? GridView.builder(physics: BouncingScrollPhysics() ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: (166/240),),itemCount: providers.length,itemBuilder: (context,i){
            return Directionality(textDirection: TextDirection.ltr,
              child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  child: InkWell(onTap: (){
                  if(providers[i]["Status"].toString()=="0"){

                  }else{
                    showdetail(i,false);
                  }},
                  child: Container(child:Column(children: [
                    Container(
                      child:providers[i]["Status"].toString()=="1"? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: ClipRRect( borderRadius: BorderRadius.circular(10),child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(providers[i]["Photo"]),)),),
                   Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                       child: Row(children: [
                         Expanded(child:Provider.of<Notifires>(context).guestmode?Container(): Container(child: providers[i]["UserFav"].toString()=="1"?
                         InkWell(onTap: ()=>showpagelogic.addtofav(providers[i]["ID"],id,subcategories,context,false,"1"),
                           child: Container(width: 27,
                             height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                         ):InkWell(onTap: ()=>showpagelogic.addtofav(providers[i]["ID"],id,subcategories,context,false,"0"),
                           child: Container(width: 27,
                             height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size:20,),),
                         ),)),Expanded(flex: 2,child: Container()),
                         Expanded(flex: 2,child: Container(child:providers[i]["BestSeller"].toString()=="1"?
                       InkWell(onTap: ()=>null,
                           child: Container(width: 36,padding: EdgeInsets.all(3),
                             height: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                             FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontSize: 8),),Container(width: 10,height: 10,child: Image( image:AssetImage("images/thumbs-up.png"),fit: BoxFit.fill)),])),),
                       ):Container()))
                       ],),
                   ))])) : Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: Image(fit: BoxFit.fill,image: NetworkImage(providers[i]["Photo"]),),),
                        Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black54,) ,width: MediaQuery.of(context).size.width,height: 185,padding: EdgeInsets.only(left: 50,top: 75,bottom: 75,right: 50),child: Container( decoration: BoxDecoration(color: Colors.red ,borderRadius: BorderRadius.circular(20)),child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
                    ),
                    Container(margin: EdgeInsets.only(left: 8,right:10 ),child:Row(children:[
                      Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(providers[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                      ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),size: 15,)),),
                      Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Directionality( textDirection: TextDirection.rtl,child: AutoSizeText(providers[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: 14),))),)
                    ]) ),
                    Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(providers[i]["Description"].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10,color: Color.fromRGBO(163, 163, 163, 1)),)),),
                  ],)
                    ,),
                ),
              ),
            );
          }):Directionality(textDirection: TextDirection.rtl,
            child:searchresult.length==0?Container(child: Center(child: Text("لا يوجد نتيجة متوافقة مع البحث"),),): GridView.builder(physics: BouncingScrollPhysics() ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: (166/240),),itemCount: searchresult.length,itemBuilder: (context,i){
              return Directionality(textDirection: TextDirection.ltr,
                child: Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white), child: InkWell(onTap: (){
                    if(searchresult[i]["Status"].toString()=="0"){

                    }else{
                      showdetail(i,true);
                    }
                  }, child: Container(child:Column(children: [
                      Container(
                        child:searchresult[i]["Status"].toString()=="1"? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: ClipRRect( borderRadius: BorderRadius.circular(10),child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(searchresult[i]["Photo"]),)),),
                          Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                            child: Row(children: [
                              Expanded(child:Provider.of<Notifires>(context).guestmode?Container(): Container(child: searchresult[i]["UserFav"].toString()=="1"?
                              InkWell(onTap: ()async{await showpagelogic.addtofav(searchresult[i]["ID"],id,subcategories,context,false,"1");
                              query.text = "";
                              setState(() {});},
                                child: Container(width: 27,
                                  height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                              ):InkWell(onTap: ()async{await showpagelogic.addtofav(searchresult[i]["ID"],id,subcategories,context,false,"0");
                              query.text = "";
                              setState(() {});},
                                child: Container(width: 27,
                                  height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size:20,),),
                              ),)),Expanded(flex: 2,child: Container()),
                              Expanded(flex: 2,child: Container(child:searchresult[i]["BestSeller"].toString()=="1"?
                              InkWell(onTap: ()=>null,
                                child: Container(width: 36,padding: EdgeInsets.all(3),
                                  height: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                                  FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontSize: 8),),Container(width: 10,height: 10,child: Image( image:AssetImage("images/thumbs-up.png"),fit: BoxFit.fill)),])),),
                              ):Container()))
                            ],),
                          ))])) : Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                          Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black54,) ,width: MediaQuery.of(context).size.width,height: 185,padding: EdgeInsets.only(left: 50,top: 75,bottom: 75,right: 50),child: Container(decoration: BoxDecoration(color: Colors.red ,borderRadius: BorderRadius.circular(20)) ,child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
                      ),
                      Container(margin: EdgeInsets.only(left: 8,right:10 ),child:Row(children:[
                        Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(searchresult[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                        ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),size: 15,)),),
                        Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Directionality( textDirection: TextDirection.rtl,child: AutoSizeText(searchresult[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: 14),))),)
                      ]) ),
                      Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(searchresult[i]["Description"].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10,color: Color.fromRGBO(163, 163, 163, 1)),)),),
                    ],)
                      ,),
                  ),
                ),
              );
            }),
          ),),
        ),Provider.of<Notifires>(context).guestmode?Container():Container(
          child:!navigate?Container(): Container(height: MediaQuery.of(context).size.height*0.046,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white),child:
          Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:false?  Container(

            ):Container(
              child: InkWell(onTap: ()async{
                Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "more", 3, context);
                },
                child: FittedBox(
                  child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("images/Vector.svg",fit: BoxFit.scaleDown,)),
                    Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                ),
              ),
            ))),Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:
              Container(
              child: InkWell(onTap: ()async{
               Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "req", 2, context);
                },
                child: Container(
                  child: FittedBox(
                    child: Column(children:[
                      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar2.png"),fit: BoxFit.scaleDown,)),
                      Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                  ),
                ),
              ),
            )))
            ,Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:Container(
              child: InkWell(onTap: ()async{
                 Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "favo", 1, context);
              }, child: FittedBox(
                  child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar3.png"),fit: BoxFit.scaleDown)),
                    Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                ),
              ),
            ))),
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:Container(
              child: InkWell(onTap: ()async{
                 Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "home", 0, context);
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
        )
      ],),),
    );
  }
  Widget places(){
    var iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    return Directionality(textDirection: TextDirection.ltr,
      child: Container(child: ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.182,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
          Container(child: Container(
            child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
              child: Row(children: [
                Expanded(flex: 2,child: InkWell(onTap: ()=>navigateback(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
                Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: AutoSizeText(name.toString(),style: TextStyle(color: Colors.white,fontSize:17),))),
                Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container():InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                    :Container(margin: EdgeInsets.only(right: 15),child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
              ],),
            ),Spacer(), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(left: 26,right:20,bottom: 23),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
              ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                if(val!=""){
                Provider.of<Notifires>(context ,listen: false).search2(providerp, val);
              }}, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
          )),
        ),
        Directionality(textDirection: TextDirection.rtl,
          child: Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.0  ,top: MediaQuery.of(context).size.height*0.03 ,left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04),height:cat=="مراسيل"? MediaQuery.of(context).size.height*0.76:MediaQuery.of(context).size.height*0.73,width: MediaQuery.of(context).size.width,child:downloadp?Container(child: Center(child: CircularProgressIndicator(),),): providerp.length==0?Container(
            child: Center(child: Text("لا يوجد تجار حاليا",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
          )
              : query.text==""? GridView.builder(physics: BouncingScrollPhysics() ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
            childAspectRatio: (166/240),),itemCount: providerp.length,itemBuilder: (context,i){
            return Directionality(textDirection: TextDirection.ltr,
              child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white,),
                child: InkWell(onTap: (){
                  if(providerp[i]["Status"].toString()=="0"){

                  }else{
                    showdetail(i,false);
                  }},
                  child: Container(child:Column(children: [
                    Container(
                      child:providerp[i]["Status"].toString()=="1"? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: ClipRRect( borderRadius: BorderRadius.circular(10),child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(providerp[i]["Photo"]),)),),
                        Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                          child: Row(children: [
                            Expanded(child:Provider.of<Notifires>(context).guestmode?Container(): Container(child: providerp[i]["UserFav"].toString()=="1"?
                            InkWell(onTap: ()=>showpagelogic.addtofavp(providerp[i]["ID"],id,subcategories,context,false,"1"),
                              child: Container(width: 27,
                                height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                            ):InkWell(onTap: ()=>showpagelogic.addtofavp(providerp[i]["ID"],id,subcategories,context,false,"0"),
                              child: Container(width: 27,
                                height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size:20,),),
                            ),)),Expanded(flex: 2,child: Container()),
                            Expanded(flex: 2,child: Container(child:providerp[i]["BestSeller"].toString()=="1"?
                            InkWell(onTap: ()=>null,
                              child: Container(width: 36,padding: EdgeInsets.all(3),
                                height: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                                FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontSize: 8),),Container(width: 10,height: 10,child: Image( image:AssetImage("images/thumbs-up.png"),fit: BoxFit.fill)),])),),
                            ):Container()))
                          ],),
                        ))])) : Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: Image(fit: BoxFit.fill,image: NetworkImage(providerp[i]["Photo"]),),),
                        Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black54,) ,width: MediaQuery.of(context).size.width,height: 185,padding: EdgeInsets.only(left: 50,top: 75,bottom: 75,right: 50),child: Container( decoration: BoxDecoration(color: Colors.red ,borderRadius: BorderRadius.circular(20)),child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
                    ),
                    Container(margin: EdgeInsets.only(left: 8,right:10 ),child:Row(children:[
                      Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(providerp[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                      ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),size: 15,)),),
                      Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Directionality( textDirection: TextDirection.rtl,child: AutoSizeText(providerp[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: 14),))),)
                    ]) ),
                    Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(providerp[i]["Description"].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10,color: Color.fromRGBO(163, 163, 163, 1)),)),),
                  ],)
                    ,),
                ),
              ),
            );
          }):Directionality(textDirection: TextDirection.rtl,
            child:searchresult.length==0?Container(child: Center(child: Text("لا يوجد نتيجة متوافقة مع البحث"),),): GridView.builder(physics: BouncingScrollPhysics() ,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: (166/240),),itemCount: searchresult.length,itemBuilder: (context,i){
              return Directionality(textDirection: TextDirection.ltr,
                child: Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),decoration: BoxDecoration(border: Border.all(color: Colors.black12) ,borderRadius: BorderRadius.circular(10),color: Colors.white), child: InkWell(onTap: (){
                  if(searchresult[i]["Status"].toString()=="0"){

                  }else{
                    showdetail(i,true);
                  }
                }, child: Container(child:Column(children: [
                  Container(
                    child:searchresult[i]["Status"].toString()=="1"? Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: ClipRRect( borderRadius: BorderRadius.circular(10),child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(searchresult[i]["Photo"]),)),),
                      Positioned(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.01 ),
                        child: Row(children: [
                          Expanded(child:Provider.of<Notifires>(context).guestmode?Container(): Container(child: searchresult[i]["UserFav"].toString()=="1"?
                          InkWell(onTap: ()async{
                            await showpagelogic.addtofavp(searchresult[i]["ID"],id,subcategories,context,false,"1");
                            query.text = "";
                            setState(() {});
                            },
                            child: Container(width: 27,
                              height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                          ):InkWell(onTap: ()async{
                            await showpagelogic.addtofavp(searchresult[i]["ID"],id,subcategories,context,false,"0");
                            query.text = "";
                            setState(() {});
                            },
                            child: Container(width: 27,
                            height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: Icon(Icons.favorite_border,color: Colors.black26,size:20,),),
                            ),)),Expanded(flex: 2,child: Container()),
                            Expanded(flex: 2,child:
                           Container(child:searchresult[i]["BestSeller"].toString()=="1"?
                          InkWell(onTap: ()=>null,
                            child: Container(width: 36,padding: EdgeInsets.all(3),
                              height: 20,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                              FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontSize: 8),),Container(width: 10,height: 10,child: Image( image:AssetImage("images/thumbs-up.png"),fit: BoxFit.fill)),])),),
                          ):Container()))
                        ],),
                      ))])) : Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 185,child: Image(fit: BoxFit.fill,image: NetworkImage(searchresult[i]["Photo"]),),),
                      Positioned(child:Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(10) ,topLeft: Radius.circular(10)),color: Colors.black54,) ,width: MediaQuery.of(context).size.width,height: 185,padding: EdgeInsets.only(left: 50,top: 75,bottom: 75,right: 50),child: Container(decoration: BoxDecoration(color: Colors.red ,borderRadius: BorderRadius.circular(20)) ,child: Center(child: FittedBox(child: Text("غير متاح",style: TextStyle(color: Colors.white),)),)),) ) ])),
                  ),
                  Container(margin: EdgeInsets.only(left: 8,right:10 ),child:Row(children:[
                    Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: FittedBox(child: AutoSizeText(searchresult[i]["Rating"],style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)),))
                    ,Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Icon(Icons.star,color: Colors.yellow.withGreen(2000),size: 15,)),),
                    Expanded(flex: 6,child: Container(alignment: Alignment.centerRight ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Directionality( textDirection: TextDirection.rtl,child: AutoSizeText(searchresult[i]["Name"],maxLines: 1,style: TextStyle(color: Color.fromRGBO(2, 44, 67, 1),fontWeight: FontWeight.bold,fontSize: 14),))),)
                  ]) ),
                  Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(searchresult[i]["Description"].toString(),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10,color: Color.fromRGBO(163, 163, 163, 1)),)),),
                ],)
                  ,),
                ),
                ),
              );
            }),
          ),),
        ),Provider.of<Notifires>(context).guestmode?Container():Container(
          child:!navigate?Container(): Container(height: MediaQuery.of(context).size.height*0.046,alignment: Alignment.center,decoration: BoxDecoration(color: Colors.white),child:
          Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:Container(
              child: InkWell(onTap: ()async{
                Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "more", 3, context);
              },
                child: FittedBox(
                  child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: SvgPicture.asset("images/Vector.svg",fit: BoxFit.scaleDown,)),
                    Container( height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                ),
              ),
            ))),Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:Container(
              child: InkWell(onTap: ()async{
                Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "req", 2, context);
              },
                child: Container(
                  child: FittedBox(
                    child: Column(children:[
                      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image :AssetImage("images/bar2.png"),fit: BoxFit.scaleDown,)),
                      Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("طلباتي",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
                  ),
                ),
              ),
            )))
            ,Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:
             Container(
              child: InkWell(onTap: ()async{
                Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "favo", 1, context);
              }, child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.025,child: Image(image : AssetImage( "images/bar3.png"),fit: BoxFit.scaleDown)),
                  Container(height: MediaQuery.of(context).size.height*0.02,child: FittedBox(child: Text("مفضلة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*10),)))]),
              ),
              ),
            ))),
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.025,right: MediaQuery.of(context).size.width*0.025),height: MediaQuery.of(context).size.height*0.07,child:
             Container(
              child: InkWell(onTap: ()async{
                Provider.of<Notifires>(context,listen: false).getindexshowpage(tabController, "home", 0, context);
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
        )
      ],),),
    );
  }
  navigateback(){
  Navigator.of(context).pop();
  }
  getdata(index) async{
    Future.delayed(const Duration(milliseconds: 500), () {
      if(name =="اماكن" ||cat == "اماكن") {
        Provider.of<Notifires>(context, listen: false).getplace1(
            index, subcategories, context);
      }else{
        Provider.of<Notifires>(context, listen: false).getdatashowpage(
            index, subcategories, context);
      }
      });
  }
  showdetail(i,search) async{
    if (name == "اماكن") {
      if (search) {
        await Provider.of<Notifires>(context,listen: false).resetplace2();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Places(
            places: searchresult[i]["Products"],
            idprovider: searchresult[i]["UserID"],
            name: searchresult[i]["Name"],);
        }));
      }
      else {
        await Provider.of<Notifires>(context,listen: false).resetplace2();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Places(
            places: providerp[i]["Products"],
            name: providerp[i]["Name"],
            idprovider: providerp[i]["UserID"],);
        }));
      }
    } else {
      if (cat == "اماكن") {
        if (search) {
          await Provider.of<Notifires>(context,listen: false).resetplace2();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Places(
              places: searchresult[i]["Products"],
              idprovider: searchresult[i]["UserID"],
              name: searchresult[i]["Name"],);
          }));
        }
        else {
          await Provider.of<Notifires>(context,listen: false).resetplace2();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Places(
              places: providerp[i]["Products"],
              name: providerp[i]["Name"],
              idprovider: providerp[i]["UserID"],);
          }));
        }
      }
      else {
        if (cat == "مراسيل") {
          if (search) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Marasildetail1(providerid: searchresult[i]["ID"],);
            }));
          }
          else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Marasildetail1(providerid: providers[i]["ID"],);
            }));
          }
        }
        else {
          if(ketchintype.toString() =="1"){
            if (search) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Cookersdetail(providerid:searchresult[i]["ID"] ,);
              }));
            }
            else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Cookersdetail(providerid: providers[i]["ID"],);
              }));
            }
          }else {
            if (search) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Detailpage(providerid: searchresult[i]["ID"],);
              }));
            }
            else {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Detailpage(providerid: providers[i]["ID"],);
              }));
            }
          }
        }
      }
    }
  }
}