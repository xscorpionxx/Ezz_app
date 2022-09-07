import 'package:ezzproject/logic/chat.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat2 extends StatefulWidget{
  var user_id;
  List messags = [];
  var type;
  var username;
  Chat2({this.user_id, this.type ,this.messags,this.username});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservices(user_id: user_id , messages: messags,username: username);
  }
}
class Stateaddservices extends State<Chat2>{
  var user_id;
  var type;
  var providerid;
  List messages =[];
  var username;
  Stateaddservices({this.user_id ,this.type ,this.messages,this.username});
  TextEditingController message ;
  Chatlogic chatlogic;
  List messages1 =[];
  BuildContext dialogcontexta;
  var timer;
  var connected = false;
  setid()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    providerid = sharedPreferences.getString("id");
  }
  Profilelogic profilelogic ;
  var download = true;
  var providername;
  getname()async{
    var data = await profilelogic.getdata();
    providername = data["name"];
    Provider.of<Notifires>(context,listen: false).getmessagesfireroom2(providerid,user_id);
    download = false;
    setState(() {});
  }
  @override
  void initState() {
    profilelogic = new Profilelogic(context);
    setid();
    getname();
    chatlogic = new Chatlogic(context);
    message = new TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    messages = Provider.of<Notifires>(context).firemessageroom2;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:download?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
          child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){navigateback();},))),
            Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("محادثة",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.045),))),
            Expanded(child: Container())
          ],),),
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.7,child: SingleChildScrollView(reverse: true,
          child: ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: messages.length
              ,itemBuilder: (context,i){
                if(messages[i]["sender"].toString() =="Provider"){
                  if(messages[i]["user_id"].toString() ==messages[i]["SenderID"].toString() ){
                    return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),true,messages[i]["SenderPhoto"], messages[i]["SenderName"]);
                  }
                  else{
                    return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),true,messages[i]["RecivePhoto"] ,messages[i]["ReciveName"] );
                  }
                }else{
                  if(messages[i]["provider_id"].toString() ==messages[i]["SenderID"].toString() ){
                    return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),false,messages[i]["SenderPhoto"], messages[i]["SenderName"]);
                  }
                  else{
                    return messagebuilder(messages[i]["message"].toString(), messages[i]["created_at"].toString(),false,messages[i]["RecivePhoto"] ,messages[i]["ReciveName"] );
                  }
                }
              }),
        ),),
        Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05) ,
          decoration: BoxDecoration( color: Color.fromRGBO(243, 244, 245, 1),border: Border.all(color: Color.fromRGBO(204, 204, 204, 1),width: 1.5),borderRadius: BorderRadius.circular(10)), child: Directionality(textDirection: TextDirection.rtl,child:
          Row(children: [Expanded(child:  InkWell(onTap: (){chatlogic.sendfirebasemessage2(providerid, user_id, message.text, username, providername) ;//chatlogic.sendmessage2(message.text, user_id);
          message.text ="";
          },child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),height: MediaQuery.of(context).size.height*0.05,decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),color: Colors.black),child: Directionality(textDirection: TextDirection.ltr,child: Icon(Icons.send,color: Colors.white,)),)))
            ,Expanded(flex: 8 ,child: TextFormField(onChanged: (val){
              if (val.contains("0") ||val.contains("2")||
                  val.contains("1")||val.contains("3")|val.contains("4")||
                  val.contains("5")||val.contains("6")||val.contains("7")||val.contains("8")
                  ||val.contains("9")||val.contains("٠") ||val.contains("١")||
                  val.contains("٢")||val.contains("٣")|val.contains("٤")||
                  val.contains("٥")||val.contains("٦")||val.contains("٧")||val.contains("٨")
                  ||val.contains("٩")) {
                setState(() {
                  message.text ="";
                });
              }
            },controller: message,decoration: InputDecoration(hintText: "اكتب هنا",hintStyle: TextStyle(color: Colors.black38,fontSize: MediaQuery.of(context).size.width*0.035,),border: InputBorder.none),)),
          ]),),)

      ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
    messagebuilder(msg,time,isme,photo ,name){
     DateTime dt = DateTime.parse(time.trim().substring(0,10));
      if(dt.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))){
        time = time.toString().trim().substring(0,10);
      }
      else{
        time = time.toString().trim().substring(11,19);
      }
      if(isme){
        return Container(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerRight ,child: Container( constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5) ,alignment: Alignment.centerRight,decoration: BoxDecoration(color: Colors.black12.withOpacity(0.1) ,borderRadius: BorderRadius.circular(10)),child:
        Column(children: [
          Container(padding: EdgeInsets.all(5),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),))),
          Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerLeft ,child: Text(time,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025),),)
        ],),),);
      }
      else{
        return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02) ,child: Row(
          children: [Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,child: Image(fit: BoxFit.fill,image: AssetImage("images/logoaz.png"),))),Expanded(flex: 6,
            child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft ,child: Container( constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.5) ,alignment: Alignment.centerRight,decoration: BoxDecoration(color: Colors.black26.withOpacity(0.2) ,borderRadius: BorderRadius.circular(10)),child:
            Column(children: [
              Container( padding: EdgeInsets.all(5),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerRight ,child: Directionality(textDirection: TextDirection.rtl,child: Text(msg,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black38),))),
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01) ,alignment: Alignment.centerLeft ,child: Text(time,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.025,color: Colors.black38),),)
            ],),),),
          ) ],
        ));
      }
    }
}