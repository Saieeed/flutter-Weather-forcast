import 'package:geolocator/geolocator.dart';
abstract class Location {

 double longtude=0 , latitude=0 ;

  void getCurrentLocation () async{

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    longtude=position.longitude;
    latitude=position.latitude;



    }


}