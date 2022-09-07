import 'package:ezzproject/logic/addcoupon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Providertransport extends StatefulWidget{
  List transports =[];
  Providertransport({this.transports});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateprovidertransport(transports : transports);
  }
}
class Stateprovidertransport extends State<Providertransport>{
  List transports =[];
  Stateprovidertransport({this.transports});
  TextEditingController cuponame ;
  TextEditingController price ;
  GlobalKey<FormState> key;
  Addcuponlogic addcuponlogic;
  @override
  void initState() {
    addcuponlogic = new Addcuponlogic(context);
    cuponame = new TextEditingController();
    price = new TextEditingController();
    key = new GlobalKey<FormState>();
    super.initState();
  }
  List selectservice =[];
  navigateback(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child:ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("تحصيلات التاجر",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
                Expanded(child: Container())
              ],),) )
          ,Container(height: MediaQuery.of(context).size.height*0.7 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),child:transports.length==0?Center(child: Container(child: Text("لا يوجد تحصيلات بعد"),),): ListView.builder( itemCount: transports.length,itemBuilder: (context,i){
            return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12.withOpacity(0.1))),height: MediaQuery.of(context).size.height*0.13,width: MediaQuery.of(context).size.width,
            child:Column(
            children:[
            Container( margin: EdgeInsets.only( left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.1,top: MediaQuery.of(context).size.height*0.02),
              child: Center(
              child: Row(children: [
                Expanded(child: Container(child: ElevatedButton( child: FittedBox(child: Text("صورة التحويل")),onPressed: (){
                  showimage(transports[i]["photo"]);
                },),)),
              Expanded(flex: 3,child: Container(alignment: Alignment.centerRight ,child: Column(children: [
              Directionality(textDirection: TextDirection.rtl,child: Container(alignment: Alignment.centerRight,child:  Row(children: [Text(" القيمة : ",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),Text(transports[i]["collection"].toString(),style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),)])),)
              ,Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(right: 3),alignment: Alignment.centerRight,child:  Row(children: [Text("التاريخ : ",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),FittedBox(child: Text(transports[i]["date"].toString() ,style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)))]),))
              ,Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(right: 3),alignment: Alignment.centerRight,child:  Row(children: [Text("رقم التحويل : ",style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),),Text( transports[i]["note"].toString(),style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold))]),))
              ],),))
              ],),
            ),)
            ],));;
          }),)
        ],)
      ),
    ),);
  }
  showimage(photo){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        content:Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02),height: MediaQuery.of(context).size.height*0.9,child: SingleChildScrollView(
          child: Column(children: [
            Container(height: MediaQuery.of(context).size.height*0.7,
              child: Directionality(
                  textDirection: TextDirection.rtl ,child: FadeInImage(placeholder: AssetImage("images/logoaz.png") ,image: NetworkImage(photo),fit: BoxFit.fill,)),
            ),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
              child: InkWell(onTap: (){
                Navigator.of(context).pop("dialog");
              },child: Container( width: MediaQuery.of(context).size.width,padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02), decoration: BoxDecoration(color: Colors.green),child: Center(child: Text("نعم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.03),),),)),
            )
          ],),
        ),),
      );
    });

  }
}