// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isNullEmptyOrFalse(dynamic o) {
    if (o is Map<String, dynamic> || o is List<dynamic>) {
      return (o == null || o.length == 0) ? true : false;
    }
    return (o == null || false == o || "" == o) ? true : false;
  }

  Map data = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;
    String bgimgurl = data['isDay']
        ? 'https://images.unsplash.com/photo-1611582032151-ece9bdaf932d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80'
        : 'https://images.unsplash.com/photo-1515311320503-6e3d309537b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(bgimgurl),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 140, 0, 0),
          child: SafeArea(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['timezone'],
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      if (!isNullEmptyOrFalse(result)) {
                        setState(() {
                          data = {
                            'timezone': result['timezone'],
                            'date': result['date'],
                            'time': result['time'],
                            'isDay': result['isDay'],
                          };
                        });
                      }
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Colors.white,
                    ),
                    label: Text(''),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['date'],
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
