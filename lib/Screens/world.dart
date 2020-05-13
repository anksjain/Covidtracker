import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restapilogin/Models/GlobalData.dart';
import 'package:restapilogin/Models/WorldTimeLine.dart';
import 'package:restapilogin/Screens/GlobalTimeline.dart';
import 'package:restapilogin/helper/GlobelHelper.dart';
import 'package:restapilogin/Screens/Timeline.dart';

class World extends StatefulWidget {
  static const String RouteName = "/World";

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  TabController _tabController;

  //Fetching world data
  GlobalHelper _globalHelper = new GlobalHelper();
  GlobalData globalData = new GlobalData();

  //till fetching is complete
  bool _loading = true;
//
  WorldTimeline r = new WorldTimeline();
  Helper h = new Helper();

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    getGlobalData();
    print("object");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void getGlobalData() async {
    globalData = await _globalHelper.getTimeline();
    r= await h.getlist();
    print("check");
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //  appBar: AppBar(),
      body: _loading
          ? onFetching()
          : TabBarView(
              children: <Widget>[
                // tabView1(),
                TimeLine(
                  globalData: r.results[0],
                ),
                GlobalTimeLine(
                  globalData: globalData,
                ),
              ],
              controller: _tabController,
            ),
      bottomNavigationBar: Container(
        height: 50,
        color: Color.fromRGBO(30, 30, 50, 1.0),
        child: TabBar(
          dragStartBehavior: DragStartBehavior.start,
          unselectedLabelColor: Colors.white,
          //indicatorColor: Colors.white,
          // labelPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          labelColor: Colors.blue,
          controller: _tabController,
          tabs: <Widget>[
            FaIcon(
              Icons.account_balance,
            ),
            Icon(Icons.list),
          ],
        ),
      ),
    );
  }

  onFetching() {
    return Container(
      color: Colors.black,
      child: Center(
        child: LinearProgressIndicator(backgroundColor: Colors.black,),
      ),
    );
  }
}
