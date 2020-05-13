import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:restapilogin/Screens/SpecificCountryTimeline.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login_Auth {
  Future<void> authentication(
      String mailId, String password, BuildContext context) async {
//    int fut;
    String myUrl = "http://192.168.2.211:9000/users/login";
//    var respnse = await  http.post(myUrl, body: ({"email": mailId, "password": password}));
//    if(respnse.statusCode==200)
//      fut=1;
//    else
//      fut=0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    http
        .post(myUrl, body: ({"email": mailId, "password": password}))
        .then((resp) {
      if (resp.statusCode == 200) {
        var jsonData = jsonDecode(resp.body);
        String token = jsonData["token"];
        preferences.setString("token", token);

        Navigator.pushNamedAndRemoveUntil(
            context, SpecificCountryTimeline.routeName, (Route<dynamic> route) => false);
      } else {
        preferences.setString("token", null);
        print(resp.statusCode);
      }
    });
    // print(fut);
    //return fut;
  }
}
