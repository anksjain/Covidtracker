import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:restapilogin/Models/covidsummary.dart';
import 'dart:async';
class Covidservice {
  CoronaSummary summary;
  Future<CoronaSummary> fetchSummary() async {
    var resp = await http.get("https://api.covid19api.com/summary");
//    if (resp.statusCode == 200) {
//      final jsonbody = jsonDecode(resp.body);
//      summary = new CoronaSummary.fromJson(jsonbody);
//      return summary;
//         } else
//      print(resp.statusCode);



    try {
      if (resp.statusCode == 200) {
        final jsonbody = jsonDecode(resp.body);
        summary = new CoronaSummary.fromJson(jsonbody);
        return summary;
      } else
        throw Exception("ERRor is occured");
    } catch (e) {
      throw Exception(e.toString());
    }

  }
}
