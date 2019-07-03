import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'globals.dart' as globals;
import 'SignInUpRout.dart' as sign;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FunRoute extends StatefulWidget {
  @override
  FunRouteState createState() => FunRouteState();
}

class FunRouteState extends State<FunRoute> {
  File _ImageFile;
  File _backGroundImg;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
               File img=await ImagePicker.pickImage(source: ImageSource.gallery);
               setState(() {
                 _backGroundImg=img;
               });
              },
              child: Text("پس زمینه"),
            )
          ],
          title: Text("مجله سرگرمی"),
        ),
        body: globals.isLoggedIn?
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
            width: MediaQuery.of(context).size.width*1,
            height: MediaQuery.of(context).size.height*1,
          child: _backGroundImg==null?null:Opacity(
            child: Image.file(_backGroundImg,fit: BoxFit.fill,),
            opacity: 0.2,
          ),
        ),
            Container(
              margin:_ImageFile==null?EdgeInsets.only(bottom: 50):EdgeInsets.only(bottom: 110),
          child: FutureBuilder(
              future: getDataFun(),
              builder: (context,snapShot){
            if(snapShot.hasData){
              return ItemImage(list: snapShot.data,);
            }else if(snapShot.hasError){
              return Center(
                child: Text("${snapShot.error}"),
              );
            }else{
              return Center(
                child:CircularProgressIndicator(),
              );
            }

          })
        ),

            Container(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(color: Colors.grey[200],border: Border.all(width: 1,color: Colors.black54)),
              child: TextField(
                maxLines: _ImageFile==null?1:5,
                decoration: InputDecoration(
                  icon: _ImageFile == null
                      ? null
                      : Container(
                    width: 100,
                    color: Colors.transparent,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.file(_ImageFile,fit: BoxFit.fill,),
                    ),
                    height: 100,
                  ),
                  suffixIcon: FlatButton(
                      onPressed: () async {
                        File img = await ImagePicker.pickImage(
                            source: ImageSource.gallery);
                        setState(() {
                          _ImageFile = img;
                        });
                      },
                      child: Icon(Icons.image)),
                  prefixIcon: Icon(Icons.send),
                  hintText: "چیزی بنویسید...",
                ),
              ),
            )

          ],
        ):
        Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*1,
              child: _backGroundImg==null?null:Opacity(
                child: Image.file(_backGroundImg,fit: BoxFit.fill,),
                opacity: 0.2,
              ),
            ),
            Container(
              child: Container(

                  child: FutureBuilder(
                      future: getDataFun(),
                      builder: (context,snapShot){
                        if(snapShot.hasData){
                          return ItemImage(list: snapShot.data,);
                        }else if(snapShot.hasError){
                          return Center(
                            child: Text("${snapShot.error}"),
                          );
                        }else{
                          return Center(
                            child:CircularProgressIndicator(),
                          );
                        }

                      })
              ),
            ),

          ],
        ),

    );
  }
}

class ItemImage extends StatefulWidget{
  final List<modalItem> list;

  const ItemImage({Key key, this.list}) : super(key: key);
  @override
  StateItemImage createState()=> StateItemImage(list);
}

class StateItemImage extends State<ItemImage>{

  final List<modalItem> list;
   bool b=true;

  StateItemImage(this.list);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,position){




      return Container(

        child:  list[position].image.isNotEmpty?Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.asset(list[position].image),
              ),
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.2,

            ),
            Text(list[position].text,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(""),
                Text(list[position].time),
              ],
            )
          ],
        ) :  Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topRight,
              child:  Text(list[position].text,textAlign: TextAlign.right,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(""),
                Text(list[position].time),
              ],
            )
          ],
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(

            border: Border.all(width: 1,color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),

      );
    });
  }

}

class modalItem{
  final String id;
  final String image;
  final String text;
  final String time;

  modalItem({this.id, this.image, this.text, this.time});


  factory modalItem.fromJson(Map<String,dynamic> json){



    return modalItem(
      id:json["id"],
      image:json["image"],
      text:json["text"],
      time:json["time"],

    );
  }
}

Future<List<modalItem>> getDataFun() async{

  var data=[{
    "id":"1",
    "image":"images/morgan.jpg",
    "text":"hello im morgan",
    "time":"10:00",
  },
    {
      "id":"1",
      "image":"",
      "text":"hello im morgan",
      "time":"20:0",
    },
    {
      "id":"1",
      "image":"images/morgan.jpg",
      "text":"hello im morgan",
      "time":"30:00",
    },
    {
      "id":"1",
      "image":"images/chogha.jpg",
      "text":"hello chogha",
      "time":"40:00",
    }];

  final response=await http.get("http://sobhanm28.ir/divar/readall.php");
  if(response.statusCode==200){
    var responseJson=json.decode(response.body);
    var rest=responseJson as List;
    var list=data.map((json)=>modalItem.fromJson(json)).toList();
    return list;
  }else throw Exception("Error in getDataFun");
}