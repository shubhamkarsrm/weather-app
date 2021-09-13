import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

enum AppState { NOT_DOWNLOADED, DOWNLOADING, FINISHED_DOWNLOADING }

class WithCordinates extends StatefulWidget {
  double? long, lat;
  WithCordinates({Key? key, required this.long, required this.lat})
      : super(key: key);
  @override
  _WithCordinatesState createState() => _WithCordinatesState(long, lat);
}

class _WithCordinatesState extends State<WithCordinates> {
  double? lon, lat;
  _WithCordinatesState(this.lon, this.lat);
  late WeatherFactory ws;
  late Weather w;
  var city;
  late String date;
  late String pressure, cloud, humidity, tmax, tmin, tfeel, wdes, wmain;
  late Icon wicon;
  AppState _state = AppState.NOT_DOWNLOADED;
  List<Weather> _data = [];
  @override
  void initState() {
    super.initState();
    ws = new WeatherFactory("0cb546ff10845c849e56f7524c32b3f7");
  }

  void queryWeather() async {
    /// Removes keyboard
    FocusScope.of(context).requestFocus(FocusNode());

    setState(() {
      _state = AppState.DOWNLOADING;
    });

    Weather weather = (await ws.currentWeatherByLocation(lon!, lat!));
    setState(() {
      _data = [weather];
      _state = AppState.FINISHED_DOWNLOADING;
    });
  }

  Widget contentFinishedDownload() {
    String icon = _data[0].weatherIcon.toString();
    String url = "http://openweathermap.org/img/wn/" + icon + "@2x.png";
    city = _data[0].areaName.toString();
    date = _data[0].date.toString();
    pressure = _data[0].pressure.toString();
    cloud = _data[0].cloudiness.toString();
    humidity = _data[0].humidity.toString();
    tmax = _data[0].tempMax.toString();
    tmin = _data[0].tempMin.toString();
    tfeel = _data[0].tempFeelsLike.toString();
    wdes = _data[0].weatherDescription.toString();
    wmain = _data[0].weatherMain.toString();
    return Center(
        child: Container(
            height: 500,
            width: 370,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.black, width: 0.7),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Padding(padding: EdgeInsets.all(5)),
                  Image.network(
                    url,
                    height: 150,
                    width: 150,
                    scale: 0.02,
                  ),
                  Text(
                    'City Name :' + city,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Text('Date : ' + date,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('WEATHER : ' + wmain,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('Description : ' + wdes,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('Maximum Temp : ' + tmax,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('Minimum Temp : ' + tmin,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('Feels Like : ' + tfeel,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('Humidity : ' + humidity,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('Pressure : ' + pressure,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.all(2)),
                  Text('Clouds : ' + cloud,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            )));
  }

  Widget contentDownloading() {
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(children: [
        Container(
            margin: EdgeInsets.only(top: 50),
            child: Center(
              child: Image.asset(
                "images/loading.gif",
                height: 580.0,
                width: 580.0,
              ),
            ))
      ]),
    );
  }

  Widget contentNotDownloaded() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: queryWeather,
            child: Text('Get Weather'),
            color: Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _resultView() => _state == AppState.FINISHED_DOWNLOADING
      ? contentFinishedDownload()
      : _state == AppState.DOWNLOADING
          ? contentDownloading()
          : contentNotDownloaded();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade100,
      appBar: AppBar(
        title: Text('Weather near you'),
      ),
      body: Container(
        child: Column(
          children: [Expanded(child: _resultView())],
        ),
      ),
    );
  }
}
