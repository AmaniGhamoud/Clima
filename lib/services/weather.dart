import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
const apikey ='b5018fd910ae4deb98c78a168fabdcc5';
double latitude=0;
double longitude=0;



class WeatherModel {

  Future<dynamic>getCityWeather (String cityName) async{
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apikey&units=metric');
    var weatherdata = await networkHelper.getData();
    return weatherdata;
  }
  Future<dynamic>getLocationWeather() async{
    Location location = new Location();
    await location.getCurrentLocation();
    longitude =location.longitude;
    latitude  =location.latitude;
    NetworkHelper networkhelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var weatherdata = await networkhelper.getData();
    return weatherdata;
  }
  Future<dynamic> getCityForecast(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apikey&units=metric');
    var forecastData = await networkHelper.getData();
    return forecastData;
  }

  Future<dynamic> getLocationForecast(double latitude, double longitude) async {
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apikey&units=metric');
    var forecastData = await networkHelper.getData();
    return forecastData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
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
