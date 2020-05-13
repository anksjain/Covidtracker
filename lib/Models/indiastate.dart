
class IndiaData{
  List<StateWise> stateList;
  IndiaData({this.stateList});

  factory IndiaData.fromJson(Map<String,dynamic> json)
  {
    return IndiaData(stateList: parseList(json["statewise"]));
  }

 static List<StateWise> parseList(json){
    //var list = json as List;   if u uncomment it then below step instead of json put list and remove type of map(statewise)
    List<StateWise> statedata = json.map<StateWise>((data)=>StateWise.fromJson(data)).toList();
    return statedata;
  }
}


class StateWise{
  String active;
  String confirmed;
  String deaths;
  String newConfirmed;
  String newDeaths;
  String stateCode;
  String newRecovered;
  String recovered;
  String state;
  
  StateWise({this.active,this.confirmed,this.deaths,this.newConfirmed,this.newDeaths,this.newRecovered,this.recovered,this.state,this.stateCode});
  
  factory StateWise.fromJson(Map<String,dynamic> json)
  {
    return StateWise(active: json["active"],confirmed: json["confirmed"],deaths: json["deaths"],newConfirmed: json["deltaconfirmed"],newRecovered: json["deltarecovered"],newDeaths: json["deltadeaths"],recovered: json["recovered"],stateCode:json["statecode"],state: json["state"]);
  }

}