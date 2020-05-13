import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restapilogin/Animation/FadeAnimation.dart';
import 'package:restapilogin/Models/WorldTimeLine.dart';

class TimeLine extends StatefulWidget {
 final DataSets globalData;
  TimeLine({this.globalData});
  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> with TickerProviderStateMixin {
  Animation<double> deathAnimation;
  Animation<double> activeAnimation;
  Animation<double> confirmedAnimation;
  Animation<double> recoveredAnimation;
  AnimationController _controller;

  String deaths="0", active="0", recovered="0", confirm="0";

  @override
  void initState() {
    // TODO: implement initState
    animate();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    recoveredAnimation = Tween<double>(
            begin: 0,
            end: double.parse(widget.globalData.total_recovered.toString()))
        .animate(_controller)
          ..addListener(() {
            setState(() {
              recovered = recoveredAnimation.value.toStringAsFixed(0);
            });
          });
    deathAnimation = Tween<double>(
            begin: 0, end: double.parse(widget.globalData.total_deaths.toString()))
        .animate(_controller)
          ..addListener(() {
            setState(() {
              deaths = deathAnimation.value.toStringAsFixed(0);
            });
          });
    confirmedAnimation = Tween<double>(
            begin: 0,
            end: double.parse(widget.globalData.total_cases.toString()))
        .animate(_controller)
          ..addListener(() {
            setState(() {
              confirm = confirmedAnimation.value.toStringAsFixed(0);
            });
          });
    activeAnimation = Tween<double>(
            begin: 0, end: double.parse(widget.globalData.total_active_cases.toString()))
        .animate(_controller)
          ..addListener(() {
            setState(() {
              active = activeAnimation.value.toStringAsFixed(0);
            });
          });
    _controller.forward();
  }



  @override
  Widget build(BuildContext context) {
   // TextStyle textStyle = Theme.of(context).textTheme.headline;
    //orientation fixed to portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Container(
      color: Color.fromRGBO(30, 30, 50, 1.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child:
//      ListView(
//        shrinkWrap: true,
//        children: <Widget>[
          Column(
        children: <Widget>[
          FadeAnimation(
            1,
            Container(
              margin: EdgeInsets.only(top: 50,bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "World Covid",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "19",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FadeAnimation(2,Text(
                    "Stay Safe, ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                FadeAnimation(2.5,
                  Text(
                    "Stay Home",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            //height: MediaQuery.of(context).size.height-300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
//                width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red,
                            ),
                            height: 150,
                            child: AvatarGlow(
                              endRadius: 90,
                              curve: Curves.elasticInOut,
                              glowColor: Colors.red[900],
                              shape: BoxShape.rectangle,
                              child: Text(
                                "$confirm",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " Confirmed",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.lightGreen,
                            ),
                            height: 150,
                            child: AvatarGlow(
                              endRadius: 90,
                              glowColor: Colors.green[900],
                              curve: Curves.elasticInOut,
                              shape: BoxShape.rectangle,
                              child: Text(
                                "$recovered",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Recovered",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                      )
                    ],
                  ),
                ),
//                  SizedBox(height: 100,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
//                width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pinkAccent,
                            ),
                            height: 150,
                            child: AvatarGlow(
                              endRadius: 90,
                              curve: Curves.elasticInOut,
                              glowColor: Colors.red[900],
                              shape: BoxShape.rectangle,
                              child: Text(
                                "$active",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Active",
                            style: TextStyle(
                                color: Colors.pinkAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.deepPurple,
                            ),
                            height: 150,
                            child: AvatarGlow(
                              endRadius: 90,
                              glowColor: Colors.blue[900],
                              curve: Curves.elasticInOut,
                              shape: BoxShape.rectangle,
                              child: Text(
                                "$deaths",
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Deaths",
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          )
                        ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      // ]),
    ));
  }
}
