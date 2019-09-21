import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class nomineRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("نامزد های انتخابات مجلس"),
      ),
      body: FutureBuilder(
          future: dataItemNomine(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NomineDetail(list: snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class NomineDetail extends StatefulWidget {
  final List<modelNomine> list;

  const NomineDetail({Key key, this.list}) : super(key: key);
  @override
  _listViewNomine createState() => _listViewNomine(list);
}

class StateNomineDetail extends State<NomineDetail> {
  bool visible;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: visible ? 1 : 0,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(color: Colors.blue),
      ),
    );
  }
}

class itemNomine extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final String desc;

  const itemNomine({Key key, this.id, this.image, this.name, this.desc})
      : super(key: key);

  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(10, (index) {
        return Container(
          margin: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.4,
          height: 100,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.asset(
                    'images/man.png',
                    fit: BoxFit.fill,
                  ),
                  Text("Name")
                ],
              )
            ],
          ),
        );
      }),
    );
  }
}

class modelNomine {
  final String id;
  final String image;
  final String name;
  final String desc;
  final String like;
  final String dislike;

  modelNomine({this.id, this.image, this.name, this.desc, this.like, this.dislike});


  factory modelNomine.fromJson(Map<String, dynamic> json) {
    return modelNomine(
      id: json["id"],
      image: json["image"],
      name: json["name"],
      desc: json["desc"],
      like: json["like"],
      dislike: json["dislike"]
    );
  }

}

Future<List<modelNomine>> dataItemNomine() async {
  var data = [
    {
      "id": "id",
      "image": "images/abbas.jpg",
      "name": "عباس گودرزی",
      "desc": "عباس گودرزی متولد ۱۳۵۶ بوده و در رشته دبیری فیزیک تحصیل کرده است. گودرزی مدرک کارشناسی ارشد خود را در رشته علوم سیاسی دریافت کرده و سابقه حضور در شورای اسلامی شهر بروجرد را در کارنامه خود دارد. وی کاندیدای مورد حمایت اصولگرایان و محافظه کاران در شهرستان بروجرد است.",
      "like":"71",
      "dislike": "3",
    },
    {
      "id": "id",
      "image": "images/ala.jpg",
      "name": "علادین بروجردی",
      "desc": "علاءالدین بروجردی زاده ۱۳۲۹ درعراق، نجف یکی از دو نماینده شهرستان بروجرد و اشترینان در مجلس ششم، مجلس هفتم، مجلس هشتم، مجلس نهم و مجلس دهم می‌باشد. نامبرده رئیس کمیسیون امنیت ملی و سیاست خارجی مجلس هشتم، مجلس نهم و دو سال اول مجلس دهم بوده‌است. وی پیش از این سابقه معاونت وزارت امورخارجه در دوران علی اکبر ولایتی را داشته‌است. او ورودی ۱۳۴۹ دانشگاه تبریز است و در سال ۱۳۵۴ در رشته علوم‌آزمایشگاهی فارغ‌التحصیل شده و پس از از تحصیل مسئول آزمایشگاه‌های محراب‌خان در شهر مشهد و سپس هلال احمر دوبی مشغول به کار بوده‌است. او پس از انقلاب همچنان در دبی می‌ماند و کمیته انقلاب اسلامی، شعبه دبی را تشکیل می‌دهد. در اوایل شروع جنگ ایران و عراق نیز وی از دبی تجهیزات پزشکی و آمبولانس به ایران ارسال می‌کرده‌است",
      "like": "35",
      "dislike": "2",
    },


  ];

  final response = await http.get("http://sobhanm28.ir/divar/readall.php");
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    var rest = jsonResponse as List;
    var list = data.map((json) => modelNomine.fromJson(json)).toList();
    return list;
  } else
    throw Exception("fuck fuck fuck in nomineList");
}

class _listViewNomine extends State<NomineDetail> {
  final List<modelNomine> list;
  bool visible = false;
  String name = "name";
  String image = "image";
  String desc = "desc";
  String like = "0";
  String dislike = "0";
  _listViewNomine(this.list);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        GridView.count(
          crossAxisCount: 2,
          children: List.generate(list.length, (index) {
            return Container(
                margin: EdgeInsets.all(5),
                child: GestureDetector(
                    onTap: () {
                      name = list[index].name;
                      image = list[index].image;
                      desc = list[index].desc;
                      like = list[index].like;
                      dislike = list[index].dislike;


                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => cardNomine(
                                  visible: visible,
                                  name: name,
                                  desc: desc,
                                  image: image,
                                  context: context,
                              like: like,
                              dislike: dislike,)));
                    },
                    child: Stack(
                      alignment: Alignment(0, 1.0),
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Hero(
                              tag: list[index].name,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  list[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Text(
                            list[index].name,
                            style: TextStyle(color: Colors.white, fontSize: 19),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(color: Colors.black12),
                        )
                      ],
                    )));
          }),
        ),
      ],
    );
  }
}


class cardNomine extends StatefulWidget{
  final bool visible;
  final String name;
  final String desc;
  final String image;
  final BuildContext context;
  final String like;
  final String dislike;

  const cardNomine({Key key, this.visible, this.name, this.desc, this.image, this.context, this.like, this.dislike}) : super(key: key);


  @override
  StateCardNomine createState()=>StateCardNomine(visible,name,desc,image,context,like,dislike);

}

class StateCardNomine extends State<cardNomine> {
  final bool visible;
  final String name;
  final String desc;
  final String image;
  final BuildContext context;
  String like;
  String dislike;
  bool iconLike=false;
  bool iconDislike=false;

  StateCardNomine(this.visible, this.name, this.desc, this.image, this.context, this.like, this.dislike);



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(" مشخصات آقای $name"),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Hero(
                tag: name,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Image.asset(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.fromLTRB(5, 15, 5, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 GestureDetector(
                  child:  Row(
                    children: <Widget>[
                      Icon(Icons.thumb_up,color: iconLike?Colors.green:null,),
                      Text(
                        like,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700,color: iconLike?Colors.green:null,),
                      ),
                    ],
                  ),
                   onTap: (){
                    if(iconLike==false){
                      int intLike=int.parse(like);
                      intLike++;
                      setState(() {
                        like="$intLike";
                        iconLike=true;
                      });
                    }else{
                      int intLike=int.parse(like);
                      intLike--;
                      setState(() {
                        like="$intLike";
                        iconLike=false;
                      });
                    }
                   },
              ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.thumb_down,color: iconDislike?Colors.red:null,),
                        Text(dislike,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700,color:iconDislike?Colors.red:null, )),
                      ],
                    ),
                    onTap: () {
                      if(iconDislike==false){
                        int intDislike=int.parse(dislike);
                        intDislike++;
                        setState(() {
                          dislike="$intDislike";
                          iconDislike=true;
                        });
                      }else{
                        int intDislike=int.parse(dislike);
                        intDislike--;
                        setState(() {
                          dislike="$intDislike";
                          iconDislike=false;
                        });
                      }

                    },
                  )
                ],
              )),
          Container(
            child: Text(
              desc,
              style: TextStyle(
                  fontSize: 17,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
