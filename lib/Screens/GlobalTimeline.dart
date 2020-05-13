import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restapilogin/Models/GlobalData.dart';

class GlobalTimeLine extends StatefulWidget {
  final GlobalData globalData;

  GlobalTimeLine({this.globalData});

  @override
  _GlobalTimeLineState createState() => _GlobalTimeLineState();
}

class _GlobalTimeLineState extends State<GlobalTimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(30, 30, 50, 1.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              expandedHeight: MediaQuery.of(context).size.height/2.5,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Row(children: <Widget>[
                  Text("Global"),
                  Text("Timeline",style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.w700),)
                ],),
                background: Image.asset("assets/covidglobe.png",fit: BoxFit.cover,),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 20,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return CountryTile(
                  global: widget.globalData.global[index + 1],
                );
              }, childCount: widget.globalData.global.length - 1),
            )
          ],
        ),
      ),
    );
  }
}

class CountryTile extends StatelessWidget {
  final Global global;

  CountryTile({this.global});

// static List<String> Datewise = global.date.split("-");
// String month=months[int.parse(global.date.split("-")[1])];
  static List<String> months = [
    "January",
    "Feburary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 5,left: 10,right: 10),
      color: Color.fromRGBO(58, 66, 100, 1.0),
      child: ExpansionTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Day",
              style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),
            ),
            Text(global.date.split("-")[2],
                style: TextStyle(color: Colors.white)),
          ],
        ),
        title: Text("Total cases",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500)),
        children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text("CONFIRMED",style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
              trailing: Text(global.confirmed.toString(),style:TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text("ACTIVE",style:TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
              trailing: Text(global.active.toString(),style:TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),

            ),
            ListTile(
              title: Text("RECOVERED",style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
              trailing: Text(global.recovered.toString(),style:TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold)),

            ),
            ListTile(
              title: Text("DEATHS",style:TextStyle(color: Colors.red[800],fontWeight: FontWeight.bold)),
              trailing: Text(global.deaths.toString(),style:TextStyle(color: Colors.red[800],fontSize: 20,fontWeight: FontWeight.bold)),

            )
          ],
        ),
          ExpansionTile(
            title: Text("New Cases",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text("CONFIRMED",style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                    trailing: Text(global.new_confirmed.toString(),style:TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text("RECOVERED",style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                    trailing: Text(global.new_recovered.toString(),style:TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold)),

                  ),
                  ListTile(
                    title: Text("DEATHS",style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                    trailing: Text(global.new_deaths.toString(),style:TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold)),

                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
