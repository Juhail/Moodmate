import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/svg.dart';
import 'package:moodmate/Home.dart';

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
  final PageController pageController = PageController(initialPage: 0);
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (pageController.page == imagePaths.length - 1) {
        pageController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  // void initState() {
  //   super.initState();
  //   pages = List.generate(imagePaths.length,
  //       (index) => ImagePlaceHolder(imagePath: imagePaths[index]));
  //   startTimer();
  // }

  // void dispose() {
  //   super.dispose();
  //   _timer?.cancel();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Text("How Are You Feeling \n today?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Column(
            children: [
              Text(
                mood[activePage],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: PageView.builder(
                    controller: pageController,
                    itemCount: imagePaths.length,
                    onPageChanged: (value) {
                      setState(() {
                        activePage = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return pages[index];
                    }),
              ),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          pages.length,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
                              ))),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: GestureDetector(
                child: Text("Start",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => Home()));
                }),
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
