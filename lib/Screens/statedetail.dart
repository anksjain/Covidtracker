import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' ;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:restapilogin/Models/Districtdata.dart';
import 'package:restapilogin/Models/indiastate.dart';
import 'package:restapilogin/helper/Districthelper.dart';

class StateDetails extends StatefulWidget {
  final String image;
  final StateWise stateWise;
  final StateDistrict district;

  StateDetails({this.image, this.stateWise, this.district});

  @override
  _StateDetailsState createState() => _StateDetailsState();
}

class _StateDetailsState extends State<StateDetails> {
//  DistrictData _districtData=new DistrictData();
//  Districthelper districthelper=new Districthelper();
//  List<StateDistrict> _list;
//
//  void getData()async{
//    _list=await districthelper.getDistricts();
//    print("object");
//    print(_list[0].state);
//
//  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(

                  color: Color.fromRGBO(30, 40, 60, 10.0),
//                  image: DecorationImage(
//                    fit: BoxFit.fill,
//                    image: AssetImage(widget.image),
//                  )
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(widget.stateWise.state,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white
                    ),),
                  ),
                  ring(),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        glowicon()
                      ],
                    ),
                  )


                ],

              ),
            ),
          ),
          widget.district!=null?_draggableScrollableSheet():Container()
        ],
      ),
    );
  }

  DraggableScrollableSheet _draggableScrollableSheet() {
    return DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.2,
        maxChildSize: 0.7,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(

                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.cyan,Color.fromRGBO(10, 20, 30, 10.0)]
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Scrollbar(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.district.districtArray.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(children: <Widget>[
                        (ExpansionTile(
                          leading: Icon(Icons.dashboard),
                          backgroundColor: Colors.black87,
                          // subtitle: Text("index",),
                          title: Text(
                            widget.district.districtArray[index].district,
                            style: TextStyle(fontSize: 20),
                          ),
                          children: <Widget>[
                            Divider(
                              thickness: 1,
                              color: Colors.white,
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ListTile(
                                  leading: Text("Active",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: Text(
                                    widget.district.districtArray[index].active
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ListTile(
                                  leading: Text("Confirmed",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: Text(
                                    widget.district.districtArray[index].confirmed
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ListTile(
                                  leading: Text("Recovered",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: Text(
                                    widget.district.districtArray[index].recovered
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ListTile(
                                  leading: Text("Deaths",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: Text(
                                    widget.district.districtArray[index].decreased
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: Text("New Confrimed",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: Text(
                                    widget.district.districtArray[index].newDeltaData.newConfirmed
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ListTile(
                                  leading: Text("New Recovered",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: Text(
                                    widget.district.districtArray[index].newDeltaData.newRecovered
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ListTile(
                                  leading: Text("New Deaths",
                                      style: TextStyle(color: Colors.white)),
                                  trailing: Text(
                                    widget.district.districtArray[index].newDeltaData.newDecreased
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                        Divider(
                          thickness: 2,
                        )
                      ]),
                    );
                  }),
            ),
          );
        });
  }

  ring() {
    Map<String,double> data=new Map();
    data.putIfAbsent("Active  "+widget.stateWise.active,()=>double.parse(widget.stateWise.active));
    data.putIfAbsent("Confirmed  "+widget.stateWise.confirmed,()=>double.parse(widget.stateWise.confirmed));
    data.putIfAbsent("Recoverd  "+widget.stateWise.recovered,()=>double.parse(widget.stateWise.recovered));
    data.putIfAbsent("Deaths  "+widget.stateWise.deaths,()=>double.parse(widget.stateWise.deaths));
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: PieChart(
        dataMap: data,
        //chartLegendSpacing: 10,
        legendPosition: LegendPosition.right,
        legendStyle:  TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w500),

      ),
    );
  }

  glowicon() {

    return Container(
     width: MediaQuery.of(context).size.width,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
         Column(
           children: <Widget>[
             AvatarGlow(
               endRadius: 50,
               shape: BoxShape.circle,
               curve: Curves.easeInOutCirc,
               glowColor: Colors.red,
               child: CircleAvatar(
                 backgroundColor: Colors.redAccent,
                 radius: 25,
                 child: Text(widget.stateWise.newDeaths,style:TextStyle(color:Colors.black,fontWeight: FontWeight.w700)),
               ),
             ),
             Text("New Deaths",style:TextStyle(color: Colors.white))
           ],
         ),
          Column(
            children: <Widget>[
              AvatarGlow(
                repeatPauseDuration: Duration(milliseconds: 300),
                endRadius: 50,
                shape: BoxShape.circle,
                curve: Curves.bounceInOut,
                glowColor: Colors.cyan,
                child: CircleAvatar(
                  backgroundColor: Colors.cyan,
                  radius: 25,
                  child: Text(widget.stateWise.newConfirmed,style:TextStyle(color:Colors.black)),
                ),
              ),
              Text("New Confirmed",style:TextStyle(color: Colors.white))
            ],
          ),
          Column(
            children: <Widget>[
              AvatarGlow(
                repeatPauseDuration: Duration(milliseconds:500 ),
                endRadius: 50,
                shape: BoxShape.circle,
                curve: Curves.bounceOut,
                glowColor: Colors.orangeAccent,
                child: CircleAvatar(
                  backgroundColor: Colors.deepOrangeAccent,
                  radius: 25,
                  child: Text(widget.stateWise.newRecovered,style:TextStyle(color:Colors.black)),
                ),
              ),
              Text("New Recoverd",style: TextStyle(color: Colors.white),)
            ],
          )
        ],
      ),
    );
  }
}

