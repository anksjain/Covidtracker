import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapilogin/Animation/FadeAnimation.dart';
import 'package:restapilogin/Screens/Homecreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  static const String routeName = "/start";

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  List<String> colors=["#ffffff","#173480","#ffd863"];
  int _currentpage = 0;
  String name = "";
  PageController _pageController = new PageController(initialPage: 0);
  SharedPreferences preferences;

  setname() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    setname();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentpage = index;
          });
        },
        children: <Widget>[
          page1("assets/page/start1.png", "#ffffff"),
          page1("assets/page/page2.png", "#173480"),
          page1("assets/page/page3.jpg", "#ffd863"),
          finalPage(),
        ],
      ),
      bottomSheet: _currentpage == 3
          ? GestureDetector(
        onTap: () {
          if (name == null || !name.contains(new RegExp(r'[A-Za-z]'))) {
            return null;
          } else {
            preferences.setString("name", this.name);
            Navigator.pushNamedAndRemoveUntil(
                context, Home.RouteName, (Route<dynamic> route) => false);
          }
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Color.fromRGBO(58, 66, 190, 1.0),
          child: Text(
            "Get Started ",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                wordSpacing: 2.0,
                color: Colors.white),
          ),
        ),
      )
          : Container(
        color: Color(int.parse(colors[_currentpage].replaceAll('#', '0xff'))),
        height: 50,
        //color: Colors.cyan,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Text(
                "Next",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                _pageController.animateToPage(_currentpage + 1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOutCirc);
              },
            ),
            Row(
              children: <Widget>[
                for (int i = 0; i < 4; i++)
                  i == _currentpage ? indicator(true) : indicator(false)
              ],
            ),
            GestureDetector(

              child: Text(
                "Skip",
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                _pageController.animateToPage(3,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.fastLinearToSlowEaseIn);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget indicator(bool focu) {
    return Container(
      margin: EdgeInsets.all(3),
      height: focu ? 15.0 : 8.0,
      width: focu ? 15.0 : 8.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: focu ? Colors.deepPurple : Colors.white70),
    );
  }

  page1(String image, String color) {
    return Scaffold(
        backgroundColor: Color(int.parse(color.replaceAll('#', '0xff'))),
        body: Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                image,
              ),
            ),
          ],
        ));
  }

  finalPage() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(58, 66, 150, 1.0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FadeAnimation(0.5, Text("Hello",style: TextStyle(fontSize: 40,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold,color: Colors.white),)),
          FadeAnimation(3.5,
             Card(
              color: Color.fromRGBO(58, 66, 190, 1.0),
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Theme(
                data: ThemeData(primaryColor: Colors.black),
                child: TextField(
                  maxLength: 20,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent)
                    ),
                    hintText: "Enter Your Name to Proceed",
                    counterText: "",
                    labelText: "What Can I Call You ?",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal)
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              ),
            ),
          ),
          FadeAnimation(2,
            Container(
              child: Image.asset("assets/welcome.png"),
            ),
          )
        ],
      ),
    );
  }
}


