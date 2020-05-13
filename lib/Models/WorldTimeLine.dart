import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';


class WorldTimeline {
  List<DataSets> results;

  WorldTimeline({this.results});

  factory WorldTimeline.fromJson(Map<String, dynamic> json)
  {
    return WorldTimeline(results: parlist(json["results"]));
  }

  static List<DataSets> parlist(json) {
    List<DataSets> list = json.map<DataSets>((u) => DataSets.fromJson(u)).toList();
    return list;
  }
}

class DataSets {
  int total_cases;
  int total_recovered;
  int total_unresolved;
  int total_deaths;
  int total_new_cases_today;
  int total_new_deaths_today;
  int total_active_cases;
  int total_serious_cases;
  int total_affected_countries;

  DataSets({this.total_active_cases,this.total_affected_countries,this.total_cases,this.total_deaths,this.total_new_cases_today,this.total_new_deaths_today,this.total_recovered,this.total_serious_cases,this.total_unresolved});

  factory DataSets.fromJson(Map<String,dynamic> json)
  {
    return DataSets(total_active_cases: json["total_active_cases"],total_affected_countries: json["total_affected_countries"],total_cases: json["total_cases"],total_deaths: json["total_deaths"],total_new_cases_today: json["total_new_cases_today"],total_new_deaths_today: json["total_new_deaths_today"],total_recovered: json["total_recovered"],total_serious_cases: json["total_serious_cases"],total_unresolved: json["total_unresolved"]);
  }
}


class Helper {
  WorldTimeline r= new WorldTimeline();
  Future<WorldTimeline> getlist() async {
    String url="https://api.thevirustracker.com/free-api?global=stats";
    var resp = await http.get(url);
    try {
      if (resp.statusCode==200)
        {
          if(resp.body.startsWith("<br />"))
          {
            int f=resp.body.indexOf("{");
            int l= resp.body.lastIndexOf("}");
            
            String resp1=resp.body.substring(f,l+1);
            print(resp1);
            final json =jsonDecode(resp1);
            r=WorldTimeline.fromJson(json);
            return r;
          }
          print(resp.statusCode);
          final json =jsonDecode(resp.body);
          r=WorldTimeline.fromJson(json);
          return r;
        }
      else
        {
          print("error");
          throw Exception();
        }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

