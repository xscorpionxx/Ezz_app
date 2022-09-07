import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/login.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:ezzproject/screens/Loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
class  Codeconf extends StatefulWidget{
  var type ;
  var phone ;
  Codeconf({this.type,this.phone});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateCodeconf(type: type,phone : phone);
  }
}
class StateCodeconf extends State<Codeconf>{
  var type ;
  var phone;
  var timess = true;
  StateCodeconf({this.type,this.phone});
  TextEditingController code ;
  GlobalKey<FormState> key;
  Signuplogic signuplogic ;
  Loginlogic loginlogic;
  CurrentRemainingTime times  ;
  settimess(){
    if(timess) {
      setState(() {
        timess = false;
      });
    }
  }
  @override
  void initState() {
    signuplogic = new Signuplogic(context);
    loginlogic = new Loginlogic(context);
    code = new TextEditingController();
    key = new GlobalKey();
    super.initState();
  }
  int endtime =DateTime.now().millisecondsSinceEpoch+ 1000 * 60;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.13,child :
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,padding: EdgeInsets.only(top: 15),
                decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child: Row(children: [
                  Expanded(child: Container(alignment: Alignment.center,child: Text("تأكيد الحساب",style: TextStyle(color: Colors.white,fontSize: 15),))),
                ],),)    ),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 30,top: MediaQuery.of(context).size.height*0.2),child: Directionality(textDirection: TextDirection.rtl,child: Text("سيتم ارسال كود تأكيد الى جهازك",style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold),)),),
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 30),child: Directionality(textDirection: TextDirection.rtl,child: Text("الرجاء وضع الكود في الحقل أدناه لتأكيد الحساب",style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold),)),),
              Directionality(textDirection: TextDirection.rtl,
                child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:20,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                  validator: loginlogic.validate,controller: code,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "الكود المرسل"),
                )),
              ),
                  Container(
                    child:timess==true?Container(): Container(margin: EdgeInsets.only(right: 20,top: 20),child: Directionality(textDirection: TextDirection.rtl,child: InkWell(onTap: ()async{
                      var data = await signuplogic.resendcode(phone);
                      if(data["status"].toString() =="true"){
                        Alertdialogazz.alert(context,data["msg"]);
                        timess = true;
                        endtime = DateTime.now().millisecondsSinceEpoch+ 1000 * 60;
                        setState(() {});
                      }
                      else{
                        Alertdialogazz.alert(context,data["msg"]);
                      }
                    },
                      child: Text("يمكنك اعادة ارسال الكود بعد مرور الوقت بالضغط هنا",
                          style: TextStyle(fontSize: 12 ,fontWeight: FontWeight.bold,decoration: TextDecoration.underline)),
                    )),),
                  ),
                   Container(
                     child:timess ==false?Container(): Container(alignment: Alignment.center,margin: EdgeInsets.only(top:20 ),
                      child: CountdownTimer(
                          endTime:endtime ,onEnd: (){
                            if(mounted) {
                              setState(() {
                                timess = false;
                              });
                            }
                      },
                          widgetBuilder: (_, CurrentRemainingTime time) {
                        times = time;
                            if (times == null) {
                              return Directionality(textDirection: TextDirection.rtl,child:  Text('00:00',style: TextStyle( fontSize: 20,color: Colors.indigo)));
                            }
                            else {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  '   00:${times.sec}',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.indigo),),
                              );
                            }
                          }),
              ),
                   ),
              Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                child: InkWell(onTap: ()=> signuplogic.confirm(code.text, phone,key,type),
                  child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                    child:Text("تأكيد الحساب", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
                ),
              ), Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1,),child: Center(
                child: InkWell(child: Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05,top: MediaQuery.of(context).size.height*0.01),child: InkWell(onTap: ()async{
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.clear();
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (contexta) {
                        return Loginpage();
                      }));
                },child: Text(" سجل الدخول من حساب اخر",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 13),)),)),
              )))
            ],),
          ),
        ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}