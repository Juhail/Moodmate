import 'package:flutter/material.dart';
import 'package:moodmate/Home.dart';
import 'package:moodmate/exp.dart';
import 'package:moodmate/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: Splash(
        showHome: showHome,
  )));
  // home: Home()
  
      
}
