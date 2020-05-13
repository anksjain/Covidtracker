import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapilogin/Screens/CountryList.dart';
import 'package:restapilogin/Screens/GlobalTimeline.dart';

import 'package:restapilogin/Screens/Homecreen.dart';
import 'package:restapilogin/Screens/India.dart';
import 'package:restapilogin/Screens/SpecificCountry.dart';
import 'package:restapilogin/Screens/SplashScreen.dart';
import 'package:restapilogin/Screens/faq.dart';
import 'package:restapilogin/Screens/start.dart';
import 'package:restapilogin/Screens/statedetail.dart';
import 'package:restapilogin/Screens/world.dart';
import 'package:restapilogin/Screens/Timeline.dart';
import 'package:restapilogin/Screens/world.dart';

import 'Screens/SpecificCountryTimeline.dart';

void main() => runApp(MyNewApp());

class MyNewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.indigo,
          appBarTheme: AppBarTheme(color: Color.fromRGBO(58, 66, 140, 1.0)),
          brightness: Brightness.light),
      routes: <String, WidgetBuilder>{
        //  SplashScreen.routeName: (context) => SplashScreen(),
        StartScreen.routeName:(context)=>StartScreen(),
        CountryList.routeName: (context) => CountryList(),
        FAQ.routeName:(context)=>FAQ(),
        Home.RouteName: (context) => Home(),
        StartScreen.routeName: (context) => StartScreen(),
        India.routeName: (context) => India(),
        World.RouteName: (context) => World(),
        SpecificCountryTimeline.routeName:(context)=>SpecificCountryTimeline(),
      },
      onGenerateRoute: (RouteSettings settings) {
        var page;
        String routeName = settings.name;
        switch (routeName) {
          case SpecificCountry.routeName:
            page = SpecificCountry(
              code: settings.arguments,
            );
            return MaterialPageRoute(builder: (context) => page);
//            break;
//          case Page.RouteName:
//            page = Page(
//              //title: settings.arguments,
//            );
//            return MaterialPageRoute(builder: (context) => page);
//            break;
        }
       // return MaterialPageRoute(builder: (context) => page);
           },
     // initialRoute: SplashScreen(),
      home: SplashScreen()
    );
  }
}
