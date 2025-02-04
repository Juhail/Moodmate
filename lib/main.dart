import 'package:flutter/material.dart';
import 'package:moodmate/Home.dart';
import 'package:moodmate/splash.dart';

void main() => runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          // '/sd': (context) => corousal(),
        }));
