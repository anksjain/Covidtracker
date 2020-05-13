class GlobalData{
  List<Global>  global;
  GlobalData({this.global});
  factory GlobalData.fromJson(Map<String,dynamic> json)
  {
    return GlobalData(global: parseJson(json["data"]));
  }
  static List<Global> parseJson(json)
  {
    List<Global> list=json.map<Global>((lst)=>Global.fromJson(lst)).toList();
    return list;
  }
}

class Global {
  String updatedAt;
  String date;
  int deaths;
  int confirmed;
  int recovered;
  int active;
  int new_confirmed;
  int new_recovered;
  int new_deaths;
  Global({this.confirmed,this.date,this.active,this.recovered,this.deaths,this.new_confirmed,this.new_deaths,this.new_recovered,this.updatedAt});
  factory Global.fromJson(Map<String,dynamic> json){
    return Global(
      updatedAt: json["updated_at"],
      date: json["date"],
      deaths: json["deaths"],
      confirmed: json["confirmed"],
      recovered: json["recovered"],
      active: json["active"],
      new_recovered: json["new_recovered"],
      new_deaths: json["new_deaths"],
      new_confirmed: json["new_confirmed"],
      
    );
  }
}