import 'package:ezzproject/logic/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Location extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Statelocation();
  }
}
class Statelocation extends State<Location>{
  var value1 = "المنطقة" ;
  var value2 = "المحافظة" ;
  var value3 = "المدينة" ;
  List region1list =["المنطقة"];
  List region2list =["المحافظة"];
  List region3list =["المدينة"];
  List region1back =[];
  List region2back =[];
  List region3back =[];
  Locationlogic locationlogic ;
 var download =true;
 List regions =[];
 List citites =[];
  getdata()async{
    var dataa = await locationlogic.getdata();
    regions = dataa["listre1"];
    for(int f = 0 ; f<regions.length;f++){
      region1back.add({"name" :regions[f]["Name"],"ID" : regions[f]["ID"].toString()});
    }
    for(int i =0 ; i<region1back.length ; i++){
      region1list.add(region1back[i]["name"].toString());
    }
    await slecetcity(dataa["re1"]);
    await selectgovern(dataa["re2"]);
    value1 = dataa["re1"];
    value2 = dataa["re2"];
    value3 = dataa["re3"];
    download = false;
    setState(() {});
  }
  slecetcity(name){
    region2back.clear();
    region2list.clear();
    region3back.clear();
    region3list.clear();
    for (int f = 0; f < regions.length; f++) {
      if (regions[f]["Name"].toString() == name.toString()) {
        citites = regions[f]["Cities"];
        for (int g = 0; g < regions[f]["Cities"].length; g++) {
          region2back.add({
            "name": regions[f]["Cities"][g]["Name"],
            "ID": regions[f]["Cities"][g]["ID"].toString()
          });
        }
      }
    }
    value2 = "المحافظة" ;
    value3 ="المدينة";
    region2list.add("المحافظة");
    region3list.add("المدينة");
    for (int i = 0; i < region2back.length; i++) {
      region2list.add(region2back[i]["name"].toString());
    }
    setState(() {});
  }
  selectgovern(name){
    region3back.clear();
    region3list.clear();
    for(int f =0 ; f<citites.length ; f++){
      if(citites[f]["Name"].toString() ==name.toString()) {
        for (int g = 0; g < citites[f]["Regions"].length; g++) {
          region3back.add({
            "name": citites[f]["Regions"][g]["Name"],
            "ID": citites[f]["Regions"][g]["ID"].toString()
          });
        }
      }
    }
    value3 ="المدينة";
    region3list.add("المدينة");
    for(int i =0 ; i<region3back.length ; i++){
      region3list.add(region3back[i]["name"].toString());
    }
    setState(() {
    });
  }
  @override
  void initState() {
    locationlogic = new Locationlogic(context);
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
        child:download ?Container(child: Center(child: CircularProgressIndicator(),),):ListView(children: [
         Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :Stack(children: [
           Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,
             decoration: BoxDecoration(color: Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(50),bottomLeft: Radius.circular(50))),child: Row(children: [
               Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.width*0.06,color: Colors.white,),onPressed: (){navigateback();},))),
               Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("الموقع",style: TextStyle(color: Colors.white,fontSize: 17),))),
               Expanded(child: Container())
             ],),)
         ],) ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.01,right: MediaQuery.of(context).size.width*0.06),child: Text("حدد الموقع" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.045),),)
        ,Container(alignment: Alignment.centerRight,margin: EdgeInsets.only( top: 10,right: MediaQuery.of(context).size.width*0.05),child: Text("المنطقة" ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black26),),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top: 10,right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: value1
                    ,items: region1list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                  Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==value1?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                    onChanged: (_) {
        if(_.toString() != "المنطقة") {
          value1 = _;
            slecetcity(value1);
            setState(() {});
    }
                    },
                  )),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05,top: 10),child: Text("المحافظة" ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black26),),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top: 10,right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: value2
                    ,items: region2list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                  Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==value2?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                    onChanged: (_) {
                 if(_.toString() != "المحافظة") {
                   value2 = _;
                   selectgovern(value2);
                   setState(() {});
                 }
                    },
                  )),
            )),
          ),Container(alignment: Alignment.centerRight,margin: EdgeInsets.only( right: MediaQuery.of(context).size.width*0.05,top: 10),child: Text("المدينة" ,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black26),),),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(decoration: BoxDecoration(color: Colors.black12.withOpacity(0.05)),margin: EdgeInsets.only( top: 10,right:MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),child: ListTile(
              title: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: value3
                    ,items: region3list.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child:
                  Text('$e',style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,color:e==value3?Color.fromRGBO(69, 190, 0, 1) :Colors.black38),)),value: e,)).toList(),
                    onChanged: (_) {
                    if(_.toString() != "المدينة") {
                      value3 = _;
                      setState(() {});
                    }
                    },
                  )),
            )),
          )
        ,
           Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
             child:InkWell(onTap: (){locationlogic.setlocation(value1, value2, value3,region1back,region2back,region3back);},
               child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
                child:Text("حفظ",style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white,fontSize: 15)) ,)),
           ),
        ],),
    ),);
  }
  navigateback(){
    Navigator.of(context).maybePop();
  }
}