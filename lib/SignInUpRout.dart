import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class signIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return signInState();
  }
}

class signInState extends State<signIn> {
  String _userName;
  String _password;
  var _errorPhone;
  var _errorPass;
  final phoneReg=RegExp(r'^09{11}');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: Builder(builder: (context) {
      return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
                Colors.blue[200],
                Colors.blue[600],
                Colors.blue[900],
              ])
          ),
          child: Stack(
            children: <Widget>[
              Opacity(
            child: Image.asset("images/brjSign.jpg",

            ),
            opacity: 0.2,
          ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "ورود",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: TextField(
                          textAlign: TextAlign.center,
//              maxLength: 11,
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "09xxxxxxxxx",
                              labelText: "شماره همراه",
                              errorText: _errorPhone),
                          onChanged: (userName) {
                            setState(() {
                              _userName = userName;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: Colors.grey, width: 2)),
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: "رمزعبور",
                              errorText: _errorPass),
                          onChanged: (password) {
                            setState(() {
                              _password = password;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _errorPhone = null;
                            _errorPass = null;
                          });

                          if (_userName==null) {
                            setState(() {

                              _errorPhone = "شماره تماس نمیتواند خالی بماند";
                            });
                          }

                          else if (_password==null) {

                            print(_errorPass);
                            setState(() {

                              _errorPass =
                              "رمز عبور نمی تواند کمتر از 4 عدد باشد";
                            });
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text("ارسال مقادیر به سرور")));
                          }
                        },
                        color: Colors.transparent,
                        child: Text(
                          "ورود",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => signUp()));
                        },
                        color: Colors.transparent,
                        child: Text(
                          "هنوز ثبت نام نکردی؟",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ));
    }));
  }
}

class signUp extends StatefulWidget {
  @override
 signUpState createState()=>signUpState();
}

class signUpState extends State<signUp> {
  String _name;
  String _phone ;
  var _password ;
  var _RepPassword ;
  var _errorName ;
  var _errorPhone ;
  var _errorPassword ;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Builder(builder: (context) {
      return ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*1,
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter,end: Alignment.bottomCenter,colors: [
              Colors.blue[200],
              Colors.blue[600],
              Colors.blue[900],
            ])),
            child: Stack(
              children: <Widget>[
                Opacity(
                  child: Image.asset("images/chogha.jpg",

                  ),
                  opacity: 0.2,
                ),


                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "ثبت نام",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: Colors.grey, width: 2)),
                            child: TextField(
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: "نام و نام خانوادگی",
                                  errorText: _errorName),
                              onChanged: (name) {
                                setState(() {
                                  _name = name;
                                });
                              },
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    border:
                                    Border.all(color: Colors.grey, width: 2)),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "09xxxxxxxxx",
                                      labelText: "شماره همراه",
                                      errorText: _errorPhone),
                                  onChanged: (phone) {
                                    setState(() {
                                      _phone = phone;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    border:
                                    Border.all(color: Colors.grey, width: 2)),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "رمزعبور",
                                      errorText: _errorPassword),
                                  onChanged: (password) {
                                    setState(() {
                                      _password = password;
                                    });
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    border:
                                    Border.all(color: Colors.grey, width: 2)),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      hintStyle: TextStyle(color: Colors.grey),
                                      hintText: "تکرار رمز عبور"),
                                  onChanged: (repPass) {
                                    setState(() {
                                      _RepPassword = repPass;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {

                                  bool regex= RegExp(r'^09\d{9}$').hasMatch(_phone);
                                  print(regex);

                                  setState(() {
                                    _errorPhone = null;
                                    _errorPassword = null;
                                    _errorName=null;
                                  });

                                  if(_name==null){
                                    setState(() {
                                      _errorName="لطفا نام خود را وارد کنید";
                                    });
                                  }

                                 else if(!regex){
                                    setState(() {
                                      _errorPhone="شماره تلفن صحیح نمی باشد";

                                    });

                                  }

                                  else if (_phone==null) {

                                    setState(() {
                                      _errorPhone =
                                      "شماره تماس نمیتواند خالی بماند";
                                    });
                                  }else if (_password != _RepPassword)
                                  {
                                    setState(() {
                                      _errorPassword =
                                      "رمز های عبور باهم مطابقت ندارند";
                                    });
                                  } else if (_password.length < 4) {
                                    setState(() {
                                      _errorPassword = "رمز عبور بیش از 4 حرف باشد";
                                    });
                                  } else {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("ارسال مقادیر به سرور")));
                                  }
                                },
                                color: Colors.transparent,
                                child: Text(
                                  "ثبت نام",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ]),
              ],
            )
          )
        ],
      );
    }));
  }
}
