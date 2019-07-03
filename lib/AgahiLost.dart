
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'globals.dart' as globals;
import 'SignInUpRout.dart' as sign;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class lostRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return stateLostRoute();
  }

}

class stateLostRoute extends State<lostRoute>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        floatingActionButton: Builder(builder: (context){
          return FloatingActionButton(onPressed: (){
            globals.isLoggedIn?

            Navigator.push(context, MaterialPageRoute(builder: (context)=>addAgahiLost()))
                :
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("برای قرار دادن آکهی ابتدا باید وارد شوید"),
              action: SnackBarAction(label: "ورود", onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>sign.signIn()));
              }),));

          },
            child: Icon(Icons.add_circle,),);
        }),
        appBar: AppBar(
          title: Text("اشخاص و اشیا گمشده"),
        ),
        body: FutureBuilder(
            future: getDataItemLost(),
            builder: (context,snapShot){
              if(snapShot.hasData){
                return itemLost(list: snapShot.data,);
              }else if(snapShot.hasError){
                return Center(
                  child: Text("${snapShot.error}"),
                );
              }else{
                return Center(child:
                CircularProgressIndicator(),);
              }
            })
    );
  }

}

class itemLost extends StatelessWidget{
  final List<modelItemLost> list;

  const itemLost({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(crossAxisCount: 2,
      children: List.generate(list.length, (position){
        return GestureDetector(

          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>detailAgahiLost(title: list[position].title,
              desc: list[position].desc,
              phone: list[position].phone,
              image: list[position].image,)));
          },

          child: Container(

              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(color: Colors.transparent),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[




                  Hero(
                    tag: list[position].title,
                    child: Image.asset(list[position].image,fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width*1,
                      height:MediaQuery.of(context).size.height*1,),
                  ),


                  Opacity(
                    child: Container(
                      child: Text(list[position].title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width*1,
                      height:MediaQuery.of(context).size.width*0.1,
                      decoration: BoxDecoration(color: Colors.blueGrey),
                    ),
                    opacity: 0.9,
                  )

                ],

              )
          ),
        );
      }),);
  }

}

class detailAgahiLost extends StatelessWidget {
  final String image;
  final String title;
  final String phone;
  final String desc;

  const detailAgahiLost({Key key, this.image, this.title, this.phone, this.desc}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.8,
          child: ListView(
            padding: EdgeInsets.all(2),
            children: <Widget>[
              Hero(
                  tag: title,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(image),
                      ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Text(
                  "تلفن همراه:  ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "desc",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "برگشت",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ))
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}

class modelItemLost{
  final String id;
  final String image;
  final String title;
  final String desc;
  final String phone;

  modelItemLost({this.id, this.image, this.title, this.desc, this.phone});

  factory modelItemLost.fromJson(Map<String,dynamic> json){
    return modelItemLost(
      id: json["id"],
      image: json["image"],
      title: json["title"],
      desc: json["desc"],
      phone: json["phone"],
    );
  }
}

Future<List<modelItemLost>> getDataItemLost() async{
  var data = [
    {
      "id": "id",
      "title": "چوغا",
      "desc": "desc",
      "number": "09123456789",
      "image": "images/chogha.jpg"
    },
    {
      "id": "id",
      "title": "مرد",
      "desc": "desc",
      "number": "09100000000",
      "image": "images/man.jpg"
    },
    {
      "id": "id",
      "number": "09123456789",
      "title": "title3",
      "desc": "desc",
      "image": "image"
    },
    {
      "id": "id",
      "title": "title4",
      "number": "09123456789",
      "desc": "desc",
      "image": "image"
    }
  ];

  final response=await http.get("http://sobhanm28.ir/divar/readall.php");


  if(response.statusCode==200){
    var responseJson=json.decode(response.body);
    var rest=responseJson as List;
    var list=data.map((json)=>modelItemLost.fromJson(json)).toList();
    return list;
  }else throw Exception("fuch of bith men in getDataItem Lost");

}

class addAgahiLost extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addAgahiLostState();
  }
}

class addAgahiLostState extends State<addAgahiLost> {
  File image;

  String _title;
  var _errorTitle;
  String _phone;
  var _errorPhone;
  String _desc;
  var _errordesc;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Builder(builder: (context){
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                padding: EdgeInsets.all(2),
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      File imageFile =
                      await ImagePicker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        image = imageFile;
                      });
                    },
                    child: Container(
                      child: image == null
                          ? Icon(
                        Icons.add_a_photo,
                        size: 50,
                      )
                          : Image.file(image),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(5),
                      child: TextField(
                        decoration: InputDecoration(labelText: "تیتر آگهی",errorText: _errorTitle),
                        onChanged: (title) {
                          setState(() {
                            _title = title;
                          });
                        },
                      )),

                  Container(
                      margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
                      child: TextField(
                        decoration: InputDecoration(labelText: "تلفن همراه",errorText: _errorPhone),
                        onChanged: (phone) {
                          setState(() {
                            _phone = phone;
                          });
                        },
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0,5,0,5),
                      child: TextField(
                        maxLines: 5,
                        decoration: InputDecoration(labelText: "توضیحات محصول",errorText: _errordesc),
                        onChanged: (desc) {
                          setState(() {
                            _desc = desc;
                          });
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){

                          setState(() {
                            _errorTitle=null;

                            _errorPhone=null;
                            _errordesc=null;
                          });


                          if(image==null){
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("برای اجناس خود عکسی انتخاب کنید"),
                              backgroundColor: Colors.blue,));
                          }else if(_title==null){
                            setState(() {
                              _errorTitle="تیتر نمیتواند خالی بماند";
                            });
                          }else if(_phone==null){
                            setState(() {
                              _errorPhone="تلفن همراه برای تماس با شما نیاز است";
                            });
                          }else if(_desc==null){
                            setState(() {
                              _errordesc="توضیحات محصول نمی تواند خالی بماند";
                            });
                          }else{



                            Scaffold.of(context).showSnackBar(SnackBar(content:
                            Text("آگهی شما پس از تایید تا چند ساعت آینده در این قسمت قرار خواهد گرفت"),duration: Duration(seconds: 7),
                              backgroundColor: Colors.blue,action: SnackBarAction(label: "برگشت" ,textColor: Colors.white,onPressed: (){
                                Navigator.pop(context);
                              }),));


                          }
                        },
                        child: Text("ارسال"),
                      ),
                      FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("انصراف"),
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          );
        })
    );
  }
}