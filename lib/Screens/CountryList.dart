import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restapilogin/Models/world.dart';
import 'package:restapilogin/Screens/SpecificCountry.dart';
import 'package:restapilogin/helper/WorldHelper.dart';

class CountryList extends StatefulWidget {
  static const String routeName = "/countryList";

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  List<String> menuItems = <String>[
    "Confirmed",
    "Critical",
    "Recovered",
    "Deaths"
  ];


  //fetch all countries data
  WorldHelper worldHelper = new WorldHelper();

  //fetching all countries detail in Data List
  List<CountryWiseData> dataList = new List<CountryWiseData>();
  List<CountryWiseData> filtered = new List<CountryWiseData>();

  //for loading data
  bool _load = true;

  //pop button
  int popButton = 0;

  void getWorldData() async {
    dataList = await worldHelper.getWorldData();
    setState(() {
      filtered = dataList;
      _load = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getWorldData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Country Timeline"),
        backgroundColor: Color.fromRGBO(58, 66, 100, 1.0),
        actions: <Widget>[
          popMenuButton(),
        ],
      ),
      body: _load
          ? whileFetch()
          : Container(
//        color: Colors.white,
              color: Color.fromRGBO(58, 66, 110, 10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  searchBox(),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: countryList(),
                  )
                ],
              ),
            ),
    );
  }

  searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: Theme(
                data: ThemeData(primaryColor: Colors.white),
                child: TextField(
                  style: TextStyle(color: Colors.white,fontSize: 20),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide:  BorderSide(color: Colors.white)
                      ),
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 20),
                      hintStyle: TextStyle(color: Colors.blue),
                      hintText: "Enter Country Name"),
                  onChanged: (value) {
                    setState(() {
                      filtered = dataList
                          .where((ck) =>
                              ck.name.toLowerCase().contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  popMenuButton() {
    return PopupMenuButton(
      tooltip: "Sort",
      icon: Icon(
        Icons.trending_up,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return (menuItems
            .map((String value) =>
                PopupMenuItem<String>(value: value, child: Text(value)))
            .toList());
      },
      onSelected: ((String value) {
        Comparator<CountryWiseData> common;
        setState(() {
          if (value == "Confirmed") {
            common = (b, a) => a.total.confirmed - (b.total.confirmed);
            this.popButton = 1;
          } else if (value == "Critical") {
            common = (b, a) => a.total.critical - (b.total.critical);
            this.popButton = 2;
          } else if (value == "Deaths") {
            common = (b, a) => a.total.deaths - (b.total.deaths);
            this.popButton = 4;
          } else if (value == "Recovered") {
            common = (b, a) => a.total.recovered - (b.total.recovered);
            this.popButton = 3;
          }

          filtered.sort(common);
        });
      }),
    );
  }

  whileFetch() {
    return Container(
      color: Color.fromRGBO(58, 66, 100, 1.0),
      child: Center(
        child: LinearProgressIndicator(backgroundColor: Colors.black,),
      ),
    );
  }

  countryList() {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      child: ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            return listTile(index: index);
          }),
    );
  }

  listTile({int index}) {
    String cases="";
    Color color;
    if(this.popButton==1)
      {
        cases=filtered[index].total.confirmed.toString();
        color= Colors.blue;
      }
    else if(this.popButton==2)
    {
      cases=filtered[index].total.critical.toString();
      color= Colors.yellow;
    }
    else if(this.popButton==3)
    {
      cases=filtered[index].total.recovered.toString();
      color= Colors.green;
    }
    else if(this.popButton==4)
    {
      cases=filtered[index].total.deaths.toString();
      color= Colors.red;
    }
    return Card(
      elevation: 10,
      color: Color.fromRGBO(64, 80, 125, 10),
      child: ListTile(
        leading: FaIcon(FontAwesomeIcons.list,color: Colors.white,),
        onTap: ()
        {
          Navigator.of(context).pushNamed(SpecificCountry.routeName,arguments:filtered[index].code);
        },
        trailing: this.popButton == 0
            ? (Container(
                height: 1,
                width: 1,
              ))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.chevronUp,
                    color: color,
                  ),
                  Text(cases,
                    style: TextStyle(
                      color: color,
                    ),
                  )
                ],
              ),
        title: Text(
          filtered[index].name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
