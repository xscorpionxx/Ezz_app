import 'package:ezzproject/logic/detailpage.dart';
import 'package:ezzproject/logic/mainlogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Productdetail extends StatefulWidget{
  var id;
  var rating;
  Productdetail({this.id,this.rating});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateProductdetail(id:id,rating:rating);
  }
}
class StateProductdetail extends State<Productdetail>{
  var id;
  var levelofstar;
  var rating;
  StateProductdetail({this.id,this.rating});
  Detailpagelogic detailpagelogic ;
  var downlaod = true;
  var data;
  getdata()async{
     data = await detailpagelogic.getdetailpage(id);
     downlaod = false;
     setState(() {});
  }
  @override
  void initState() {
    levelofstar  =int.parse(rating.toString().trim().substring(0,1));
    detailpagelogic =new Detailpagelogic(context);
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(color: Colors.black12.withOpacity(0.05),width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(
        child: downlaod?Container(child: Center(child: CircularProgressIndicator(),),) :ListView(children: [
          Container(alignment: Alignment.centerLeft,margin: EdgeInsets.only(left: 20),child: IconButton(icon:Icon( Icons.close),onPressed: (){
            Navigator.of(context).pop();
          },),)
          ,Container(margin: EdgeInsets.only(bottom: 15) ,height: MediaQuery.of(context).size.height*0.3,child: FadeInImage(image: NetworkImage(data["Photo"]),placeholder: AssetImage("images/logoaz.png"),fit: BoxFit.fitHeight,),),
          Container(height: MediaQuery.of(context).size.height*0.6,decoration: BoxDecoration(boxShadow:  [ BoxShadow(
            color: Colors.black12.withOpacity(0.1),
            blurRadius: 0.0,
            spreadRadius: 2.0,
            offset: Offset(0.5, 0.5), // shadow direction: bottom right
          )],color: Colors.white,borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft:Radius.circular(40) )
          ),child: SingleChildScrollView(
            child: Column(children: [
              Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right:30,top: 15),child:
              Directionality( textDirection: TextDirection.rtl,child: Text(data["Name"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),),
             Directionality(textDirection: TextDirection.rtl, child: Container(
                child: Row(
                  children:[ Directionality(textDirection: TextDirection.rtl,
                    child: Container(width: MediaQuery.of(context).size.width*0.35,margin: EdgeInsets.only(right: 30),height: MediaQuery.of(context).size.height*0.05,alignment: Alignment.centerRight ,child:  Container(child: ListView.builder( padding: EdgeInsets.zero,scrollDirection: Axis.horizontal ,itemCount: 5,itemBuilder: (context,i){
                      if(levelofstar >i ){
                        return  Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Color.fromRGBO(244, 194, 27, 1),size: MediaQuery.of(context).size.width*0.05,));
                      }
                      else{
                        return  Container(alignment: Alignment.centerRight ,child: Icon(Icons.star,color: Colors.black38,size: MediaQuery.of(context).size.width*0.05,));
                      }
                    }),
                    )),
                  ),Container(child: Text(rating.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),)],
                ),
              ))
              ,Directionality(textDirection: TextDirection.rtl,
                child: Container(width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [ Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right:30,top: 15),child:
                      Directionality( textDirection: TextDirection.rtl,child: Text(data["SalePrice"].toString()+"ريال" ,style: TextStyle(color: Colors.red.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 18),)),),
                   Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right:30,top: 15),child:
                Directionality( textDirection: TextDirection.rtl,child:data["Price"].toString()==data["SalePrice"].toString() ?Container() :Text(data["Price"].toString()+"ريال" ,style: TextStyle( decoration: TextDecoration.lineThrough,color: Colors.black12.withOpacity(0.6),fontWeight: FontWeight.bold,fontSize: 18),)),) ],
                  ),
                ),
              ),
              Container( margin: EdgeInsets.only(top: 30),child: InkWell( onTap: ()=>Provider.of<Notifires>(context,listen: false).plus(data["ID"] ,0, num,data["Price"] , context),child: Container(padding: EdgeInsets.only(top: 10,bottom: 10),width: MediaQuery.of(context).size.width *0.5,decoration: BoxDecoration(boxShadow:  [ BoxShadow(
                color: Color.fromRGBO(69, 190, 0, 1).withOpacity(0.3),
                blurRadius: 0.0,
                spreadRadius: 2.0,
                offset: Offset(0.5, 0.5), // shadow direction: bottom right
              )],borderRadius: BorderRadius.circular(20),color: Color.fromRGBO(69, 190, 0, 1)) ,child:
              Center(child: Text("أضف للعربة",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),)))
              ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right:30,top: 25),child:
              Directionality( textDirection: TextDirection.rtl,child: Text("تفاصيل المنتج",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),)),)
              ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right:30,top: 15,left: 20),child:
              Directionality( textDirection: TextDirection.rtl,child: Text(data["Description"],style: TextStyle(color: Colors.black,fontSize: 16),)),)
            ],),
          ),)
        ],),
      ),
    ),);
  }
  navigateback(){
    Navigator.of(context).pop();
  }
}