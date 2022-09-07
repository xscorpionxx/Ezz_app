import 'dart:io';
import 'package:ezzproject/logic/addservice2.dart';
import 'package:ezzproject/logic/alertdialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditServices2 extends StatefulWidget{
  var service;
  EditServices2({this.service});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Stateaddservices2(service: service);
  }
}
class Stateaddservices2 extends State<EditServices2>{
  TextEditingController name ;
  TextEditingController detail ;
  TextEditingController marka ;
  TextEditingController licence ;
  TextEditingController price ;
  TextEditingController saleprice ;
  TextEditingController num ;
  TextEditingController id ;
  TextEditingController phone ;
  TextEditingController licence2 ;
  TextEditingController name2 ;
  Addservice2logic addservice2logic;
  var service;
  Stateaddservices2({this.service});
  var photo;
  GlobalKey<FormState> key;
  getdata(){
    name.text = service["Name"].toString();
    detail.text = service["Description"].toString();
    marka.text =service["CarBrand"].toString();
    num.text = service["CarNumber"].toString();
    licence.text= service["CarLicense"].toString();
    id.text = service["DriverNationalNumber"].toString();
    phone.text = service["DriverPhone"].toString();
    licence2.text = service["DriverLicense"].toString();
    name2.text= service["DriverName"].toString();
    photo = service["Photo"];
    saleprice.text = service["SalePrice"].toString();
    price.text = service["Price"].toString();
    setState(() {});
  }
  @override
  void initState() {
    addservice2logic= new Addservice2logic(context);
    key = new GlobalKey<FormState>();
    name = new TextEditingController();
    detail = new TextEditingController();
    marka = new TextEditingController();
    num = new TextEditingController();
    licence= new TextEditingController();
    price = new TextEditingController();
    saleprice= new TextEditingController();
    id = new TextEditingController();
    phone = new TextEditingController();
    licence2 = new TextEditingController();
    name2= new TextEditingController();
    getdata();
    super.initState();
  }
  File image ;
  chooseimage()async {
    var status = await Permission.camera.status;
    var takepermission = await Permission.camera.request();
    if (takepermission.isGranted) {
      var image1 = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image1 != null) {
        image = File(image1.path);
        setState(() {});
      }
    }
  }
  List selectservice =[];
  navigateback(){
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Container(width:  MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Form(key: key,
        child: ListView(children: [
          Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,child :
            Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(color:Color.fromRGBO(42, 171, 227, 1),borderRadius: BorderRadius.only(bottomRight: Radius.circular(90),bottomLeft: Radius.circular(90))),child: Row(children: [
                Expanded(child: Container(margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.05),child: IconButton(icon: Icon(Icons.arrow_back,size: MediaQuery.of(context).size.height*0.04,color: Colors.white,),onPressed: (){navigateback();},))),
                Expanded(flex: 5,child: Container(alignment: Alignment.center,child: Text("تعديل خدمة",style: TextStyle(color: Colors.white,fontSize: MediaQuery.of(context).textScaleFactor*18),))),
                Expanded(child: Container())
              ],),) ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.01) ,child: Text("تعديل دينات وسيارات",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)
          , Container(height: MediaQuery.of(context).size.height*0.18 ,margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.09,top: MediaQuery.of(context).size.height*0.02,right:MediaQuery.of(context).size.width*0.09 ),child:image != null?Container(
            child: InkWell(onTap: ()=>chooseimage(),child: Image( fit: BoxFit.fill,image: FileImage(image),)),
          ) : InkWell(onTap: ()=>chooseimage() ,child: Image( fit: BoxFit.fill,image: NetworkImage(photo))) )
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate,controller: name,toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),onChanged: (val) {
              if (val.contains("0") ||val.contains("2")||
                  val.contains("1")||val.contains("3")|val.contains("4")||
                  val.contains("5")||val.contains("6")||val.contains("7")||val.contains("8")
                  ||val.contains("9")||val.contains("٠") ||val.contains("١")||
                  val.contains("٢")||val.contains("٣")|val.contains("٤")||
                  val.contains("٥")||val.contains("٦")||val.contains("٧")||val.contains("٨")
                  ||val.contains("٩")) {
                setState(() {
                  name.text ="";
                });
              }
            },style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم الخدمة "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate, onChanged: (val){
              if (val.contains("0") ||val.contains("2")||
                  val.contains("1")||val.contains("3")|val.contains("4")||
                  val.contains("5")||val.contains("6")||val.contains("7")||val.contains("8")
                  ||val.contains("9")||val.contains("٠") ||val.contains("١")||
                  val.contains("٢")||val.contains("٣")|val.contains("٤")||
                  val.contains("٥")||val.contains("٦")||val.contains("٧")||val.contains("٨")
                  ||val.contains("٩")) {
                setState(() {
                  detail.text ="";
                });
              }
            },controller: detail,toolbarOptions: ToolbarOptions(
              copy: false,
              cut: false,
              paste: false,
              selectAll: false,
            ),style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),minLines: 2,maxLines: 3 ,decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "تفاصيل "),
            )),
          ),Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.01) ,child: Text("بيانات السيارة",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate,controller: marka,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "ماركة السيارة"),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate,controller: num,keyboardType: TextInputType.number,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم السيارة "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate,  controller: licence,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رخصة السيارة"),
            )),
          ),
          Container(alignment: Alignment.centerRight,margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.1,top:MediaQuery.of(context).size.height*0.01) ,child: Text("بيانات السائق",style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.022),),)
          ,Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate,controller:  name2,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "اسم السائق"),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate,controller: id,keyboardType: TextInputType.number,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم الهوية الشخصية "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: addservice2logic.validate,controller: licence2,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رخصة السائق "),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: Alertdialogazz.validateMobile,  controller: phone,inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],keyboardType: TextInputType.phone,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "رقم للتواصل"),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: Alertdialogazz.validateMobile,  controller: price,maxLength: 6,keyboardType: TextInputType.number,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "السعر"),
            )),
          ),
          Directionality(textDirection: TextDirection.rtl,
            child: Container(padding:EdgeInsets.only(right: MediaQuery.of(context).size.width*0.02),decoration: BoxDecoration(border: Border.all(color: Colors.black38),borderRadius: BorderRadius.circular(5)),margin: EdgeInsets.only( top:MediaQuery.of(context).size.height*0.01 ,left:  MediaQuery.of(context).size.width*0.07,right: MediaQuery.of(context).size.width*0.07),child: TextFormField(
              validator: Alertdialogazz.validateMobile,  controller: saleprice,maxLength: 6,keyboardType: TextInputType.number,style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),decoration: InputDecoration(border: InputBorder.none, hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height*0.015),hintText: "السعر بعد الخصم"),
            )),
          )
          ,Container(margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
            child: InkWell(onTap: ()=>addservice2logic.editservice2(service["ID"] ,key, name.text, price.text, saleprice.text, detail.text, marka.text, num.text, licence.text, name2.text, id.text, licence2.text, phone.text, image),
              child: Container(height: MediaQuery.of(context).size.height*0.07,alignment: Alignment.center,decoration: BoxDecoration(color: Color.fromRGBO(69, 190, 0, 1),),
                child:Text("تعديل", style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)) ,),
            ),
          )

        ],),
      ),
    ),);
  }
}