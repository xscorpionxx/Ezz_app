
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
class Cookersdetail extends StatefulWidget{
  var providerid;
  var subcatid;
  var catid;
  Cookersdetail({this.providerid,this.subcatid,this.catid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statedetailpage(providerid: providerid,subcatid: subcatid,catid: catid );
  }
}
class Statedetailpage extends State<Cookersdetail>{
  var detaildata;
  var providerid;
  var subcatid;
  var catid;
  Detailpagelogic detailpagelogic;
  Statedetailpage({this.providerid,this.subcatid,this.catid});
  TextEditingController address;
  TextEditingController detail;
  GlobalKey<FormState> key;
  @override
  void initState() {
    key = new GlobalKey();
    address = new TextEditingController();
    detail = new TextEditingController();
    detailpagelogic = new Detailpagelogic(context);
    super.initState();
    getdata();
  }
  getdata()async{
    if (subcatid != null || catid != null) {
      await Provider.of<Notifires>(context, listen: false).getdatashowpage(
          catid !=null ? catid : subcatid,
          catid !=null ? null : subcatid , context);
    }
      await Provider.of<Notifires>(context, listen: false).getdetailpage(
          providerid);
    //  Provider.of<Notifires>(context, listen: false).getdatadetailpage(
   //       detaildata["Products"]);
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  var hist ;
  var realhist;
  var time ;
  var realtime;
  var value_type="عائلية";
  List value_types =["عائلية","زيارة"];
  var download ;
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  @override
  Widget build(BuildContext context) {
    detaildata =Provider.of<Notifires>(context).provider;
    download= Provider.of<Notifires>(context).downloaddetailpage;
    var iconofshop =Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:Form(key: key,
        child:download?Container(child: Center(child: CircularProgressIndicator(),),) :ListView(shrinkWrap: true ,children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
              Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
                decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(60),bottomLeft: Radius.circular(60))),child: Row(children: [
                  Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                  Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1) ,alignment: Alignment.center,child: Text(detaildata["Name"].toString(),style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                  Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container() : InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                  Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container() : InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                      :Container(margin: EdgeInsets.only(right: 15),child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                ],),) ),
          Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3,child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image:NetworkImage(detaildata["Photo"]) ,),),
            Positioned(left: MediaQuery.of(context).size.width*0.8,top: MediaQuery.of(context).size.height*0.05,
              child: Container(child:detaildata["BestSeller"].toString()=="1"?
              InkWell(onTap: ()=>null,
                child: Container(alignment: Alignment.centerRight ,width: 72,padding: EdgeInsets.all(3),
                  height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromRGBO(254, 254, 115, 1)),child:
                  FittedBox(child: Row(children:[ Text("بائع مميز",style: TextStyle(color: Color.fromRGBO(8, 67, 143, 1),fontSize: 16),),Container(width: 20,height: 20,child: Image( image:AssetImage("images/thumbs-up.png"),fit: BoxFit.fill)),])),),
              ):Container()),
            )]))
          ,Directionality(textDirection: TextDirection.rtl,
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
            Expanded(child:  Container(child: Text("مواعيد العمل",style: TextStyle(fontSize:12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1 ,right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.01),))
          ],),),
          Container( margin: EdgeInsets.only(top: 10,right: 7),child: Row(children: [
            Expanded(flex: 5,child:Provider.of<Notifires>(context).guestmode?Container() : Container(child: InkWell(onTap: ()=>navigatetoallreview(detaildata["Rating"],detaildata["UserID"]),child: AutoSizeText("مشاهدة تقييم البائع",maxLines: 1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromRGBO(246, 7, 7, 1)),)),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.16),))
            ,Expanded(child: Container( child: Text(detaildata["Rating"].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,) ),
            Expanded(child: Container( child: Icon(Icons.star,color: Colors.yellow.withGreen(1000),size: 20,),alignment: Alignment.centerRight,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),))
            ,Expanded(flex: 3,child:  Container( child: Text("التقييم",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.13),))
          ],),),
          Provider.of<Notifires>(context).guestmode?Container() :Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,top: MediaQuery.of(context).size.height*0.01),child: Text("بيانات الطلب",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black,fontWeight: FontWeight.bold),),)
                  ,Provider.of<Notifires>(context).guestmode?Container() :Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 15,top: MediaQuery.of(context).size.height*0.01),child: Text("نوع المناسبة",style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),),)
                  ,Provider.of<Notifires>(context).guestmode?Container() :Container(color: Colors.black12.withOpacity(0.05),width: MediaQuery.of(context).size.width,padding: EdgeInsets.only(left: 10,right: 10),margin: EdgeInsets.only( top: 7,right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),
                    child:  Directionality(textDirection: TextDirection.rtl,
                      child: DropdownButtonHideUnderline(
                            child: DropdownButton(style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),
                              hint: Text("حدد",style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),)
                              ,value: value_type
                              ,items: value_types.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child: Text('$e')),value: e,)).toList(),
                              onChanged: (_) {
                                value_type =_;
                                setState(() {});
                              },
                            )),
                    ),
                  ),
          Provider.of<Notifires>(context).guestmode?Container() : Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),child: Row(children: [
                    Expanded(child: Container(child: Column(children: [Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("الساعة",style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),),)
                      ,Directionality(textDirection: TextDirection.rtl,
                        child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12.withOpacity(0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
                        ListTile(title:InkWell( onTap: (){
                          showtime();
                        },child: AutoSizeText(realtime==null?" ":realtime.toString(),maxLines: 1, style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)))),trailing:  Icon(Icons.timer,color: Colors.green),)),),
                      ],),)),
                    Expanded(child: Container(child: Column(children: [Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child: Text("التاريخ",style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),),)
                      ,Directionality(textDirection: TextDirection.rtl,
                        child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12.withOpacity(0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child:
    ListTile(title: InkWell( onTap: (){
      showhist();
    },child: AutoSizeText(realhist==null?" ":realhist.toString(),maxLines: 1, style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)))),trailing:  Icon(Icons.calendar_today,color: Colors.green,),)),),
                      ],),))
                  ],),),
          Provider.of<Notifires>(context).guestmode?Container() : Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.05),child: Text("العنوان",style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),),)
                  ,Provider.of<Notifires>(context).guestmode?Container() :Directionality(textDirection: TextDirection.rtl,
                    child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),color: Colors.black12.withOpacity(0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField(validator:detailpagelogic.validate,controller: address ,style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                  ),
          Provider.of<Notifires>(context).guestmode?Container() : Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.05),child: Text("التفاصيل",style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),),)
                  ,Provider.of<Notifires>(context).guestmode?Container() :Directionality(textDirection: TextDirection.rtl,
                    child: Container(color: Colors.black12.withOpacity(0.05),margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),child: TextFormField( validator:detailpagelogic.validate,controller: detail ,minLines: 2,maxLines: 3,style: TextStyle(fontSize: 15,color: Color.fromRGBO(100, 108, 112, 1)),decoration: InputDecoration(hintText: "",border: InputBorder.none),),),
                  ),Provider.of<Notifires>(context).guestmode?Container() :Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),child: InkWell(onTap: (){
                    detailpagelogic.makeeventorder(key, detaildata["ID"], value_type.toString(), realhist, realtime, address.text, detail.text);
                  },
                    child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                      child:Text("ارسال", style: TextStyle(color: Colors.white,fontSize:15,fontWeight: FontWeight.bold)) ,),
                  ))
           ],),
              ),
      ));
  }
  navigatetoallreview(rat,id){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Allriviews(id:id,name: detaildata["Name"],photo: detaildata["Photo"],);
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  showtime(){
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                          child:CupertinoTimerPicker( onTimerDurationChanged: (val){
                            if(val.toString().substring(1,2)==":"){
                              time = val.toString().substring(0,4);
                            }else{
                              time = val.toString().substring(0,5);
                            }
                          },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
              setState(() {
                realtime = time;
              });
              Navigator.of(context).pop("dialog");
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
  showhist(){
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return StatefulBuilder(
          builder:(contexta,setStatea){
            return AlertDialog(
              content:Container(
                child:SingleChildScrollView(child:
                Column(
                  children:[ Container(height: MediaQuery.of(context).size.height*0.4,width:MediaQuery.of(context).size.width,
                      child:Center(
                        child: CalendarDatePicker(initialDate:DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 10000)),onDateChanged: (val){
                            hist= val.toString().substring(0,10);
                        },) ))],
                )),
              ),actions: [Container(child: ElevatedButton(child: Text("تم"),onPressed: (){
                setState(() {
                  realhist = hist;
                });
              Navigator.of(context).pop("dialog");
            },),),Container(child: ElevatedButton(child: Text("الغاء"),onPressed: (){
              Navigator.of(context).pop("dialog");
            },),)],
            );
          });
    },
    );
  }
}