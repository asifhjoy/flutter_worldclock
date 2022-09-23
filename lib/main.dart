// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:testapp/pages/home.dart';
import 'package:testapp/pages/loading.dart';
import 'package:testapp/pages/choose_location.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}
