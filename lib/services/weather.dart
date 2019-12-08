import 'package:geolocator/geolocator.dart';
import 'package:clima/services/networking.dart';
const apikey = '7eb7d46d942b3891b37fa4e09672dff6';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic>  getCityWeather(String cityName)async{
  
  var url  ='$openWeatherMapURL?q=$cityName&appid=$apikey';

  NetworkHelper networkHelper = new NetworkHelper(url);
  var weatherData = await networkHelper.getData();

  return weatherData ;
  }

  Future getLocationData()async
  {
    try{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print (position);
    NetworkHelper networkHelper =  NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apikey');
    var weatherData = await networkHelper.getData() ;
    return weatherData ;
    }
    catch(e){
      return (e);
    }
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
