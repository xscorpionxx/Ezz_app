import 'package:ezzproject/logic/cahngepassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Changepass extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateChangepass();
  }
}
class StateChangepass extends State<Changepass>{
  TextEditingController password ;
  TextEditingController passwordnewre ;
  TextEditingController passwordnew ;
  GlobalKey<FormState> key;
  Changepasslogic changepasslogic;
  setpassword()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    changepasslogic.oldpassword =sharedPreferences.getString("password");
  }
  @override
  void initState() {
    password = new TextEditingController();
    changepasslogic = new Changepasslogic(context);
    setpassword();
    passwordnewre = new TextEditingController();
    passwordnew = new TextEditingController();
    key = new GlobalKey();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.13,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("تغيير كلمة السر",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
                Expanded(child: Container())
              ],),)    ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.1 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
               validator:changepasslogic.validatepasswordpast ,controller: password,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "كلمة المرور الحالية "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: changepasslogic.validatepassword,controller: passwordnew,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "كلمة المرور الجديدة "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: changepasslogic.validatepasswordre,controller: passwordnewre,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "تأكيد كلمة المرور "),
            )),
          ),
          Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap: ()=>changepasslogic.updatepass(passwordnew.text, passwordnewre.text, key),
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                child:Text("حفظ ", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )
          ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}