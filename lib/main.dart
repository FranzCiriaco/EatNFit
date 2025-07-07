import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_franz/pages/Dashbaord.dart';
import 'package:my_franz/pages/ListItems.dart';
import 'package:my_franz/pages/workout.dart';
import 'package:my_franz/World TIme/pages/home.dart';
import 'package:my_franz/World TIme/pages/loading.dart';
import 'package:my_franz/World TIme/pages/choose_location.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/location': (context) => ChooseLocation(),
  },
));


