import 'package:ezzproject/screens/provider/more.dart';
import 'package:ezzproject/screens/provider/commision.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/logic/home2.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/screens/provider/providertransport.dart';
import 'package:ezzproject/screens/provider/reqsusets.dart';
import 'package:ezzproject/screens/provider/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../users/notification.dart';
import 'cupon.dart';
import 'notificationpro.dart';

class Home2 extends StatefulWidget{
  var servicetype ;
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(42, 171, 227, 1),
    ));
    // TODO: implement createState
    return Statehome2();
  }
}
class Statehome2 extends State<Home2> with TickerProviderStateMixin{
  Map<dynamic,dynamic> home2_data;
  var profiledata;
  TabController tabController2;
  TabController tabController2p;
  TabController tabController3p;
  TextEditingController cuponname ;
  TextEditingController cuponprice ;
  TextEditingController transportcollection;
  TextEditingController transportingnote;
  var transportingdate;
  var dateable = false;
  var download_service ;
  Home2logic home2logic;
  var active ;
  TabController tabController;
  var servicetype;
  var downloadhome ;
  var downloadcupons ;
  var downloadreq ;
  var section;
  var downloadmore ;
  List mazads =[];
  Homelogic homelogic;
  var servicetypespec;
  TextEditingController descmarsol;
  TextEditingController offermarsol;
  GlobalKey<FormState> keymarsol;
  gettype()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    servicetype = sharedPreferences.getString("servicetype");
    servicetypespec = sharedPreferences.getString("servicetypespec");
  }
  @override
  void initState() {
    transportcollection = new TextEditingController();
    transportingnote= new TextEditingController();
    descmarsol = new TextEditingController();
    offermarsol = new TextEditingController();
    keymarsol = new GlobalKey<FormState>();
    home2logic = new Home2logic(context);
    tabController2 = new TabController(vsync: this, length:4);
    tabController2p = new TabController(vsync: this, length:3);
    tabController3p = new TabController(vsync: this, length:3);
    tabController = new TabController(vsync: this, length:6);
    cuponname = new TextEditingController();
    cuponprice = new TextEditingController();
    super.initState();
    getdata2();
    gettype();
    tabController2.addListener(() {
      setState(() {
      });
    });
    tabController3p.addListener(() {
      setState(() {
      });
    });
    tabController2p.addListener(() {
      setState(() {
      });
    });
  }
  getdata2()async{
    homelogic  = new Homelogic(context);
    homelogic.initializesnotification();
    Future.delayed(const Duration(milliseconds: 500), () {
      Provider.of<Notifires>(context,listen: false).reset();
      Provider.of<Notifires>(context, listen: false).gethome_provider(context);
    });
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  //List data =[1];
  var newrequest = true;
  var able = false;
  List servicess =[];
  List cupons =[];
  List reqs = [];
  var downloadreqs;
  var downloadmazad;
  var histfrom;
  var histto;
  var rewards;
  var value;
  var plege;
  List values =["يومي"];
  List onworklist =[];
  List donelist =[];
  List canceldlist =[];
  @override
  Widget build(BuildContext context) {
    value = Provider.of<Notifires>(context).valuehome2;
    active = Provider.of<Notifires>(context).active2;
    servicess = Provider.of<Notifires>(context).services;
    cupons = Provider.of<Notifires>(context).cupons;
    home2_data = Provider.of<Notifires>(context).home_provider;
    profiledata = Provider.of<Notifires>(context).profiledata;
    downloadhome = Provider.of<Notifires>(context).downloadhome2;
    downloadreq = Provider.of<Notifires>(context).downloadreq2;
    downloadmazad = Provider.of<Notifires>(context).downloadmazad;
    downloadcupons = Provider.of<Notifires>(context).downloadcupons;
    downloadmore = Provider.of<Notifires>(context).dwonloadpro;
    histfrom = Provider.of<Notifires>(context).histfrom;
     histto = Provider.of<Notifires>(context).histto;
    rewards = Provider.of<Notifires>(context).rewards;
    reqs = Provider.of<Notifires>(context).reqs;
    downloadreqs = Provider.of<Notifires>(context).downloadreqs;
    onworklist =Provider.of<Notifires>(context).onworklist;
    donelist =Provider.of<Notifires>(context).donelist;
    canceldlist =Provider.of<Notifires>(context).canceldlist;
    plege =Provider.of<Notifires>(context).plege;
    mazads =Provider.of<Notifires>(context).mazads;
    section =Provider.of<Notifires>(context).sectionm;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:  SingleChildScrollView(physics: ClampingScrollPhysics(),
        child: Column(children: [
          Directionality(textDirection: TextDirection.rtl,
            child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.95 ,child: TabBarView(physics: NeverScrollableScrollPhysics(),controller: tabController,children:[
              Homescreen(),
              services(context,servicetypespec,home2logic,servicetype,),
             servicetype.toString()=="اماكن"? reqmkan(context,tabController2p,servicetype,home2logic) :servicetype.toString()=="مراسيل"?reqmarsol(context,tabController2p,servicetype,home2logic,keymarsol,offermarsol,descmarsol,setState)
                 :servicetypespec=="true"?reqcooker(context,tabController3p,home2logic) :req(context,tabController2,servicetype,home2logic,homelogic),
              servicetypespec=="true"?Container(child: Center(child: Text("لا يمكنك اضافة كوبون لهذا الحساب"),),) : coupon(context,servicetype,home2logic),
              more(context,homelogic),
              commision(context,home2logic, transportcollection,setState,transportingnote)
            ])),
          ),
          Container(decoration: BoxDecoration(color: Colors.white),child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.05,child:active=="more"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                   Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005),child: SvgPicture.asset("images/Vector.svg",fit: BoxFit.scaleDown,)),
                  FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "more", 4, context);
                Future.delayed(const Duration(milliseconds: 500), () {
                  Provider.of<Notifires>(context,listen: false).getprofile(context,false);
                });
              },
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005 ),child: SvgPicture.asset("images/Vector.svg",fit: BoxFit.scaleDown,)),
                  FittedBox(child: Text("المزيد",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))])),
              ),
            )))
            ,Container(
              child:servicetypespec=="true"?Container(): Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.05,child:active=="cop"?  Container(
                decoration: BoxDecoration() ,
                child: FittedBox(
                  child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/icona41.png"),fit: BoxFit.scaleDown,)),
                   FittedBox(child: Text("كوبونات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
                ),
              ) :Container(
                child: InkWell(onTap: (){
                  Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "cop", 3, context);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    if(downloadreq){
                      Provider.of<Notifires>(context,listen: false).getservices(context);
                    }
                    Provider.of<Notifires>(context,listen: false).getcupon(context);
                  });
                },
                  child:FittedBox(child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/copon.png"),fit: BoxFit.scaleDown,)),
                   FittedBox(child: Text("كوبونات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))])),
                ),
              ))),
            ),
            Expanded(child: Container(margin: EdgeInsets.only(left: 1,right: 1),height: MediaQuery.of(context).size.height*0.05,child:active=="com"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005),child:  Icon(Icons.monetization_on_outlined,color: Colors.blue,size: MediaQuery.of(context).textScaleFactor*23,)),
                  Text("العمولة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),)]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "com", 5, context);
              },
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.005 ),child: Icon(Icons.monetization_on_outlined,color: Colors.black54,size: MediaQuery.of(context).textScaleFactor*23)),
                  Text("العمولة",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),)])),
              ),
            ))),
            Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.05,child:active=="req"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image: AssetImage("images/icon31.png"),)),
                  FittedBox(child: Text("الطلبات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "req", 2, context);
                Future.delayed(const Duration(milliseconds: 200), () {
                  Provider.of<Notifires>(context,listen: false).getreqs(context);
                });
              },
                child:FittedBox(child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child:  Image(image: AssetImage("images/icona30.png"),)),
                 FittedBox(child: Text("الطلبات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))])),
              ),
            )))
            ,Container(
              child:servicetypespec=="true"?Container(): Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.05,child:active=="ser"?  Container(
                decoration: BoxDecoration() ,
                child: FittedBox(
                  child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/icona21.png"),fit: BoxFit.scaleDown,)),
                   FittedBox(child: Text("الخدمات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
                ),
              ) :Container(
                child: InkWell(onTap: (){
                  Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "ser", 1, context);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    Provider.of<Notifires>(context,listen: false).getservices(context);
                    Provider.of<Notifires>(context, listen: false)
                        .getmazads(context);
                  });
                },
                  child: FittedBox(
                    child: Column(children:[
                      Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),height: MediaQuery.of(context).size.height*0.03,child: Image(image :AssetImage("images/services.png"),fit: BoxFit.scaleDown,)),
                      FittedBox(child: Text("الخدمات",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
                  ),
                ),
              ))),
            ),
            Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),height: MediaQuery.of(context).size.height*0.05,child:active=="home"?  Container(
              decoration: BoxDecoration() ,
              child: FittedBox(
                child: Column(children:[
                  Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,width: MediaQuery.of(context).size.width*0.05 ,child: Image(image: AssetImage("images/icona12.png"),fit: BoxFit.fill,)),
                 FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
            ) :Container(
              child: InkWell(onTap: (){
                Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "home", 0, context);
              },child:FittedBox(
                child: Column(children:[
                    Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01) ,width: MediaQuery.of(context).size.width*0.05 ,child: Image(image: AssetImage("images/icona10.png"),fit: BoxFit.fill,)),
                 FittedBox(child: Text("الرئيسية",style: TextStyle(color:Colors.black,fontSize: MediaQuery.of(context).textScaleFactor*9),))]),
              ),
              ),
            ))),
          ],),)]),
      ),
    ),);
  }
  Widget Homescreen(){
    return  Directionality(textDirection: TextDirection.ltr,
      child: Container(child: Directionality(textDirection: TextDirection.ltr,
        child: downloadhome?Container(child: Center(child: CircularProgressIndicator(),),): ListView(children: [
             Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
                Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
                  decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                    Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الرئيسة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.04),))),
                  ],),) ,
            ),
            Container(child: !newrequest? Container():Directionality(textDirection: TextDirection.rtl,
              child: Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.025) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,bottom:MediaQuery.of(context).size.height*0.01 ) ,color: Color.fromRGBO(11, 168, 11, 1) ,child: Row(children: [
                Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,left:MediaQuery.of(context).size.width*0.02 ) ,child: InkWell( onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                   return Notificationspro();
                  }));
                  },child: Icon(Icons.notifications_none,color: Colors.white,size: MediaQuery.of(context).size.height*0.05,)),)
                ,Container(height: MediaQuery.of(context).size.height*0.05 ,child: VerticalDivider(color: Colors.white,thickness: 1,),),
                Container(child: Text(int.parse(home2_data["ProviderNewOrder"].toString())>0? "لديك طلبات جيدة تابع طلباتك":"رؤية الطلبات",style: TextStyle( color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),),),
                Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01 ),child: InkWell(onTap: (){
                  Provider.of<Notifires>(context,listen: false).getinde2x(tabController, "req", 2, context);
                  Future.delayed(const Duration(milliseconds: 200), () {
                    Provider.of<Notifires>(context,listen: false).getreqs(context);
                  });
                },child: Text("هنا",style: TextStyle(decoration: TextDecoration.underline ,color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),)),)
              ],)),
            ),),
            Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [
              Expanded(flex: 2,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),child: Row(children: [
                InkWell( onTap: (){
                  if(home2_data["ProviderStatus"].toString() =="1"){
                    home2logic.providerstatus("1", context);
                  }
                },child: Container(width: MediaQuery.of(context).size.width*0.22,height: MediaQuery.of(context).size.height*0.06,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:home2_data["ProviderStatus"].toString() =="1"? Color.fromRGBO(241, 241, 241, 1):Colors.red ),child:Center(child: Text("غير متاح",style: TextStyle(color:home2_data["ProviderStatus"].toString() =="1"? Colors.black38:Colors.white,fontSize: 17,fontWeight: FontWeight.bold),)),)),
                InkWell(onTap: (){
                  if(home2_data["ProviderStatus"].toString() =="0"){
                    home2logic.providerstatus("0", context);
                  }
                },child: Container(width: MediaQuery.of(context).size.width*0.22,height: MediaQuery.of(context).size.height*0.06,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,color:home2_data["ProviderStatus"].toString() =="1"? Color.fromRGBO(11, 168, 11, 1):Colors.black26.withOpacity(0.1) ),child: Center(child: Text("متاح",style: TextStyle(color:home2_data["ProviderStatus"].toString() =="1"? Colors.white:Colors.black38,fontSize: 17,fontWeight: FontWeight.bold),)),))
              ],),)),
              Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07),alignment: Alignment.centerRight ,child: Text("الحالة",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),))
            ],),),
             Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20,top: MediaQuery.of(context).size.height*0.02) ,child: Directionality(textDirection: TextDirection.rtl,child: Text( plege.toString()+ "ونسبة العمولة الخاصة بي هي "+home2_data["commission"].toString() +"%",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.indigo),)),)
            ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20,top: MediaQuery.of(context).size.height*0.02) ,child: Text("احصائيات",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),)
            , Container(child: Row(children: [Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color.fromRGBO(246, 212, 116, 0.44)),child:
             Center(child: FittedBox(
                child: Column(children: [
                  Container(child: Text(home2_data["ProviderInOrder"].toString() ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                  Container(child: Text("طلب قيد التنفيذ",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                ],),
              )),)),
              Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color.fromRGBO(241, 248, 255, 1)),child: Center(
                child: FittedBox(
                  child: Column(children: [
                    Container(child: Text(home2_data["ProviderNewOrder"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                    Container(child: Text("طلب جديد",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                  ],),
                ),
              ),))],),),
            Container(child: Row(children: [Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color.fromRGBO(252, 209, 213, 0.36)),child: Center(
              child: FittedBox(
                child: Column(children: [
                  Container(child: Text(home2_data["ProviderCancelOrder"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                  Container(child: Text("طلب ملغي",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                ],),
              ),
            ),)),
              Expanded(child: Container(height: MediaQuery.of(context).size.height*0.09 ,margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color.fromRGBO(11, 168, 11, 0.33)),child: Center(
                child: FittedBox(
                  child: Column(children: [
                    Container(child: Text(home2_data["ProviderCompleteOrder"].toString(),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),),
                    Container(child: Text("طلب تم تنفيذه",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017),),)
                  ],),
                ),
              ),))],),),
            Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 20,top: MediaQuery.of(context).size.height*0.01) ,child: Text("العائدات",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),),
            Container( alignment: Alignment.centerRight ,child: Row(children: [Expanded(child:Container(
              decoration: BoxDecoration(color: Color.fromRGBO(11, 168, 11, 1)),margin: EdgeInsets.only(left: 10),child: InkWell(onTap: (){
              home2logic.showhist("2");
            },child: ListTile(title:Directionality( textDirection: TextDirection.rtl,child: Container(child:FittedBox(child: AutoSizeText(histto ==null? "تاريخ النهاية":histto.toString(),maxLines: 1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10),)))),trailing:  Icon(Icons.calendar_today,size: 15,color: Colors.white,),)),
            )) ,Expanded(child:Container(margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(color: Color.fromRGBO(11, 168, 11, 1)),padding: EdgeInsets.all(0),child: InkWell(onTap: (){
    home2logic.showhist("1");
    } ,child: ListTile(title:Directionality( textDirection: TextDirection.rtl,child: FittedBox(child: AutoSizeText(histfrom ==null? "تاريخ البداية":histfrom.toString(),maxLines: 1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10)))),trailing:  Icon(Icons.calendar_today,size: 15,color: Colors.white,))),
            )),
              Expanded(child:Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.08,left: MediaQuery.of(context).size.width*0.08 ,top: MediaQuery.of(context).size.height*0.01),alignment: Alignment.centerRight,child: AutoSizeText("حدد تاريخ ",maxLines: 1,style: TextStyle(color: Colors.black38 ,fontSize: MediaQuery.of(context).size.height*0.02),)) )]),),
            Container(child:histto !=null&&histfrom!=null? InkWell( onTap: (){
              Provider.of<Notifires>(context,listen: false).getrewards(context,histto,histfrom);
            },child: Container(decoration: BoxDecoration(color: Color.fromRGBO(11, 168, 11, 1)),margin: EdgeInsets.only(top: 10,right: MediaQuery.of(context).size.width*0.2,left:MediaQuery.of(context).size.width*0.2 ),padding: EdgeInsets.only(top: 5,bottom: 5),child: Center(child: AutoSizeText("الحصول على العائدات خلال الفترة",maxLines: 1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10))),)):Container()),
          Container(child:rewards!=null? Directionality(textDirection: TextDirection.rtl,child: Container(margin: EdgeInsets.only(top: 10,right: MediaQuery.of(context).size.width*0.2,left:MediaQuery.of(context).size.width*0.2 ),padding: EdgeInsets.only(top: 5,bottom: 5),child: Center(child: AutoSizeText("القيمة هي : "+rewards.toString(),maxLines: 1,style: TextStyle(color: Color.fromRGBO(11, 168, 11, 1),fontWeight: FontWeight.bold,fontSize: 10))),)) : Container())
            ,Container(decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(7)),margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.015,right: MediaQuery.of(context).size.width*0.07,left: MediaQuery.of(context).size.width*0.07,bottom: 10),padding: EdgeInsets.only(bottom: 20) ,child:Column(
              children:[ Container(child: Row(children: [
                Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.rtl,child: FittedBox(child: Text(home2_data["ProviderTotalSales"].toString()+" ريال",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),)))) )
                ,Expanded(flex: 3 ,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),alignment: Alignment.centerRight,child: Text("اجمالي المبيعات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),)))
                ,Expanded(child: Container(child: Image(image: AssetImage("images/cash.png"))))
              ],)),
                Container(child: Row(children: [
                  Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.rtl,child: FittedBox(child: Text(home2_data["ProviderCommission"].toString()+" ريال",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*12),)))) )
                  ,Expanded(flex: 3 ,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),alignment: Alignment.centerRight,child: Text("اجمالي العمولة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(child: Container())
                ],)),Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),child: Row(children: [
                  Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerLeft,child: Directionality(textDirection: TextDirection.ltr,child: FittedBox(child:InkWell(onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return Providertransport(transports: home2_data["ProviderTransport"],);
                    }));
                  },child: Icon(Icons.arrow_back,color: Colors.white,))))) )
                  ,Expanded(flex: 3 ,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),alignment: Alignment.centerRight,child: Text("التحصيلات",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                  Expanded(child: Container())
                ],)) ,Container(child: Divider(color: Colors.white,),) ,Container( height: MediaQuery.of(context).size.height*0.06,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.07,left: MediaQuery.of(context).size.width*0.07),child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText(home2_data["ProviderCancelHint"],maxLines: 2,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),) ))],))
          ]
          ),
      ),
      ),
    );
  }
}