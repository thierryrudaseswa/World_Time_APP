import 'package:flutter/material.dart';
import 'package:world_time/page/choose_File.dart';
import 'package:world_time/page/loading.dart';
import "page/home.dart";

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/' : (context) => Loading(),
      '/home' : (context) => Home(),
      '/location' : (context) => ChooseLocation(),
    },
  ));
}
