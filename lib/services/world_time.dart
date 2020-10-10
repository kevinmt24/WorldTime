import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;   //location name for the UI
  String time;  //time in that location
  String flag; //Url to an asset flag icon
  String url; //location url for the api endpoint
  bool isDaytime;


  WorldTime({this.url,this.flag,this.location});

  Future<void> getTime() async {
    try {
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      time = DateFormat.jm().format(now);
      isDaytime = now.hour> 6 && now.hour< 20 ? true: false;
    }
    catch (e){
      print(e);
      time = 'Could not fetch data';
    }

  }

}

