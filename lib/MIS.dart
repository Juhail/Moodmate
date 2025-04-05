import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/macrad.dart';

class MIS extends StatefulWidget {
  @override
  _MISState createState() => _MISState();
}

class _MISState extends State<MIS> {
  List<String> activities = [
    'Go for a walk',
    'Read a book',
    'Watch a movie',
    'Cook a meal',
  ];
 final PageController pageController = PageController(viewportFraction: 0.95);
  int activePage = 0;

  



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
          height: 350,
          decoration: BoxDecoration(color: Color(0xFFB6CD7D), boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 7,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
          ]),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "You\'r Happy!",
              style: TextStyle(
              letterSpacing: 1.8,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              ),
            ),
            ),
            Center(
            child: SvgPicture.asset(
              'assets/happyol.svg',
              width: 200,
              height: 200,
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
              Row(
              children: [
                Expanded(
                flex: 1,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text(
                      DateFormat('d EEE MMM').format(now).toUpperCase(),
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF9BB068),
                      ),
                    ),
                    ],
                  ),
                  ),
                ),
                ),
                SizedBox(width: 10),
                Expanded(
                flex: 1,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                                    color: const Color(0xFF9BB068),

                  borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text(
                      'Breath',
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                      ),
                    ),
                    ],
                  ),
                  ),
                ),
                ),
              ],
              ),
              SizedBox(height: 15),
              Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                    '1 of 5',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9BB068),
                    ),
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Smile To 3 People \n You see',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF9BB068),
                  ),
                ),
                Spacer(),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                  color: const Color(0xFF9BB068),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  ),
                  child: Row(
                  children: [
                    Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                      "Swap",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      ),
                    ),
                    ),
                    VerticalDivider(
                    width: 1,
                    color: Colors.white.withOpacity(0.5),
                    ),
                    Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                      "Accept",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      ),
                    ),
                    ),
                  ],
                  ),
                ),
                ],
              ),
              ),
            ],
            ),
          ),
          ),
        ],
        ),
        //
// Mood Cards
        //
        SizedBox(
        height: 200,
        child: Stack(
          children: [
          PageView.builder(
            controller: pageController,
            itemCount: moodCards.length,
            onPageChanged: (index) {
            setState(() {
              activePage = index;
            });
            },
            itemBuilder: (context, index) {
            final card = moodCards[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                height: 200,
              decoration: BoxDecoration(
                color: card['color'],
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
                ],
              ),
              child: card['child'],
              ),
            );
            },
          ),
        
          ],
        ),
        ),  Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
              moodCards.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                onTap: () {
                  pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  );
                },
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: activePage == index
                    ? Colors.orangeAccent
                    : Colors.grey.shade400,
                ),
                ),
              ),
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
