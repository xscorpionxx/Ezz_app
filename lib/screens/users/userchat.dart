import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/chat.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat.dart';
class Userchat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateUserchat();
  }
}
class StateUserchat extends State<Userchat> {
  TextEditingController query;
  Chatlogic chatlogic;
  @override
  void initState() {
    query = new TextEditingController();
    getdata();
    chatlogic = new Chatlogic(context);
    super.initState();
  }
  List messages =[];
  List searhcresult =[];
  var downlaod;
  @override
  Widget build(BuildContext context) {
    searhcresult = Provider.of<Notifires>(context,listen: false).searchresultchat;
    downlaod = Provider.of<Notifires>(context).downchatuser;
    messages = Provider.of<Notifires>(context).messages1;
    lastmessages = Provider.of<Notifires>(context).lastmessages1;
    ids = Provider.of<Notifires>(context).ids1;
    sub = Provider.of<Notifires>(context).sub1;
    // TODO: implement build
    return Scaffold(body: ListView(children: [
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.182,
        decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
        Container(child: Container(
          child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
            child: Row(children: [
              Expanded(flex: 2,child: InkWell(onTap: (){Navigator.of(context).pop();},child: Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 25),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
              Expanded(flex: 3,child: Container(alignment: Alignment.centerLeft,child: AutoSizeText("محادثات",style: TextStyle(color: Colors.white,fontSize:17),))),
            ],),
          ),Spacer(), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(left: 26,right:20,bottom: 23),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
            ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
              Provider.of<Notifires>(context ,listen: false).searchuserchat(lastmessages,val);
              setState(() {});
            }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
        )),
      ), Container(
        child:downlaod?Container(height: MediaQuery.of(context).size.height*0.6,child: Center(child: CircularProgressIndicator(),),):lastmessages.length==0?
        Container(height: MediaQuery.of(context).size.height*0.6,child: Center(child: Text("لا يوجد رسائل حاليا"),),) : Container(margin: EdgeInsets.only(top: MediaQuery
            .of(context)
            .size
            .height * 0.05),
          height: MediaQuery
              .of(context)
              .size
              .height * 0.8,
          child:query.text=="" ?ListView.builder(physics: BouncingScrollPhysics(),
              itemCount: lastmessages.length, itemBuilder: (context, i) {
            if(lastmessages[i]["sender"].toString()=="User" ){
              return message(lastmessages[i]["created_at"] , lastmessages[i]["message"],lastmessages[i]["ReciveName"],lastmessages[i]["SenderPhoto"] , lastmessages[i]["provider_id"],
                  sub[i][ids[i]]);
            }else{
              return message(lastmessages[i]["created_at"] , lastmessages[i]["message"],lastmessages[i]["SenderName"],lastmessages[i]["RecivePhoto"]  , lastmessages[i]["provider_id"],
                  sub[i][ids[i]]);
            }
          }):ListView.builder(
              itemCount: searhcresult.length, itemBuilder: (context, i) {
            if(searhcresult[i]["sender"].toString()=="User" ){
              return message(searhcresult[i]["created_at"] , searhcresult[i]["message"],searhcresult[i]["ReciveName"],searhcresult[i]["SenderPhoto"] , searhcresult[i]["provider_id"],
                  sub[i][ids[i]]);
            }else{
              return message(searhcresult[i]["created_at"] , searhcresult[i]["message"],searhcresult[i]["SenderName"],searhcresult[i]["RecivePhoto"]  , searhcresult[i]["provider_id"],
                  sub[i][ids[i]]);
            }
          }),),
      )],),);
  }
  message(time , message , name , photo ,provider_id ,sub){
    print(sub);
    DateTime dt = DateTime.parse(time.trim().substring(0,10));
    if(dt.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
      time = time.toString().trim().substring(0,10);
    }
    else{
      time = time.toString().trim().substring(11,19);
    }
    return InkWell(onTap: ()async{
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Chat(id: provider_id,providername:name ,able: true,);
      }));
    }
        ,child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.03),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.white,boxShadow: [  BoxShadow(
          color: Colors.black12
          ,blurRadius: 1.0,
          spreadRadius: 0.0,
          offset: Offset(2.0, 2.0), // shadow direction: bottom right
        )],borderRadius: BorderRadius.circular(10)),child: Row(children: [
          Expanded(flex: 2,child:Container( child:  AutoSizeText(time,maxLines: 1,style: TextStyle(color: Colors.grey,fontSize:14),),) ),
          Expanded(flex: 6,child: Column(children: [
            Container(child: Text(name,style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*13,fontWeight: FontWeight.bold),),),
            Container(child:  Text(message,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontSize: MediaQuery.of(context).textScaleFactor*13),),),
          ],)),
          Expanded(flex: 2,child: Container(height: MediaQuery.of(context).size.height*0.08,child: ClipRRect(borderRadius: BorderRadius.circular(100),child: Image(image: AssetImage("images/logoaz.png"),fit: BoxFit.fill,)),))
        ],),));
  }
  alertwait() {
    showDialog(
        barrierDismissible: false, context: context, builder: (context) {
      return AlertDialog(elevation: 0,backgroundColor: Colors.transparent,
        content: Container(width: 30, height: 30,
            child: Center(child: SizedBox(
                width: 30, height: 30, child: CircularProgressIndicator()))),
      );
    });
  }
  List lastmessages = [];
  List sub =[];
  List ids = [];
  getdata() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   Provider.of<Notifires>(context,listen: false).getlistmessages(sharedPreferences.getString("id"));
  }
}