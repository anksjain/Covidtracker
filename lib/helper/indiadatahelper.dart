import 'package:restapilogin/Models/indiastate.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class IndiaHelper{
  //List<statewise> statedata = new List<statewise>();
  IndiaData indiaData = new IndiaData();
  Future<IndiaData> getStateWiseData() async{
    String URL ="https://api.covid19india.org/data.json";
    try {
      var response = await http.get(URL);
      if (response.statusCode == 200) {

        final jsonbody = jsonDecode(response.body);
        indiaData = IndiaData.fromJson(jsonbody);
        print(response.statusCode);
        return indiaData;
      }
      else
        throw Exception("Error is Occured");
    }catch(e)
    {
      throw Exception(e.toString());
    }


  }
}