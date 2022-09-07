import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:ezzproject/logic/showpage.dart';
import 'package:ezzproject/screens/users/placedetail.dart';
import 'package:ezzproject/screens/users/shoppingcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'notification.dart';

class Places extends StatefulWidget{
  List places =[];
  var name;
  var catid ;
  var subcatid ;
  var idprovider;
  Places({this.places,this.name,this.idprovider,this.subcatid,this.catid});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateplaces(places :places,name:name,idprovider:idprovider,subcatid:subcatid,catid:catid);
  }
}
class Stateplaces extends State<Places> with SingleTickerProviderStateMixin{
  List places =[];
  var name;
  var idprovider;
  List placessearch =[];
  var subcatid;
  var catid;
  Stateplaces({this.places,this.name,this.idprovider,this.subcatid,this.catid});
  TextEditingController query ;
  Showpagelogic showpagelogic;
  var download ;
  @override
  void initState() {
    showpagelogic = new Showpagelogic(context);
    query = new TextEditingController();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
     placessearch = Provider.of<Notifires>(context).searchplaces;
     places = Provider.of<Notifires>(context).placep;
     download = Provider.of<Notifires>(context).downloadp2;
     var iconofshop = Provider.of<Notifires>(context).iconofshopstate;
    // TODO: implement build
    return Scaffold(body:  Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child:ListView(children: [
        Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.182,
          decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child:
          Container(child: Container(
                child:Column(children:[ Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
                  child: Row(children: [
                    Expanded(flex: 2,child: InkWell(onTap: ()=>navigateback(),child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.03),child: Icon(Icons.arrow_back_ios,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,)))),
                    Expanded(flex: 9,child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),alignment: Alignment.center,child: AutoSizeText(name.toString(),style: TextStyle(color: Colors.white,fontSize: 17),))),
                    Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container(): InkWell(onTap: ()=>navigatetonotification(),child: SvgPicture.asset("images/Icon-alarm.svg",semanticsLabel: "wadca",))),
                    Expanded(flex: 2,child:Provider.of<Notifires>(context).guestmode?Container():InkWell(onTap: ()=>navigatetoshopping(),child:iconofshop=="1"?Stack(children:[ Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", )),Positioned(top: 2,left: 20 ,child: Container(width: 10,height: 10,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.red,),)),])
                        :Container(child:SvgPicture.asset("images/Icon feather-shopping-cart.svg",semanticsLabel: "wasdca", ))) )
                  ],),
                ), Spacer(), Container(padding: EdgeInsets.only(right:  MediaQuery.of(context).size.width*0.01 ,left: MediaQuery.of(context).size.width*0.01) ,margin: EdgeInsets.only(left: 26,right:20,bottom: 23 ),decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5))
                  ,child: Directionality(textDirection: TextDirection.rtl,child: TextFormField(controller: query,onChanged: (val){
                      Provider.of<Notifires>(context, listen: false)
                          .searchplace(places, val);
                  }, style:  TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*12,color: Colors.black26),decoration: InputDecoration(hintText: "بحث",hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color: Colors.black26),border: InputBorder.none,suffixIcon: Icon(Icons.search,color: Colors.black26,)),)),)]),
          )),
        ),Directionality(textDirection: TextDirection.rtl,
          child: Container(margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03 ,left: MediaQuery.of(context).size.width*0.04,right: MediaQuery.of(context).size.width*0.04),height: MediaQuery.of(context).size.height*0.75,width: MediaQuery.of(context).size.width,child:download?Container(child: Center(child: CircularProgressIndicator(),),): places.length==0?Container(
            child: Center(child: Text("لا توجد أية عناصر",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)),
          ): query.text==""? Directionality(textDirection: TextDirection.rtl,
            child: GridView.builder(physics: BouncingScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: (160/230),
            ),itemCount: places.length,itemBuilder: (context,i){
              return Directionality(textDirection: TextDirection.ltr,
                child: InkWell(onTap: ()=>showdetail(i,false),
                  child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,boxShadow: [BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 1.0,
                    spreadRadius: 3.0,
                    offset: Offset(0.0, 0.0), // shadow direction: bottom right
                  )]),child:Column(children: [
                    Container(child:Stack(children:[
                      Container(width: MediaQuery.of(context).size.width,height: 155,child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight:Radius.circular(20) ) ,child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(places[i]["Photos"][0]),)),),
                      Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.02 ,child:Container(
                        child:Provider.of<Notifires>(context).guestmode?Container(): places[i]["UserFav"].toString()=="1"?
                      InkWell(onTap:()async{
                        await showpagelogic.addtofavpalces(places[i]["ID"],context,"1");
                      }, child: Container(width: 27,
                          height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                      ):InkWell(onTap: ()async{
                        await showpagelogic.addtofavpalces(places[i]["ID"],context,"0");
                      },
                        child: Container(width: 27,
                          height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black12.withOpacity(0.2)),child: Icon(Icons.favorite_border,color: Colors.white,size:20,),),
                      ),)) ])),
                    Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 10) ,child: Text(places[i]["Name"],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(5, 131, 127, 1),fontSize: 13),),)
                    ,Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child:Row(children:[
                      Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,
                        child: Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.0 ),
                          child:  ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 1,itemBuilder: (context,i){
                            return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.amberAccent.withGreen(500),size: 15));
                          }),
                        ),
                      )),Expanded(child: Container(height: MediaQuery.of(context).size.height*0.03,alignment: Alignment.center,child:  Text(places[i]["Rating"].toString().substring(0,places[i]["Rating"].toString().length),overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),),
                    ]) ),
                    Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: 12),child: Directionality(textDirection: TextDirection.rtl,child:   FittedBox(child: AutoSizeText( "ابتداء من "+places[i]["DayRental"].toString() + " ريال",maxLines: 1,style: TextStyle(fontSize: 10,color: Colors.black54,fontWeight: FontWeight.bold),)))),
                    Spacer()
                  ],)
                    ,),
                ),
              );
            }),
          ):Directionality(textDirection: TextDirection.rtl,
            child:placessearch.length==0? Container(child: Center(child: Text("لا يوجد نتيجة متوقعة مع البحث"),),):GridView.builder(physics: BouncingScrollPhysics(),gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: (160/230),
            ),itemCount: placessearch.length,itemBuilder: (context,i){
              return Directionality(textDirection: TextDirection.ltr,
                child: InkWell(onTap: ()=>showdetail(i,false),
                  child: Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white,boxShadow: [BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 1.0,
                    spreadRadius: 3.0,
                    offset: Offset(0.0, 0.0), // shadow direction: bottom right
                  )]),child:Column(children: [
                    Container(child:Stack(children:[ Container(width: MediaQuery.of(context).size.width,height: 155,child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight:Radius.circular(20) ) ,child: FadeInImage(fit: BoxFit.fill,placeholder: AssetImage("images/logoaz.png"),image: NetworkImage(placessearch[i]["Photos"][0]),)),),
                      Positioned(top: MediaQuery.of(context).size.height*0.02,left: MediaQuery.of(context).size.width*0.02 ,child:Container(child:
                      Provider.of<Notifires>(context).guestmode?Container():placessearch[i]["UserFav"].toString()=="1"?
                              InkWell(onTap: ()async{
                                await showpagelogic.addtofavpalces(placessearch[i]["ID"],context,"1");
                                query.text = "";
                                setState(() {});
                              },
                                child: Container(width: 27,
                                  height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.lightBlueAccent),child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),),
                              ):InkWell(onTap: ()async{
                               await showpagelogic.addtofavpalces(placessearch[i]["ID"],context,"0");
                               query.text = "";
                               setState(() {});
                                 } ,
                                child: Container(width: 27,
                                  height: 27,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black12.withOpacity(0.2)),child: Icon(Icons.favorite_border,color: Colors.white,size:20,),),
                              ),)) ])),
                    Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.025) ,child: Text(placessearch[i]["Name"],maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(5, 131, 127, 1),fontSize: 13),),)
                    ,Container( margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05),child:Row(children:[
                      Expanded(flex: 4,child: Directionality(textDirection: TextDirection.rtl,
                        child: Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.0 ),
                          child:  ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 1,itemBuilder: (context,i){
                            return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.amberAccent.withGreen(500),size: 15));
                          }),
                        )
                      )),Expanded(child: Container(height: MediaQuery.of(context).size.height*0.03,alignment: Alignment.center,child:  Text(placessearch[i]["Rating"].toString().substring(0,placessearch[i]["Rating"].toString().length),overflow: TextOverflow.ellipsis,maxLines: 1,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),)),),
                    ]) ),
                    Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),child: Directionality(textDirection: TextDirection.rtl,child:   FittedBox(child: AutoSizeText( "ابتداء من "+placessearch[i]["DayRental"].toString() + " ريال",maxLines: 1,style: TextStyle(fontSize: 10,color: Color.fromRGBO(86, 86, 86, 1),fontWeight: FontWeight.bold),)))),
                    Spacer() ],)
                    ,),
                ),
              );
            }),
          )),
        )
            ],),),
          );
  }
  navigatetonotification(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Notifications();
    }));
  }
  navigatetoshopping(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Shoppingcard();
    }));
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  getdata() async {
    if (subcatid != null || catid != null) {
     await Provider.of<Notifires>(context, listen: false).getplace1(
          catid !=null ? catid : subcatid,
          catid !=null ? null : subcatid , context);
     await Provider.of<Notifires>(context, listen: false).getplace2(idprovider);
    }
    else{
      Future.delayed(const Duration(milliseconds: 100), () {
        Provider.of<Notifires>(context, listen: false).getplace2(idprovider);
      });
  }
  }
  showdetail(i,search){
    if(search){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Placedetail(detaildata: placessearch[i],idprovider: idprovider,);
      }));
    }
    else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Placedetail(detaildata: places[i],idprovider: idprovider,);
      }));
    }
  }
}