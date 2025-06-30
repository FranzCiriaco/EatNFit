import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_franz/pages/Dashbaord.dart';
import 'package:my_franz/pages/ListItems.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Fullscreen (status bar overlays)
  runApp(MaterialApp(
    home: ListItems(),
  ));
}




