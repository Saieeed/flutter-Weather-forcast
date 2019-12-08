import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather ;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
    WeatherModel weatherModel = WeatherModel();
      var temp ;
      String condition ;
      var city ;
  @override
  void initState() {

    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic data ){
    setState(() {

      if(data ==null){
      temp = 0 ;
      condition = '404' ;
      city = 'Error locating ';
      return ;
      }
      temp = data['main']['temp'] ;
      temp = temp.floor()-273;
      var condetion = data['weather'][0]['id'];
      condition = weatherModel.getWeatherIcon(condetion);
      city = data['name'];

    });

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
                  FlatButton(
                    onPressed: () async{
                      var weatherData = await  weatherModel.getLocationData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 20.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()async {
                      var awaitedCityName = await Navigator.push(context, MaterialPageRoute(builder:(context){
                        return CityScreen();
                      } )
                      );
                      if(awaitedCityName != null){
                       var weatherData = await weatherModel.getCityWeather(awaitedCityName);
                       updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row( mainAxisAlignment:   MainAxisAlignment.center,
                  children: <Widget>[

                  Text(
                      temp.toString()+'°' ,
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition
                      ,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherModel.getMessage(temp) +'  in '+city,
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
