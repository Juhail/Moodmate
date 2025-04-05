import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/MIS.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> activities = [
    'Go for a walk',
    'Read a book',
    'Watch a movie',
    'Cook a meal',
  ];
DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 247, 244, 242),
      body: SingleChildScrollView(
        child: Column(children: [
          ClipPath(
            clipper: GreenContainerClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height:350,
              decoration: BoxDecoration(color: Color(0xFFB6CD7D), boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 7,
                  blurRadius: 10,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ]),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text("You\'r Happy!",style :TextStyle(letterSpacing: 1.8,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/happyol.svg',
                      width: 200,
                      height: 200,
                    //   fit: BoxFit.cover,
                    ),
                  ),
                

                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                  child: Column(
                    children: [ 
                      // First Container
                      GestureDetector(
                        onDoubleTap: () {
                                  Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => MIS()));
                                },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                        
                          ),child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: SvgPicture.asset( 'assets/heart.svg',
                                    width: 18,
                                    height: 18,
                                  ),
                                ),  Text(DateFormat('d EEE MMM').format(now).toUpperCase(), style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF9BB068),
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),SizedBox(height: 15,),
                      // Second Container
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 129,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                      
                        ),child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          children:  [
                        
 Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(
                                child: SvgPicture.asset( 'assets/sadh.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ),  Text('Mood Streak', style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF9BB068),
                              ),),
                            ],
                          ),SizedBox(height: 5,),
                          Text('80', style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF9BB068),
                              ),),Text('Healthy', style: TextStyle(
                                fontSize: 15,
                              //  fontWeight: FontWeight.bold,
                                color: const Color(0xFF9BB068),
                              ),),
                          ],),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Row
                        (mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          SvgPicture.asset('assets/heart.svg',
                            width: 25,
                            height: 25,
                          ),Text('Freud Score',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF9BB068),
                            ),),
                        ],),
                        Center(
                          child: Image.asset( 'assets/chart.png',
                            width: 140,
                            height: 110,
                          ),
                        ),],
                        
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,20,10,20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 230, 235, 218),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: SizedBox(height: 50,width: 50
                      ,                        child: Center(
                          child: SvgPicture.asset(
                            'assets/Vector.svg',
                            width: 30,
                            height: 30,
                           // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Go For A Walk',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '2.h/8h',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                               color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),SizedBox(width: 40,),
                    Center(
                      child: SvgPicture.asset(
                        'assets/Frame.svg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                color: Color.fromARGB(205, 203, 202, 202),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Who ever try To pull you down is already below you,',textAlign: TextAlign.center,
                      style: TextStyle(letterSpacing: 4,
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                     Text('                -Alexander',
                     textAlign: TextAlign.right,
                      style: TextStyle(letterSpacing: 4,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(205, 189, 188, 188),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text('read more..',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w200,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                        
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class GreenContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.85); // Left curve start
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 1.15,
      size.width,
      size.height * 0.85,
    ); // Bottom curve
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
