import 'dart:convert';

import 'package:restapilogin/Models/Districtdata.dart';
import 'package:http/http.dart' as http;

class Districthelper{
 //DistrictData districtData= new DistrictData();
  Future<List<StateDistrict>> getDistricts() async{
    String URL="https://api.covid19india.org/v2/state_district_wise.json";
   var response=await http.get(URL);
   try{
     if(response.statusCode==200)
       {
         //way 2 use class and use this for below
        print(response.statusCode);
        print("District");
//         var json = jsonDecode(response.body);
//         districtData=DistrictData.fomJson(json);
//         return districtData.States;


     //way 1
         List<StateDistrict> list= getdis(response.body);
         return list;

       }
     else
       throw Exception("error happen");
   }catch(e) {
     throw Exception(e.toString());
   }

  }
}

//this is one way(1)
//Use this method to get list of statedistrict or use class
    List<StateDistrict> getdis(String resp) {
      final parsed = jsonDecode(resp).cast<Map<String, dynamic>>();
      return parsed.map<StateDistrict>((data) => StateDistrict.fomJson(data))
          .toList();
    }