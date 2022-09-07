import 'package:ezzproject/logic/partner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Partner extends StatefulWidget{
  var sharelink;
  Partner({this.sharelink});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateshareapp(sharelink : sharelink);
  }
}
class Stateshareapp extends State<Partner>{
  var sharelink;
  Stateshareapp({this.sharelink});
  TextEditingController password ;
  TextEditingController passwordnewre ;
  TextEditingController passwordnew ;
  var data= {"stock" : "2000ريال"};
  Partenerlogic partenerlogic;
  List datas = [];
  var download = true;
  getdata()async{
   datas = await partenerlogic.getpartners();
   download = false;
   setState(() {});
  }
  @override
  void initState() {
    password = new TextEditingController();
    passwordnewre = new TextEditingController();
    passwordnew = new TextEditingController();
    partenerlogic = new Partenerlogic(context);
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
            decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child:
            Container(child:
                Container(margin: EdgeInsets.only(top: 20),
                  child: Row(children: [
                    Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
                    Expanded(flex: 5,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.15),alignment: Alignment.center,child: Text("شركاء النجاح",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.height*0.02),))),
                   ],),
            )),
          ),
          Container(padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.03) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03,right: MediaQuery.of(context).size.width*0.05,left: MediaQuery.of(context).size.width*0.05) ,decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [Colors.black45,Colors.black]),borderRadius: BorderRadius.circular(10)) ,child: Row(children: [
            Expanded(child: InkWell( onTap: (){
              FlutterShare.share(title: "شارك التطبيق الان",
                  linkUrl: sharelink.toString());
            },child: Container(height: MediaQuery.of(context).size.height*0.05,child: SvgPicture.asset("images/share.svg",semanticsLabel: "dawdasx",)))),
            Expanded( flex: 5 ,child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1),child: Column(children: [
              Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.centerRight,child: Text("شارك التطبيق الان",style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),),),
              Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.04),alignment: Alignment.centerRight,child: Text("واحصل على عمولات مميزة",style: TextStyle(color: Colors.white),),)

            ],),)),
          ],),),
          Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: MediaQuery.of(context).size.height*0.03) ,alignment: Alignment.centerRight,child: Text("قائمة المسوقين بالعمولة",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035),),)
          ,Container(height: MediaQuery.of(context).size.height*0.7 ,child:download?Container(child: Center(child: CircularProgressIndicator(),),):datas.length==0 ?Container(child: Center(child: Text("لا يوجد أشخاص"),),): ListView.builder( itemCount: datas.length,itemBuilder: (context,i){
            return Container(decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.02) ,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01,left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: Row(
                children: [
                  Expanded(flex: 2,child: Container(child: Directionality(textDirection: TextDirection.rtl,child: Text("ريال"+datas[i]["rewards"].toString(),style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 15),)),)),
                  Expanded(flex: 4,child: Container(alignment: Alignment.center ,child: Text("الأرباح المحققة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.03),),)),
                  Expanded(flex: 8,child:  Container(alignment: Alignment.centerRight,child: Text( datas[i]["Name"],style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),),))
                  ,Expanded(flex: 2,child: Container( child: ClipRRect(borderRadius: BorderRadius.circular(10),child: Image(fit: BoxFit.fill,image: NetworkImage(datas[i]["Photo"].toString()),)),))
                ],));
          }),)
        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).maybePop();
  }
}