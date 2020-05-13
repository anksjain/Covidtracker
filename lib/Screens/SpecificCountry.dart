import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapilogin/Animation/FadeAnimation.dart';
import 'package:restapilogin/Models/Specificcountry.dart';
import 'package:restapilogin/Screens/SpecificCountryTimeline.dart';

class SpecificCountry extends StatefulWidget {
  static const String routeName = "/specific";
  final String code;

  SpecificCountry({this.code});

  @override
  _SpecificCountryState createState() => _SpecificCountryState();
}

class _SpecificCountryState extends State<SpecificCountry> with SingleTickerProviderStateMixin{
  SpecificCountryDetails country = new SpecificCountryDetails();
  SpecificCountryHelper helper = new SpecificCountryHelper();
  //
  bool _loading=false;
  getDetails()
  async{
    country=await helper.getCountrydata(widget.code);
    setState(() {
      _loading=true;
    });
  }
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    getDetails();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading?TabBarView(
        controller: _tabController,
        children: <Widget>[
          bodyData(),
          SpecificCountryTimeline(fullDay: country.data.dayWise,)
        ],
      ):Center(
              child: LinearProgressIndicator(),
            ),
bottomNavigationBar: Container(
  height: 0,
  color: Color.fromRGBO(58, 66, 86, 1.0),
  child: TabBar(
   // dragStartBehavior: DragStartBehavior.start,
    unselectedLabelColor: Colors.white,
    indicatorColor: Colors.blue[200],
    indicatorWeight: 2,
    // labelPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    labelColor: Colors.blue,
    controller: _tabController,
    tabs: <Widget>[
      Icon(
        Icons.print,
      ),
      Icon(Icons.list),
    ],
  ),
),

    );
  }

  Total() {
    return Card(
      color: Colors.white38,
      elevation: 20,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Total cases",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Box1("Confirmed"),
                Box2(country.data.total.confirmed.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Box1("Criticals"),
                Box2(country.data.total.critical.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Box1("Recovered"),
                Box2(country.data.total.recovered.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Box1("Deaths"),
                Box2(country.data.total.deaths.toString())
              ],
            )
          ],
        ),
      ),
    );
  }

  Total1() {
    return Card(
      color: Colors.white38,
      elevation: 20,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Today",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Box1("Deaths"),
                Box2(country.data.today.deaths.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Box1("Confirmed"),
                Box2(country.data.today.confirmed.toString())
              ],
            ),
          ],
        ),
      ),
    );
  }

  name() {
    return Flexible(
      child: Container(
        child: FadeAnimation(4,
           Text(
            country.data.name,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Box1(String item) {
    return Container(
      child: Text(item,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
    );
  }

  Box2(String item) {
    return Container(
      child: Text(item,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
    );
  }

  bodyData() {
    List<String> date = country.data.updateAt.split("-");
    List<String> value = date[2].split(":");
    String time = value[0].substring(3) + ":" + value[1];
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Color.fromRGBO(58, 66, 140, 1.0),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.black87,
              ),
            )
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 2 / 5 - 225,

            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //FadeAnimation(1, Text("Covid",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))),
                  FadeAnimation(1, Text("Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))),
                  FadeAnimation(2,Text("Line",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.yellow))),

                ],
              ),
            ),

          ),
        Positioned(
          top: MediaQuery.of(context).size.height * 2 / 5 - 150,
          child: FadeAnimation(3,
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: MediaQuery.of(context).size.width - 60,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height * 2 / 5 - 150),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.mirror,
                      colors: [Colors.blue[900], Colors.red,Colors.cyan]),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[name()],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Box1("UpdateAt"),
                            Box2(time),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Box1("Country Code"),
                            Box2(country.data.code.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Box1("Population"),
                            Box2(country.data.population.toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Box1("Cases Per Million"),
                            Box2(country.data.total.calculated.casePerMillion),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Box1("Recovery rate"),
                            Box2(country.data.total.calculated.recoveryRate ==
                                    "null"
                                ? "-"
                                : country.data.total.calculated.recoveryRate
                                    .substring(0, 4)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Box1("Death rate"),
                            Box1(country.data.total.calculated.deathRate == "null"
                                ? "-"
                                : country.data.total.calculated.deathRate
                                    .substring(0, 4)),
                          ],
                        )
                      ],
                    ),
                    Total(),
                    Total1()
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
//      body: FutureBuilder(
//        future: helper.getCountrydata(widget.code),
//        builder: (BuildContext context,
//            AsyncSnapshot<SpecificCountryDetails> snapshot) {
//          if (snapshot.connectionState == ConnectionState.done) {
//            country = snapshot.data;
//            return Container(child: bodyData());
//          } else
//            return Center(
//              child: LinearProgressIndicator(),
//            );
//        },
//      ),