import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';
import 'package:geolocator/geolocator.dart';

const openMeteoURL = 'https://api.open-meteo.com/v1/forecast';

class WeatherModel {

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    Position? position = await location.getCurrentLocation();

    if (position == null) {
      print('Location not available');
      return;
    }

    NetworkHelper networkHelper= NetworkHelper(  Uri.parse(
      '$openMeteoURL'
          '?latitude=${position.latitude}'
          '&longitude=${position.longitude}'
          '&current_weather=true',
    ),);

    var weatherData = await networkHelper.getData();

    if (weatherData == null) {
      print('Weather data not available');
      return;
    }
    return weatherData;
  }

  String getWeatherIcon(int code) {
    if (code == 0) {
      return '☀️';
    } else if (code <= 3) {
      return '⛅';
    } else if (code <= 48) {
      return '🌫';
    } else if (code <= 67) {
      return '🌧';
    } else if (code <= 77) {
      return '❄️';
    } else if (code <= 99) {
      return '⛈';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
