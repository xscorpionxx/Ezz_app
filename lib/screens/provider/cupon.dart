import 'package:ezzproject/logic/mainlogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'addcoupons.dart';
import 'editcupon.dart';
editcupon(i,context,servicess,cupons,servicetype)async{
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return Editcoupons(services: servicess,data: cupons[i],servicetype :servicetype);
  }));
}
Widget coupon(context,servicetype,home2logic){
  List cupons = Provider.of<Notifires>(context).cupons;
  List servicess = Provider.of<Notifires>(context).services;
  var downloadcupons =  Provider.of<Notifires>(context).downloadcupons;
  var downloadreq =  Provider.of<Notifires>(context).downloadreq2;
  return Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,child: Directionality(
    textDirection: TextDirection.ltr,
    child: ListView(children: [
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
        decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
          Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text(" كوبونات خصم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
        ],),) ),
      Container(child
          :Column(
        children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [Expanded(child: InkWell(onTap: ()async{
          if(!downloadcupons) {
            if(!downloadreq){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Addcoupons(
                  services: servicess, servicetype: servicetype,);
              }));
            }
          }
        },child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(5)) ,child: Center(child: Text("اضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.white)),),))),Expanded(child: Column(children: [
          Container(child: Text("كوبونات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),),
          Container(child: Directionality(textDirection: TextDirection.rtl,child: Text(" عدد"+cupons.length.toString()+"من الكوبونات " ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),)),)
        ],))],),),
          Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,height: MediaQuery.of(context).size.height*0.65 ,child:
          downloadcupons?Container(child: Center(child: CircularProgressIndicator(),),) : cupons.length==0? Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),alignment: Alignment.topCenter ,child: Text("لا توجد كوبونات مضافة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15),),) :ListView.builder(itemCount: cupons.length,itemBuilder: (context,i){
            return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12.withOpacity(0.1))),height: MediaQuery.of(context).size.height*0.21,width: MediaQuery.of(context).size.width,
                child:Column(
                  children:[
                    Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.035,top: MediaQuery.of(context).size.height*0.02) ,child:  Container(alignment: Alignment.centerRight ,child: Column(children: [
                      Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("رقم الكوبون : ",style: TextStyle(fontWeight: FontWeight.bold),),Text( cupons[i]["CouponID"].toString(),style: TextStyle(color: Colors.black54),)]),))
                      ,Directionality(textDirection: TextDirection.rtl,child: Container(alignment: Alignment.centerRight,child: FittedBox(child: Row(children: [Text("كود الكوبون : ",style: TextStyle(fontWeight: FontWeight.bold),),Text(cupons[i]["CouponCode"].toString() ,style: TextStyle(color: Colors.black54))])),))
                      ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("قيمة الكوبون : ",style: TextStyle(fontWeight: FontWeight.bold),),Text(cupons[i]["CouponValue"].toString() ,style: TextStyle(color: Colors.black54))]),))
                    ],),)),
                    // ,Expanded(child: Container(height: MediaQuery.of(context).size.width*0.2 ,width: MediaQuery.of(context).size.width*0.1,child: Text("")))),),
                    Container(
                      child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                        Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deletecupon(i,context,home2logic,cupons),child: Icon(Icons.delete,color: Colors.red,))),
                        InkWell(onTap: (){ if(!downloadreq){editcupon(i,context,servicess,cupons,servicetype);}},child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
                      ],),),
                    )
                  ],) );
          }),)
        ],
      ))
    ],),
  ),);
}
deletecupon(i,context,home2logic,cupons){
  return showDialog(context: context, builder: (context) {
    return StatefulBuilder(builder: (Context, setState) {
      return AlertDialog(
          content: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.2,
            child: Column(children: [
              Container(child: Text("حذف الكوبون"),)
              , Container(child: Text("هل تريد حذف الكويون"),),
              Container(margin: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.05),
                child: Row(
                    children: [ Expanded(flex: 3,
                      child: InkWell(onTap: () {
                        Navigator.of(context).pop();
                      },
                        child: Container(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.07,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.black26,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text("رفض", style: TextStyle(
                              color: Colors.white, fontSize: MediaQuery
                              .of(context)
                              .textScaleFactor * 12)),),
                      ),
                    ), Expanded(child: Container()),
                      Expanded(flex: 3, child: InkWell(onTap: () {
                        Navigator.of(context).pop();
                        home2logic.deletecupon(cupons[i]["CouponID"]);
                      },
                        child: Container(height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.07,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text("موافق", style: TextStyle(
                              color: Colors.white, fontSize: MediaQuery
                              .of(context)
                              .textScaleFactor * 12)),),
                      )),
                    ]),
              )
            ],),
          )
      );
    },
    );
  });
}