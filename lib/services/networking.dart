import 'package:http/http.dart' as http ;
import 'dart:convert';

class NetworkHelper {

NetworkHelper(this.url);
String url  ;

    Future getData()async{
      try{
    http.Response response = await http.get(url);
    if(response.statusCode ==200){
      String data = response.body ;
      return jsonDecode(data);
    }else {
      return (response.statusCode);
    }
      }
      catch(e){
        return e;
      }
}
}

// var temp = decode['main']['temp'] ;
      // var condetion = decode['weather'][0]['id'];
      // var city = decode['name'];
      // print(city);
      // print(condetion);
      // print(temp);