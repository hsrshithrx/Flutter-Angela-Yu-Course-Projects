import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:clima_flutter/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:clima_flutter/services/location.dart';





class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  @override
  void initState() {
    super.initState();

    getLocationData();
  }

  Future<void> getLocationData() async {
    Location location = Location();
    Position? position = await location.getCurrentLocation();
    if (position == null) {
      print('Location not available');
      return;
    }

    var weatherData = await WeatherModel().getLocationWeather();

    String cityName = await location.getCityName(position);

    if (!mounted) return;

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData,
        cityName: cityName,);
    },),);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
