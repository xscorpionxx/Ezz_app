import 'package:ezzproject/logic/addreview.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Revieworder extends StatefulWidget{
  var id ;
  var review;
  Revieworder({this.id,this.review});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateRevieworder(id: id,review:review);
  }
}
class StateRevieworder extends State<Revieworder>{
  Addreviewlogic addreviewlogic;
  var levelofstar =0 ;
  var id;
  var review;
  StateRevieworder({this.id,this.review});
  var levelofstar1 =0;
  var levelofstar2 =0;
  var levelofstar3 =0;
  TextEditingController comment;
  GlobalKey<FormState> key;
  addstar(type,i){
    if(type==0) {
      levelofstar = i + 1;
      setState(() {});
    }
    if(type==1) {
      levelofstar1 = i + 1;
      setState(() {});
    }
    if(type==2) {
      levelofstar2 = i + 1;
      setState(() {});
    }
    if(type==3) {
      levelofstar3 = i + 1;
      setState(() {});
    }
  }
  List qs =[];
  var dwonload =false;
  Homelogic homelogic;
  @override
  void initState() {
    homelogic = new Homelogic(context);
    comment = new TextEditingController();
    key = new GlobalKey();
    addreviewlogic = new Addreviewlogic(context);
    if(review!=null){
      levelofstar = int.parse(review[0]["star_num"].toString());
      comment.text = review[0]["desc"].toString();
    }
    super.initState();
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return Scaffold(body: dwonload?Container(child: Center(child: CircularProgressIndicator(),),width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,): SingleChildScrollView(physics: ClampingScrollPhysics(),
      child: Form(key: key,
        child: Column(children: [
          Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03, left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){navigateback();},))),
            Expanded(flex: 7,child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,alignment: Alignment.center,child: Text(review !=null?"رؤية التقييم" :"اضافة تقييم",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.04),))),
          ],),),
          Container(height: MediaQuery.of(context).size.height*0.1,margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1,top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,child: Row(children: [
            Expanded(flex: 2,child: Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.16,alignment: Alignment.center,child:
            Column(children: [
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight,child: Text("تقييم الطلب".toString(),style: TextStyle(fontSize: 17,color: Color.fromRGBO(0, 0, 0, 1),fontWeight: FontWeight.bold),),),
              Directionality(textDirection: TextDirection.rtl,
                child: Container(width: MediaQuery.of(context).size.width*0.4,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),height: MediaQuery.of(context).size.width*0.08 ,alignment: Alignment.centerRight ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                  if(levelofstar >i ){
                    return InkWell(onTap: (){if(review==null){ addstar(0,i);}},child: Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Colors.yellow.withGreen(200),size: MediaQuery.of(context).size.width*0.08,)));
                  }
                  else{
                    return InkWell(onTap: (){if(review==null){ addstar(0,i);}},child: Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.08,)));
                  }
                }),
                )),
              )
            ],),)),
            Expanded(child: Container( height: MediaQuery.of(context).size.height*0.1,child:
            Container(child:Image(image: AssetImage("images/logoaz.png"),fit: BoxFit.fill,))))],),),
          Container(padding:EdgeInsets.all(MediaQuery.of(context).size.width*0.01)  ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05)
            ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.black26)),height: MediaQuery.of(context).size.height*0.2,child: Directionality(textDirection: TextDirection.rtl,
                child: TextFormField( enabled:review!=null? false:true,textInputAction: TextInputAction.send,validator: validate,controller: comment,style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black),maxLines: 5,minLines: 4,decoration: InputDecoration(hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26) ,hintText: "أضف تعليق",border: InputBorder.none),)),)
          ,Container(
            child:review==null? Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.width*0.08,left:MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),
              child: InkWell(onTap: (){
                if(levelofstar !=0 && comment.text !=""){
                  homelogic.addrevieworder(id, levelofstar.toString(), comment.text.toString());
                }else{
                  Alertdialogazz.alert(context, "يجب اضافة التقييم بالشكل الصحيح");
                }
              },child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                child:Text("اضافة تقييمك", style: TextStyle(color: Colors.white,fontSize:15,fontWeight: FontWeight.bold)) ,)),
            ) : Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.width*0.08,left:MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),
              child: InkWell(onTap: (){
                Navigator.of(context).pop();
              },child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                child:Text("حسنا", style: TextStyle(color: Colors.white,fontSize:15,fontWeight: FontWeight.bold)) ,)),
            ),
          )
        ],),
      ),),);
  }
  String validate(String value){
    if (value.isEmpty) {
      return 'لا يمكن أن تبقي الحقل فارغ';
    }
    return null;
  }
}