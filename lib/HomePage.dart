import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/WithCordinates.dart';
import 'ShowWeather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String cityname;
  double? lat, lon;
  //userNameValidate = false;
  void getUserLocation() async {
    var position = await GeolocatorPlatform.instance
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
  }

  bool isUserNameValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade100,
        appBar: AppBar(
          title: Text('weather info'),
        ),
        body: Center(
            child: Container(
                height: 300,
                width: 370,
                child: Card(
                  color: Colors.purple.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.black, width: 0.7),
                  ),
                  //margin: EdgeInsets.fromLTRB(20, 275, 20, 275),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.all(7.5)),
                      Text(
                        'Please type your city name',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.black),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        shadowColor: Colors.black,
                        child: TextFormField(
                            decoration: InputDecoration(
                              labelText: '       Enter your city',
                            ),
                            onChanged: (newValue) {
                              cityname = newValue;
                            }),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      RaisedButton(
                          child: Text('Next'),
                          onPressed: () {
                            //
                            if (cityname != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ShowWeather(
                                        city: cityname,
                                      )));
                            }
                          }),
                      Padding(padding: EdgeInsets.all(5)),
                      RaisedButton(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.gps_fixed),
                            VerticalDivider(
                              color: Colors.black,
                              width: 5,
                              thickness: 5,
                            ),
                            Text(
                              'USING CURRENT LOCATION',
                            )
                          ]),
                          onPressed: () {
                            getUserLocation();
                            if (lat != null && lon != null) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      WithCordinates(long: lat, lat: lon)));
                            }
                          })
                    ],
                  ),
                ))));
  }
}
