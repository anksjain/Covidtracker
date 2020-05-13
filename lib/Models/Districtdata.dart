import 'package:flutter/foundation.dart';


//way 2 method get arrya of StateDusrtict in class district data and use it
//class DistrictData{
//  List<StateDistrict> States;
//  DistrictData({this.States});
//  factory DistrictData.fomJson(List<dynamic> json)
//  {
//    return DistrictData(States:parseJson(json));
//  }
//  static List<StateDistrict> parseJson(json)
//  {
//    List<StateDistrict> list = json.map<StateDistrict>((data)=>StateDistrict.fomJson(data)).toList();
//    return list;
//  }
//}

class StateDistrict {
  String state;
  String stateCode;
  List<DistrictArray> districtArray;
  StateDistrict({this.state,this.districtArray,this.stateCode});

  factory StateDistrict.fomJson(Map<String,dynamic> json)
  {
    return StateDistrict(state: json["state"],districtArray:parseJson(json["districtData"]),stateCode: json["statecode"]);
  }

  static List<DistrictArray> parseJson(json)
  {
    List<DistrictArray> list = json.map<DistrictArray>((data)=>DistrictArray.fromJson(data)).toList();
    return list;

  }
}

class DistrictArray {
  String district;
  int active;
  int confirmed;
  int decreased;
  int recovered;
  DeltaData newDeltaData;
  DistrictArray({this.district,this.confirmed,this.recovered,this.decreased,this.newDeltaData,this.active});
  factory DistrictArray.fromJson(Map<String,dynamic> json)
  {
    return(DistrictArray(district: json["district"] ,confirmed: json["confirmed"] ,decreased: json["deceased"] ,recovered: json["recovered"] ,active:json["active"] ,newDeltaData: DeltaData.fromJson(json["delta"])));
  }

}

class DeltaData {
  int newConfirmed;
  int newDecreased;
  String newRecovered;

  DeltaData({this.newConfirmed,this.newDecreased,this.newRecovered});
  factory DeltaData.fromJson(Map <String,dynamic> json)
  {
    return DeltaData(newConfirmed: json["confirmed"] ,newDecreased: json["deceased"] ,newRecovered: json["recovered"].toString() );
  }

}