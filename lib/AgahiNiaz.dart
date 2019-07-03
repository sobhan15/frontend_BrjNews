

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'SignInUpRout.dart'  as sign;
import 'globals.dart' as globals;
import 'package:image_picker/image_picker.dart';


class modelItemNiaz {
  final String id;
  final String title;
  final String price;
  final String desc;
  final String number;
  final String image;

  modelItemNiaz(
      {this.id, this.title, this.price, this.desc, this.number, this.image});
  factory modelItemNiaz.fromJson(Map<String, dynamic> json) {
    return modelItemNiaz(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      desc: json["desc"],
      number: json["number"],
      image: json["image"],
    );
  }
}



class addAgahiNiaz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addAgahiNiazState();
  }
}

class addAgahiNiazState extends State<addAgahiNiaz> {
  File image;

  String _title;
  var _errorTitle;
  String _price;
  var _errorPrice;
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
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                      child: TextField(
                        decoration: InputDecoration(labelText: "قیمت",errorText: _errorPrice),
                        onChanged: (price) {
                          setState(() {
                            _price = price;
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
                            _errorPrice=null;
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
                          }else if(_price==null){
                            setState(() {
                              _errorPrice="قیمت نمی تواند خالی بماند";
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
                            Text("محصول شما پس از تایید تا چند ساعت آینده در این قسمت قرار خواهد گرفت"),duration: Duration(seconds: 7),
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


class NiazRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: new Builder(builder: (context) {
        return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              if (globals.isLoggedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => addAgahiNiaz()));
              } else {
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("برای قرار دادن آکهی ابتدا باید وارد شوید"),
                  backgroundColor: Colors.blue,
                  action: SnackBarAction(label: "ورود",textColor: Colors.white, onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>sign.signIn()));
                  }),));
              }
            });
      }),
      appBar: AppBar(
        title: Text("نیازمندی ها"),
      ),
      body: FutureBuilder(
          future: getDataItemNiaz(),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return ItemNiaz(
                list: snapShot.data,
              );
            } else if (snapShot.hasError) {
              return Text("${snapShot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

}

class detailAgahiNiaz extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String phone;
  final String desc;

  const detailAgahiNiaz(
      {Key key, this.image, this.title, this.price, this.phone, this.desc})
      : super(key: key);

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
                margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                child: Text(
                  " قیمت: $price ریال ",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
                child: Text(
                  "تلفن همراه: $phone",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  desc,
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

class ItemNiaz extends StatefulWidget {
  final List<modelItemNiaz> list;

  const ItemNiaz({Key key, this.list}) : super(key: key);

  @override
  StateItemNiaz createState() => StateItemNiaz(list);
}

class StateItemNiaz extends State<ItemNiaz> {
  final List<modelItemNiaz> list;

  StateItemNiaz(this.list);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, position) => Hero(
                tag: list[position].title,
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => detailAgahiNiaz(
                                title: list[position].title,
                                image: list[position].image,
                                phone: list[position].number,
                                price: list[position].price,
                                desc: list[position].desc,
                              )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(""),
                                Text(""),
                                Text(
                                  list[position].price,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                list[position].title,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(""),
                              Text(""),
                            ],
                          ),
                          Container(
                            child: ClipRRect(
                              child: Image.asset(
                                list[position].image,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(10)),
                            ),
                            margin: EdgeInsets.only(left: 10),
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                Border.all(width: 2, color: Colors.grey),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}

Future<List<modelItemNiaz>> getDataItemNiaz() async {
  var data = [
    {
      "id": "id",
      "title": "چوغا",
      "price": "price",
      "desc": "desc",
      "number": "09123456789",
      "image": "images/chogha.jpg"
    },
    {
      "id": "id",
      "title": "مرد",
      "price": "price",
      "desc": "desc",
      "number": "09100000000",
      "image": "images/man.jpg"
    },
    {
      "id": "id",
      "number": "09123456789",
      "title": "title3",
      "price": "price",
      "desc": "desc",
      "image": "image"
    },
    {
      "id": "id",
      "title": "title4",
      "number": "09123456789",
      "price": "price",
      "desc": "desc",
      "image": "image"
    }
  ];

  final response = await http.get("http://sobhanm28.ir/divar/readall.php");

  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    var rest = responseJson as List;
    var list = data.map((json) => modelItemNiaz.fromJson(json)).toList();
    return list;
  } else
    throw Exception("fuck off bith men in getDataItemNiaz");
}
