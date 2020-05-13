import 'dart:async';
import 'package:location_permissions/location_permissions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:restapilogin/Screens/Homecreen.dart';
import 'package:restapilogin/Screens/start.dart';
import 'package:geolocator/geolocator.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
   SharedPreferences preferences= await SharedPreferences.getInstance();
    String name = preferences.getString("name");
    var _duration = new Duration(seconds:1);
    if(name!=null)
      {
        return new Timer(_duration, navigationPageHome);
      }
    else {
      return new Timer(_duration, navigationPageWel);
    }

  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed(Home.RouteName);
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed(StartScreen.routeName);
  }
  @override
  void initState() {
    // TODO: implement initState
    startTime();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(int.parse("#fefaf9".replaceAll("#", "0xff"))),
        child: Center(
          child: Image.asset("assets/V1.png",width: 200,height: 200,),
        ),
      ),
    );
  }
}
