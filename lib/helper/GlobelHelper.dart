import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:restapilogin/Models/GlobalData.dart';

class GlobalHelper {
  String URL = "https://corona-api.com/timeline";
  GlobalData globalData;

  Future<GlobalData> getTimeline() async {
    var Response = await http.get(URL);
    try {
      if (Response.statusCode == 200) {
        print(Response.statusCode);

        final json = jsonDecode(Response.body);
        globalData = GlobalData.fromJson(json);
        print("Global data");
        return globalData;
      } else {
        print("else error");
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
