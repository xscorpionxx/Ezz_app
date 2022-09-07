import 'package:ezzproject/logic/login.dart';
import 'package:ezzproject/logic/signup.dart';
import 'package:ezzproject/screens/resetpass2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Resetpass extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateResetpass();
  }
}
class StateResetpass extends State<Resetpass>{
  TextEditingController email ;
  TextEditingController passwordnewre ;
  TextEditingController passwordnew ;
  GlobalKey<FormState> key;
  Loginlogic loginlogic;
  Signuplogic signuplogic;
  var stage1 = true;
  @override
  void initState() {
    signuplogic = new Signuplogic(context);
    email = new TextEditingController();
    loginlogic = new Loginlogic(context);
    passwordnewre = new TextEditingController();
    passwordnew = new TextEditingController();
    key = new GlobalKey();
    super.initState();
  }
  sendforget(key,email)async{
    var state  = await signuplogic.sendforget(key, email,"1");
    if(state){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Resetpass2(phone : email);
      }));
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: SingleChildScrollView(
          child: Column(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.13,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,padding: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("نسيت كلمة السر",style: TextStyle(color: Colors.white,fontSize: 15),))),
                Expanded(child: Container())
              ],),)    ),
            Container(
              child:!stage1? Container():Directionality(textDirection: TextDirection.rtl,
                child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.1 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                   keyboardType: TextInputType.phone,validator: signuplogic.validateemail,inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],controller: email,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم الهاتف"),
                )),
              ),
            ),
            Container(
              child:!stage1?Container(): Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                child: InkWell(onTap: ()=>sendforget(key,email.text),
                  child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                    child:Text("ارسال الكود للهاتف", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
                ),
              ),
            ),],),
        ),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).maybePop();
  }
}