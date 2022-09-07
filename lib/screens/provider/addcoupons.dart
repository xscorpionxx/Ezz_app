import 'package:ezzproject/logic/addcoupon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Addcoupons extends StatefulWidget{
  List services =[];
  var servicetype ;
  Addcoupons({this.services,this.servicetype});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateAddcoupons(services: services ,servicetype: servicetype);
  }
}
class StateAddcoupons extends State<Addcoupons>{
  List services =[];
  var servicetype ;
  StateAddcoupons({this.services ,this.servicetype});
  var val = "ريال";
  List vals = ["ريال"];
  TextEditingController cuponame ;
  TextEditingController num ;
  TextEditingController price ;
  GlobalKey<FormState> key;
  Addcuponlogic addcuponlogic;
  @override
  void initState() {
    for(int f =0 ; f<services.length ;f++){
      checks.add(false);
    }
    addcuponlogic = new Addcuponlogic(context);
    cuponame = new TextEditingController();
    num = new TextEditingController();
    price = new TextEditingController();
    key = new GlobalKey<FormState>();
    super.initState();
  }
  List selectservice =[];
  navigateback(){
    Navigator.of(context).pop();
  }
  List checks =[];
  showdialog(){
    return showDialog( context: context, builder: (context) {
      return StatefulBuilder(builder: (Context , setState){
        return AlertDialog(
            content:Container(height: MediaQuery.of(context).size.height*0.45,
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.03,top: MediaQuery.of(context).size.height*0.02) ,alignment: Alignment.centerRight,child: Text("المنتجات التي يطبق عليها الكوبون",style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.035),),)
                  ,Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.3 ,child: ListView.builder(itemCount: services.length,itemBuilder: (context,i){
                    return CheckboxListTile(activeColor: Colors.green,title: Directionality(textDirection: TextDirection.rtl,child: Text(services[i]["Name"])),value: checks[i], onChanged: (val){ setState((){checks[i] = val;});});;
                  }),),
                  Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.05 ,left: MediaQuery.of(context).size.width*0.05),
                    child: InkWell(onTap: (){
                      Navigator.of(context).pop("dialog");
                    },
                      child: Container( height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),borderRadius: BorderRadius.circular(10)),
                        child:InkWell(child: Container(child: Text("اضافة ", style: TextStyle(color: Colors.white,fontSize:15,fontWeight: FontWeight.bold)))) ,),
                    ),
                  )
                ],),
              ),
            )
        );},
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child:servicetype =="مزاد"? ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("اضافة كوبون خصم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
                Expanded(child: Container())
              ],),) )
          ,Container( margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4),child:  Center(child: Text("لا يمكنك اضافة كوبون للمزادات"),),)
        ],) : ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.12,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),bottomLeft: Radius.circular(70))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: 30,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("اضافة كوبون خصم",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).size.width*0.045),))),
                Expanded(child: Container())
              ],),))
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.1 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
              validator: addcuponlogic.validate,controller: cuponame,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم الكوبون"),
            )),
          ),
          Container(
            child:servicetype !="اماكن"?Container() : Directionality(textDirection: TextDirection.rtl,
              child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.only( top:20 ,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child: TextFormField(
                validator: addcuponlogic.validate,controller: num,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),keyboardType: TextInputType.number,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: 12),hintText: "عدد الايام الواجب توافرها على الاقل لتطبيق الخصم"),
              )),
            ),
          ),
          Container(
            child: Row(
              children:[Expanded(child:  Directionality(textDirection: TextDirection.rtl,
                child: Container(height: MediaQuery.of(context).size.height*0.075 ,padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child:
                ListTile(
                  title: DropdownButtonHideUnderline(
                      child: DropdownButton(
                         value: val
                        ,items: vals.map((e) => DropdownMenuItem(child: Container(alignment: Alignment.centerRight,child: Text('$e')),value: e,)).toList(),
                        onChanged: (_) {
                           val =_;
                          setState(() {});
                        },
                      )),
                )),
              )),
                Expanded(child:  Directionality(textDirection: TextDirection.rtl,
                  child: Container(alignment: Alignment.centerRight,height: MediaQuery.of(context).size.height*0.075 ,padding:EdgeInsets.all( 5),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child:
                  TextFormField( maxLength: 6,decoration: InputDecoration(hintText: "قيمة الخصم",border: InputBorder.none),keyboardType: TextInputType.number ,controller: price,validator: addcuponlogic.validate ,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015))),
                ))],
            ),
          ),
          Container(
            child:servicetype =="اماكن" ?Container(): Directionality(textDirection: TextDirection.rtl,
              child: Container(alignment: Alignment.centerRight,height: MediaQuery.of(context).size.height*0.075 ,padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(10)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.03,left:  MediaQuery.of(context).size.width*0.05,right: MediaQuery.of(context).size.width*0.05),child:
              InkWell( onTap: ()=>showdialog(),child: ListTile(trailing: Icon(Icons.arrow_drop_down) ,title: Text("المنتجات التي يطبق عليها الكوبون",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.017))))),
            ),
          ),
          Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap: (){
              List service = [];
              for(int f =0 ; f<checks.length ; f++){
                if(checks[f]){
                  service.add(services[f]["ID"]);
                }
              };
              addcuponlogic.addcupon(key,cuponame.text , price.text ,service,servicetype,num.text);
            },
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
                child:InkWell(child: Container(child: Text("اضافة ", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)))) ,),
            ),
          )
        ],),
      ),
    ),);
  }
}