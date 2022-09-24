// ignore_for_file: prefer_const_constructors

import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String timezone = '';
  String time = '';
  String date = '';
  bool isDay = false;

  WorldTime(this.timezone);

  Future<void> getTime() async {
    try {
      Response response = await get(Uri.parse(
          'https://timeapi.io/api/Time/current/zone?timeZone=$timezone'));
      Map data = jsonDecode(response.body);
      DateTime now = DateTime.parse(data['dateTime']);
      isDay = (now.hour > 6 && now.hour < 19) ? true : false;
      date = DateFormat.yMMMMEEEEd().format(now);
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Error in Fetching Time';
    }
  }
}
