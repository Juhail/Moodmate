import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/Home.dart';
import 'package:moodmate/MIS.dart';


final moodBox = Hive.box('moods');
String? todayMood = moodBox.get(DateFormat('yyyy-MM-dd').format(DateTime.now()));


class corousal extends StatefulWidget {
  @override
  _corousalState createState() => _corousalState();
}

class _corousalState extends State<corousal> {
  final List<String> imagePaths = [
    "assets/crying.svg",
    "assets/slightly_sad.svg",
    "assets/neutral.svg",
    "assets/slightly_smile.svg",
    "assets/big_smile.svg"
  ];

  final List<String> mood = ["awful", "bad", "Meh", "good", "rad"];
  late List<Widget> pages = List.generate(imagePaths.length,
      (index) => ImagePlaceHolder(imagePath: imagePaths[index]));

  int activePage = 0;
  bool isButtonVisible = false;
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Top Text
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Text("How Are You Feeling \n today?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          // Carousel Section
          Column(
            children: [
              // Image Carousel
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: PageView.builder(
                  controller: pageController,
                  itemCount: imagePaths.length,
                  onPageChanged: (value) {
                    setState(() {
                      activePage = value;
                      isButtonVisible = true;
                    });
                  },
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              ),

              // Mood Text
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  mood[activePage],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              // Dot Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: InkWell(
                      onTap: () {
                        pageController.animateToPage(index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: activePage == index
                            ? Colors.yellow
                            : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),

          // Start Button (Animated)
          AnimatedScale(
            scale: isButtonVisible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutBack,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40, top: 10),
              child: TextButton(
                onPressed: isButtonVisible
                    ? () async {

final moodBox = Hive.box('moods');
        final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
        final selectedMood = mood[activePage]; // e.g., "bad", "rad"

        // Save only if not already stored
        if (!moodBox.containsKey(today)) {
          await moodBox.put(today, selectedMood);
        }
String? todayMood = moodBox.get(DateFormat('yyyy-MM-dd').format(DateTime.now()));

print('todays mood =$todayMood');
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => Home()));
                      }
                    : null,
                child: Text("Start",  style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),),
               
                
              
            ),
          ),
        ],
      ),
    );
  }
}
class ImagePlaceHolder extends StatelessWidget {
  final String? imagePath;

  const ImagePlaceHolder({super.key, this.imagePath});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath!,
      fit: BoxFit.cover,
    );
  }
}

