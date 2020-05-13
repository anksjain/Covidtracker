class WorldData
{
  List<CountryWiseData> dataList;
  WorldData({this.dataList});
  factory WorldData.fromJson(Map<String,dynamic> json)
  {
    return WorldData(dataList:parseJson(json["data"]));
  }
  static List<CountryWiseData> parseJson(json)
  {
    List<CountryWiseData> list=json.map<CountryWiseData>((jsondata)=>CountryWiseData.fromJson(jsondata)).toList();
    return list;
  }

}
class CountryWiseData{
  String name;
  String code;
  //
  int population;
  String updateAt;
  Today today;
  Total total;
  CountryWiseData({this.total,this.today,this.name,this.code,this.population,this.updateAt});
  factory CountryWiseData.fromJson(Map<String,dynamic> json)
  {
    return CountryWiseData(name: json["name"],code: json["code"],population: json["population"] ,updateAt: json["Data"],today: Today.fromJson(json["today"]),total: Total.fromJson(json["latest_data"]));
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