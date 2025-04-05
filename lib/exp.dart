import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_svg/svg.dart';


class corousal extends StatefulWidget {
  @override
  _corousalState createState() => _corousalState();
}

class _corousalState extends State<corousal> {
  
  
  late List<Widget> pages = [
      Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,15),
            child:
            //
             Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,20,10,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 230, 235, 218),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                                'assets/Vectorm.svg',
                                width: 20,
                                height: 20,
                               // fit: BoxFit.cover,
                              ),
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Listen to Your \nFavourite Music',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
                  ),Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(  
                        width: MediaQuery.of(context).size.width,
                          height:43,
                          decoration: BoxDecoration(
                       color: const Color(0xFF9BB068),                          borderRadius: BorderRadius.circular(30),
                        
                          ),child: Center(child: Text('Spotify', style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),)),
                          
                    ),
                  ),
                ],
              ),
            ),
          ),
  ];
  int activePage = 0;
  final PageController pageController = PageController(initialPage: 0);
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (pageController.page == pages.length - 1) {
        pageController.animateTo(0,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      } else {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }

  @override
  

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
            
              Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: PageView.builder(
                    controller: pageController,
                    itemCount: pages.length,
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
          
        ],
      ),
    );
  }
}

