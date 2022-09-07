import 'package:ezzproject/screens/users/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'orderdata2.dart';

class Success extends StatefulWidget{
  var order;
  Success({this.order});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateSuccess(order: order);
  }
}
class  StateSuccess extends State<Success>{
  var order ;
  StateSuccess({this.order});

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body:Column(children: [
      Container(child: Center(child: Icon(Icons.check,size: MediaQuery.of(context).size.height*0.1,color: Colors.white,)),margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.05 ,top: MediaQuery.of(context).size.height*0.2) ,width: MediaQuery.of(context).size.height*0.2,height:MediaQuery.of(context).size.height*0.2 ,decoration: BoxDecoration(
          color: Color.fromRGBO(69, 190, 0, 1), borderRadius: BorderRadius.circular(100)
      ),),
      Directionality(textDirection: TextDirection.rtl ,child: Container(child:Center(child: Text("اكتمل طلبك بنجاح",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.black),)),)),
      Directionality(textDirection: TextDirection.rtl ,child: Container(child:Center(child: Text("رقم الطلب  "+order["OrderCode"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.black),)),)),
      Container( padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),child:Center(child: InkWell( onTap: (){
         showorderdetail();
      } ,child:  Text("تفاصيل الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022,color: Colors.white)))),margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2,left: MediaQuery.of(context).size.width*0.1,right:MediaQuery.of(context).size.width*0.1 ),color: Color.fromRGBO(69, 190, 0, 1),),
      Container(margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height*0.05 ,top: MediaQuery.of(context).size.height*0.03) ,child: Center(child: InkWell(onTap: (){
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
          return Home();
        }));
      },child: Text("العودة للرئيسية",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02,color: Colors.black)))),)

    ],) ,);
  }
  showorderdetail(){
  return Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Orderdata2(data: order,);
  }));
  }
}