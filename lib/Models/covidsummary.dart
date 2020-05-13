import 'dart:convert';

import 'package:http/http.dart' as http;

class CoronaSummary {
  global Global;
  List<country> Countries;

  CoronaSummary({this.Global, this.Countries});

  factory CoronaSummary.fromJson(Map<String, dynamic> json) {
    return CoronaSummary(
        Global: global.fromJson(json["Global"]),
        Countries: paresCountry(json["Countries"]));
  }

  static List<country> paresCountry(json) {
    var list = json as List;
    List<country> list1 = list.map((data) => country.fromJson(data)).toList();
    return list1;
  }
}

class global {
  int NewConfirmed;
  int TotalConfirmed;
  int NewDeaths;
  int TotalDeaths;
  int NewRecovered;
  int TotalRecovered;

  global(
      {this.NewConfirmed,
      this.TotalConfirmed,
      this.NewDeaths,
      this.TotalDeaths,
      this.NewRecovered,
      this.TotalRecovered});

  factory global.fromJson(Map<String, dynamic> json) {
    return global(
        NewConfirmed: json["NewConfirmed"],
        NewDeaths: json["NewDeaths"],
        TotalDeaths: json["TotalDeaths"],
        NewRecovered: json["NewRecovered"],
        TotalConfirmed: json["TotalConfirmed"],
        TotalRecovered: json["TotalRecovered"]);
  }
}

class country {
  String Country;
  String CountryCode;
  int NewConfirmed;
  int TotalConfirmed;
  int NewDeaths;
  int TotalDeaths;
  int NewRecovered;
  int TotalRecovered;

  country(
      {this.Country,
      this.CountryCode,
      this.NewConfirmed,
      this.TotalConfirmed,
      this.NewDeaths,
      this.TotalDeaths,
      this.NewRecovered,
      this.TotalRecovered});

  factory country.fromJson(Map<String, dynamic> json) {
    return country(
        Country: json["Country"],
        NewConfirmed: json["NewConfirmed"],
        NewDeaths: json["NewDeaths"],
        TotalDeaths: json["TotalDeaths"],
        NewRecovered: json["NewRecovered"],
        TotalConfirmed: json["TotalConfirmed"],
        TotalRecovered: json["TotalRecovered"],
        CountryCode: json["CountryCode"]);
  }
}
