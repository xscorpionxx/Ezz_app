import 'dart:io';
import 'package:ezzproject/logic/home.dart';
import 'package:ezzproject/screens/Loginpage.dart';
import 'package:ezzproject/screens/aboutapp.dart';
import 'package:ezzproject/screens/codeconirmation.dart';
import 'package:ezzproject/screens/provider/addauction.dart';
import 'package:ezzproject/screens/provider/addcoupons.dart';
import 'package:ezzproject/screens/provider/addservice.dart';
import 'package:ezzproject/screens/provider/addservice2.dart';
import 'package:ezzproject/screens/provider/addservice3.dart';
import 'package:ezzproject/screens/provider/editservice.dart';
import 'package:ezzproject/screens/provider/home2.dart';
import 'package:ezzproject/screens/resetpass2.dart';
import 'package:ezzproject/screens/users/chat.dart';
import 'package:ezzproject/screens/users/home.dart';
import 'package:ezzproject/screens/users/showimages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/mainlogic.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
Mainlogic mainlogic = new Mainlogic();
SharedPreferences sharedPreferences;
void main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(
 ChangeNotifierProvider(create: (_){
   return Notifires();
 },child: MyApp(),)
      );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    if (message.notification.title.toString() == "1") {
      FlutterRestart.restartApp();
    }
  }
}
class MyApp extends StatelessWidget {
  Mainlogic mainlogic = new Mainlogic();
  @override
  Widget build(BuildContext context) {
    mainlogic.gettoken();
    return

      FutureBuilder(future: mainlogic.getdata() , builder: (context ,snapshot ){
      if(snapshot.hasError){
        return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),
            title: "Ezz",debugShowCheckedModeBanner: false,
          home: Loginpage());
      }
      if(snapshot.connectionState ==ConnectionState.done){
        if(mainlogic.data["token"] !=null &&mainlogic.data["phone"] !=null ) {
            return FutureBuilder(future: mainlogic.login(
                mainlogic.data["phone"],mainlogic.data["password"]),
                builder: (context, snapshot)  {
                  if (snapshot.hasError) {
                    Fluttertoast.showToast(
                        msg: mainlogic.message.toString() =="null"?"الرجاء اعادة محاولة تسجيل الدخول":mainlogic.messageso.toString(),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                    return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),
                        title: "Ezz",
                        debugShowCheckedModeBanner: false,
                        home: Loginpage());
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (mainlogic.status == true) {
                      print(mainlogic.accountstatus);
                      if(mainlogic.accountstatus.toString().trim() =="1"){
                        return MaterialApp(
                            theme: ThemeData(fontFamily: 'Tajawal'),
                            title: "Ezz",
                            debugShowCheckedModeBanner: false,
                            home: mainlogic.type == "تاجر"
                                ? Home2()
                                : Home() //Section1(username: data,)
                        );
                      }
                      else{
                        return MaterialApp(
                            theme: ThemeData(fontFamily: 'Tajawal'),
                            title: "Ezz",
                            debugShowCheckedModeBanner: false,
                            home: Codeconf(type: mainlogic.type,phone:mainlogic.data["phone"] ,) // mainlogic.type == "تاجر"
                                 //Section1(username: data,)
                        );
                      }
                    }
                    else {
                      Fluttertoast.showToast(
                          msg: mainlogic.message.toString() =="null"?"الرجاء اعادة محاولة تسجيل الدخول":mainlogic.messageso.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      return MaterialApp(
                          theme: ThemeData(fontFamily: 'Tajawal'),
                          title: "Ezz",
                          debugShowCheckedModeBanner: false,
                          home: Loginpage()
                      );
                    }
                  }
                  return MaterialApp(
                    title: "Loading", debugShowCheckedModeBanner: false,
                    theme: ThemeData(fontFamily: 'Tajawal'),
                    home: Scaffold(
                      body: Center(child: CircularProgressIndicator()),),);
                });
        }
        else{
          return MaterialApp(theme: ThemeData(fontFamily: 'Tajawal'),title: "Ezz",debugShowCheckedModeBanner: false,
              home: Loginpage()
          );
        }
      }
      return MaterialApp(title:"Loading",debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Tajawal'),
        home: Scaffold(body: Center(child: CircularProgressIndicator()),),);
    },);
  }
}
