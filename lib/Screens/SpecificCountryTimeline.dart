import 'package:flutter/material.dart';
import 'package:restapilogin/Models/Specificcountry.dart';

class SpecificCountryTimeline extends StatelessWidget {
  final List<FullDay> fullDay;

  SpecificCountryTimeline({this.fullDay});

  static const String routeName = "/specificCountryTimeline";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
//        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            child: timeLineList(),
          ),
        ));
  }

  timeLineList() {
    return Container(
      child: ListView.builder(
          itemCount: fullDay.length,
          itemBuilder: (context, index) {
            return tile(index);
          }),
    );
  }

  tile(int index) {
     List<String> months = [
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
    return Card(
        elevation: 10,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(64, 80, 125, 10)),
          child: ExpansionTile(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text("CONFIRMED",style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                    trailing: Text(fullDay[index].confirmed.toString(),style:TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text("ACTIVE",style:TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                    trailing: Text(fullDay[index].active.toString(),style:TextStyle(color: Colors.deepOrange,fontSize: 20,fontWeight: FontWeight.bold)),

                  ),
                  ListTile(
                    title: Text("RECOVERED",style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                    trailing: Text(fullDay[index].recovered.toString(),style:TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold)),

                  ),
                  ListTile(
                    title: Text("DEATHS",style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                    trailing: Text(fullDay[index].deaths.toString(),style:TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold)),

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
                        trailing: Text(fullDay[index].newConfirmed.toString(),style:TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.bold)),
                      ),
                      ListTile(
                        title: Text("RECOVERED",style:TextStyle(color: Colors.green,fontWeight: FontWeight.bold)),
                        trailing: Text(fullDay[index].newRecovered.toString(),style:TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold)),

                      ),
                      ListTile(
                        title: Text("DEATHS",style:TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                        trailing: Text(fullDay[index].newDeaths.toString(),style:TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold)),

                      )
                    ],
                  ),
                ],
              )
            ],
              leading: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.white24)
                  )
                ),
                child: Container(
                  height: 40,
                 width: 40,
                 alignment: Alignment.center,
                 // padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle
                  ), child: Text(fullDay[index].date.split("-")[2])
                ),
              ),
              title: Text(
                months[int.parse(fullDay[index].date.split("-")[1])-1],
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.linear_scale, color: Colors.yellowAccent),
                ],
              ),
              trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
        ));
  }
}
