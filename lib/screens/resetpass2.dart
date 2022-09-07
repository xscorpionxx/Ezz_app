 import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/cahngepassword.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';
class  Resetpass2 extends StatefulWidget{
  var phone;
  Resetpass2({this.phone});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateResetpass2(phone: phone);
  }
}
class StateResetpass2 extends State<Resetpass2>{
  var phone;
  StateResetpass2({this.phone});
  TextEditingController password ;
  TextEditingController email ;
  TextEditingController code ;
  GlobalKey<FormState> key;
  GlobalKey<FormState> key1;
  Signuplogic signuplogic ;
  Changepasslogic changepasslogic;
  setpassword()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    changepasslogic.oldpassword =sharedPreferences.getString("password");
  }
  @override
  void initState() {
    signuplogic = new Signuplogic(context);
    password = new TextEditingController();
    changepasslogic = new Changepasslogic(context);
    setpassword();
    code = new TextEditingController();
    email = new TextEditingController();
    email.text = phone.toString();
     key = new GlobalKey();
    key1 = new GlobalKey();
    super.initState();
  }
  CurrentRemainingTime times  ;
  var timess = true;
  int endtime =DateTime.now().millisecondsSinceEpoch+ 1000* 60;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: SingleChildScrollView(physics: ClampingScrollPhysics(),
          child: Column(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.13,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("اعادة تعيين كلمة السر",style: TextStyle(color: Colors.white,fontSize: 15),))),
                Expanded(child: Container())
              ],),)    ),
            Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 30,top: 100),child: Directionality(textDirection: TextDirection.rtl,child: Text("تم ارسال الكود الى رقم الهاتف الذي أدخلته",style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold),)),),
            Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 30,top: 5),child: Directionality(textDirection: TextDirection.rtl,child: Text("يمكنك الان تغيير كلمة السر الخاصة بك",style: TextStyle(color: Colors.indigo,fontSize: 14,fontWeight: FontWeight.bold),)),),
            Directionality(textDirection: TextDirection.rtl,
              child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:10,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                validator: changepasslogic.validate,controller: code,keyboardType: TextInputType.number ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "الكود المرسل"),
              )),
            ),
            Directionality(textDirection: TextDirection.rtl,
              child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                validator:signuplogic.validatepassword ,controller: password,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "كلمة المرور الجديدة "),
              )),
            ),
            Directionality(textDirection: TextDirection.rtl,
              child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                keyboardType: TextInputType.phone,inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],validator: Alertdialogazz.validateMobile, enabled: false,controller: email,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم الهاتف"),
              )),
            ),
            Container(
              child:timess==true?Container(): Container(margin: EdgeInsets.only(right: 20,top: 20),child: Directionality(textDirection: TextDirection.rtl,child: InkWell(onTap: ()async{
                  var data = await signuplogic.sendforget(key1,phone,"0");
                  if(data){
                    Alertdialogazz.alert(context,"تم ارسال الكود للهاتف");
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
                child: CountdownTimer(endTime:endtime ,onEnd: (){
                  setState(() {
                    timess = false;
                  });
                }, widgetBuilder: (_, CurrentRemainingTime time) {
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
              child: InkWell(onTap: ()=>signuplogic.reset(code.text, email.text, password.text,key),
                child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                  child:Text("اعادة تعيين", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
              ),
            )
          ],),
        ),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).maybePop();
  }
}