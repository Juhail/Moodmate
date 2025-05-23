import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:moodmate/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('moodBox');
  await Hive.openBox('quotesData');

  
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MaterialApp(debugShowCheckedModeBanner: false,home: Splash(
        showHome: showHome,
  )));
  // home: Home()
  
      
}
