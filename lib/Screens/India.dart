import 'dart:async';
import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/widgets.dart';
import 'package:restapilogin/Animation/FadeAnimation.dart';
import 'package:restapilogin/Models/Districtdata.dart';
import 'package:restapilogin/Models/indiastate.dart';
import 'package:restapilogin/Models/statelist.dart';
import 'package:restapilogin/Screens/statedetail.dart';
import 'package:restapilogin/helper/Districthelper.dart';
import 'package:restapilogin/helper/indiadatahelper.dart';
import 'package:pie_chart/pie_chart.dart';

class India extends StatefulWidget {
  static const String routeName = "/india";

  @override
  _IndiaState createState() => _IndiaState();
}

class _IndiaState extends State<India> {
  //for india state data
  IndiaData _indiaData;
  List<StateList> stateList = new List<StateList>();

  Districthelper _districthelper = new Districthelper();
  List<StateDistrict> districtList = new List<StateDistrict>();

//for internal image on tiles
  void getStateList() {
    stateList = getstatelist();
  }

  //for loding json data
  bool _loading = true;
  bool _load = false;

  //this for piechart
  Map<String, double> totalMap = new Map();
  Map<String, double> dailyMap = new Map();

  setTotalData(StateWise s) {
    totalMap.putIfAbsent("Active", () => double.parse(s.active));
    totalMap.putIfAbsent("Confirmed", () => double.parse(s.confirmed));
    totalMap.putIfAbsent("Deaths", () => double.parse(s.deaths));
    totalMap.putIfAbsent("Recovered", () => double.parse(s.recovered));
  }

  setDailyData(StateWise s) {
    dailyMap.putIfAbsent("New Confirm", () => double.parse(s.newConfirmed));
    dailyMap.putIfAbsent("New Death", () => double.parse(s.newDeaths));
    dailyMap.putIfAbsent("New Recovered", () => double.parse(s.newRecovered));
  }

  @override
  void initState() {
    // TODO: implement initState
    getStateList();
    getIndiaData();
    super.initState();
  }

  void getIndiaData() async {
    IndiaHelper _indiaHelper = IndiaHelper();
    _indiaData = await _indiaHelper.getStateWiseData();
    districtList = await _districthelper.getDistricts();
    print("object");
    print(districtList[0].districtArray[0].district);
    // getDistrictData();
    //  print(districtList.length);
    // print("check");
    print(districtList[0].state);
    // Timer(Duration(seconds: 1), () {
    setState(() {
      _loading = false;
      _load = true;
    });
    //  });
    setTotalData(_indiaData.stateList[0]);
    setDailyData(_indiaData.stateList[0]);
  }

  void getDistrictData() async {
    districtList = await _districthelper.getDistricts();
    print("object");
    print(districtList[0].districtArray[0].district);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(body: loadingScreen())
        : BackdropScaffold(
            resizeToAvoidBottomInset: false,
            iconPosition: BackdropIconPosition.action,
            headerHeight: 120,
            animationCurve: Curves.bounceInOut,
            frontLayerBorderRadius:
                BorderRadius.only(topLeft: Radius.circular(150)),
            frontLayer: frontLayer(),
            backLayer: _load
                ? backLayer()
                : Container(
                    color: Color.fromRGBO(58, 66, 140, 1.0),
                    alignment: Alignment.topCenter,
                    child: Text(""),
                  ));
  }

  loadingScreen() {
    return Container(
     color:Colors.black ,
      child: Center(child: CircularProgressIndicator(backgroundColor: Colors.yellow,),),
    );
  }

  Widget liveIcon() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 50,
        ),
        Expanded(
//          child: ListView(
//            // shrinkWrap: true,
//            scrollDirection: Axis.horizontal,
//            children: <Widget>[
//              Container(
//                width: MediaQuery.of(context).size.width - 50,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AvatarGlow(
                        glowColor: Colors.yellow,
                        endRadius: 50.0,
                        child: CircleAvatar(
                          radius: 30,
                         backgroundColor:  Color.fromRGBO(58, 66, 150, 1.0),
                         // backgroundColor: Colors.purple,
                          foregroundColor: Colors.yellow,
                          child: Text(_indiaData.stateList[0].newDeaths),
                        ),
                      ),
                      Text(
                        "New",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Deaths ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AvatarGlow(
                        glowColor: Colors.yellow,
                        endRadius: 50.0,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:  Color.fromRGBO(58, 66, 150, 1.0),
                          foregroundColor: Colors.yellow,
                          child: Text(_indiaData.stateList[0].newConfirmed),
                        ),
                      ),
                      Text(
                        "New",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Confirmed",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )
                    ]),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AvatarGlow(
                        glowColor: Colors.yellow,
                        endRadius: 50.0,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:  Color.fromRGBO(58, 66, 150, 1.0),
                          foregroundColor: Colors.yellow,
                          child: Text(_indiaData.stateList[0].newRecovered),
                        ),
                      ),
                      Text(
                        "New",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Recovered ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ]),
                // ]),
              ]),
        ),
