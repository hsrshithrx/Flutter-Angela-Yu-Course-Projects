import 'package:clima_flutter/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter/utilities/constants.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';
import 'package:geolocator/geolocator.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.cityName});

  final locationWeather;
  final String? cityName;


  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  String? cityName;
  WeatherModel weather = WeatherModel();
  int? temp;
  String? weatherIcon;
  String? weatherMessage;


  @override
  void initState(){
    super.initState();
    cityName = widget.cityName;
    updateUI(widget.locationWeather);

  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) return;
    setState(() {
      int temperature =
      weatherData['current_weather']['temperature'].toInt();

      int weatherCode =
      weatherData['current_weather']['weathercode'];

      temp = temperature; // int? ← int (allowed)
      weatherIcon = weather.getWeatherIcon(weatherCode);
      weatherMessage = weather.getMessage(temperature); // ✅ int passed
    });
  }

  Future<void> refreshLocationWeather() async {
    Location location = Location();

    Position? position = await location.getCurrentLocation();
    if (position == null) return;

    NetworkHelper networkHelper = NetworkHelper(
      Uri.parse(
        'https://api.open-meteo.com/v1/forecast'
            '?latitude=${position.latitude}'
            '&longitude=${position.longitude}'
            '&current_weather=true',
      ),
    );

    var weatherData = await networkHelper.getData();
    if (weatherData == null) return;

    String newCityName = await location.getCityName(position);

    // ✅ CALL updateUI DIRECTLY
    updateUI(weatherData);

    // ✅ update city name separately
    setState(() {
      cityName = newCityName;
    });

    print('📍 LAT: ${position.latitude}, LON: ${position.longitude}');

  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: () {
                      refreshLocationWeather();
                      },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var typedName= await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));
                      if (typedName == null){

                      };


                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      temp != null ? '$temp°' : '--',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon ?? '',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherMessage ?? ''} in ${cityName ?? 'your location'}!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
