import 'package:auto_size_text/auto_size_text.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addreviewplace.dart';

class Allriviewsplaces extends StatefulWidget{
  var idplace;
  var idprovider;
  var name;
  var photo;
  List reviews =[];
  Allriviewsplaces({this.reviews,this.idprovider,this.idplace,this.name,this.photo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservicesplaces(idplace: idplace,idprovider: idprovider,name: name,photo:photo);
  }
}
class Stateaddservicesplaces  extends State<Allriviewsplaces > {
  TextEditingController message;
  var levelofstar;
  getreviews(){
    Provider.of<Notifires>(context,listen: false).getplace4();
  }
  @override
  void initState() {
    message = new TextEditingController();
    getreviews();
    super.initState();
  }
  var idplace;
  var idprovider;
  var rating;
  List reviews =[];
  var photo;
  var download;
  var name;
  Stateaddservicesplaces ({this.reviews,this.idprovider,this.idplace,this.rating,this.name,this.photo});
  @override
  Widget build(BuildContext context) {
    reviews  =Provider.of<Notifires>(context).reviewsp;
    download = Provider.of<Notifires>(context).downloadp4;
    rating = Provider.of<Notifires>(context).rating;
    levelofstar =int.parse(rating.toString().trim().substring(0,1)) ;
    // TODO: implement build
    return MaterialApp(debugShowCheckedModeBanner: false,theme: ThemeData(fontFamily: 'Tajawal',accentColor: Colors.yellow.withGreen(200)),
      home: Scaffold(body:Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
          child:ListView(children: [
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.05,margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.02),
              child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.black,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("التقييمات",style: TextStyle(color: Colors.black,fontSize: MediaQuery.of(context).size.width*0.045),))),
                Expanded(child: Container())
              ],),),
            Container(height: MediaQuery.of(context).size.height*0.1,width: MediaQuery.of(context).size.width*0.5,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.4),child: Row(children: [
              Container(alignment: Alignment.centerRight,height: MediaQuery.of(context).size.height*0.08,width:  MediaQuery.of(context).size.width*0.3,child:Column(children: [
                Directionality(textDirection: TextDirection.rtl,
                  child: Container(width: MediaQuery.of(context).size.width*0.4,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),height: MediaQuery.of(context).size.height*0.05,alignment: Alignment.centerRight ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                    if(levelofstar >i ){
                      return  Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Color.fromRGBO(244, 194, 27, 1),size: MediaQuery.of(context).size.width*0.05,));
                    }
                    else{
                      return  Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
                    }
                  }),
                  )),
                )
                ,Container(alignment: Alignment.centerRight ,child: Text("("+reviews.length.toString()+")"+"تقييم ",style:TextStyle(fontSize: MediaQuery.of(context).size.width*0.025,color: Colors.black38),))])),
              Container(child: Text(rating.toString(),style:TextStyle(fontSize: MediaQuery.of(context).size.width*0.08),),)
            ],),),
            Container(child: Divider(color: Colors.black26,thickness: 1.5,),margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),)
            ,Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ),
              child: Row(children: [ Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
              }),
              ))) ,Expanded(flex: 4,child:Container(alignment: Alignment.centerRight,child:  Container( height: MediaQuery.of(context).size.height*0.005,child: LinearProgressIndicator(value: 0,backgroundColor: Colors.black26,))),),
                Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight ,child: Text("8",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black38),),))],),
            ),
            Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ),
              child: Row(children: [ Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
              }),
              ))) ,Expanded(flex: 4,child:Container(alignment: Alignment.centerRight,child:  Container( height: MediaQuery.of(context).size.height*0.005,child: LinearProgressIndicator(value: 0,backgroundColor: Colors.black26,))),),
                Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight ,child: Text("8",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black38),),))],),
            ),
            Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ),
              child: Row(children: [ Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
              }),
              ))) ,Expanded(flex: 4,child:Container(alignment: Alignment.centerRight,child:  Container( height: MediaQuery.of(context).size.height*0.005,child: LinearProgressIndicator(value: 0,backgroundColor: Colors.black26,))),),
                Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight ,child: Text("8",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black38),),))],),
            ),
            Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ),
              child: Row(children: [ Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
              }),
              ))) ,Expanded(flex: 4,child:Container(alignment: Alignment.centerRight,child:  Container( height: MediaQuery.of(context).size.height*0.005,child: LinearProgressIndicator(value: 0,backgroundColor: Colors.black26,))),),
                Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight ,child: Text("8",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black38),),))],),
            ),
            Container(height: MediaQuery.of(context).size.height*0.03,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right: MediaQuery.of(context).size.width*0.01 ),
              child: Row(children: [ Expanded(flex: 2,child:Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02) ,alignment: Alignment.center ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                return Container(alignment: Alignment.center ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
              }),
              ))) ,Expanded(flex: 4,child:Container(alignment: Alignment.centerRight,child:  Container( height: MediaQuery.of(context).size.height*0.005,child: LinearProgressIndicator(value: 0,backgroundColor: Colors.black26,))),),
                Expanded(child: Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,alignment: Alignment.centerRight ,child: Text("8",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04,color: Colors.black38),),))],),
            ),Container(child: Divider(color: Colors.black26,thickness: 1.5,),margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05,right:MediaQuery.of(context).size.width*0.05 ),),
            Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05) ,child: Text("تقييمات العملاء",style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.045,fontWeight: FontWeight.bold),),)
            ,Container(height: MediaQuery.of(context).size.height*0.45 ,child:download?Container(child: Center(child: CircularProgressIndicator(),),)
                :reviews.length==0? Container(child: Center(child: Text("لا يوجد تقييمات")),) :ListView.builder(physics: BouncingScrollPhysics(),itemCount: reviews.length,itemBuilder: (context,i){
              return Container(margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03,left: MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child:
              Column(children: [
                Container(child: Row(children: [
                  Expanded(child: Container(child: Row(children: [
                    Icon(Icons.star,size: 16,color: Color.fromRGBO(244, 194, 27, 1)),
                    Text(reviews[i]["StarNum"].toString(),style: TextStyle(fontSize: 12,color: Color.fromRGBO(244, 194, 27, 1)),)
                  ],),))
                  ,Expanded(flex: 4,child: Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03),child: Directionality(textDirection: TextDirection.rtl,child: AutoSizeText("نشر "+reviews[i]["Date"].toString(),maxLines: 1,style: TextStyle(fontSize: 12,color: Color.fromRGBO(102, 102, 102, 1)),)),))
                  ,Expanded(child: Container(child:  Directionality( textDirection: TextDirection.rtl,child: AutoSizeText(reviews[i]["UserName"],maxLines: 1,style: TextStyle(fontSize: 12,color: Color.fromRGBO(79, 198, 233, 1)),)),))
                ],),),
                Directionality(textDirection: TextDirection.rtl,child: Container( margin: EdgeInsets.only(right: 10),alignment: Alignment.centerRight,child: AutoSizeText(reviews[i]["Description"],maxLines: 2,style: TextStyle(color: Color.fromRGBO(170, 170, 170, 1),fontSize:13),) ,))
              ],),);
            }),),
            Container(margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.width*0.08,left:MediaQuery.of(context).size.width*0.1,right: MediaQuery.of(context).size.width*0.1),
              child: InkWell(onTap: ()=>navigatetoaddreview(),child: Container(height: MediaQuery.of(context).size.height*0.05,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1)),
                child:Text("اضافة تقييمك", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,)),
            )


          ]))),
    );
  }
  navigateback(){
    Navigator.of(context).pop();
  }
  navigatetoaddreview(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return Addreviewplaces(idprovider: idprovider,idplace: idplace ,name: name,photo:photo);
    }));
  }
}