//            ],
//            //width: MediaQuery.of(context).size.width - 90,
//          ),
        //)
      ],
    );
  }

  backLayer() {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 140, 1.0),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        // margin: EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                    //height: MediaQuery.of(context).size.height,
                    color:  Color.fromRGBO(58, 66, 140, 1.0),
                    child: Column(
                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
//                        Icon(Icons.keyboard_arrow_down),
                        Text("Pull to refresh"),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: FadeAnimation(0.5,
                                  Text(
                                    "Total Cases",
                                    style: TextStyle(
                                        fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              child: PieChart(
                                animationDuration: Duration(seconds: 1),
                                dataMap: totalMap,
                                chartType: ChartType.ring,
                                chartValueStyle: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w700),
                                legendStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
//
                                showChartValuesInPercentage: false,
                                colorList:  [
                                  Colors.redAccent[100],
                                  Colors.blueAccent[100],
                                  Colors.yellow[100],
                                  Colors.greenAccent
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                //alignment: Alignment.topLeft,
                                child: FadeAnimation(0.5,
                                   Text(
                              "New Cases",
                              style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 20),
                              padding: EdgeInsets.only(left: 20),
                              child: PieChart(
                                chartValueStyle: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.w700),
                                legendStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                                dataMap: dailyMap,
                                chartType: ChartType.ring,
                                showChartValuesInPercentage: true,
                                colorList: [
                                  Colors.redAccent[100],
                                  Colors.blueAccent[100],
                                  Colors.greenAccent
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  frontLayer() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(150)),
          color: Colors.black87
          //color: Color.fromRGBO(30, 40, 60, 10.0),
          ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            SizedBox(
              child: liveIcon(),
              height: 150,
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                    itemCount: stateList.length,
                    itemBuilder: (context, index) {
                      return (StateTile(
                        place: _indiaData.stateList[index + 1].state,
                        stateWise: _indiaData.stateList[index + 1],
                        districtList: districtList,
                      ));
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    setState(() {
      _load = false;
    });
    getIndiaData();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
}

class StateTile extends StatefulWidget {
  final String place;
  final StateWise stateWise;
  final List<StateDistrict> districtList;

  StateTile({this.place, this.stateWise, this.districtList});

  @override
  _StateTileState createState() => _StateTileState();
}

class _StateTileState extends State<StateTile> {
  List<StateList> stateList = getstatelist();
  StateDistrict districtData;
  bool noDistrict = true;
  String image1;

  void getImage() {
    for (int i = 0; i < stateList.length; i++) {
      if (stateList[i].getStateName().toLowerCase() ==
          widget.place.toLowerCase()) {
        image1 = stateList[i].getStateImage();
        break;
      }
    }
  }

  void getDistrictsData() {
    //districtData= widget.districtList.elem
    // districtData =widget.districtList.where((t)=>t.stateCode==(widget.stateWise.stateCode)).cast()<StateDistrict>;
    // print(districtData.stateCode);
    for (int i = 0; i < widget.districtList.length; i++) {
      if (widget.stateWise.stateCode == widget.districtList[i].stateCode) {
        districtData = widget.districtList[i];
        break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getDistrictsData();
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
//              child: Text(
//                widget.place,
//                style: TextStyle(
//                    color: Colors.white,
//                    fontWeight: FontWeight.w500,
//                    fontSize: 20),
//              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(image1))),
            ),
            Positioned.fill(
                child: Material(
              borderRadius: BorderRadius.circular(17),
              color: Colors.black45,
              child: InkWell(
                child: Center(
                  child: Text(
                    widget.place,
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                splashColor:
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StateDetails(
                                image: image1,
                                stateWise: widget.stateWise,
                                district: districtData,
                              )));
                },
                borderRadius: BorderRadius.circular(17),
              ),
            ))
          ],
        ));
  }
}
