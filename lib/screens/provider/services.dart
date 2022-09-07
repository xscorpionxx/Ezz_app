import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Editauction.dart';
import 'Editservicee3.dart';
import 'addauction.dart';
import 'addservice.dart';
import 'addservice2.dart';
import 'addservice3.dart';
import 'editservice.dart';
import 'editservice2.dart';
import '../users/mazadat.dart';
addservice(context){
  return showDialog(context: context, builder: (context) {
    return StatefulBuilder(builder: (Context, setState) {
      return AlertDialog(
          content: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.3,
            child: Column(children: [
              Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 1),child: InkWell( onTap: (){
                Navigator.of(context).pop("dialog");
              },child: Icon(Icons.close,size: 16,)),),
              Container(child: Center(child: Text("أضافة",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),)
              , Container(child: Text("ماذا تريد أن تفعل",style: TextStyle(fontSize: 16,),),),
              Container(margin: EdgeInsets.only(top: 15),
                child: InkWell(onTap: (){
                  Navigator.of(context).pop("dialog");
                  addservicefinal(context);
                },
                  child: Container(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("اضافة خدمة", style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15)),),
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10),
                child: InkWell(onTap: (){
                  Navigator.of(context).pop("dialog");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Addauction();
                  }));
                },
                  child: Container(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.07,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.black26,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text("اضافة مزاد", style: TextStyle(
                        color: Colors.white,fontWeight: FontWeight.bold, fontSize: 15)),),
                ),
              )
            ],),
          )
      );
    },
    );
  });
}
addservicefinal(context) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var servicetype = sharedPreferences.getString("servicetype");
  if(servicetype == "مراسيل") {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddServices2();
    }));
  }
  if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddServices();
    }));
  }
  if(servicetype == "اماكن"){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddServices3();
    }));
  }
  if(servicetype == "مزاد"){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Addauction();
    }));
  }
}
editservice(i,context,servicess) async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var servicetype = sharedPreferences.getString("servicetype");
  if(servicetype == "مراسيل") {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditServices2(service : servicess[i]);
    }));
  }
  if(servicetype != "اماكن" && servicetype!="مزاد" && servicetype!="مراسيل" ){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Editservice(service : servicess[i]);
    }));
  }
  if(servicetype == "اماكن"){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return EditServices3(service : servicess[i]);
    }));
  }
  if(servicetype == "مزاد"){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Editauction(service : servicess[i]);
    }));
  }
}
editservicem(i,context,mazads) async{
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return Editauction(service : mazads[i]);
  }));
}
deleteservice(int i,context,servicess,home2logic)async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return showDialog(context: context, builder: (context) {
    return StatefulBuilder(builder: (Context, setState) {
      return AlertDialog(
          content: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.2,
            child: Column(children: [
              Container(child: Text("حذف الخدمة"),)
              , Container(child: Text("هل تريد حذف الخدمة"),),
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
                        home2logic.deleteservice(servicess[i]["ID"]);
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
deleteservicem(int i,context,mazads,home2logic)async{
  return showDialog(context: context, builder: (context) {
    return StatefulBuilder(builder: (Context, setState) {
      return AlertDialog(
          content: Container(height: MediaQuery
              .of(context)
              .size
              .height * 0.2,
            child: Column(children: [
              Container(child: Text("حذف المزاد"),)
              , Container(child: Text("هل تريد حذف المزاد"),),
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
                        home2logic.deleteservicem(mazads[i]["ID"]);
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
Widget sectionser(servicetype,context,home2logic){
  List servicess = Provider.of<Notifires>(context).services;
  var section =Provider.of<Notifires>(context).sectionm;
 var downloadreq = Provider.of<Notifires>(context).downloadreq2;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,height: MediaQuery.of(context).size.height*0.65 ,child: downloadreq?Container(child: Center(child: CircularProgressIndicator(),),)
      :servicess.length==0? Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),alignment: Alignment.topCenter ,child: Text("لا توجد خدمات مضافة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15),),) :ListView.builder( physics: BouncingScrollPhysics(),itemCount: servicess.length,itemBuilder: (context,i){
    print(servicess);
    return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12.withOpacity(0.1))),width: MediaQuery.of(context).size.width,
        child:servicetype == "اماكن" ? Column(
          children:[
            Container(child: Row(children: [
              Expanded(flex: 5,child: Container(margin: EdgeInsets.only(right: 5),alignment: Alignment.centerRight ,child: Column(children: [
                Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),Text(servicess[i]["Name"] ==null ?"": servicess[i]["Name"].toString(),style: TextStyle(color: Colors.black54,fontSize: 14),)]),))
                ,Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width,alignment: Alignment.centerRight,child:   Row(children: [Expanded(child: AutoSizeText("تفاصيل المنتج : ",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),Expanded(flex: 2,child: Directionality(textDirection: TextDirection.rtl,child: Text(servicess[i]["Description"] ==null ?servicess[i]["Desc"]:servicess[i]["Description"],overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black54,fontSize: 14))))]),))
                ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),Text(servicess[i]["Price"] ==null ?servicess[i]["DayRental"] == null ?"":servicess[i]["DayRental"].toString() : servicess[i]["Price"].toString(),style: TextStyle(color: Colors.black54,fontSize: 14))]),))
              ],),))
              ,Expanded(flex: 2,child: Container(margin: EdgeInsets.only(top: 10),height: MediaQuery.of(context).size.height*0.13 ,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(fit: BoxFit.fill,image: NetworkImage(servicess[i]["Photos"][0]))),))
            ],),),
            Container(
              child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: 10,bottom: 10),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.03),child: Row(children: [
                Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservice( i,context,servicess,home2logic),child: Icon(Icons.delete,color: Colors.red,))),
                InkWell(onTap: ()=>editservice(i,context,servicess),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
              ],),),
            )
          ],):servicetype=="مراسيل"?Column(
          children:[
            Container(child: Row(children: [
              Expanded(flex: 5,child: Container(margin: EdgeInsets.only(right: 5),alignment: Alignment.centerRight ,child: Column(children: [
                Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),Text(servicess[i]["Name"] ==null ?"": servicess[i]["Name"].toString(),style: TextStyle(color: Colors.black54,fontSize: 14),)]),))
                ,Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width,alignment: Alignment.centerRight,child:   Row(children: [Expanded(child: AutoSizeText("تفاصيل المنتج : ",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),Expanded(flex: 2,child: Directionality(textDirection: TextDirection.rtl,child: Text(servicess[i]["Description"] ==null ?servicess[i]["Desc"]:servicess[i]["Description"],overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black54,fontSize: 14))))]),))
                ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),Text(servicess[i]["Price"] ==null ?servicess[i]["WeeklyRental"] == null ?"":servicess[i]["WeeklyRental"].toString() : servicess[i]["Price"].toString(),style: TextStyle(color: Colors.black54,fontSize: 14))]),))
              ],),))
              ,Expanded(flex: 2,child: Container(margin: EdgeInsets.only(top: 10),height: MediaQuery.of(context).size.height*0.13 ,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(fit: BoxFit.fill,image: NetworkImage(servicess[i]["Photo"]))),))
            ],),),
            Container(
              child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: 10,bottom: 10),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.02),child: Row(children: [
                Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservice(i,context,servicess,home2logic),child: Icon(Icons.delete,color: Colors.red,))),
                InkWell(onTap: ()=>editservice(i,context,servicess),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
                ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),
                  child: InkWell( onTap: (){
                    if(servicess[i]["Status"].toString()=="متاح"){
                      home2logic.productstatus("1", servicess[i]["ID"], context);
                    }
                  },child:Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:servicess[i]["Status"].toString()=="متاح" ? Colors.black12.withOpacity(0.15):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:servicess[i]["Status"].toString()=="متاح" ? Colors.black38:Colors.white),)),)),
                ),
                InkWell(onTap: (){
                  if(servicess[i]["Status"].toString()!="متاح"){
                    home2logic.productstatus("0", servicess[i]["ID"], context);
                  }
                },child: Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:servicess[i]["Status"].toString()=="متاح"? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.05) ),child: Center(child: Text("متاح",style: TextStyle(color:servicess[i]["Status"].toString()=="متاح" ? Colors.white:Colors.black38),)),)),
              ],),),
            )
          ],) : servicetype != "اماكن"&& servicetype != "مراسيل"&&servicetype != "مزاد" ?Column(
          children:[
            Container(child: Row(children: [
              Expanded(flex: 5,child: Container(margin: EdgeInsets.only(right: 5),alignment: Alignment.centerRight ,child: Column(children: [
                Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),Text(servicess[i]["Name"] ,style: TextStyle(color: Colors.black54,fontSize: 14),)]),))
                ,Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width,alignment: Alignment.centerRight,child:   Row(children: [Expanded(child: AutoSizeText("تفاصيل المنتج : ",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),Expanded(flex: 2,child: Directionality(textDirection: TextDirection.rtl,child: Text(servicess[i]["Description"],overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black54,fontSize: 14))))]),))
                ,Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("السعر : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),Text(servicess[i]["Price"].toString() + "ريال",style: TextStyle(color: Colors.black54,fontSize: 14))]),))
              ],),))
              ,Expanded(flex: 2,child: Container(margin: EdgeInsets.only(top: 10),height: MediaQuery.of(context).size.height*0.13 ,child: ClipRRect( borderRadius: BorderRadius.circular(10),child: Image(fit: BoxFit.fill,image: NetworkImage(servicess[i]["Photo"]))),))
            ],),),
            Container(
              child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: 10,bottom: 10),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.02),child: Row(children: [
                Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservice(i,context,servicess,home2logic),child: Icon(Icons.delete,color: Colors.red,))),
                InkWell(onTap: ()=>editservice(i,context,servicess),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
                ,Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),
                  child: InkWell( onTap: (){
                    if(servicess[i]["Status"].toString()=="متاح"){
                      home2logic.productstatus("1", servicess[i]["ID"], context);
                    }
                  },child:Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:servicess[i]["Status"].toString()=="متاح" ? Colors.black12.withOpacity(0.05):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:servicess[i]["Status"].toString()=="متاح" ? Colors.black38:Colors.white),)),)),
                ),
                InkWell(onTap: (){
                  if(servicess[i]["Status"].toString()!="متاح"){
                    home2logic.productstatus("0", servicess[i]["ID"], context);
                  }
                },child: Container(width: MediaQuery.of(context).size.width*0.15 ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:servicess[i]["Status"].toString()=="متاح"? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:servicess[i]["Status"].toString()=="متاح" ? Colors.white:Colors.black38),)),)),
              ],),),
            )
          ],)  :Container() );
  }),);
}
Widget sectionm(context,home2logic){
  List mazads =Provider.of<Notifires>(context).mazads;
  var downloadmazad = Provider.of<Notifires>(context).downloadmazad;
  return Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.04) ,height: MediaQuery.of(context).size.height*0.65 ,child: downloadmazad?Container(child: Center(child: CircularProgressIndicator(),),)
      :mazads.length==0? Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),alignment: Alignment.topCenter ,child: Text("لا توجد مزادات مضافة",style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*15),),) :ListView.builder( physics: BouncingScrollPhysics(),itemCount: mazads.length,itemBuilder: (context,i){
    return Container(decoration: BoxDecoration(border: Border.all(color: Colors.black12.withOpacity(0.1))),width: MediaQuery.of(context).size.width,
        child: Column(
          children:[
            Container(child: Row(children: [
              Expanded(flex: 2,child: TextButton(child: AutoSizeText("رؤية العروض",maxLines: 1,),onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return Mazad(mazad: mazads[i],able : false);
                }));
              },),),
              Expanded(flex: 5,child: Container(margin: EdgeInsets.only(right: 3),alignment: Alignment.centerRight ,child: Column(children: [
                Directionality(textDirection: TextDirection.rtl,child: Container(child: Row(children: [Text("اسم الخدمة : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),Text("مزاد علني",style: TextStyle(color: Colors.black54,fontSize: 15),)]),))
                ,Directionality(textDirection: TextDirection.rtl,child: Container(width: MediaQuery.of(context).size.width,alignment: Alignment.centerRight,child:   Row(children: [ Text("تفاصيل المنتج : ",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),), Directionality(textDirection: TextDirection.rtl,child: Text(mazads[i]["Description"],overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black54,fontSize: 15)))]),))
              ],),))
              ,Expanded(flex: 2,child: Container(margin: EdgeInsets.only(top: 5),height: MediaQuery.of(context).size.height*0.12 ,child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(fit: BoxFit.fill,image: NetworkImage(mazads[i]["Photo"]))),))
            ],),),
            Container(
              child:Container(height: MediaQuery.of(context).size.height*0.06 ,margin: EdgeInsets.only(top: 10,bottom: 10),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01) ,color: Colors.black12.withOpacity(0.05),child: Row(children: [
                Container(margin: EdgeInsets.only(right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child:InkWell(onTap: ()=>deleteservicem( i,context,mazads,home2logic),child: Icon(Icons.delete,color: Colors.red,))),
                InkWell(onTap: ()=>editservicem(i,context,mazads),child: Container(child:SvgPicture.asset("svg/Icon feather-edit.svg" ,fit: BoxFit.fill,)))
              ],),),
            )
          ],) );
  }),);
}
Widget services(context,servicetypespec,home2logic,servicetype,){
 var section =Provider.of<Notifires>(context).sectionm;
 List servicess = Provider.of<Notifires>(context).services;
  return Container(child: Directionality(textDirection: TextDirection.ltr,
    child:servicetypespec.toString()=="true"?Container(child: Center(child: Text("لا يمكنك اضافة خدمات لهذا الحساب"),),height: MediaQuery.of(context).size.height*0.8,) : ListView(children: [
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
      Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
        decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
          Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الخدمات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
        ],),) ),Container(child
          :Column(
        children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [Expanded(child: InkWell(onTap: ()=>addservice(context),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ) ,height: MediaQuery.of(context).size.height*0.07,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(5)) ,child: Center(child: Text("اضافة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025,color: Colors.white)),),))),Expanded(child: Container(
          margin: EdgeInsets.only(right: 25),
          child: Column(children: [
            Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text("الخدمات",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)),),
            Container(alignment: Alignment.centerRight,child: Directionality(textDirection: TextDirection.rtl,child: Text(" عدد"+servicess.length.toString()+"من الخدمات " ,style: TextStyle(fontSize: 13),)),)
          ],),
        ))],),),
          Container(
            child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01,top: MediaQuery.of(context).size.height*0.02)
              ,child: Row(children: [
                Expanded(child: section == "1"?Container(alignment: Alignment.center,child: Column(children:[
                  Text("خدمات",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.width*0.035),),
                  Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ) ,height: MediaQuery.of(context).size.height*0.005,color: Colors.blue,)]),): Container(
                    child: InkWell(onTap: (){
                      if(section !="1") {
                        Provider.of<Notifires>(context, listen: false)
                            .changesecm("1");
                      }},child: Container(alignment: Alignment.center ,child: Text("خدمات",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),))),
                )
                , Expanded(child: section == "2"?Container(alignment: Alignment.center,child: Column(children:[
                  Text("مزادات",style: TextStyle(color: Colors.blue,fontSize: MediaQuery.of(context).size.width*0.035),),
                  Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1 ) ,height: MediaQuery.of(context).size.height*0.005,color: Colors.blue,)]),): Container(
                    child: InkWell(onTap: (){
                      if(section !="2") {
                        Provider.of<Notifires>(context, listen: false)
                            .changesecm("2");
                      }},child: Container(alignment: Alignment.center ,child: Text("مزادات",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),))),
                )
              ],) ,),
          ),section =="1"?sectionser(servicetype,context,home2logic) :sectionm(context,home2logic)
        ],
      ))
    ],),
  ),);
}