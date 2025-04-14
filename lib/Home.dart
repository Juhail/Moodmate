import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moodmate/MoodCalender.dart';
import 'package:moodmate/homeanimation.dart';
import 'package:moodmate/macrad.dart';
import 'package:moodmate/todaysmood.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
final int currentLevel = 5;
class _HomeState extends State<Home> {
  List<String> activities = [
    'Go for a walk',
    'Read a book',
    'Watch a movie',
    'Cook a meal',
  ];
DateTime now = DateTime.now();
final PageController pageController = PageController(viewportFraction: 0.95);
  int activePage = 0;


bool isActive = true;
  @override
  Widget build(BuildContext context) {
    String date =DateFormat('d EEE MMM').format(now).toUpperCase();

    
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 247, 244, 242),
      body: SingleChildScrollView(
        child: 
        isActive?
        //
        //
        //
        Column(children: [
     
          AnimatedWavyHeader(
            // width: MediaQuery.of(context).size.width,
            // height:350,
           
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [  Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("You\'r $todayMood!",style :TextStyle(letterSpacing: 1.8,
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
                        onTap: () { setState(() {
    isActive = !isActive;
    print(isActive);
  });
                                },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFF9BB068),
                            borderRadius: BorderRadius.circular(30),
                        
                          ),child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Center(
                                //   child: SvgPicture.asset( 'assets/heart.svg',
                                //     width: 18,
                                //     height: 18,
                                //   ),
                                // ),  
                                Text(isActive? 'Mood Change': 'Go Back', style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color:  Colors.white,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //
                      //
                      //
                      //
                      //
                    
//
//




                      //
                      //
                      //
                      //
                      SizedBox(height: 15,),
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
                              ),  Text('Freud Score', style: TextStyle(
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
                  child: GestureDetector(onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoodImprovementCalendar(),
                      ),
                    );
                  },
                   
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
                              width: 20,
                              height: 20,
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
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15,0,15,0),
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
                            'Mood Streak',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        Row(
                          children: List<Widget>.generate(7, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Container(
                                width: 30,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: index < currentLevel ?
                               const Color(0xFF9BB068)
                                  : 
                                  Colors.grey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            );
                          }),
                        ),
                        Text('Apr: 20 / 31',style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),),
                        ],
                      ),
                    ),
                    //SizedBox(width: 40,),
                    // Center(
                    //   child: SvgPicture.asset(
                    //     'assets/Frame.svg',
                    //     width: 50,
                    //     height: 50,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
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
                      height: 50,
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
       
       //
       //
       //
       
       
        ]):
        //
        //
        //
        Column(children: [
        AnimatedWavyHeader(
     
              
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
                    GestureDetector(
                       onTap: () { setState(() {
    isActive = !isActive;
    print(isActive);
  });
                                },
                      child: Text(
                     'Go back',
                        style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9BB068),
                        ),
                      ),
                    ),
                    ],
                  ),
                  ),
                ),
                ),
//
//
//
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
              height: 170,
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
                    padding: const EdgeInsets.fromLTRB(0,10,0,5),
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
                Divider(indent: 5,
                endIndent: 5,
                  thickness: 2,
                  height: 1,
               color: Color.fromARGB(255, 230, 235, 218),
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                                          color: Colors.white,

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
                                          color: const Color(0xFF9BB068),

                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      ),
                    ),
                    ),
                    VerticalDivider(
                      endIndent: 3,
                  thickness: 2,
                    width: 1,
               color: Color.fromARGB(255, 230, 235, 218),
                    ),
                    Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                      "Accept",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                  color: const Color(0xFF9BB068),
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
        height: 160,
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
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
        ), 
                SizedBox(height: 15,),
Padding(
  padding: const EdgeInsets.only(bottom: 20),
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
                ? Colors.black
                : Colors.grey.shade400,
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


