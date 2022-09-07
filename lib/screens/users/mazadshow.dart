import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'mazadat.dart';
import 'notification.dart';
class Mazadshow extends StatefulWidget{
  List mazads =[];
  Mazadshow({this.mazads});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemazadshow(mazads :mazads);
  }
}
class Statemazadshow extends State<Mazadshow> with SingleTickerProviderStateMixin{
  List mazads =[];
  Statemazadshow({this.mazads});
  TextEditingController query ;
  Showpagelogic showpagelogic;
  @override
  void initState() {
    showpagelogic = new Showpagelogic(context);
    query = new TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.1,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40))),child:
          Container(child: Container(
                child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Row(children: [
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigateback(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: AutoSizeText("مزاد",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),))),
                    Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container():InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                        :Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                  ],),
                )]),
          )),
        ),
        Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,height: MediaQuery.of(context).size.height*0.85,child:mazads.length==0?Container(child: Center(child: Text("لا يوجد مزادات حاليا"),),): ListView.builder(physics: BouncingScrollPhysics(),itemCount:mazads.length ,itemBuilder: (context,i){
          return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),child: InkWell(onTap: ()=>navigatetomazad(i),child: Container(color: Colors.black12.withOpacity(0.1) ,child: Directionality(textDirection: TextDirection.rtl,child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined,size: MediaQuery.of(context).size.width*0.05),title: Text(mazads[i]["Description"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),)),)));
        }),)
      ],),),
    );
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetomazad(i){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Mazad(mazad: mazads[i],);
    }));
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}