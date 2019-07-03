


import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.80,
      child: Drawer(
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      image: AssetImage("images/chogha.jpg"), fit: BoxFit.fill),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Text(
                            "صفحه اصلی",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Icon(
                            Icons.supervised_user_circle,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Text(
                            "انتخابات مجلس",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Icon(
                            Icons.thumbs_up_down,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Text(
                            "نظرسنجی",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Icon(
                            Icons.wallpaper,
                            color: Colors.blue,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
                          child: Text(
                            "آگهی های فوری",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.lightBlue[200],
                        Colors.blue,
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}

class itemNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          drawer: drawer(),
          appBar: AppBar(
              shape: UnderlineInputBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
              bottom: TabBar(tabs: [
                Tab(
                  text: "بروجرد",
                ),
                Tab(
                  text: "لرستان",
                ),
                Tab(
                  text: "ایران و جهان",
                ),
              ]),
              centerTitle: true,
              elevation: 10,
              title: Text("خبرها")),
          body: TabBarView(children: [
            brjNews(),
            lorestanNews(),
            iranNews(),
          ])),
    );
  }
}

class brjNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<PostNews>>(
        future: _databrj(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _list2(
              list: snapshot.data,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class _list2 extends StatelessWidget {
  final List<PostNews> list;

  const _list2({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, position) => Hero(
          tag: list[position].title,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => detailNews(
                        keyItem: list[position].title,
                        img:list[position].image ,
                        desc: list[position].desc,
                        arthur: list[position].author ,
                        date:  list[position].date,
                      )));
            },
            child: Container(
              padding: EdgeInsets.only(top: 5),
              width: 320,
              height: 80,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(
                          list[position].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(80)),
                          color: Colors.red,
                          border: Border.all(width: 1)),
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            list[position].title,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                list[position].date,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(list[position].author,
                                  style: TextStyle(color: Colors.grey)),
                              Text(list[position].category,
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Widget brjItem() {
  return Container(
    padding: EdgeInsets.only(top: 5),
    width: 320,
    height: 80,
    child: Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "titleNews",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "data",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text("arthor", style: TextStyle(color: Colors.grey)),
                    Text("category", style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            height: 80,
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(80)),
                border: Border.all(width: 1)),
          ),
        ],
      ),
    ),
  );
}

class lorestanNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<PostNews>>(
        future: _dataLorestan(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _list2(
              list: snapshot.data,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class iranNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<PostNews>>(
        future: _dataIran(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _list2(
              list: snapshot.data,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class PostNews {
  final String id;
  final String title;
  final String image;
  final String category;
  final String desc;
  final String date;
  final String author;

  PostNews(
      {this.id, this.title, this.image, this.category,this.desc,this.date, this.author});

  factory PostNews.fromJson(Map<String, dynamic> json) {
    return PostNews(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      category: json["category"],
      desc: json["desc"],
      date: json["date"],
      author: json["author"],
    );
  }
}

Future<List<PostNews>> _databrj() async {
  var dataNews = [
    {
      "id": "id",
      "title": "قایقرانی در بروجرد",
      "image": "images/b1.jpg",
      "category": "ورزشی",
      "desc": "قایقرانی در بروجرد برای بانوان و آقایان در دریاچه فدک استارت خود\n اولین جلسه تمرینی 9 تیر 98",
      "date": "98/04/09",
      "author": "سبحان"
    },
    {
      "id": "id",
      "title": "روز جهانی مبارزه با مواد مخدر",
      "image": "images/b2.jpg",
      "category": "ورزشی",
      "desc": "باستانی کاران بروجردی روز جهانی مبارزه با مواد مخدر را گرامی داشتند",
      "date": "98/04/08",
      "author": "سبحان"
    },
    {
      "id": "id",
      "title": "اینستکس انتظارات ایران را برآورده نمیکند",
      "image": "images/b3.jpg",
      "category": "سیاسی",
      "desc": "بروجردی : اگر اروپایی ها به دلیل ترس از آمریکا یا نا توان در عمل به قانون بین المللی به تعهدات خود عمل نکنند باید منتظر اقدامات ایران در کاهش تعهدات باشند و اگر انتظاری غیر از این دارند باید عمل را جایگزین حرف کنند.",
      "date": "98/04/08",
      "author": "سبحان"
    },
  ];

  final response = await http.get("http://sobhanm28.ir/divar/readall.php");

  if (response.statusCode == 200) {
    var jsonresponse = json.decode(response.body);
    var list = jsonresponse as List;
    var rest = dataNews.map((json) => PostNews.fromJson(json)).toList();

    return rest;
  } else
    throw Exception("fuck of bith men");
}

Future<List<PostNews>> _dataLorestan() async {
  var dataNews = [
    {
      "id": "id",
      "title": "غرق شدن جوان 27 ساله در بیشه",
      "image": "images/l1.jpg",
      "desc": "روز گذشته یک جوان حدود 27 ساله اهل همدان که با دوستان خود برای تفریح به آبشار بیشه آمده بود به دلیل مسلط نبودن به فنون شنا و شدت بالای جریان آب در رودخانه غرق شد و جان خود را از دست داد",
      "category": "حوادث",
      "date": "98/04/05",
      "author": "علی"
    },
    {
      "id": "id",
      "title": "آتش سوزی با یک نخ سیگار",
      "image": "images/l2.jpg",
      "desc": "تصویری از کشت زار های در حال سوختن گندم در روستای قشلاق و تلاش مردم و آتش نشانان برای خاموش کردن آن",
      "category": "حوادث",
      "date": "98/04/05",
      "author": "علی"
    },
  ];

  final response = await http.get("http://sobhanm28.ir/divar/readall.php");

  if (response.statusCode == 200) {
    var jsonresponse = json.decode(response.body);
    var list = jsonresponse as List;
    var rest = dataNews.map((json) => PostNews.fromJson(json)).toList();

    return rest;
  } else
    throw Exception("fuck of bith men");
}

Future<List<PostNews>> _dataIran() async {
  var dataNews = [
    {
      "id": "id",
      "title": "همسر حاکم دبی گریخت",
      "image": "images/i1.jpg",
      "desc": "پایگاه خبری دیلی بیست آمریکا جمعه در مطلبی به نقل از منابع اختصاصی خود فرار شاهزاده هیا خواهر پادشاه اردن و زن بن راشد آل مکتومحاکم امارت دبی امارات متحد عربی را تایید کرد",
      "category": "سیاسی",
      "date": "98/04/07",
      "author": "سبحان"
    },
    {
      "id": "id",
      "title": "دیدار پوتین و بن سلمان",
      "image": "images/i2.jpg",
      "desc": "desc",
      "category": "سیاسی",
      "date": "98/04/06",
      "author": "سبحان"
    },
    {
      "id": "id",
      "title": "بولتون دلیلی ندارد ایران غنی سازی خود را افزایش دهد",
      "image": "images/i3.jpg",
      "desc": "مشاور امنیت ملی آمریکا با اعتراض به اقدام ایران در افزایش ذخایر اورانیوم غنی سازی شده در پیامی در توئیتر نوشت که دلیلی ندارد ایران غنی‌سازی خود را افزایش دهد مگر آنکه به دنبال سلاح هسته‌ای باشد.",
      "category": "سیاسی",
      "date": "98/04/06",
      "author": "سبحان"
    },
    {
      "id": "id",
      "title": "ترامپ:ایران با آتش بازی می کند",
      "image": "images/i4.jpg",
      "desc": "رئیس جمهور آمریکا در واکنش به گزارش‌ها مبنی بر عبور ایران از سقف ذخایر اورانیوم غنی شده گفت که ایران در حال بازی با آتش است.",
      "category": "سیاسی",
      "date": "98/04/06",
      "author": "سبحان"
    },
  ];

  final response = await http.get("http://sobhanm28.ir/divar/readall.php");

  if (response.statusCode == 200) {
    var jsonresponse = json.decode(response.body);
    var list = jsonresponse as List;
    var rest = dataNews.map((json) => PostNews.fromJson(json)).toList();

    return rest;
  } else
    throw Exception("fuck of bith men");
}

class detailNews extends StatelessWidget {
  final String keyItem;
  final String img;
  final String desc;
  final String date;
  final String arthur;

  const detailNews({Key key, this.keyItem, this.img, this.desc,this.date, this.arthur}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        elevation: 30,
        child: Icon(Icons.comment),
      ),
      appBar: AppBar(
        elevation: 10,
        title: Text(keyItem),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: keyItem,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)),
              child: Image.asset(img),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*1,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    topLeft: Radius.circular(50))),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                   keyItem,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        date,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text("", style: TextStyle(color: Colors.grey)),
                      Text(arthur, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                   desc,

                    textAlign: TextAlign.center,
                    style: TextStyle(letterSpacing: 1, height: 1.5,fontSize: 18),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
