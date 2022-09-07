import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:ezzproject/logic/shoppingcart.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'notification.dart';
class Shoppingcard extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateShopping();
  }
}
class StateShopping extends State<Shoppingcard>{
  List products = [];
  int totalprice;
  List shoppinglist =[];
  var region2 = "المحافظة"  ;
  var region1 = "المنطقة";
  var region3 = "المدينة";
  List region1list =["المنطقة"];
  List region2list =["المحافظة"];
  List region3list =["المدينة"];
  int discountprice =0 ;
  List region2back =[];
  List region1back =[];
  List region3back =[];
  GlobalKey<FormState> key ;
  var location;
  Shoppingcartlogic shoppingcartlogic;
  TextEditingController discount ;
  TextEditingController address ;
  TextEditingController phone ;
  Signuplogic signuplogic;
  List regions =[];
  List citites =[];
  Profilelogic profilelogic;
  @override
  void initState() {
    profilelogic = new Profilelogic(context);
    signuplogic = new Signuplogic(context);
    shoppingcartlogic = new Shoppingcartlogic(context);
    discount = new TextEditingController();
    address = new TextEditingController();
    phone = new TextEditingController();
    key =new GlobalKey<FormState>() ;
    getdata();
    super.initState();
  }
  var change = false;

  getdata()async{
    downloadcart = true;
    setState(() {

    });
    await Provider.of<Notifires>(context,listen: false).getcart(context);
    var dataa = await signuplogic.getplaces();
    regions = dataa["1"];
    for(int f = 0 ; f<regions.length;f++){
      region1back.add({"name" :regions[f]["Name"],"ID" : regions[f]["ID"].toString()});
    }
    for(int i =0 ; i<region1back.length ; i++){
      region1list.add(region1back[i]["name"].toString());
    }
    var profiledata = await profilelogic.getdata();
    phone.text = profiledata["phone"].toString();
    region1 = profiledata["re1"];
    slecetcity(profiledata["re1"]);
    region2 = profiledata["re2"];
    selectgovern(profiledata["re2"]);
    region3 = profiledata["re3"];
    downloadcart = false;
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
    region3="المدينة";
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
  var downloadcart;
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  Widget build(BuildContext context) {
    location =Provider.of<Notifires>(context).location;
    products = Provider.of<Notifires>(context).shoppingcart;
    totalprice = Provider.of<Notifires>(context).totalpricecart;
    shoppinglist = Provider.of<Notifires>(context).shoppinglist;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:  Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1) ,alignment: Alignment.center,child: Text("عربة التسوق",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                Expanded(child: InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                Expanded(child:InkWell(onTap: ()=>null,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07))) )
              ],),) ),
           Container(height:MediaQuery.of(context).size.height *0.85 ,child:downloadcart?Container(child: Center(child: CircularProgressIndicator(),),) :products.length==0 ?Container(child: Center(child: Text("لا يوجد أي منتج في عربة التسوق "),),) : ListView(children: [
             Directionality(textDirection: TextDirection.rtl, child:  Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child: Container(alignment: Alignment.centerRight,child: AutoSizeText("لديك"+shoppinglist.length.toString() +" عنصر في السلة",maxLines: 1,style: TextStyle(fontSize: 16),),)),
               Expanded(child: Container(alignment: Alignment.centerLeft,child: InkWell(onTap: ()=>null,child:true?Container(): Text("حذف الكل",style: TextStyle(decoration: TextDecoration.underline,color: Colors.redAccent,fontSize: MediaQuery.of(context).size.width*0.035),)),))],),)),
             Container(
               child:products.length==0?Container() :Container(height: MediaQuery.of(context).size.height*0.32,width: MediaQuery.of(context).size.width,child: ListView.builder( physics: BouncingScrollPhysics(),itemCount: products.length,itemBuilder: (context,i){
                 return Container( margin: EdgeInsets.only(left: 20,right: 20) ,height: MediaQuery.of(context).size.height*0.12,padding: EdgeInsets.only(top: 0),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),child:Row(children: [
                   Expanded(child: Container(margin: EdgeInsets.only(top: 7) ,width: MediaQuery.of(context).size.width*0.1,child: Column(children: [
                     Directionality(textDirection: TextDirection.rtl,child: Text(products[i]["SalePrice"].toString()+"ريال",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 13))),IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){ Provider.of<Notifires>(context,listen: false).delete(i, products[i]["SalePrice"], context);
                        })
                   ],),)),Expanded(flex: 2,child: Container(margin: EdgeInsets.only(top: 10) ,width: MediaQuery.of(context).size.width*0.1,child: Column(children: [
                     Container(margin: EdgeInsets.only(right: 20) ,alignment: Alignment.centerRight,child: FittedBox(child: Directionality( textDirection: TextDirection.rtl,child: Text(products[i]["Name"],style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold))))),Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:20 ) ,child: Row(children: [
                       Expanded(child: InkWell(onTap: ()=>Provider.of<Notifires>(context,listen: false).minus2(products[i]["ID"].toString(),i ,products[i]["Qt"],int.parse(products[i]["SalePrice"].toString()) , context)
                 ,child: Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(5)) ,alignment:Alignment.centerRight,padding:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.015 ) ,child: Center(child: Icon(Icons.minimize,color: Colors.white,)),))),
                       Expanded(flex: 2,child: Container(alignment: Alignment.center,child: Text(products[i]["Qt"].toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),))),
                       Expanded(child: InkWell(onTap: ()=>Provider.of<Notifires>(context,listen: false).plus2( products[i]["ID"].toString(),i ,products[i]["Qt"],int.parse(products[i]["SalePrice"].toString()),context)
                 ,child: Container(decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(5)) ,alignment:Alignment.centerRight,height: MediaQuery.of(context).size.height*0.04,child: Center(child: Icon(Icons.add,color: Colors.white,)),)))
                     ],),)
                   ],),)),
                   Expanded(child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image(image: NetworkImage(products[i]["Photo"]),fit: BoxFit.fill,)),))
                 ],)
                   ,);
               }),),
             ),
             Container(height: MediaQuery.of(context).size.height*0.07,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right: MediaQuery.of(context).size.width*0.02) ,padding: EdgeInsets.all(5) ,decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(217, 212, 212, 1),width: 1) ,color: Colors.white,borderRadius: BorderRadius.circular(20)),child: Row(children: [
               Expanded(child: InkWell(onTap: ()=>discounts(),child: Container(height: MediaQuery.of(context).size.height*0.07,width: MediaQuery.of(context).size.width*0.25,alignment: Alignment.center,child: Text("تطبيق",style: TextStyle(color: Colors.white,fontSize: 12),),decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(20)),)))
               ,Expanded(flex: 3,child: Container(child: Directionality(textDirection: TextDirection.rtl,child: TextFormField( style: TextStyle(fontSize: 12),controller: discount,decoration: InputDecoration( hintText: "قسيمة الخصم",hintStyle: TextStyle(fontSize: 12),border: InputBorder.none),))))]),),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),color: Colors.white,width: MediaQuery.of(context).size.width,child: Column(children: [
               Container( child: Text("تفاصيل الطلب",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top: 10),),
               Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child:Directionality(textDirection: TextDirection.rtl ,child: Container( alignment: Alignment.centerLeft,child:   Text("0"+"ريال" ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))))
                 ,Expanded(child: Container(margin: EdgeInsets.only(top: 10) ,alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl ,child: Text("خدمة التوصيل",style: TextStyle(fontSize: 12)))))],),)
               , Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Row(children: [Expanded(child: Directionality(textDirection: TextDirection.rtl ,child: Container( alignment: Alignment.centerLeft,child: Text(totalprice.toString()+"ريال",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))))
                 ,Expanded(child: Container(margin: EdgeInsets.only(top: 10) ,alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl ,child: Text("التكلفة",style: TextStyle(fontSize: 12)))))],),),
               Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1,top: 10 ),child: Row(children: [Expanded(child:Directionality(textDirection: TextDirection.rtl ,child: Container( alignment: Alignment.centerLeft,child:  Text(discountprice.toString()+"ريال" ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))))
                 ,Expanded(child: Container(alignment: Alignment.centerRight,child:Directionality(textDirection: TextDirection.rtl ,child: Text("قسيمة الخصم",style: TextStyle(fontSize: 12)))))],),)
               ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),child: Divider(thickness: 1,),),
               Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1,bottom: 10 ),child: Row(children: [Expanded(child:Directionality(textDirection: TextDirection.rtl ,child: Container( alignment: Alignment.centerLeft,child:  Text((int.parse(totalprice.toString()) - discountprice).toString()+"ريال" ,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03)))))
                 ,Expanded(child: Container(margin: EdgeInsets.only(right: 0) ,alignment: Alignment.centerRight,child: Text("الاجمالي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.03))))],),)
             ],),),
             Container(
               child: change? Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,),color: Colors.white,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.08,child: Column(children: [
                 Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.02,right:MediaQuery.of(context).size.width*0.1 ) ,child : Row(children: [Expanded(child:Container(child: InkWell(onTap: (){
                   change = true;
                   setState(() {});
                 },child: Text("اكمال البيانات",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.red))),)),Expanded(child:Container(alignment: Alignment.centerRight,child: Text("العنوان",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold)),))],)),
               ],),),
             ),
             Container(
               child: !change? Container(): Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),color: Colors.white,width: MediaQuery.of(context).size.width,child: Column(children: [
                Directionality(textDirection: TextDirection.rtl, child:  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                   child: Row(children:[ Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ) ,child : Container(alignment: Alignment.centerRight,child: Text("اكمال المعلومات",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold)),))) ,
                    Expanded(child:InkWell(child: Container( margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerLeft,child: Text("تم",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,fontWeight: FontWeight.bold,color: Colors.red)),),onTap: (){
                      setState(() {
                        change = false;
                      });
                    },))
                   ]),
                 )),
                 Directionality(textDirection: TextDirection.rtl,
                   child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.01 ,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child : Row(children: [ Expanded(child: Directionality(textDirection: TextDirection.rtl, child:
                   Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,border: Border.all(color: Color.fromRGBO(217, 212, 212, 1),width: 1)),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                   FittedBox(child: DropdownButtonHideUnderline(
                         child: DropdownButton(
                           hint: Text("المنطقة" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),)
                          , value: region1
                           ,items: region1list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                         Text('$e',style: TextStyle(fontSize: 13,color:e==region1?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                           onChanged: (_) {
                             if(_.toString() != "المنطقة") {
                               region1 = _;
                               slecetcity(region1);
                               setState(() {});
                             }
                           },
                         ))),),
                   )),Expanded(child:Directionality(textDirection: TextDirection.rtl, child:
                   Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,border: Border.all(color: Color.fromRGBO(217, 212, 212, 1),)),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                     FittedBox(
                         child: DropdownButtonHideUnderline(
                             child: DropdownButton(
                               hint: Text("المحافظة" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),),
                               value: region2
                               ,items: region2list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                             Text('$e',style: TextStyle(fontSize: 13,color:e==region2?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                               onChanged: (_) {
                                 if(_.toString() != "المحافظة") {
                                   region2 = _;
                                   selectgovern(region2);
                                   setState(() {});
                                 }
                               },
                             )),
                       ),
                   ),
                   )),Expanded(child:Directionality(textDirection: TextDirection.rtl, child:
                   Container(
                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white,border: Border.all(color: Color.fromRGBO(217, 212, 212, 1),width: 1)),width: MediaQuery.of(context).size.width*0.9,height: MediaQuery.of(context).size.height*0.08,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                    DropdownButtonHideUnderline(
                         child: DropdownButton(
                           hint: Text("المدينة" , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),),
                           value: region3
                           ,items: region3list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                         Text('$e',style: TextStyle(fontSize: 13,color:e==region3?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                           onChanged: (_) {
                             if(_.toString() != "المدينة") {
                               region3 = _;
                               setState(() {});
                             }
                           },
                         ))),
                   ))],)),
                 ),
                   Directionality(textDirection: TextDirection.rtl,
                     child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,left: MediaQuery.of(context).size.width*0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: Row(children:[
                       Directionality( textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width*0.75 ,child: TextFormField(keyboardType: TextInputType.phone,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),textDirection: TextDirection.rtl, controller: phone,inputFormatters: <TextInputFormatter>[
                         FilteringTextInputFormatter.digitsOnly
                       ],decoration: InputDecoration( hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),hintText: "رقم الجوال",border: InputBorder.none),))),
                       Container(width: 10,height: MediaQuery.of(context).size.height*0.05,child: VerticalDivider(color: Colors.black38,thickness: 1.5,),),
                       Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,child: Text("+966",style: TextStyle(color: Colors.black54,fontSize: MediaQuery.of(context).size.width*0.03),),)]),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Color.fromRGBO(217, 212, 212, 1),width: 1)),),
                   )
                 ,Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height*0.01,top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child : Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: address , textInputAction: TextInputAction.send,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),maxLines: 2,decoration: InputDecoration(hintText: "العنوان بالتفصيل",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.black38),border: InputBorder.none),)),decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Color.fromRGBO(217, 212, 212, 1),width: 1)),)),
               ],),),
             ),
             Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
               child: InkWell(onTap:(){
           shoppingcartlogic.makeorder(address.text ,phone.text,region1,region2,region3,region1back,region2back,region3back ,discount.text,(int.parse(totalprice.toString()) - discountprice).toString());
                 },
                 child: Container( height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft:Radius.circular(20) ),color:Color.fromRGBO(42, 171, 227, 1),),child: Row(children: [
                   Expanded( flex: 2,child:InkWell(child: Container(decoration: BoxDecoration(color: Colors.white.withOpacity(0.1),borderRadius: BorderRadius.circular(20)),height: MediaQuery.of(context).size.height*0.1 ,child: Row(children:[ Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01,left:MediaQuery.of(context).size.width*0.02 ),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: Text("اتمام الطلب",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),)))]),)) ),
                   Expanded(flex: 3,child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.01),child: FittedBox(
                     child: Column(children: [Text("المجموع",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),),
                         Directionality(textDirection: TextDirection.rtl,child: Text("ريال"+(int.parse(totalprice.toString()) - discountprice).toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*11),))
                       ]),
                   )))]),),
               ),
             )

           ],),)
              ],),
      ),
    ),);
  }
  discounts()async{
    var data = await shoppingcartlogic.addpromocode(discount.text.toString(), totalprice.toString(),products);
    if(data["state"]){
      discountprice = int.parse(data["value"].toString().split(".")[0]);
      setState(() {});
    }
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}