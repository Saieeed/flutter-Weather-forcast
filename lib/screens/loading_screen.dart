import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {


  void getWeatherData ()
  async{
      WeatherModel weather = new WeatherModel() ;
      var weatherData ;
      weatherData= await weather.getLocationData();
      
      if(weatherData == null ){
        Navigator.push(context,  MaterialPageRoute(builder: (context){
      return Scaffold(
        body: Center(
       child: Text(
         "Error appeared , pls check your Location settings :)",
         style: Theme.of(context).textTheme.title,
       ),
     )
   );
      })) ;
      }
      else {
      Navigator.push(context,  MaterialPageRoute(builder: (context){
      return LocationScreen(locationWeather: weatherData);
      })) ;
      }
    }
  @override
  void initState() {
      super.initState();
      getWeatherData();
  }
  @override
  void deactivate() {
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Center(child:SpinKitFoldingCube(
        color: Colors.white,
        size:100.0,
      ) ),

    );
  }
}

