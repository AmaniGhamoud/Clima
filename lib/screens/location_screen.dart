import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:intl/intl.dart';
import '../services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen ({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>  {
  
  @override
  WeatherModel weather = WeatherModel();
  int temperature=0;
  String cityname='';
  String weatherIcon= '';
  String weatherText= '';
  List<Forecast> forecastList = [];
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }
  Future<void> updateUi (dynamic weatherData) async {
    setState(() {
      if (weatherData == null){
        temperature = 0;
        cityname = '';
        weatherIcon = 'Error';
        weatherText = 'Enabel to get weather data';
        forecastList = [];
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      cityname = weatherData['name'];
      weatherIcon =weather.getWeatherIcon(condition);
      weatherText =weather.getMessage(temperature);
      
    });
    var forecastData = await weather.getCityForecast(cityname);
    setState(() {
      forecastList = parseForecastData(forecastData);
    });
  }
  
  


  List<Forecast> parseForecastData(dynamic forecastData) {
    List<Forecast> forecasts = [];
    Map<String, bool> daysAdded = {};

    for (var item in forecastData['list']) {
      String dateText = item['dt_txt'];
      DateTime dateTime = DateTime.parse(dateText);
      String day = DateFormat('EEE').format(dateTime); // Get the first three letters

      if (!daysAdded.containsKey(day) && forecasts.length < 5) {
        forecasts.add(Forecast(
          day: day,
          temp: item['main']['temp'],
          condition: item['weather'][0]['id'],
        ));
        daysAdded[day] = true;
      }
    }

    return forecasts;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/a.jpg'),
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
                 IconButton(
                    onPressed: () async {
                      var weatherdata = await weather.getLocationWeather();
                      updateUi(weatherdata);
                    },
                    icon: Icon(
                      Icons.near_me,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                 IconButton(
                    onPressed: () async {
    var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CityScreen();
    }));
    if (typedName != null) {
      var weatherData = await weather.getCityWeather(typedName);
      var forecastData = await weather.getCityForecast(typedName);
      updateUi(weatherData);
      setState(() {
        forecastList = parseForecastData(forecastData);
      });
    }
  },
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "$weatherText in $cityname!",
                  //textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(height: 160,
                    width: 300,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Row(
                      children: [
                        Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: forecastList.length,
                                      itemBuilder: (context, index) {
                                        return ForecastCard(forecast: forecastList[index]);
                                      },
                                    ),
                                  ),
                        
                        ],),
                    ),
              ),
              SizedBox(height: 0,),
              
            ],
          ),
        ),
      ),
    );
  }
}
class Forecast {
  final String day;
  final double temp;
  final int condition;

  Forecast({required this.day, required this.temp, required this.condition});
}

class ForecastCard extends StatelessWidget {
  final Forecast forecast;

  ForecastCard({required this.forecast});

  @override
  Widget build(BuildContext context) {
    WeatherModel weatherModel = WeatherModel();
    return Container(
      width: 60.0,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(60.0)),
      ),
      margin: EdgeInsets.all(6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            forecast.day,
            style: TextStyle(fontSize: 18.0,fontFamily: 'Spartan MB',),
          ),
          Text(
            weatherModel.getWeatherIcon(forecast.condition),
            style: TextStyle(fontSize: 32.0),
          ),
          Text(
            '${forecast.temp.toInt()}°',
            style: TextStyle(fontSize: 18.0,fontFamily: 'Spartan MB',),
          ),
        ],
      ),
    );
  }
}