import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/location.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'allreviews.dart';
import 'notification.dart';
class Marasildetail2 extends StatefulWidget{
  var detaildata;
  var detailproduct;
  Marasildetail2({this.detaildata,this.detailproduct});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statemarasildetail(detaildata: detaildata,detailproduct: detailproduct);
  }
}
class Statemarasildetail extends State<Marasildetail2>{
  var detaildata;
  var detailproduct;
  Detailpagelogic detailpagelogic;
  Statemarasildetail({this.detaildata ,this.detailproduct});
  @override
  void initState() {
    detailpagelogic = new Detailpagelogic(context);
    super.initState();
    getdata();
  }
  List housesimg = [5,3,2];
  int totalprice ;
  getdata()async{
    Provider.of<Notifires>(context,listen: false).getdatadetailpage(detaildata["Products"]);
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  var value_type="";
  List value_types =[];
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  Widget build(BuildContext context) {
     totalprice = Provider.of<Notifires>(context).totalprice;
    var iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child:
        Container(
          child:detaildata == null?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
                decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1) ,alignment: Alignment.center,child: Text(detaildata["Name"].toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                  Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container() : InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                  Expanded(flex: 2,child: Provider.of<Notifires>(context).guestmode?Container() :InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                      :Container(margin: EdgeInsets.only(right: 15),child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                ],),)),
            Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image:NetworkImage(detaildata["Photo"]) ,),),
              Positioned(left: MediaQuery.of(context).size.width*0.8,top: MediaQuery.of(context).size.height*0.05,
                child: Container(child:detaildata["BestSeller"].toString()=="1"?
                InkWell(onTap: ()=>null,
                  child: Container(alignment: Alignment.centerRight ,width: 72,padding: EdgeInsets.all(3),
                    height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                    FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontSize: 16),),Container(width: 20,height: 20,child: Image( image:AssetImage("images/thumbs-up.png"),fit: BoxFit.fill)),])),),
                ):Container()),
              )]))
            , Directionality(textDirection: TextDirection.rtl,
                child: Container(width: MediaQuery.of(context).size.width,child: Row(children:[
                  Expanded(flex: 4,child: Container(child: Text(detaildata["Name"].toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),)),
                  Expanded(child:  Container())]),
                )),
            Directionality(textDirection: TextDirection.rtl, child: Container(child: Text(detaildata["Description"].toString(),style: TextStyle(fontSize: 12,color: Colors.black38),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),)),
            Container(child: Row(children: [
              Expanded(flex: 3,child: Container( child: Text(detaildata["Location"].toString(),style: TextStyle(fontSize: 12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
              Expanded(child: Container(child: Text("الموقع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
            ],),),
            Container(margin: EdgeInsets.only(right: 10) ,child: Row(children: [
              Expanded(flex: 2,child: Container(child: Text(detaildata["WorkTime"].toString(),maxLines: 1,style: TextStyle(fontSize: 12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: 20 ,right: 1,top: MediaQuery.of(context).size.height*0.01),)),
              Expanded(child:  Container(child: Text("مواعيد العمل",maxLines: 1,style: TextStyle(fontSize:12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),))
            ],),),
            Container( margin: EdgeInsets.only(top: 10,right: 7),child: Row(children: [
              Expanded(flex: 5,child:Provider.of<Notifires>(context).guestmode?Container() : Container(child: InkWell(onTap: ()=>navigatetoallreview(detaildata["Rating"],detaildata["UserID"]),child: AutoSizeText("مشاهدة تقييم البائع",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromRGBO(246, 7, 7, 1)),)),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.16),))
              ,Expanded(child: Container( child: Text(detaildata["Rating"].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,) ),
              Expanded(child: Container( child: Icon(Icons.star,color: Colors.yellow.withGreen(1000),size: 20,),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),))
              ,Expanded(flex: 3,child:  Container( child: Text("التقييم",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.13),))
            ],),),
            Container(child: Divider(color: Colors.black38,),margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.07,right:MediaQuery.of(context).size.width*0.07 ),),
          Container(
                child:Container(
                    child:Container(height: MediaQuery.of(context).size.height*0.35,
                      child: Column(children: [
                        Container(child: Text("بيانات السيارة",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 23,top: MediaQuery.of(context).size.height*0.01),)
                        ,Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right:23 ),child : Row(
                            children:[Expanded(flex: 2,
                              child: Container( child: FittedBox(child: Text(detailproduct["CarNumber"].toString(),style: TextStyle(fontSize: 12,color: Colors.black54),)),alignment: Alignment.centerRight,),
                              ),Expanded(flex: 2,child:     Container( alignment: Alignment.centerRight, child:FittedBox(child: Text("رقم السيارة",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),))))
                              ,Expanded(
                              child: Container( alignment: Alignment.centerRight,child: Text(detailproduct["CarBrand"].toString(),style: TextStyle(fontSize: 12,color: Colors.black54),))
                            ) ,Expanded(child:  Container( alignment: Alignment.centerRight,child: Text("الماركة",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),)))]),
                        ),
                        Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02,right: 23),child : Row(
                            children:[Expanded(flex: 3,
                              child:   Container(alignment: Alignment.centerRight ,child: Text(detailproduct["CarLicense"].toString(),style: TextStyle(fontSize: 12,color: Colors.black54),)),
                            ) ,Expanded(
                              child: Container(alignment: Alignment.centerRight ,child: Text("رخصة القيادة",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),))
                            )]),
                        ),
                        Container(child: Text("بيانات السائق",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 23,top: MediaQuery.of(context).size.height*0.03),)
                        ,Container(child: Row(children: [
                          Expanded(flex: 2,child: Container( child: Text(detailproduct["DriverName"],style: TextStyle(fontSize: 12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                          Expanded(child: Container(child: Text("الاسم",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                        ],),),
                        Container(child: Row(children: [
                          Expanded(flex: 2,child: Container( child: Text(detailproduct["DriverNationalNumber"].toString(),style: TextStyle(fontSize: 12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                          Expanded(child: Container(child: Text("الهوية الوطنية",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                        ],),),
                        Container(child: Row(children: [
                          Expanded(flex: 2,child: Container( child: Text(detailproduct["DriverLicense"].toString(),style: TextStyle(fontSize: 12,color: Colors.black54),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) ),
                          Expanded(child: Container(child: Text("رخصة القيادة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,top: MediaQuery.of(context).size.height*0.01),) )
                        ],),),
                        //Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
                         // child:Text("اتصل الان ", style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04)) ,)
                      ],),
                    )
                )),
          ]),
        )));
  }
  navigatetoallreview(rat,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Allriviews( id:id,name: detaildata["Name"],photo: detaildata["Photo"],);
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }

}