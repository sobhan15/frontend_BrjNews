import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'globals.dart' as globals;
import 'SignInUpRout.dart' as sign;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class StateAgahiroute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return agahiRoute();
  }

}




class agahiRoute extends State<StateAgahiroute>{
  bool b=true;



  Widget appBarTitle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.only(left: 20),
          onPressed: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
        ),
        Text("ترحیم",style: TextStyle(color: Colors.white,fontSize: 20),),
        FlatButton(
          padding: EdgeInsets.only(right: 20),
          onPressed: (){

            ChangeAppbarTitle();

          },
          child: Icon((Icons.search),color: Colors.white,size: 25,),
        )
      ],
    );
  }
  Widget appBarTitle3(List<modalItemDead> list){



    Widget FilterSearch(String query){
      List dummySearchList=List();
      dummySearchList.add(list);
      if(query.isNotEmpty){
        List<modalItemDead> dummtListData=List();
        dummySearchList.forEach((item){
          if(item.contain(query)){
            dummtListData.add(item);
          }
        });
        setState(() {
//          _lista.clear();
//          _lista.addAll(dummtListData);
        });

      }else{
        setState(() {
//          _lista.clear();
//          _lista.addAll(list);
        });
      }
    }

    return FlatButton(
      onPressed: (){
      ChangeAppbarTitle();
      },
      child:  TextField(
        onChanged: (v){
          FilterSearch(v);
        },

        decoration: InputDecoration(
            hintText: "جستجو...",
            prefixIcon: GestureDetector(
              onTap: (){
                ChangeAppbarTitle();
              },
              child: Container(
                child: Icon(Icons.arrow_back,color: Colors.white,),
              ),
            ),
            hintStyle: TextStyle(color: Colors.white,fontSize: 22)
        ),
      ),
    );
  }

void ChangeAppbarTitle(){
    setState(() {
      b=!b;
    });
}


  Widget SearchBar(BuildContext context,List<modalItemDead> list) {
    print("searchBarList :$list");

    return  PreferredSize(child:
    Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(top: 20),
      height: 60,
      width: MediaQuery.of(context).size.width*1,
      child:b? appBarTitle(): appBarTitle3(list),
      decoration: BoxDecoration(color: Colors.black54),
    )
        , preferredSize: Size(0,50));

  }


  @override
  Widget build(BuildContext context) {
    List<modalItemDead> _list;
    return Scaffold(
      appBar: SearchBar(context,_list),
      floatingActionButton: Builder(builder: (context){
       return FloatingActionButton(
         backgroundColor: Colors.black54,
          child: Icon(Icons.add_photo_alternate),
          onPressed:(){
            globals.isLoggedIn?
            Navigator.push(context, MaterialPageRoute(builder: (context)=>addAgahiDead()))
                :
           Scaffold.of(context).showSnackBar(SnackBar(content: Text("برای قرار دادن آکهی ابتدا باید وارد شوید"),
             action: SnackBarAction(label: "ورود", onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>sign.signIn()));
             }),));
          }
        );
      }),

      body:FutureBuilder<List<modalItemDead>>(
          future: getDataItemDead(),
          builder: (context,snapShot){
            if(snapShot.hasData){
//            _list=snapShot.data;
//            print("_ListInFurter: $_list");
              return deadItem(list: snapShot.data,);
            }else if(snapShot.hasError){
              return Center(
                child: Text("${snapShot.error}"),
              );
            }else{

              return Center(
                child: CircularProgressIndicator(backgroundColor: Colors.black,),
              );
            }
          }),

    );
  }

}



class deadItem extends StatelessWidget{

  final List<modalItemDead> list;


  const deadItem({Key key, this.list}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(crossAxisCount: 1,
    children: List.generate(list.length, (position){
      return Card(
        elevation: 5,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5),
              child: Image.asset(list[position].image
              ,fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width*1,
                height: MediaQuery.of(context).size.height*1,),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*0.1,
              decoration: BoxDecoration(color: Colors.black87),
              child: Text(list[position].name,style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      );
    }),);
  }

}

class addAgahiDead extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return addAgahiDeadState();
  }
}

class addAgahiDeadState extends State<addAgahiDead> {
  File image;
  String _name;
  var _errorName;


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
                        decoration: InputDecoration(labelText: "نام مرحوم",errorText: _errorName),
                        onChanged: (name) {
                          setState(() {
                            _name = name;
                          });
                        },
                      )),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){

                          setState(() {
                            _errorName=null;
                          });


                          if(image==null){
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text("برای مرحوم عکسی انتخاب کنید"),
                              backgroundColor: Colors.blue,));
                          }else if(_name==null){
                            setState(() {
                              _errorName="نامی برای مرحوم انتخاب کنید";
                            });
                          }else{



                            Scaffold.of(context).showSnackBar(SnackBar(content:
                            Text("آگهی شما پس از تایید تا چند ساعت آینده در این قسمت قرار خواهد گرفت"),duration: Duration(seconds: 7),
                              backgroundColor: Colors.grey,action: SnackBarAction(label: "برگشت" ,textColor: Colors.white,onPressed: (){
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

class modalItemDead{
  final String id;
  final String image;
  final String name;

  modalItemDead({this.id, this.image, this.name});

  factory modalItemDead.fromJson(Map<String,dynamic> json){
    return modalItemDead(
      id: json["id"],
      image: json["image"],
      name: json["name"],
    );
  }
}

Future<List<modalItemDead>> getDataItemDead() async{

  var data=[
    {
    "id":"id",
    "image":"images/sergio.jpg",
    "name":"sergio"
  },
    {
      "id":"id",
      "image":"images/morgan.jpg",
      "name":"morgan"
    },
    {
      "id":"id",
      "image":"images/sergio.jpg",
      "name":"sergio"
    },
    {
      "id":"id",
      "image":"images/morgan.jpg",
      "name":"morgan"
    },

  ];

  final response=await http.get("http://sobhanm28.ir/divar/readall.php");
  if(response.statusCode==200){
    var responseJson=json.decode(response.body);
    var rest=responseJson as List;
    var list=data.map((json)=>modalItemDead.fromJson(json)).toList();
    return list;
  }else throw Exception("fuck of bitch men in getdataItemLost");
}