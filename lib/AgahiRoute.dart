
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;
import 'AgahiLost.dart' as lost;
import 'AgahiNiaz.dart' as niaz;
import 'SignInUpRout.dart' as sign;
import 'package:http/http.dart' as http;
import 'AgahiDead.dart' as dead;




class typeAgahi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("آگهی ها"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>niaz.NiazRoute()));
            },
            child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        "images/help.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: Text("نیازمندی ها",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                        )),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => lost.lostRoute()));
            },
            child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        "images/lost.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: Text("اشخاص و اشیا گمشده",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                        )),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>dead.StateAgahiroute()));
            },
            child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        "images/dead.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Center(
                          child: Text("ترحیم",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        )),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}





