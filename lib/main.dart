
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'newsRoute.dart' as newsRoute;
import 'AgahiRoute.dart' as agahiRoute;
import 'nomineRoute.dart' as nomineRote;
import 'SignInUpRout.dart' as sign;
import 'package:http/http.dart' as http;
import 'package:carousel_pro/carousel_pro.dart';
import 'FunRoute.dart' as funRoute;
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {




  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale:
            Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "IranSans"),
        home: MainRoute());
  }
}


Widget testBgCarousel(){

}

class MainRoute extends StatefulWidget{
  @override
  MainRouteState createState()=>MainRouteState();
}

class MainRouteState extends State<MainRoute>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("بروجردی ها"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width*1,
            height: MediaQuery.of(context).size.height*0.3,
            margin: EdgeInsets.all(5),
            child:
            Carousel(
              images: [
                Image.asset("images/imgs1.jpg",fit: BoxFit.fill,),
                Image.asset("images/imgs3.jpg",fit: BoxFit.fill,),
                Image.asset("images/imgs2.jpg",fit: BoxFit.fill,),
              ],
              autoplayDuration: Duration(seconds: 3),
              animationCurve: Curves.fastOutSlowIn,
              showIndicator: false,
            ),
            decoration: BoxDecoration(color: Colors.deepOrangeAccent),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(

                children: <Widget>[

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return newsRoute.itemNews();
                      }));
                    },
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.receipt,
                            size: 40,
                            color: Colors.white,
                          ),
                          Text(
                            "مجله خبری",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue[900]),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => nomineRote.nomineRoute()));
                    },
                    child: Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.fingerprint,
                            size: 40,
                            color: Colors.white,
                          ),
                          Text(
                            "انتخابات \n مجلس",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.green),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => agahiRoute.typeAgahi()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.40,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "ثبت آگهی رایگان",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.record_voice_over,
                            size: 22,
                            color: Colors.white,
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.blue),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>funRoute.FunRoute()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.40,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "مجله تفریحی",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.videogame_asset,
                            size: 22,
                            color: Colors.white,
                          )
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.redAccent),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => testRoute()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.40,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "دوربین مخفی \n مصاحبه",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.camera,
                            size: 22,
                            color: Colors.white,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.deepOrangeAccent),
                    ),
                  )
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>sign.signIn()));
            },
            child: Container(

              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*0.12,
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("ورود/ثبت نام",style: TextStyle(color: Colors.white,fontSize: 22),),
                  Icon(Icons.system_update_alt,size: 30,color: Colors.white,),

                ],
              ),
              decoration: BoxDecoration(color: Colors.amberAccent,borderRadius: BorderRadius.all(Radius.circular(15))),
            ),
          )
        ],
      ),
    );
  }
}

class testRoute extends StatefulWidget{
  @override
  testRouteState createState()=>testRouteState();
}

class testRouteState extends State<testRoute>{
  File _file;

  Future _choose() async {
    var file=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file=file;
    });

    print("$_file :=============================================");
  }

  void _upload(){
    var url="http://192.168.43.15:8000/getImage";
    if(_file==null) return;
    String base64Image=base64Encode(_file.readAsBytesSync());
    String fileName=_file.path.split("/").last;
    print(base64Image);
    http.post(url,
        body: {"image":base64Image,
                "name":fileName}).then((res){
                  print(res.statusCode);
                  print(res.body);
    }).catchError((err){
      print(err);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: <Widget>[
            Center(
              child: _file==null?null: Image.file(_file),
            ),
           Row(
             children: <Widget>[
               FlatButton(
                 onPressed: (){
                   _choose();
                 },
                 child: Text("choose photo"),
               ),
               FlatButton(
                 onPressed: (){
                   _upload();
                 },
                 child: Text("upload photo"),
               )
             ],
           )
          ],
        )
    );
  }

}

Future<http.Response> postrequest() async{
  var url="http://192.168.43.15:8000/insertUser";
  Map data={
    'name':'sobhan',
    'family':'moradi',
    'age':"21"
  };
  var body=json.encode(data);
  var response=await http.post(url,
      headers: {"Content-Type":"application/json"},
      body: body);
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

