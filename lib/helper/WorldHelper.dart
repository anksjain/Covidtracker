import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:restapilogin/Models/world.dart';

class WorldHelper{
  WorldData _worldData=new WorldData();
  Future<List<CountryWiseData>> getWorldData() async{
    String URL="https://corona-api.com/countries";
    var response = await http.get(URL);
    try{
      if(response.statusCode==200) {
        print(response.statusCode);
        var json = jsonDecode(response.body);
        _worldData = WorldData.fromJson(json);
        return _worldData.dataList;
      }
      else {
        print("else block");
        throw Exception("Error is occuring");
      }

    }catch(e)
    {
      print("catch");
      throw Exception(e.toString());
    }
//
  //  doiubt what teh error in below
//    await http.get(URL)
//        .then((resp){
//          print(resp.statusCode);
//          if(resp.statusCode==200)
//            {
//              var json = jsonDecode(resp.body);
//              _worldData=WorldData.fromJson(json);
//              return _worldData.dataList;
//            }
//          else
//           throw Exception("Error occurs");
//    }).catchError((e)
//    {
//      throw Exception(e.toString());
//
//    });
  }
}