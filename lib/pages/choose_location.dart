// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:worldclock/services/worldtime.dart';
import 'package:dio/dio.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List timezones = [];

  void getTimezones() async {
    Response response;
    var dio = Dio();
    response =
        await dio.get('https://timeapi.io/api/TimeZone/AvailableTimeZones');
    setState(() {
      timezones = (response.data.toList());
    });
  }

  void updateTime(timezone) async {
    WorldTime obj = WorldTime(timezone);
    await obj.getTime();
    Navigator.pop(context, {
      'timezone': obj.timezone,
      'date': obj.date,
      'time': obj.time,
      'isDay': obj.isDay,
    });
  }

  @override
  void initState() {
    super.initState();
    getTimezones();
  }

  @override
  Widget build(BuildContext context) {
    if (timezones.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose a TimeZone'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Center(
          child: SpinKitFadingCircle(
            color: Colors.blue,
            size: 50,
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 219, 219),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a TimeZone'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 10,
        child: ListView.builder(
          itemCount: timezones.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(timezones[index]);
                  },
                  title: Text(
                    timezones[index],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
