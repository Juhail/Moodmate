import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moodmate/Home.dart';
import 'package:moodmate/mood.dart';
import 'package:moodmate/onb.dart';

class Splash extends StatefulWidget {
  final bool showHome;
  const Splash({super.key, required this.showHome});
  @override
  _SplashState createState() => _SplashState(showHome: showHome);
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  final bool showHome;

  _SplashState({required this.showHome});

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => showHome ? corousal() : onboarding()));
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
