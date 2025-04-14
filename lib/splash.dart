import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/Home.dart';
import 'package:moodmate/mood.dart';
import 'package:moodmate/onb.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  final bool showHome;
  const Splash({super.key, required this.showHome});
  @override
  _SplashState createState() => _SplashState(showHome: showHome);
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  final bool showHome;
  late Widget nextPage; // Define nextPage as a class-level variable

  Future<void> moodSaved() async {
    final moodBox = await Hive.openBox('moods');
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final bool moodSaved = moodBox.containsKey(today);
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboardingDone') ?? false;

    if (onboardingDone && moodSaved) {
      nextPage = Home();
    } else if (onboardingDone && !moodSaved) {
      nextPage = corousal();
    } else {
      nextPage = onboarding();
    }
  }

  _SplashState({required this.showHome});

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    _initializeSplash();
  }

  Future<void> _initializeSplash() async {
    await moodSaved(); // Wait for moodSaved to complete
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => nextPage)); // Use the initialized nextPage
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.yellow, Colors.orange])),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_emotions, size: 140),
                Text(
                  'Splash',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ),
              ],
            )));
  }
}

