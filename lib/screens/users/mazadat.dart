import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/mazadlogic.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'notification.dart';

class Mazad extends StatefulWidget{
  var mazad;
  var able ;
  Mazad({this.mazad,this.able});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemazad(mazad: mazad,able: able);
  }
}
class Statemazad extends State<Mazad>{
  var mazad;
  var able ;
  Statemazad({this.mazad,this.able});
  TextEditingController message;
  TextEditingController price;
  Mazadlogic mazadlogic;
  GlobalKey<FormState> key;
  List comments =[];
  @override
  void initState() {
    key = new GlobalKey<FormState>();
    mazadlogic = new Mazadlogic(context);
    message = new TextEditingController();
    price = new TextEditingController();
    getdata1();
    super.initState();
  }
  getdata1()async{
    comments = await mazadlogic.getcomments(mazad["ID"]);
    download = false;
   setState(() {
   });
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetostore(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  var download = true;
  @override
  Widget build(BuildContext context) {
    var iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
            decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
            Container(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                  child: Row(children: [
                    Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text("مزادات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                    Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container():able==false?Container(): InkWell(onTap: navigatetonotification,child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container():able==false?Container():  InkWell(onTap: ()=>navigatetostore(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                        :Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )))  )
                  ],),
            )),
          ),
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.25,child:FadeInImage(placeholder: AssetImage("images/emptyphoto.png"),image: NetworkImage(mazad["Photo"]),fit: BoxFit.cover,)),
          Container(child:Row(children:[Expanded(child:  Container(child:Center(child:  Text(mazad["status"].toString()=="1"?"متاح" : "انتهى",style: TextStyle(color: Color.fromRGBO(42, 171, 227, 1)),)),)) , Expanded(flex: 3,child: Container(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05,top: 10,bottom: 5),  color: Colors.black12,
            alignment: Alignment.centerRight,child: Column(children: [Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText( "نمط المزاد :"+mazad["Type"].toString(),maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.indigo),)),),
              Container( alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText( mazad["Description"].toString(),maxLines: 2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Color.fromRGBO(139, 139, 139, 1)),)),),
              Container( alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(  "يبدأ المزاد من "+mazad["StartPrice"].toString() +"ريال ",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.red),)),)]),
          ))])),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),height:able==false||mazad["status"].toString()=="0" ? MediaQuery.of(context).size.height*0.45:MediaQuery.of(context).size.height*0.35,child:download?Container(child: Center(child: CircularProgressIndicator(),),): comments.length==0?Container(child: Center(child: Text("لا يوجد تعليقات"),),) :
          mazad["status"].toString()=="0"?ListView.builder( physics: BouncingScrollPhysics(),itemCount: comments.length,itemBuilder: (context,i){
            if(i==0){
              return Container(color: Color.fromRGBO(42, 171, 227, 1) ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:Row(children: [
                Expanded(flex: 7,child: Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Column(children: [
                  Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(comments[i]["User"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.white),)),),
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(comments[i]["Comment"],maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03,color: Colors.white),)),),
                  Container(child: Divider(color: Colors.white,thickness: 1,),)
                ],),)),
                Expanded(child: Container( height: MediaQuery.of(context).size.height*0.1,alignment: Alignment.topCenter,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image: NetworkImage(comments[i]["UserPhoto"]),fit: BoxFit.fill,)),))
              ],));
            }else{
            return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:Row(children: [
              Expanded(flex: 7,child: Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Column(children: [
                Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(comments[i]["User"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)),),
                Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(comments[i]["Comment"],maxLines: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)),),
                Container(child: Divider(color: Colors.black12.withOpacity(0.1),thickness: 1,),)
              ],),)),
              Expanded(child: Container( height: MediaQuery.of(context).size.height*0.1,alignment: Alignment.topCenter,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image: NetworkImage(comments[i]["UserPhoto"]),fit: BoxFit.fill,)),))

            ],));}
          }) :ListView.builder( physics: BouncingScrollPhysics(),itemCount: comments.length,itemBuilder: (context,i){
return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:Row(children: [
  Expanded(flex: 7,child: Container(margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: Column(children: [
    Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(comments[i]["User"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)),),
    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,child: Directionality(textDirection: TextDirection.rtl,child: Text(comments[i]["Comment"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),)),),
    Container(child: Divider(color: Colors.black12.withOpacity(0.1),thickness: 1,),)
  ],),)),
  Expanded(child: Container( height: MediaQuery.of(context).size.height*0.1,alignment: Alignment.topCenter,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(image: NetworkImage(comments[i]["UserPhoto"]),fit: BoxFit.fill,)),))

],));
          }),),
          Container(
            child: Container(
              child:Provider.of<Notifires>(context).guestmode?Container():able==false?Container():mazad["status"].toString()=="0"?Container(): Container(height: MediaQuery.of(context).size.height*0.1,width: MediaQuery.of(context).size.width,margin: EdgeInsets.only(bottom: 5),
                child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05) ,
                  decoration: BoxDecoration( color: Color.fromRGBO(243, 244, 245, 1),border: Border.all(color: Color.fromRGBO(204, 204, 204, 1),width: 1.5),borderRadius: BorderRadius.circular(10)), child: Directionality(textDirection: TextDirection.rtl,child:
                  Row(children: [Expanded(flex: 2,child:  InkWell(onTap: ()async{
                    await mazadlogic.addcomm(key, message.text,price.text,mazad["ID"]);
                    message.text ="";
                    price.text = "";
                    setState(() {});
                    getdata1();
                    },child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),color: Colors.black),child: Directionality(textDirection: TextDirection.ltr,child: Icon(Icons.send,color: Colors.white,)),)))
                    ,Expanded(flex: 8 ,child: TextFormField( validator: mazadlogic.validate,controller: message,textInputAction: TextInputAction.send,decoration: InputDecoration(hintText: "تعليق",hintStyle: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.035,),border: InputBorder.none),)),
                      Expanded(flex: 3 ,child: TextFormField( validator: mazadlogic.validatecach,keyboardType: TextInputType.number,controller: price,textInputAction: TextInputAction.send,decoration: InputDecoration(hintText: " قيمة",hintStyle: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.035,),border: InputBorder.none),)),
    ]),),
              ),
            ),
          )
        ),
      ]),
    ),));
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}