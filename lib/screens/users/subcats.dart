import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:ezzproject/screens/users/showpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'notification.dart';

class Subcats extends StatefulWidget{
  List data ;
  var tabcontroller;
  var maincontext;
  var name;
  var idad;
  Subcats({this.data,this.tabcontroller,this.maincontext,this.name,this.idad});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statesubcats(idad : idad,data: data,maincontext: maincontext,tabcontroller: tabcontroller,name:name);
  }
}
class Statesubcats extends State<Subcats> with SingleTickerProviderStateMixin {
  List data;
  var tabcontroller;
  var maincontext;
  var name;
  var idad;
  var iconofshop;
  Statesubcats({this.idad,this.data,this.tabcontroller,this.maincontext,this.name});
  @override
  void initState() {
    adable();
    super.initState();
  }
  adable(){
    print(idad);
    if(idad !=null){
      Future.delayed(Duration(milliseconds: 100),(){
        Provider.of<Notifires>(context,listen: false).adsgotosubcats2(context,idad,data,name);
      });
    }
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
  @override
  Widget build(BuildContext context) {
    iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body: Container(width: MediaQuery
        .of(context)
        .size
        .width, height: MediaQuery
        .of(context)
        .size
        .height,
      child: ListView(children: [
        Directionality(textDirection: TextDirection.rtl,
          child: Container(width: MediaQuery
              .of(context)
              .size
              .width, height: MediaQuery
              .of(context)
              .size
              .height, child:
          ListView(children: [
            Directionality(textDirection: TextDirection.rtl,
              child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height ,child:
              Directionality(textDirection: TextDirection.ltr,
                child: Container(child: ListView(children: [
                  Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.1,
                    decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
                    Container(child: Container(
                      child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
                        child: Row(children: [
                          Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                          Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: Text(name.toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                          Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                          Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetostore(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                              :Container(margin: EdgeInsets.only(right: 15),child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                        ],),
                      )]),
                    )),
                  ),
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,height: MediaQuery.of(context).size.height*0.85,child:data.length==0? Container(child: Center(child: Text("لا يوجد فئات"),),):ListView.builder(physics: BouncingScrollPhysics(),itemCount:data.length ,itemBuilder: (context,i){
                    return Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,child: InkWell(onTap: ()=>navigatetoshowpage(i),child: Container(color: Colors.black12.withOpacity(0.1),child: Directionality(textDirection: TextDirection.rtl,child: ListTile(trailing: Icon(Icons.arrow_forward_ios_outlined,size: MediaQuery.of(context).size.width*0.05),title: Text(data[i]["Name"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.03),),)),)));
                  }),)
                ],),),
              )
              ),
            ),
          ])
          ),
        ),
      ]),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  navigatetoshowpage(i)async{
    await Provider.of<Notifires>(context,listen: false).resetshowpagevalues();
    Future.delayed(Duration(milliseconds: 100) ,()
    {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Showpage(cat: name,
          id: data[i]["ID"],
          name: data[i]["Name"],
          subcategories: data,
          tabcontroller: tabcontroller,
          maincontext: context,
          navigate: false,
          ketchintype: data[i]["Type"].toString(),);
      }));
    });
  }
}



