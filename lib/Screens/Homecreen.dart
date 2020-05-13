import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/widgets.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:restapilogin/Animation/FadeAnimation.dart';
import 'package:restapilogin/Models/Districtdata.dart';
import 'package:restapilogin/Models/world.dart';
import 'package:restapilogin/Screens/CountryList.dart';
import 'package:restapilogin/Screens/India.dart';
import 'package:restapilogin/Screens/faq.dart';
import 'package:restapilogin/Screens/world.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restapilogin/helper/Districthelper.dart';
import 'package:restapilogin/helper/WorldHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  static const String RouteName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String Name = "";
  String image;
  String locationdistrict;
  String locationState;
  String locationcountry;
  bool checkPermission = false;
  bool locationEnable;
  SharedPreferences preferences;

  opensetting() async {
    print(checkPermission);
    if (checkPermission == false) {
      bool open = await LocationPermissions().openAppSettings();
      print(open);
    }
    bool isShown =
        await LocationPermissions().shouldShowRequestPermissionRationale();
    print("$isShown shown");
    Navigator.pushNamedAndRemoveUntil(
        context, Home.RouteName, (Route<dynamic> route) => false);
  }

  getLocal() async {
    PermissionStatus permission =
        await LocationPermissions().requestPermissions();
    ServiceStatus serviceStatus =
        await LocationPermissions().checkServiceStatus();
//    print(permission);
//    print(serviceStatus);
    if (permission == PermissionStatus.granted) {
      if (serviceStatus == ServiceStatus.enabled) {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        List<Placemark> p = await Geolocator()
            .placemarkFromCoordinates(position.latitude, position.longitude);
        print(p[0].locality +
            "-" +
            p[0].country +
            "" +
            p[0].subAdministrativeArea +
            p[0].administrativeArea +
            p[0].isoCountryCode);
        setState(() {
          checkPermission = true;
          locationEnable = true;
          preferences.setString("country", p[0].isoCountryCode);
          preferences.setString("district", p[0].subAdministrativeArea);
          preferences.setString("state", p[0].administrativeArea);
          locationState = p[0].administrativeArea;
          locationdistrict = p[0].subAdministrativeArea;
          locationcountry = p[0].isoCountryCode;
        });
      } else {
        Position position = await Geolocator()
            .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
        print(position);
        setState(() {
          checkPermission = true;
          locationEnable = false;
          locationState = preferences.getString("state");
          locationdistrict = preferences.getString("district");
          locationcountry = preferences.getString("country");
        });
      }
    } else {
      setState(() {
        checkPermission = false;
      });
    }
    print(locationcountry);
    print(locationState);
    print(locationdistrict);
    print(locationEnable);
    print(checkPermission);
  }

  getpref() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      Name = preferences.getString("name");
      image = preferences.getString("imagefile");
      //print("$image image");
    });
  }

  // for coverting image to string
  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  // for converting string to image
  Image imageFromBase64String(String base64) {
    return Image.memory(
      base64Decode(base64),
      fit: BoxFit.cover,
      width: 100,
      height: 100,
    );
  }

  //
  File _imageFile;

  @override
  void initState() {
    // TODO: implement initState
    getpref();
    getLocal();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(30, 30, 50, 1.0),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.black87,
          color: Color.fromRGBO(30, 30, 50, 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              mainpicture(),
              checkPermission
                  ? local()
                  : SizedBox(
                      height: 50,
                    ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 0),
                child: RichText(
                  text: TextSpan(
                      text: "Track",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      children: <TextSpan>[
                        TextSpan(
                            text: " Virus",
                            style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 18,
                            ))
                      ]),
                ),
              ),
              items(),
              Protect(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, bottom: 20),
                    child: RichText(
                      text: TextSpan(
                          text: "Corona",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                          children: <TextSpan>[
                            TextSpan(
                                text: " Symtopms",
                                style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 18,
                                ))
                          ]),
                    ),
                  ),
                  Symptoms(),
                ],
              ),
