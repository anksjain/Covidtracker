import 'dart:convert';

import 'package:http/http.dart' as http;
class SpecificCountryDetails
{
  SpecificData data;
  SpecificCountryDetails({this.data});
  factory SpecificCountryDetails.fromJson(Map<String,dynamic> json)
  {
    return SpecificCountryDetails(data:SpecificData.fromJson(json["data"]));
  }
  
}
class SpecificData{
  String name;
  String code;
  int population;
  String updateAt;
  Today today;
  Total total;
 List<FullDay> dayWise;
  SpecificData({this.total,this.today,this.name,this.code,this.population,this.updateAt,this.dayWise});
  factory SpecificData.fromJson(Map<String,dynamic> json)
  {
    return SpecificData(name: json["name"],code: json["code"],population: json["population"] ,updateAt: json["updated_at"],today: Today.fromJson(json["today"]),total: Total.fromJson(json["latest_data"]),dayWise: parseList(json["timeline"]));
  }
 static List<FullDay> parseList(json)
  {
    List<FullDay> list=json.map<FullDay>((item)=>FullDay.fromJson(item)).toList();
    return list;
  }

}
class Total {
  int deaths;
  int confirmed;
  int recovered;
  int critical;
  Calculated calculated;
  Total({this.confirmed,this.deaths,this.recovered,this.calculated,this.critical});
  factory Total.fromJson(Map<String,dynamic> json)
  {
    return Total(deaths: json["deaths"],recovered: json["recovered"], confirmed: json["confirmed"],critical: json["critical"],calculated: Calculated.fromJson(json["calculated"]));
  }

}

class Calculated {
  String deathRate;
  String recoveryRate;
  String casePerMillion;
  Calculated({this.deathRate,this.casePerMillion,this.recoveryRate});
  factory Calculated.fromJson(Map<String,dynamic> json)
  {
    return Calculated(deathRate: json["death_rate"].toString(),recoveryRate: json["recovery_rate"].toString(),casePerMillion: json["cases_per_million_population"].toString());
  }

}

class Today{
  int deaths;
  int confirmed;
  Today({this.deaths,this.confirmed});
  factory Today.fromJson(Map<String,dynamic> json)
  {
    return Today(deaths: json["deaths"],confirmed: json["confirmed"]);
  }

}

class FullDay {
  String date;
  int deaths;
  int confirmed;
  int active;
  int recovered;
  int newConfirmed;
  int newRecovered;
  int newDeaths;
  FullDay({this.date,this.deaths,this.confirmed,this.recovered,this.active,this.newConfirmed,this.newRecovered,this.newDeaths});
  factory FullDay.fromJson(Map<String,dynamic> json)
  {
    return FullDay(date:json["date"],deaths: json["deaths"],newDeaths: json["newDeaths"],newRecovered: json["newRecovered"],newConfirmed: json["newConfirmed"],confirmed: json["confirmed"],recovered: json["recovered"],active: json["active"]);
  }
}

class SpecificCountryHelper {

  final String url="https://corona-api.com/countries/";
  SpecificCountryDetails s = new SpecificCountryDetails();
  Future<SpecificCountryDetails> getCountrydata(String countryCode)
  async{
    try{
      var response = await http.get(url+"$countryCode");
      if(response.statusCode==200)
        {
          print("$countryCode"+"response");
          final json = jsonDecode(response.body);
          s=SpecificCountryDetails.fromJson(json);
          return s;
        }
      else
        {
          print(response.statusCode);
          throw Exception();
        }

    }catch(e)
    {
      throw Exception(e.toString());
    }
  }


}