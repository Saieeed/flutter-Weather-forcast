import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';
const apikey = '7eb7d46d942b3891b37fa4e09672dff6';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {
  double lat,long ;
  void  getLocationData()async
  {
    try{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print (position);
    lat=position.latitude ;
    long=position.longitude;
    NetworkHelper networkHelper =  NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apikey');
    var weatherData = await networkHelper.getData() ;
    Navigator.push(context,  MaterialPageRoute(builder: (context){
    return LocationScreen(locationWeather: weatherData);
    }));

    }
    catch(e){
      print(e);
    }

  }
 
  @override
  void initState() {
    super.initState();
    getLocationData();

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

