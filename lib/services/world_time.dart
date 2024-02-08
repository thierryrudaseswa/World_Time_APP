import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


class WorldTime{
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDaytime;
  WorldTime({this.location,this.flag,this.url});

  Future<Map<String, dynamic>?> getTime() async {
    Uri url = Uri.parse('http://worldtimeapi.org/api/timezone/${this.url}');


    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonData = jsonDecode(response.body);

        // Access individual properties
        String datetime = jsonData['datetime'];
        String offset = jsonData['utc_offset'].substring(1, 3);
        DateTime now = DateTime.parse(datetime);
        now = now.add(Duration(hours: int.parse(offset)));
        isDaytime = now.hour < 6 && now.hour >20 ? true : false;
       time = DateFormat.jm().format(now);
        // print(now);

        return jsonData; // Return the data
      } else {
        print('Failed to get time: ${response.statusCode}');
        return null; // Return null in case of failure
      }
    } catch (e) {
      print('Error: $e');
      return null; // Return null in case of an exception
    }
  }

}

WorldTime instance = WorldTime(location: 'Berlin',flag:'germany.png',url:'Europe/Berlin');