//              Protect(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, bottom: 20),
                child: RichText(
                  text: TextSpan(
                      text: "Practice the 3C's-",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                      children: <TextSpan>[
                        TextSpan(
                            text: " Clean, Cover, Contain",
                            style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 18,
                            ))
                      ]),
                ),
              ),
              C3(),
            ],
          ),
        ),
      ),
      drawer: Container(
        width: 250,
        child: drawerMenu(),
      ),
    );
  }

  drawerMenu() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black45,
                // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
              ),
              child: above(),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  below("Home", Icons.home, Colors.black, Home.RouteName),
                  below("India Tracker", Icons.track_changes, Colors.blue,
                      India.routeName),
                  below("World Tracker", Icons.all_inclusive, Colors.indigo,
                      World.RouteName),
                  below("FAQ", Icons.question_answer, Colors.redAccent,
                      FAQ.routeName),
                  checkPermission
                      ? locationtoogle(
                          Icons.location_on, Colors.black87, "Location On")
                      : locationtoogle(
                          Icons.location_off, Colors.black87, "Location Off"),
                  bottomSheet("Rate Us", Icons.rate_review, Colors.cyan),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  above() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeAnimation(
            1.5,
            RichText(
                text: TextSpan(
                    text: "Hello \n",
                    style: TextStyle(color: Colors.cyan, fontSize: 30),
                    children: <TextSpan>[
                  TextSpan(
                      text: this.Name, style: TextStyle(color: Colors.white))
                ])),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (ctx) => imageBottomSheet());
            },
            child: ClipOval(
                child: this.image == null
                    ? CircleAvatar(
                        radius: 50,
                        child: FaIcon(
                          FontAwesomeIcons.userAstronaut,
                        ),
                      )
                    : imageFromBase64String(this.image)),
          )
        ],
      ),
    );
  }

  bottomSheet(String item, IconData icon, Color color) {
    return ListTile(
        onTap: () {
          showModalBottomSheet(
              context: context, builder: (ctx) => BottomSheet());
        },
        title: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: Icon(
          icon,
          color: color,
        ));
  }

  below(String item, IconData icon, Color color, String route) {
    return ListTile(
        onTap: () {
          if (item == "Home") {
            Navigator.pushNamedAndRemoveUntil(
                context, route, (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamed(context, route);
          }
        },
        title: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: Icon(
          icon,
          color: color,
        ));
  }

  Widget items() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // scrollDirection: Axis.horizontal,
        children: <Widget>[
//          button(
//          "India", "assets/icon/india_burned.png", India.routeName),
//          button("Global TimeLine", "assets/icon/globe1.jpeg",
//                  World.RouteName),
//                  button(
//            "India", "assets/icon/india_burned.png", India.routeName)
          Expanded(
              child: button(
                  "India", "assets/icon/india_burned.png", India.routeName)),
          Expanded(
              child: button("Global", "assets/icon/globe1.jpeg",
                  World.RouteName)),
          Expanded(
            child: button("Country", "assets/icon/covworld_burned.png",
                CountryList.routeName),
          )
        ],
      ),
//
    );
  }

  Widget button(String name, String image, String routeName) {
    return Container(
     // color: Colors.black,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      width: 100,
      // height: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClipOval(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  color: Colors.white,
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    image,
                    width: 50,
                    height: 50,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: Text(
                  name+"",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),

//      ),
    );
  }

  imageBottomSheet() {
    return Container(
      height: 100,
      decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await _pickFromGallery();
              },
              child: Container(
                alignment: Alignment.center,
                child: Icon(Icons.image),
              ),
            ),
          ),
          Divider(
            color: Colors.black87,
            thickness: 20,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await _pickFromCamera();
              },
              child: Container(
                alignment: Alignment.center,
                child: Icon(Icons.camera),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Null> _pickFromGallery() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = base64String(imageFile.readAsBytesSync());
      preferences.setString("imagefile", image);
      print(preferences.getString("imagefile"));
    });
  }

  Future<Null> _pickFromCamera() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      this.image = base64String(imageFile.readAsBytesSync());
      preferences.setString("imagefile", image);
      print(preferences.getString("imagefile"));
    });
  }

  local() {
    if (locationcountry == null) {
      return Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          "Enable GPS to get your area data",
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        color: Colors.white54,
      );
    } else if (locationcountry.toLowerCase() == "in") {
      Districthelper districthelper = new Districthelper();
      return FutureBuilder(
        future: districthelper.getDistricts(),
        builder: (BuildContext context,
            AsyncSnapshot<List<StateDistrict>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            DistrictArray districtArray = new DistrictArray();
            int Confirm = 0;
            int recovered = 0;
            int deaths = 0;
            snapshot.data.forEach((f) {
              if (f.state == locationState) {
                f.districtArray.forEach((t) {
                  Confirm += t.confirmed;
                  recovered += t.recovered;
                  deaths += t.decreased;
                  if (t.district.toLowerCase() ==
                      locationdistrict.toLowerCase()) {
                    districtArray = t;
                  }
                });
              }
            });
            //print(districtArray.district);
            return districtArray.district != null
                ? futureLoctaionData(
                    districtArray.district,
                    districtArray.active,
                    districtArray.recovered,
                    districtArray.decreased)
                : futureLoctaionData(locationState, Confirm, recovered, deaths);
          }
          return SizedBox(
            height: 50,
          );
        },
      );
    } else {
      WorldHelper w = new WorldHelper();
      return FutureBuilder(
        future: w.getWorldData(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CountryWiseData>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            CountryWiseData d = new CountryWiseData();
            ;
            for (int i = 0; i < snapshot.data.length; i++) {
              if (snapshot.data[i].code.toLowerCase() ==
                  locationcountry.toLowerCase()) {
                d = snapshot.data[i];
                print(d.name);
                break;
              }
            }
            return d.name != null
                ? futureLoctaionData(d.name, d.total.confirmed,
                    d.total.recovered, d.total.deaths)
                : SizedBox(
                    height: 50,
                  );
          }
          return SizedBox(
            height: 50,
          );
        },
      );
    }
  }

  locationtoogle(IconData icon, Color color, String text) {
    return ListTile(
        onTap: () {
          opensetting();
        },
        title: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        leading: Icon(
          icon,
          color: color,
        ));
  }

  futureLoctaionData(String name, int confirm, int recovered, int deaths) {
    return Card(
      color: Color.fromRGBO(90, 80, 190, 1.0),
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "$name",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "$confirm",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Deaths",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "$deaths",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Recovered",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "$recovered",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class mainpicture extends StatefulWidget {
  @override
  _mainpictureState createState() => _mainpictureState();
}

class _mainpictureState extends State<mainpicture> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Carousel(
        animationDuration: Duration(milliseconds: 1500),
        //borderRadius: true,
        showIndicator: false,
        animationCurve: Curves.easeInOutCirc,
        overlayShadowColors: Colors.black,
        radius: Radius.circular(50),
        images: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/homepic/tracker1.jpg") // image:Image.network(",)

                      )),
              child: Material(
                color: Colors.black26,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70)),
              )),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                        "assets/homepic/home2.png") // image:Image.network(",)

                    )),
            child: Material(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70)),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/homepic/home3.jpg") // image:Image.network(",)

                      )),
              child: Material(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70)),
              )),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70)),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/homepic/home5.png") // image:Image.network(",)

                      )),
              child: Material(
                color: Colors.white24,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70)),
              )),
        ],
      ),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
      ),
    );
  }
}

class Symptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          sympImage("assets/Prevention/fever.png", "Fever"),
          sympImage("assets/Prevention/coughing.png", "Cough"),
          sympImage("assets/Prevention/breathing.png", "Shortness of breath"),
          sympImage("assets/Prevention/neck.png", "Muscle aches"),
          sympImage("assets/Prevention/headache.png", "Headache"),
          sympImage("assets/Prevention/diarrhea.png", "Diarrhea"),
          sympImage("assets/Prevention/sore.png", "Sore throat"),
          sympImage("assets/Prevention/taste.png", "Loss of taste and Smell"),
        ],
      ),
    );
  }

  sympImage(String image, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
              radius: 60,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              )),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}

class Protect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      child: Card(
        color: Colors.black54,
        child: ExpansionTile(
          trailing: FaIcon(
            FontAwesomeIcons.arrowCircleDown,
            color: Colors.blue,
          ),
          // backgroundColor: Colors.red,
          title: Text(
            "THE BEST WAYS TO PROTECT YOURSELF",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            protection("assets/protect/1.png",
                "Avoid touching your eyes, nose or mouth with unwashed hands."),
            protection("assets/protect/2.png",
                "Clean and disinfect surfaces and objects that people frequently touch."),
            protection("assets/protect/3.png",
                "Avoid close contact with people who are sick, sneezing or coughing."),
            protection("assets/protect/4.jpg",
                "The virus can spread between people interacting in close proximity—for example, speaking, coughing, or sneezing—even if those people are not exhibiting symptoms. In light of this evidence, CDC recommends wearing cloth face coverings in public settings where other social distancing measures are difficult to maintain (e.g., grocery stores and pharmacies) especially in areas of significant community-based transmission."),
            protection("assets/protect/5.png",
                "Wash your hands frequently and thoroughly, using soap and water for at least 20 seconds. Use alcohol-based hand sanitizer if soap and water aren’t available."),
            protection("assets/protect/6.png", "Stay home when you are ill."),
            protection("assets/protect/7.png",
                "Cough or sneeze into a tissue or flexed elbow, then throw the tissue in the trash."),
          ],
        ),
      ),
    );
  }

  protection(String image, String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              image,
              width: 100,
              height: 100,
            ),
          ),
//          CircleAvatar(
//            radius: 60,
//            backgroundColor: Colors.cyan,
//          ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white38,
      height: MediaQuery.of(context).size.height / 3,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Thank you",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          FaIcon(FontAwesomeIcons.thumbsUp)
        ],
      ),
    );
  }
}

class C3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          practice1(),
          practice23(
              "Cover",
              "Cover your cough or sneeze with a tissue, then throw the tissue in the trash. ",
              "If no tissue is available, cough or sneeze into your upper sleeve, not your hands.",
              "assets/c3/c2.png"),
          practice23(
              "Contain",
              "Stay home when you are sick, except to get medical care.",
              "Avoid close contact with people who are sick.",
              "assets/c3/c2.png")
        ],
      ),
    );
  }

  practice1() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              "assets/c3/c1.png",
              width: 130,
              height: 130,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Clean",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Wash your hands often with soap and water for at least 20 seconds.",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Clean and disinfect frequently touched surfaces and objects.",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  practice23(String title, String point1, String point2, String image) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ClipOval(
            child: Image.asset(
              image,
              width: 130,
              height: 130,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  point1,
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.w500),
                ),
                Text(point2,
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w500)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
