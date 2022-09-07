import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return Statenotifi();
  }
}
class Statenotifi extends State<Notifications>{
  List notification =[];
  Profilelogic profile ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  var download = true;
  getdata()async{
    profile = new Profilelogic(context);
    notification = await profile.getnoty();
    download = false;
    setState(() {});
  }
  del(id)async {
    var state = await profile.delnoti(id);
    if(state.toString() =="true") {
    download = true;
    setState(() {

    });
    notification = await profile.getnoty();
    download = false;
    setState(() {});
  }
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  @override
  Widget build(BuildContext context) {
    var iconofshop =Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body: Container(
      child:download?Center(child: CircularProgressIndicator(),) :ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
          decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
          Container(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),alignment: Alignment.center,child: Text("التنبيهات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(flex: 2,child:InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                      :Container(margin: EdgeInsets.only(right: 15),child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                ],),
          )),
        ),

        Container(
            child: Container(width: MediaQuery.of(context).size.width*0.2,alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.02,bottom: MediaQuery.of(context).size.height*0.02),child:notification.length==0?Container(): Row(children: [
              InkWell(onTap: (){
                del(null);
              },child: Container(child: Text("حذف الكل",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.red,decoration:TextDecoration.underline),),))
            ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: Icon(Icons.delete,color: Colors.red,size: MediaQuery.of(context).size.width*0.05,),)],),),
        )
        ,Container(height: MediaQuery.of(context).size.height*0.8,
          child:notification.length==0? Center(child: Text("لا يوجد اشعارات"),):  Container(height: MediaQuery.of(context).size.height*0.88 ,child: ListView.builder(physics: BouncingScrollPhysics(),itemCount: notification.length,itemBuilder: (context,i){
           return Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.02),
             child: InkWell(onTap: (){
               if(notification[i]["order"]!=null && notification[i]["order"].toString() !="0"){
                 profile.getorderdetail(notification[i]["order"]);
               }
             },
               child: Container(padding: EdgeInsets.all(10),color: Colors.white,child:Row(children: [
                   Expanded(flex: 1,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerLeft,child: InkWell( onTap: (){
                     del(notification[i]["id"]);
                   },child: Icon(Icons.delete,color: Colors.red,size: 20,)),))
                 ,Expanded(flex: 3,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerLeft,child: Text(notification[i]["date"]==null?"--" :notification[i]["date"].toString(),style: TextStyle(fontSize: 12,color: Color.fromRGBO(12, 145, 190, 1))),))
                , Expanded(flex: 6,child: Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(notification[i]["msg"],maxLines: 5,style: TextStyle(fontSize: 14),)),)),
                 Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),alignment: Alignment.centerRight,child: Container(height: MediaQuery.of(context).size.width*0.01,width: MediaQuery.of(context).size.width*0.01,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(200)),), ))
               ],) ,),
             ),
           );
          }),),
        )
      ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}